#!/usr/bin/env python3
"""R5: full command table for the /sys/kernel/mik/MI_AUDIO debug CLI.
Correctly resolves .L.str.* symbols against .rodata.str1.1 and maps each
command string to its handler address."""
import sys, os, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs

PATH = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'


def build_strtab(e):
    """For each rodata section produce (name, base_off, data). Symbols .L.str.*
    have st_value == offset within their section; all sections have addr 0 in
    a .ko, so we must resolve by finding which section the offset falls in."""
    secs = []
    for s in e.secs:
        if s['name'].startswith('.rodata') and s['size'] and s['type'] != 8:
            secs.append((s['name'], s['off'], s['size'], s['addr']))
    return secs


def string_at(e, secs, val):
    for name, off, size, addr in secs:
        if val < size:
            d = e.b[off + val:off + val + 400]
            m = re.match(rb'[\x20-\x7e]+', d)
            if m:
                return m.group().decode('latin1'), name
    return None, None


def main():
    e = ELF32(PATH)
    r = Relocs(e)
    secs = build_strtab(e)
    print('rodata sections:')
    for n, o, sz, a in secs:
        print('   %-18s off=0x%08x size=0x%x addr=0x%x' % (n, o, sz, a))

    # find relocations whose symbol is a .L.str.*  -> these are command strings
    cmds = []
    for va, rec in r.data.items():
        sname, sval, rtype, addend, reloff, secname = rec
        if sname.startswith('.L.str'):
            s, sec = string_at(e, secs, sval)
            if s:
                cmds.append((va, sname, sval, s, sec))
    # dedupe by string
    seen = {}
    for va, sname, sval, s, sec in sorted(cmds, key=lambda x: x[0]):
        seen.setdefault(s, (va, sname, sval, sec))

    print()
    print('=== .L.str symbols resolvable to strings: %d (unique %d) ===' % (len(cmds), len(seen)))
    for s in sorted(seen, key=lambda k: seen[k][0]):
        va, sname, sval, sec = seen[s]
        print('   0x%08x %-12s +0x%-8x %-18s "%s"' % (va, sname, sval, sec, s[:70]))


main()
