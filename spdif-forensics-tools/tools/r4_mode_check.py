from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB
import struct
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
tdata=text.data(); tbase=text['sh_addr']
def show(addr, mode, n=12):
    md=Cs(CS_ARCH_ARM, mode); md.detail=False
    off=addr-tbase
    buf=tdata[off:off+64]
    out=[]
    for i,ins in enumerate(md.disasm(buf, addr)):
        if i>=n: break
        out.append(f"  {ins.address:08x}: {ins.mnemonic:8s} {ins.op_str}")
    return out
for tgt in (0x44428c, 0x448a10):
    print(f"=== {tgt:08x} ARM mode ===")
    for l in show(tgt, CS_MODE_ARM): print(l)
    print(f"=== {tgt:08x} THUMB mode ===")
    for l in show(tgt|1, CS_MODE_THUMB): print(l)
    print()
# count branches over a sample in each mode
mdA=Cs(CS_ARCH_ARM, CS_MODE_ARM); mdA.detail=False
mdT=Cs(CS_ARCH_ARM, CS_MODE_THUMB); mdT.detail=False
for mode,md,st in (("ARM",mdA,0x444000),("THUMB",mdT,0x444000|1)):
    off=st-tbase
    buf=tdata[off:off+0x4000]
    nb=sum(1 for ins in md.disasm(buf, st) if ins.mnemonic.startswith(('bl','b ')))
    print(f"{mode}: branches in 16KB sample @0x444000: {nb}")
