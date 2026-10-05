#!/usr/bin/env python3
"""R6: resolve unrelocated ARM branch targets in a .ko via .rel.* sections.

For branch-type relocations (R_ARM_CALL/JUMP24/PC24/THM_*), the raw `bl`/`b`
immediate is a placeholder (usually 0). The real target is given by the
relocation's symbol. For non-relocated branches we decode the immediate directly.

Usage:
  r6_reloc.py <module.ko>                 # dump all branch relocations + callees
  r6_reloc.py <module.ko> resolve <va> [va ...]   # resolve specific call sites
"""
import sys, struct, re

ARM_BR_TYPES = {0x1a:'CALL', 0x1b:'PLT32', 0x1c:'PC24', 0x1d:'JUMP24',
                0x1e:'THM_CALL', 0x1f:'THM_JUMP24', 0x1b:'PLT32'}
# add THM_JUMP19 / THM_JUMP11 if present
ARM_BR_TYPES[0x14] = 'THM_JUMP19'
ARM_BR_TYPES[0x15] = 'THM_JUMP11'

def sign_extend(val, bits):
    if val & (1 << (bits-1)):
        val -= (1 << bits)
    return val

def extract_arm_imm24(insn):
    # bits[23:0] of B/BL
    imm24 = insn & 0xffffff
    return sign_extend(imm24 << 2, 26)

class ELF32R:
    def __init__(self, path):
        self.b = open(path,'rb').read()
        b=self.b
        e_shoff,=struct.unpack_from('<I',b,0x20)
        e_shentsize,=struct.unpack_from('<H',b,0x2e)
        e_shnum,=struct.unpack_from('<H',b,0x30)
        e_shstrndx,=struct.unpack_from('<H',b,0x32)
        secs=[]
        for i in range(e_shnum):
            o=e_shoff+i*e_shentsize
            (name,typ,flags,addr,off,size,link,info,align,entsize)=\
                struct.unpack_from('<10I',b,o)
            secs.append(dict(nameoff=name,type=typ,flags=flags,addr=addr,
                             off=off,size=size,link=link,info=info,
                             entsize=entsize))
        sh=secs[e_shstrndx]
        def sname(n):
            e=b.index(b'\0',sh['off']+n); return b[sh['off']+n:e].decode('latin1')
        for s in secs: s['name']=sname(s['nameoff'])
        self.secs=secs
        # symbols
        sym=self.sec('.symtab'); self.syms=[]
        if sym:
            st=self.secs[sym['link']]; sb=self.b
            for i in range(sym['size']//16):
                o=sym['off']+i*16
                nameoff,value,size,info,other,shndx=struct.unpack_from('<IIIBBH',sb,o)
                e=sb.index(b'\0',st['off']+nameoff)
                nm=sb[st['off']+nameoff:e].decode('latin1')
                self.syms.append(dict(name=nm,value=value,size=size,
                                      type=info&0xf,bind=info>>4,shndx=shndx))
        # relocations
        self.reloc={}  # (sec_off_key) handled per-section; map offset->(symidx,type,symsec)
        self.relsecs=[]
        for s in secs:
            if s['type']==9:  # SHT_REL
                self.relocs_for(s)
        # symbol-by-value index (for mapping a VA to nearest symbol)
        self.byval=sorted([(s['value'],s) for s in self.syms if s['name'] and s['shndx']!=0],
                          key=lambda x:x[0])
    def sec(self,n):
        for s in self.secs:
            if s['name']==n: return s
        return None
    def relocs_for(self,s):
        entsize=s['entsize'] or 8
        n=s['size']//entsize
        sb=self.b
        for i in range(n):
            o=s['off']+i*entsize
            r_offset,r_info=struct.unpack_from('<II',sb,o)
            symidx=r_info>>8; rtype=r_info&0xff
            self.reloc[(s['name'],r_offset)]=(symidx,rtype,s)
    def sym_at(self,va):
        # nearest symbol with value <= va
        best=None
        for v,s in self.byval:
            if v<=va: best=s
            else: break
        return best
    def insn_at(self,va,sec=None):
        sec=sec or self.sec('.text')
        off=sec['off']+va-sec['addr']
        return struct.unpack_from('<I',self.b,off)[0]
    def resolve(self,va):
        """Resolve a branch/call site. Returns (target_va, symname_or_None, via)."""
        # find a relocation keyed by this offset in any .rel section
        rel=None
        for (rn,ro),(symidx,rtype,rs) in self.reloc.items():
            if ro==va:
                rel=(symidx,rtype,rs); break
        if rel:
            symidx,rtype,rs=rel
            sym=self.syms[symidx] if symidx < len(self.syms) else None
            sname=sym['name'] if sym else None
            if sym and sym['shndx']!=0:
                # defined symbol: target ~= sym value (relocation writes S+A-P; for
                # placeholder imm the bias ~ +8). Good enough to map to symbol.
                tgt=sym['value']
                return (tgt, sname, f'REL:{ARM_BR_TYPES.get(rtype,hex(rtype))}')
            else:
                return (0, sname, f'REL_UNDEF:{ARM_BR_TYPES.get(rtype,hex(rtype))}')
        # no relocation -> decode immediate directly (assembler-resolved local call)
        insn=self.insn_at(va)
        if (insn & 0x0f000000) in (0x0a000000, 0x0b000000):  # B / BL
            imm=extract_arm_imm24(insn)
            tgt=(va+8)+imm
            s=self.sym_at(tgt)
            return (tgt, s['name'] if s else None, 'IMM')
        return (None,None,'NONBR')

def main():
    path=sys.argv[1]
    e=ELF32R(path)
    if len(sys.argv)>2 and sys.argv[2]=='resolve':
        for a in sys.argv[3:]:
            va=int(a,0)
            tgt,name,via=e.resolve(va)
            print(f"site 0x{va:08x} -> target 0x{tgt:08x} sym={name} via={via}")
        return
    # dump all branch relocations
    for (rn,ro),(symidx,rtype,rs) in sorted(e.reloc.items(), key=lambda x:(x[0][1])):
        if rtype in ARM_BR_TYPES:
            sym=e.syms[symidx] if symidx<len(e.syms) else None
            sname=sym['name'] if sym else None
            s=self.sym_at(ro)
            print(f"{rn:14s} off=0x{ro:08x} in {s['name'] if s else '?':40s} -> {sname} ({ARM_BR_TYPES[rtype]})")

if __name__=='__main__':
    main()
