#!/usr/bin/env python3
"""R5: map a mik.ko file offset -> VA, identify enclosing function, and
disassemble a window in BOTH pristine and active variants side by side."""
import sys, re
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection
from capstone import *

PATH_PRISTINE = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
PATH_ACTIVE   = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
PATH_PATCHED  = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_patched.ko'

TARGET_OFFS = [0x9a334, 0x9b54c]


def load(path):
    f = open(path, 'rb')
    e = ELFFile(f)
    secs = list(e.iter_sections())
    syms = []
    for s in secs:
        if isinstance(s, SymbolTableSection):
            for sym in s.iter_symbols():
                if sym['st_info']['type'] == 'STT_FUNC' and sym['st_value']:
                    syms.append((sym['st_value'], sym['st_size'], sym.name))
    syms.sort()
    return f, e, secs, syms


def off2va(secs, off):
    for s in secs:
        if s['sh_type'] in ('SHT_PROGBITS', 'SHT_NOBITS'):
            if s['sh_offset'] <= off < s['sh_offset'] + s['sh_size']:
                return s['sh_addr'] + (off - s['sh_offset']), s.name
    return None, None


def va2off(secs, va):
    for s in secs:
        if s['sh_type'] in ('SHT_PROGBITS',):
            if s['sh_addr'] <= va < s['sh_addr'] + s['sh_size']:
                return s['sh_offset'] + (va - s['sh_addr'])
    return None


def fn_of(syms, va):
    best = None
    for a, sz, n in syms:
        if a <= va:
            if best is None or a > best[0]:
                best = (a, sz, n)
    return best


def main():
    fp, ep, secsp, symsp = load(PATH_PRISTINE)
    fa, ea, secsa, symsa = load(PATH_ACTIVE)
    fz, ez, secsz, symsz = load(PATH_PATCHED)

    print('=== mik.ko sections (exec/progbits) ===')
    for s in secsp:
        if s['sh_flags'] & 0x4:  # SHF_EXECINSTR
            print('  %-12s addr=0x%08x size=0x%x off=0x%x' %
                  (s.name, s['sh_addr'], s['sh_size'], s['sh_offset']))

    for off in TARGET_OFFS:
        va, secname = off2va(secsp, off)
        fn = fn_of(symsp, va)
        print()
        print('=== file offset 0x%x -> VA 0x%x (%s) ===' % (off, va, secname))
        print('    enclosing fn: %s @0x%x size=0x%x  (delta +0x%x)' %
              (fn[2], fn[0], fn[1], va - fn[0]) if fn else '    NO ENCLOSING FN')

    # disassemble a window around each target in both variants
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM)
    md.skipdata = True
    for off in TARGET_OFFS:
        va, _ = off2va(secsp, off)
        win_off = off - 0x60
        win_va = va - 0x60
        n = 0x100
        fp.seek(win_off); b_old = fp.read(n)
        fa.seek(win_off); b_new = fa.read(n)
        fz.seek(win_off); b_pat = fz.read(n)
        print()
        print('=' * 78)
        print('WINDOW around VA 0x%x (file off 0x%x)' % (va, off))
        print('=' * 78)
        io = md.disasm(b_old, win_va)
        inew = {i.address: i for i in md.disasm(b_new, win_va)}
        ipat = {i.address: i for i in md.disasm(b_pat, win_va)}
        for i in io:
            mark = ''
            if i.address == va:
                mark = '   <<<< TARGET (off 0x%x)' % off
            diff_new = ''
            if i.address in inew and inew[i.address].bytes != i.bytes:
                diff_new = '  [ACTIVE: %-24s %s]' % (
                    inew[i.address].mnemonic + ' ' + inew[i.address].op_str,
                    inew[i.address].bytes.hex())
            diff_pat = ''
            if i.address in ipat and ipat[i.address].bytes != i.bytes:
                diff_pat = '  [DTS_PATCHED: %-20s %s]' % (
                    ipat[i.address].mnemonic + ' ' + ipat[i.address].op_str,
                    ipat[i.address].bytes.hex())
            print('  0x%08x: %-8s %-28s %s%s%s%s' %
                  (i.address, i.bytes.hex(), i.mnemonic, i.op_str, mark, diff_new, diff_pat))


main()
