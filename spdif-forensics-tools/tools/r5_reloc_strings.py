#!/usr/bin/env python3
"""R5: resolve movw/movt data relocations inside a function to real string
targets, using the project's relocation-aware ELF helper."""
import sys, os, re, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs, R_ARM_MOVW_ABS_NC, R_ARM_MOVT_ABS
from capstone import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
FUNCS = {'MI_DEBUG_AOUT_ProcessDbgInfo': (0x3e4c0, 0x1974),
         '_MI_DEBUG_AUDIO_ParseParam': (None, None)}


def rodata_strings(e):
    """VA -> string for rodata sections"""
    out = {}
    for s in e.secs:
        if s['name'].startswith('.rodata') or s['name'] in ('.data',):
            base = s['addr']
            d = e.b[s['off']:s['off'] + s['size']]
            for m in re.finditer(rb'[\x20-\x7e]{3,}', d):
                out[base + m.start()] = m.group().decode('latin1')
    return out


def main():
    e = ELF32(PATH)
    r = Relocs(e)
    strs = rodata_strings(e)
    print('section list:')
    for s in e.secs:
        if s['name'].startswith(('.rodata', '.text', '.data')):
            print('   %-20s addr=0x%08x off=0x%08x size=0x%x' %
                  (s['name'], s['addr'], s['off'], s['size']))
    print('branch relocs: %d   data relocs: %d' % (len(r.branch), len(r.data)))

    va0, size = 0x3e4c0, 0x1974
    va1 = va0 + size
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True; md.skipdata = True
    off = e.va2off(va0)
    data = e.b[off:off + size]
    insns = list(md.disasm(data, va0))

    # pair up movw/movt using the DATA relocation table
    print()
    print('=== resolved data relocations (movw/movt) in 0x%x..0x%x ===' % (va0, va1))
    seen = {}
    for i in insns:
        if i.mnemonic in ('movw', 'movt') and i.address in r.data:
            sname, sval, rtype, addend, reloff, secname = r.data[i.address]
            seen.setdefault(i.address, (sname, sval, rtype, i.mnemonic, i.op_str))

    for addr in sorted(seen):
        sname, sval, rtype, mn, op = seen[addr]
        # target = symbol value; for section symbols the string lives at rodata_base+sval
        cand = []
        if sval in strs:
            cand.append('"%s"' % strs[sval][:80])
        # also try common merged-string section bases
        for s in e.secs:
            if s['name'] == sname and s['name'].startswith('.rodata'):
                pass
        print('  0x%08x %-5s %-14s sym=%-24s val=0x%08x %s' %
              (addr, mn, op, sname, sval, ' '.join(cand)))

    # Print the portion of disasm with relocation annotations
    print()
    print('=== annotated disassembly (first 220 insns) ===')
    n = 0
    for i in insns:
        note = ''
        if i.address in r.data:
            sname, sval, rtype, addend, reloff, secname = r.data[i.address]
            note = '  ; RELOC sym=%s val=0x%x' % (sname, sval)
            if sval in strs:
                note += ' -> "%s"' % strs[sval][:70]
        if i.mnemonic.startswith('bl'):
            tgt = r.call_target(i.address)
            if tgt:
                note += '  [-> %s]' % tgt
        print('  0x%08x: %-8s %-9s %-30s%s' %
              (i.address, i.bytes.hex(), i.mnemonic, i.op_str, note))
        n += 1
        if n > 220:
            break


main()
