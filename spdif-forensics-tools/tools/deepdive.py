#!/usr/bin/env python3
"""Static deep-dive scanner for the C50A DTS forensic audit.

Builds:
  * caller cross-references for key functions (utpa2k.ko + mik.ko)
  * full g_AudioVars2 field-access map (writes/reads of 0x4d8/0x440/0x582/
    0x4d0/0x4d4/0x43d/0x43e) across utpa2k.ko .text
  * EDID parser + capability-word build (mik.ko)

Output: tools/deepdive_utpa2k.txt and tools/deepdive_mik.txt
"""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import attach
from relocs import Relocs
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB, CS_MODE_LITTLE_ENDIAN

OFFS = {0x4d8: '0x4d8 DTS-level', 0x440: '0x440 missing-mask',
        0x582: '0x582 DTS:X', 0x4d0: '0x4d0 Dolby/DSP-tier',
        0x4d4: '0x4d4 sub-tier', 0x43d: '0x43d Dolby-prem',
        0x43e: '0x43e Dolby-prem'}


def load(path):
    e = ELF32(path); e = attach(e); return e


def callers_of(e, rel, names):
    out = {}
    for nm in names:
        hits = rel.by_target.get(nm, [])
        out[nm] = hits
    return out


def scan_field_access(e, rel, outpath, label):
    """Stream-disassemble .text, capture ldr/str with target offsets."""
    t = e.text
    code = e.read_va(t['addr'], t['size'])
    start = t['addr']; end = start + t['size']
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN); md.detail = True
    f = open(outpath, 'w')
    f.write(f"=== {label}: g_AudioVars2 field-access scan (offsets {sorted(OFFS)})\n")
    addr = start
    nfound = 0
    while addr < end:
        chunk = code[addr - start: addr - start + 0x2000]
        if len(chunk) < 4: break
        ins = list(md.disasm(chunk, addr))
        if not ins:
            addr += 4; continue
        for i in ins:
            op = i.op_str
            for off, lbl in OFFS.items():
                if (f'#{off:#x}' in op) and i.mnemonic[:3] in ('ldr', 'str'):
                    fn = e.nearest_sym(i.address) or '?'
                    f.write(f"0x{i.address:08x} [{fn}] {i.mnemonic} {op}   ({lbl})\n")
                    nfound += 1
                    break
        last = ins[-1].address + 4
        addr = last if last > addr else addr + 4
    f.write(f"--- total field-access hits: {nfound}\n")
    f.close()
    print(f"{label}: {nfound} field-access hits -> {outpath}")


def dump_callers(e, rel, names, outpath, label):
    f = open(outpath, 'w')
    f.write(f"=== {label}: caller cross-references\n")
    for nm in names:
        hits = rel.by_target.get(nm, [])
        f.write(f"\n--- callers of {nm} ({len(hits)} sites) ---\n")
        for va, rtype in hits:
            fn = e.nearest_sym(va) or '?'
            f.write(f"  0x{va:08x}  (in {fn})\n")
    f.close()
    print(f"{label}: caller xref -> {outpath}")


if __name__ == '__main__':
    root = os.path.dirname(os.path.abspath(__file__))
    inv = os.path.join(root, '..')
    # ---- utpa2k.ko ----
    e = load(os.path.join(inv, 'kmods/utpa2k.ko'))
    rel = Relocs(e)
    dump_callers(e, rel, [
        'MDrv_AUDIO_Get_DTS_License', 'MDrv_AUDIO_CheckHashkey',
        'MDrv_AUDIO_SetDecodeSystem', 'MDrv_AUDIO_OpenDecodeSystem',
        'MDrv_AUDIO_ApplyHashkey', 'HAL_AUDIO_SetSystem2',
        'MDrv_AUDIO_Get_License', 'MDrv_AUDIO_Get_Decoder_Support',
    ], os.path.join(root, 'deepdive_callers_utpa2k.txt'), 'utpa2k.ko')
    scan_field_access(e, rel, os.path.join(root, 'deepdive_fields_utpa2k.txt'), 'utpa2k.ko')
    # ---- mik.ko ----
    m = load(os.path.join(inv, 'kmods/mik.ko'))
    mrel = Relocs(m)
    dump_callers(m, mrel, [
        '_MI_AOUT_SetHdmiAutoMode', '_MI_AOUT_ParseEdidAudioDataBlock',
        '_MI_AOUT_SetHdmiInfo', 'MI_AOUT_SetDigitalMode',
        '_MI_AOUT_SetDigitalChannelStatus', 'MApi_AUDIO_SPDIF_SetMode',
    ], os.path.join(root, 'deepdive_callers_mik.txt'), 'mik.ko')
    print("done")
