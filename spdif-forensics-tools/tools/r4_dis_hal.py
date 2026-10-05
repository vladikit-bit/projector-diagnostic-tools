from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
import sys
FN="libs/audio.primary.mt5889.so"
start=int(sys.argv[1],16); n=int(sys.argv[2],16) if len(sys.argv)>2 else 0x140
f=open(FN,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
tdata=text.data(); tbase=text['sh_addr']
# resolve exports for names
d=elf.get_section_by_name('.dynsym')
names={}
for s in d.iter_symbols():
    if s.name: names.setdefault(s['st_value']&~1, s.name)
# rodata for literal strings
rod=elf.get_section_by_name('.rodata')
rdata=rod.data() if rod else b''; rbase=rod['sh_addr'] if rod else 0
def str_at(va):
    if not rod: return None
    off=va-rbase
    if 0<=off<len(rdata):
        e=rdata.find(b'\x00', off)
        if e<0: e=len(rdata)
        try: return rdata[off:e].decode('utf-8')
        except: return None
    return None
md=Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail=True
off=start-tbase
buf=tdata[off:off+n]
addr=start
for ins in md.disasm(buf, addr):
    extra=""
    if ins.mnemonic in ('bl','blx'):
        t=ins.operands[0].imm if ins.operands and ins.operands[0].type==2 else None
        if t is not None:
            extra=f"  ; -> {names.get(t&~1, hex(t))}"
    if ins.mnemonic=='ldr':
        for op in ins.operands:
            if op.type==3 and op.mem.base==35:
                lit=((ins.address & ~3)+4+op.mem.disp)&0xffffffff
                s=str_at(lit)
                extra=f"  ; lit={lit:08x}" + (f" '{s}'" if s else "")
    print(f"  {ins.address:08x}: {ins.mnemonic:10s} {ins.op_str}{extra}")
