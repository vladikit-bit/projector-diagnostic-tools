#!/usr/bin/env python3
"""Phase 3 independent binary verification for the C50A / MT5889 SPDIF DTS
forensic audit.

Targets (all read-only disassembly; no patching):
  utpa2k.ko:
    * MDrv_AUTH_IPCheck            @0x1390c   - does it merely read a bit?
    * HAL_AUDIO_SetSystem2         @0x44d0b0 - DTS case -> which DSP byte?
    * MDrv_AUDIO_Get_DTS_License   @0x422aa0 - same IPIDs {0xf,0x3a,0x12,7}?
    * CheckHashkey field writers   @0x423494 - which IPIDs write 0x43d/0x43e
                                    (claimed Dolby-premium flags)?
  mik.ko:
    * _MI_AOUT_SetHdmiAutoMode     @0x7e99e  - EDID-driven SPDIF mode (T2)
    * MI_AOUT_SetDigitalMode       @0x7faf8
    * _MI_AOUT_SetDigitalChannelStatus @0x6c268

We resolve external call targets via .rel.text relocations (the R_ARM_CALL /
R_ARM_JUMP24 fix) so `bl MDrv_AUTH_IPCheck` becomes visible.
"""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc
from relocs import Relocs

# g_AudioVars2 byte offsets of interest (per prior reports; to be confirmed
# here by control flow / writers, not assumed).
WATCH = {0x43d: '0x43d?', 0x43e: '0x43e?', 0x440: '0x440 missing-mask',
         0x444: '0x444 avail-mask', 0x4d0: '0x4d0 Dolby/DSP-tier',
         0x4d4: '0x4d4 sub-tier', 0x4d8: '0x4d8 DTS level', 0x582: '0x582 DTS:X'}


def load(path):
    e = ELF32(path)
    e = __import__('forensic_dis').attach(e)
    return e


def dump_func(e, va, size, name, rel=None, watch=None, ipid_watch=None):
    f = ArmFunc(e, va, size, thumb=False, name=name)
    print('=' * 78)
    print(f'{name} @ 0x{va:x}  size 0x{size:x}  ({len(f.insns)} insns)')
    print('=' * 78)
    for i in f.insns:
        # resolve call target
        tgt = ''
        if i.mnemonic in ('bl', 'blx', 'bx') and rel:
            nm = rel.call_target(i.address)
            if nm:
                tgt = f'   ; -> {nm}'
        # field-write watcher
        flags = []
        op = i.op_str
        for off, lbl in (watch or WATCH).items():
            # crude: look for immediate #-0xNNN used with [rN, #off]
            if f'#{off:#x}' in op or f'#{off}' in op:
                # only when it's a memory op (str/ldr family)
                if i.mnemonic[:3] in ('str', 'ldr', 'stR', 'ldR'):
                    flags.append(f'[{lbl}]')
        # IPID immediate watcher (e.g. mov r0,#0xf)
        ipf = ''
        if ipid_watch:
            for v in ipid_watch:
                if f'#{v:#x}' in op or f'#{v}' in op:
                    ipf = f'   ; IPID#{v:#x}'
        extra = '  '.join(flags)
        line = f'0x{i.address:08x}: {i.mnemonic:<8} {i.op_str}'
        if tgt or extra or ipf:
            line += f'   {tgt}{ipf}  {extra}'
        print(line)
    return f


def main():
    root = os.path.dirname(os.path.abspath(__file__))
    inv = os.path.join(root, '..')
    # ---- utpa2k.ko ----
    e = load(os.path.join(inv, 'kmods/utpa2k.ko'))
    rel = Relocs(e)
    print(f'[utpa2k.ko] branch relocs={len(rel.branch)} data relocs={len(rel.data)}')

    # sizes from symtab
    sz = {s['name']: s['size'] for s in e.syms if s['name']}
    dump_func(e, 0x1390c, max(sz.get('MDrv_AUTH_IPCheck', 0), 0x180),
              'MDrv_AUTH_IPCheck', rel=rel,
              watch={}, ipid_watch=None)
    dump_func(e, 0x44d0b0, max(sz.get('HAL_AUDIO_SetSystem2', 0), 0x600),
              'HAL_AUDIO_SetSystem2', rel=rel)
    dump_func(e, 0x422aa0, max(sz.get('MDrv_AUDIO_Get_DTS_License', 0), 0x400),
              'MDrv_AUDIO_Get_DTS_License', rel=rel,
              ipid_watch={0xf, 0x3a, 0x12, 0x7, 0xb, 0xc})

    # CheckHashkey: scan full body for writers to 0x43d/0x43e and 0x4d0
    ch = sz.get('MDrv_AUDIO_CheckHashkey', 0)
    print('=' * 78)
    print(f'MDrv_AUDIO_CheckHashkey @ 0x423494 size 0x{ch:x} -- field writers')
    print('=' * 78)
    f = ArmFunc(e, 0x423494, ch, name='CheckHashkey')
    # group writes by offset
    writers = {o: [] for o in WATCH}
    for i in f.insns:
        op = i.op_str
        for off in WATCH:
            if (f'#{off:#x}' in op) and i.mnemonic[:3] in ('str', 'ldr'):
                writers[off].append((i.address, i.mnemonic, i.op_str))
    for off in sorted(writers):
        if writers[off]:
            print(f'\n--- writes/reads to g_AudioVars2[{off:#x}] ({WATCH[off]}) '
                  f': {len(writers[off])} ---')
            for a, m, o in writers[off]:
                print(f'  0x{a:08x}: {m:<8} {o}')

    # ---- mik.ko ----
    print('\n\n' + '#' * 78)
    print('# mik.ko')
    print('#' * 78)
    m = load(os.path.join(inv, 'kmods/mik.ko'))
    mrel = Relocs(m)
    msz = {s['name']: s['size'] for s in m.syms if s['name']}
    dump_func(m, 0x7e99e, max(msz.get('_MI_AOUT_SetHdmiAutoMode', 0), 0x400),
              '_MI_AOUT_SetHdmiAutoMode', rel=mrel)
    dump_func(m, 0x7faf8, max(msz.get('MI_AOUT_SetDigitalMode', 0), 0x400),
              'MI_AOUT_SetDigitalMode', rel=mrel)
    dump_func(m, 0x6c268, max(msz.get('_MI_AOUT_SetDigitalChannelStatus', 0), 0x120),
              '_MI_AOUT_SetDigitalChannelStatus', rel=mrel)


if __name__ == '__main__':
    main()
