#!/usr/bin/env python3
"""Resolve PLT thunks -> import names for an ELF, using the raw ARM PLT decoder.
Usage: r4_plt.py <elf.so> [start_va end_va ...]
If no VA range given, prints the whole map (sorted). If VA(s) given, prints only those.
"""
import sys
sys.path.insert(0, '.')
from elfx import ELF, decode_plt

f = sys.argv[1]
E = ELF(f)
# build rel_map: GOT va -> import name
rel_map = {}
for ro, ri, rt in E.relocs('.rel.plt'):
    sym = E.dynsyms()[ri]['name'] if ri < len(E.dynsyms()) else f'?{ri}'
    rel_map[ro] = sym
# also .rel.dyn (some REL32) for completeness
for ro, ri, rt in E.relocs('.rel.dyn'):
    if ro not in rel_map and ri < len(E.dynsyms()):
        rel_map[ro] = E.dynsyms()[ri]['name']

thunks = decode_plt(E)

want = [int(x, 16) for x in sys.argv[2:]]
items = sorted(thunks.items())
if want:
    items = [(va, t) for va, t in items if va in want]
print(f"// {f}")
print(f"// PLT thunks resolved: {len(thunks)}")
for va, (name, got) in items:
    print(f"  PLT 0x{va:06x}  ->  {name}   (GOT 0x{got:06x})")
