#!/usr/bin/env python3
"""R8: relocate-aware disassembly of an arbitrary VA window in a .ko.
Usage: r8_diswin.py <ko> <start_va> <size> [--find-func]
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import attach
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN
import importlib.util

spec = importlib.util.spec_from_file_location('r6_reloc', os.path.join(os.path.dirname(os.path.abspath(__file__)), 'r6_reloc.py'))
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)

ko = sys.argv[1]
start = int(sys.argv[2], 0)
size = int(sys.argv[3], 0)

e = attach(ELF32(ko))
er = m.ELF32R(ko)
reloc = {}
for (rn, ro), (symidx, rtype, rs) in er.reloc.items():
    sym = er.syms[symidx] if symidx < len(er.syms) else None
    reloc[ro] = (sym['name'] if sym else None, rtype)

# enclosing function
fn = None
for s in e.syms:
    if s.get('size') and s['value'] <= start < s['value'] + s['size'] and s.get('type') == 'STT_FUNC':
        if fn is None or s['size'] < fn['size']:
            fn = s
if fn:
    print(";; enclosing function: %s  va=0x%08x size=0x%x" % (fn['name'], fn['value'], fn['size']))
else:
    print(";; no enclosing FUNC symbol found")

md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN)
md.detail = True
md.skipdata = True
code = e.read_va(start, size)
for i in md.disasm(code, start):
    ann = ''
    if i.address in reloc:
        sn, rt = reloc[i.address]
        ann = '   <<< REL type=0x%02x sym=%s' % (rt, sn)
    print('0x%08x: %-10s %s%s' % (i.address, i.mnemonic, i.op_str, ann))
