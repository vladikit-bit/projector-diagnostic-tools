#!/usr/bin/env python3
"""R6: data-section xref. Scans .data/.data.rel.ro/.rodata for dwords equal to a
string VA (registration tables that embed a name pointer + func pointer).

Usage: r6_dataref.py <module.ko> <substr> [substr ...]
"""
import sys, struct, importlib.util
def main():
    path=sys.argv[1]; subs=sys.argv[2:]
    spec=importlib.util.spec_from_file_location('r6_reloc','tools/r6_reloc.py')
    m=importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    e=m.ELF32R(path)
    # string VAs
    strvas={}
    for sec in e.secs:
        if sec['name'] in ('.rodata','.data','.data.rel.ro'):
            d=e.b[sec['off']:sec['off']+sec['size']]
            for sub in subs:
                sb=sub.encode('latin1'); start=0
                while True:
                    i=d.find(sb,start)
                    if i<0: break
                    strvas.setdefault(sub,[]).append((sec['name'],sec['addr']+i))
                    start=i+1
    allvas=set(v for lst in strvas.values() for (_,v) in lst)
    print("string VAs:", {k:[hex(x) for _,x in v] for k,v in strvas.items()})
    # scan data sections for dwords == str VA
    for sec in e.secs:
        if sec['name'] in ('.data','.data.rel.ro'):
            d=e.b[sec['off']:sec['off']+sec['size']]
            for off in range(0,len(d)-4,4):
                val=struct.unpack_from('<I',d,off)[0]
                if val in allvas:
                    # this dword holds a string VA; print it and next dword (func ptr?)
                    nxt=struct.unpack_from('<I',d,off+4)[0] if off+8<=len(d) else None
                    # resolve next dword via reloc if present
                    rel=e.reloc.get((sec['name'],sec['addr']+off+4))
                    relname=None
                    if rel:
                        sym=e.syms[rel[0]] if rel[0]<len(e.syms) else None
                        relname=sym['name'] if sym else None
                    sname=''
                    for k,lst in strvas.items():
                        if val in [x for _,x in lst]: sname=k
                    print(f"{sec['name']}+0x{off:x} (VA 0x{sec['addr']+off:08x}) -> str '{sname}' (0x{val:08x})  next_dword=0x{nxt:08x} next_rel={relname}")
    # also scan .rodata (tables may be const)
    for sec in e.secs:
        if sec['name']=='.rodata':
            d=e.b[sec['off']:sec['off']+sec['size']]
            for off in range(0,len(d)-4,4):
                val=struct.unpack_from('<I',d,off)[0]
                if val in allvas:
                    sname=''
                    for k,lst in strvas.items():
                        if val in [x for _,x in lst]: sname=k
                    print(f".rodata+0x{off:x} (VA 0x{sec['addr']+off:08x}) -> str '{sname}' (0x{val:08x})  [const table]")
if __name__=='__main__':
    main()
