#!/usr/bin/env python3
"""R6: find every instruction that references a symbol whose name matches a
substring (e.g. a DTS packer string / codec-id constant), and map it to the
containing function. Reveals which functions touch the DTS SDO packer path.

Usage: r6_packref.py <module.ko> <substr> [substr ...]
"""
import sys, importlib.util
def load(path):
    spec=importlib.util.spec_from_file_location('r6_reloc','tools/r6_reloc.py')
    m=importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    return m.ELF32R(path)
def main():
    path=sys.argv[1]
    subs=sys.argv[2:]
    e=load(path)
    # build (insn_va -> symname) for ALL relocations
    refs={}
    for (rn,ro),(symidx,rtype,rs) in e.reloc.items():
        sym=e.syms[symidx] if symidx<len(e.syms) else None
        if not sym or not sym['name']: continue
        sn=sym['name']
        if any(s in sn for s in subs):
            refs[ro]=(sn,rtype)
    # map to containing function
    from collections import defaultdict
    byfn=defaultdict(list)
    for va,(sn,rt) in sorted(refs.items()):
        fn=e.sym_at(va)
        fnname=fn['name'] if fn else '???'
        byfn[fnname].append((va,sn,rt))
    for fnname in sorted(byfn):
        print(f"\n### {fnname}")
        for va,sn,rt in byfn[fnname]:
            print(f"    0x{va:08x}  sym={sn}  reltype=0x{rt:02x}")
    if not byfn:
        print("no references found for:", subs)
if __name__=='__main__':
    main()
