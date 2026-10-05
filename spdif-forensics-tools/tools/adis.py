import sys, struct
from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

def load(lib):
    f=open(lib,'rb'); elf=ELFFile(f)
    secs=[]
    for s in elf.iter_sections():
        if s.header['sh_type']=='SHT_PROGBITS' and s['sh_addr']:
            secs.append((s.name, s['sh_addr'], s['sh_addr']+s.header['sh_size'], s.data(), s['sh_offset']))
    syms={}
    for sec in elf.iter_sections():
        if sec.header['sh_type'] in ('SHT_SYMTAB','SHT_DYNSYM'):
            for sym in sec.iter_symbols():
                if sym['st_value'] and sym.name:
                    syms.setdefault(sym.name, (sym['st_value'], sym['st_size']))
    # PLT resolution: .rel.plt index -> symbol ; plt entry size derived
    plt=elf.get_section_by_name('.plt'); relplt=elf.get_section_by_name('.rel.plt')
    dynsym=elf.get_section_by_name('.dynsym')
    pltmap={}
    if plt and relplt:
        base=plt['sh_addr']; size=plt.header['sh_size']; n=relplt.num_relocations()
        ent = size/(n+1) if n else 0
        if ent and ent in (12,16,20):
            for i in range(n):
                rel=relplt.get_relocation(i)
                nm=dynsym.get_symbol(rel['r_info_sym']).name
                pltmap[base+int(ent)*(i+1)] = nm
    return f, elf, secs, syms, pltmap

def rd(secs, addr, n=4):
    for name,a0,a1,data,off in secs:
        if a0<=addr<a1 and name!='.bss':
            d=data[addr-a0:addr-a0+n]
            return d
    return None

def getstr(secs, addr, maxn=80):
    d=rd(secs, addr, maxn)
    if not d: return None
    z=d.find(b'\0')
    if z<0: z=len(d)
    try: s=d[:z].decode('utf-8','replace')
    except: return None
    return s if s.isprintable() and len(s)>2 else None

def disasm(lib, symname, out):
    f, elf, secs, syms, pltmap = load(lib)
    addr, size = syms[symname]
    if addr & 1: addr &= ~1
    md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail=False
    code = rd(secs, addr, size if size>0 else 0x800)
    # literal pool tracking: scan whole function region for words that point into rodata/plt
    out.write(f"===== {lib} {symname} @ {hex(addr)} size {hex(size)} =====\n")
    regval={}
    for ins in md.disasm(code, addr):
        line=f"{ins.address:08x}  {ins.mnemonic:<9} {ins.op_str}"
        notes=[]
        op=ins.op_str
        # literal load
        if ins.mnemonic.startswith('ldr') and '[pc' in op:
            try:
                imm=int(op.split('#')[1].rstrip(']'),0)
            except:
                imm=None
            if imm is not None:
                pc=(ins.address+4)&~3
                w=rd(secs, pc+imm,4)
                if w and len(w)==4:
                    val=struct.unpack('<i',w)[0]
                    notes.append(f"pool={hex(val)}")
                    regval[ins.op_str.split(',')[0].strip()]=val
                    nm=pltmap.get(val)
                    if nm: notes.append(f"; -> PLT {nm}")
                    s=getstr(secs,val)
                    if s: notes.append(f'; "{s[:60]}"')
        if ins.mnemonic=='add' and 'pc' in op:
            parts=[p.strip() for p in op.split(',')]
            dst=parts[0]
            if dst in regval:
                v=regval[dst]
                base=(ins.address+4)&~3
                final=(base+(v & 0xffffffff)) & 0xffffffff
                nm=pltmap.get(final)
                if nm: notes.append(f"; -> PLT {nm}")
                s=getstr(secs,final)
                if s: notes.append(f'; "{s[:60]}"')
        if ins.mnemonic.startswith('blx') or ins.mnemonic.startswith('bl'):
            try:
                tgt=int(op.lstrip('#'),0)
                nm=pltmap.get(tgt)
                if nm: notes.append(f"; CALL {nm}")
                else:
                    for k,v in syms.items():
                        if (v[0]&~1)==tgt:
                            notes.append(f"; CALL {k}"); break
            except: pass
        if 'adr' in ins.mnemonic:
            try:
                imm=int(op.split('#')[1],0)
                pc=(ins.address+4)&~3
                tgt=pc+imm
                regval[ins.op_str.split(',')[0].strip()]=tgt
                s=getstr(secs,tgt)
                if s: notes.append(f'; "{s[:60]}"')
            except: pass
        out.write(line+("  "+"; ".join(notes) if notes else "")+"\n")
    out.write("\n")

if __name__=='__main__':
    lib, sym, outp = sys.argv[1], sys.argv[2], sys.argv[3]
    with open(outp,'w') as o:
        disasm(lib, sym, o)
    print("wrote", outp)
