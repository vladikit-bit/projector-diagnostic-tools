import sys, struct
from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB, CS_MODE_ARM

def main(ko, symname, outp, force_arm=False):
    f=open(ko,'rb'); elf=ELFFile(f)
    secs=list(elf.iter_sections())
    symtab=None; strtab=None
    for s in secs:
        if s.header['sh_type']=='SHT_SYMTAB': symtab=s
    # symbol
    target=None
    for sym in symtab.iter_symbols():
        if sym.name==symname and sym['st_value']:
            target=(sym['st_value'], sym['st_size'], sym['st_shndx'])
    if not target:
        print("symbol not found"); return
    val,sz,shndx = target
    sec=secs[shndx]
    data=sec.data()[val:val+(sz if sz>0 else 0x1000)]
    # relocations for this section
    relmap={}
    for s in secs:
        if s.header['sh_type'] in ('SHT_REL','SHT_RELA') and s.header['sh_info']==shndx:
            for r in s.iter_relocations():
                relmap[r['r_offset']] = symtab.get_symbol(r['r_info_sym']).name
    # string sections (for data refs)
    def getsec(idx): return secs[idx]
    def cstr(secobj, off, n=80):
        d=secobj.data()[off:off+n]
        z=d.find(b'\0')
        if z<0: z=len(d)
        try: s=d[:z].decode('utf-8','replace')
        except: return None
        return s if s.isprintable() and len(s)>2 else None
    thumb = not force_arm
    # detect: check first 2 bytes for common thumb push (0xB5xx) vs arm (0xE92D or movw e3..)
    b0=struct.unpack_from('<H',data,0)[0]
    b0w=struct.unpack_from('<I',data,0)[0]
    if (b0 & 0xFF00)==0xB500 or (b0 & 0xF800)==0xE92D//256 or (data[0]==0x2D and data[1]==0xE9):
        thumb=True
    if b0w>>28 in (0xE,0xC):
        thumb=False
    md=Cs(CS_ARCH_ARM, CS_MODE_THUMB if thumb else CS_MODE_ARM)
    out=open(outp,'w')
    out.write(f"===== {ko} {symname} sec_off={hex(val)} size={hex(sz)} mode={'T' if thumb else 'A'} =====\n")
    addr=val
    for ins in md.disasm(data, addr):
        line=f"{ins.address:08x}  {ins.mnemonic:<9} {ins.op_str}"
        notes=[]
        if ins.address in relmap:
            notes.append("rel→"+relmap[ins.address])
        # literal pool: ldr rX,[pc,#imm]
        if ins.mnemonic.startswith('ldr') and '[pc' in ins.op_str:
            try: imm=int(ins.op_str.split('#')[1].rstrip(']'),0)
            except: imm=None
            if imm is not None:
                pc=(ins.address+4)&~3
                pa=pc+imm
                if pa in relmap:
                    rn=relmap[pa]
                    notes.append(f"pool→{rn}")
                    # resolve string if points to a section symbol: find symbol value
                    for sym in symtab.iter_symbols():
                        if sym.name==rn and sym['st_value'] is not None and sym['st_shndx']!='SHN_UNDEF':
                            ssec=getsec(sym['st_shndx'])
                            sv=sym['st_value']
                            st=cstr(ssec, sv)
                            if st: notes.append(f'; "{st[:60]}"')
                            break
        if ins.mnemonic in ('bl','blx') and ins.op_str.startswith('#'):
            try:
                t=int(ins.op_str.lstrip('#'),0)
                if t in relmap: notes.append("CALL "+relmap[t])
                else:
                    for sym in symtab.iter_symbols():
                        if sym['st_value']==t and sym['st_info']['type']=='STT_FUNC':
                            notes.append("CALL "+sym.name); break
            except: pass
        out.write(line+("  "+"; ".join(notes) if notes else "")+"\n")
    out.close()
    print("wrote",outp)

if __name__=='__main__':
    main(sys.argv[1], sys.argv[2], sys.argv[3], force_arm=('--arm' in sys.argv))
