#!/usr/bin/env python3
"""R6: literal-pool xref finder. Finds `ldr rx,[pc,#imm]` whose literal-pool
slot holds the VA of a string matching a substring. Maps to containing function.

Usage: r6_litxref.py <module.ko> <substr> [substr ...]
"""
import sys, importlib.util
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN

def find_str_vas(e, subs):
    vas={}
    for sec in e.secs:
        if sec['name'] in ('.rodata','.data','.data.rel.ro'):
            d=e.b[sec['off']:sec['off']+sec['size']]
            for sub in subs:
                sb=sub.encode('latin1')
                start=0
                while True:
                    i=d.find(sb,start)
                    if i<0: break
                    va=sec['addr']+i
                    vas.setdefault(sub,[]).append(va)
                    start=i+1
    return vas

def main():
    path=sys.argv[1]; subs=sys.argv[2:]
    spec=importlib.util.spec_from_file_location('r6_reloc','tools/r6_reloc.py')
    m=importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    e=m.ELF32R(path)
    strvas=find_str_vas(e,subs)
    allvas=set()
    for v in strvas.values(): allvas.update(v)
    print("string VAs:", {k:[hex(x) for x in v] for k,v in strvas.items()})
    text=e.sec('.text')
    md=Cs(CS_ARCH_ARM, CS_MODE_ARM|CS_MODE_LITTLE_ENDIAN)
    code=e.b[text['off']:text['off']+text['size']]
    from collections import defaultdict
    hits=defaultdict(list)
    n=0
    for ins in md.disasm(code, text['addr']):
        n+=1
        if ins.mnemonic=='ldr' and '[pc' in ins.op_str:
            # parse offset
            try:
                off=int(ins.op_str.split('#')[-1].rstrip(']'),0)
            except: continue
            pool=((ins.address+8)&~3)+off
            # read pool dword
            po=text['off']+pool-text['addr']
            if po+4>len(e.b): continue
            val=int.from_bytes(e.b[po:po+4],'little')
            if val in allvas:
                fn=e.sym_at(ins.address)
                hits[fn['name'] if fn else '???'].append((ins.address,val))
    for fn in sorted(hits):
        print(f"\n### {fn}")
        for va,val in hits[fn]:
            sname=''
            for k,v in strvas.items():
                if val in v: sname=k
            print(f"    0x{va:08x}  -> str VA 0x{val:08x} ({sname})")
    if not hits: print("no literal-pool xrefs found")

if __name__=='__main__':
    main()
