from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
import struct
LIB="libs/libutopia.so"
f=open(LIB,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
tdata=text.data(); tbase=text['sh_addr']; tsz=text['sh_size']
rod=elf.get_section_by_name('.rodata')
print(f".text base={tbase:08x} size={tsz:#x}   .rodata base={rod['sh_addr']:08x} size={rod['sh_size']:#x}")
targets={
 "SPDIF out codec prev":0x1656ca,
 "Hash Key DTSX Fail":0x165546,
 "eDigitalOutfMode":0x1a7700,
 "Fail switch SPDIF":0x1ad63e,
 "HAL SPDIF Non-PCM":0x17d9cc,
 "HAL SPDIF PCM":0x147653,
 "Hash-key Support DTSX":0x1acf12,
 "Tx_NonPCM":0x1a74c8,
 "SPDIF mode set to":0x1b8d53,
 "Invalid SPDIF Path":0x16b49b,
 "DTSXEncode cur":0x13b6f5,
 "R2NonPcmSetting":0x1a7738,
}
md=Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail=True
def find_loaders(pool_addr, window=0x1200):
    """scan .text backwards from pool_addr for a ldr rx,[pc,#imm] resolving to pool_addr"""
    lo=tbase; hi=tbase+tsz
    st=max(lo, pool_addr-window); en=min(hi, pool_addr+8)
    buf=tdata[st-tbase:en-tbase]
    out=[]
    a=st|1
    i=0
    while a < en-1:
        got=False
        for ins in md.disasm(buf[i:], a):
            got=True
            if ins.id==111:  # ARM_INS_LDR
                ops=ins.operands
                if len(ops)>=2 and ops[1].type==3:  # mem
                    m=ops[1].mem
                    if m.base==35:  # ARM_REG_PC
                        tgt=((ins.address & ~3)+4+m.disp)&0xffffffff
                        if tgt==pool_addr:
                            out.append(ins.address)
            a=ins.address+ins.size; i+=ins.size
        if not got:
            i+=2; a+=2
    return out
def fn_start(addr):
    """walk back for push {..lr} prologue"""
    lim=max(tbase, addr-0x4000)
    a=addr & ~1
    best=None
    while a>lim:
        a-=2
        w=struct.unpack_from('<H', tdata, a-tbase)[0]
        # push {..., lr}: pattern b5xx (push with lr) or b4xx
        if (w & 0xff00)==0xb500 and (w & 0x0100):
            best=a|1; break
        if (w & 0xff00)==0xb400:
            best=a|1; break
    return best
print("\n== literal refs ==")
for k,S in targets.items():
    pat=struct.pack('<I', S)
    idx=tdata.find(pat)
    if idx<0:
        # try in .rodata / .data too
        print(f"{k:24s} S={S:08x} : pool word not found in .text"); continue
    pool=tbase+idx
    loaders=find_loaders(pool)
    fs=[fn_start(L) for L in loaders]
    print(f"{k:24s} S={S:08x} pool={pool:08x} loaders={[hex(x) for x in loaders]} fn_start={[hex(x) if x else '??' for x in fs]}")
