#!/usr/bin/env python3
"""R5: reverse the /sys/kernel/mik/MI_AUDIO debug-CLI command syntax.
Disassembles MI_DEBUG_AOUT_ProcessDbgInfo / _MI_DEBUG_AUDIO_ParseParam and
resolves movw/movt + LDR-literal string references against .rodata."""
import re
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection
from capstone import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
TARGETS = ['MI_DEBUG_AOUT_ProcessDbgInfo', '_MI_DEBUG_AUDIO_ParseParam',
           '_MI_DEBUG_AUDIO_Init', 'MI_DEV_DEBUG_Aout']


def load(path):
    f = open(path, 'rb'); e = ELFFile(f)
    secs = list(e.iter_sections())
    syms = {}
    for s in secs:
        if isinstance(s, SymbolTableSection):
            for sym in s.iter_symbols():
                syms.setdefault(sym.name, (sym['st_value'], sym['st_size']))
    return f, e, secs, syms


def rodata_map(f, secs):
    """map VA -> string for all .rodata* sections"""
    out = {}
    for s in secs:
        if s.name.startswith('.rodata') or s.name in ('.data', '.data.rel.ro'):
            f.seek(s['sh_offset']); d = f.read(s['sh_size'])
            base = s['sh_addr']
            for m in re.finditer(rb'[\x20-\x7e]{4,}', d):
                out[base + m.start()] = m.group().decode('ascii', 'replace')
    return out


def sect_of(secs, va):
    for s in secs:
        if s['sh_addr'] <= va < s['sh_addr'] + s['sh_size'] and s['sh_type'] != 'SHT_NOBITS':
            return s
    return None


def va2off(secs, va):
    s = sect_of(secs, va)
    return s['sh_offset'] + (va - s['sh_addr']) if s else None


def immval(op):
    s = op.replace(' ', '')
    m = re.match(r'#0x([0-9a-fA-F]+)', s)
    if m: return int(m.group(1), 16)
    m = re.match(r'#(\d+)', s)
    if m: return int(m.group(1))
    return None


def main():
    f, e, secs, syms = load(PATH)
    strs = rodata_map(f, secs)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True; md.skipdata = True

    for name in TARGETS:
        if name not in syms:
            print('### %s : NOT FOUND' % name); continue
        va, sz = syms[name]
        sz = sz or 0x2000
        sz = min(sz, 0x4000)
        off = va2off(secs, va)
        if off is None:
            print('### %s : no file offset' % name); continue
        f.seek(off); data = f.read(sz)
        insns = list(md.disasm(data, va))
        print()
        print('=' * 100)
        print('### %s  VA 0x%x size 0x%x  (%d insns)' % (name, va, sz, len(insns)))
        print('=' * 100)
        pending = {}
        for i in insns:
            note = ''
            m = i.mnemonic
            if m == 'movw' and i.operands:
                try:
                    r = i.reg_name(i.operands[0].reg)
                    pending[r] = immval(i.op_str.split(',', 1)[1])
                except Exception:
                    pass
            elif m == 'movt' and i.operands:
                try:
                    r = i.reg_name(i.operands[0].reg)
                    lo = pending.get(r, 0)
                    hi = immval(i.op_str.split(',', 1)[1])
                    addr = (hi << 16) | lo
                    if addr in strs:
                        note = '   ;-> "%s"' % strs[addr][:90]
                except Exception:
                    pass
            elif m == 'ldr' and i.op_str.startswith('r') and '[pc' in i.op_str:
                pass
            if m.startswith('bl'):
                note += '   [CALL]'
            print('  0x%08x: %-8s %-9s %-32s%s' %
                  (i.address, i.bytes.hex(), m, i.op_str, note))


main()
