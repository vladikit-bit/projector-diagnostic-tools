from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
import re
LIB="libs/libutopia.so"
f=open(LIB,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
tdata=text.data(); tbase=text['sh_addr']; tsz=text['sh_size']
targets={
 0x1656ca:"SPDIF out codec prev",
 0x165546:"Hash Key DTSX Fail",
 0x1a7700:"eDigitalOutfMode",
 0x1ad63e:"Fail switch SPDIF",
 0x17d9cc:"HAL SPDIF Non-PCM",
 0x147653:"HAL SPDIF PCM",
 0x1acf12:"Hash-key Support DTSX",
 0x1a74c8:"Tx_NonPCM",
 0x1b8d53:"SPDIF mode set to",
 0x16b49b:"Invalid SPDIF Path",
 0x13b6f5:"DTSXEncode cur",
 0x1a7738:"R2NonPcmSetting",
}
def imm(op):
    s=op.replace(' ','')
    m=re.match(r'#0x([0-9a-fA-F]+)', s)
    if m: return int(m.group(1),16)
    m=re.match(r'#(\d+)', s)
    if m: return int(m.group(1))
    return None
md=Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail=False; md.skipdata=True
found={}
prev=None
CH=0x40000
for off in range(0, tsz, CH):
    chunk=tdata[off:off+CH]
    addr=(tbase+off)|1
    for ins in md.disasm(chunk, addr):
        mn=ins.mnemonic
        if mn=='movw':
            parts=[p.strip() for p in ins.op_str.split(',')]
            prev=(ins.address, imm(parts[1]) if len(parts)>1 else None, parts[0] if parts else None)
        elif mn=='movt':
            parts=[p.strip() for p in ins.op_str.split(',')]
            val=imm(parts[1]) if len(parts)>1 else None
            rd=parts[0] if parts else None
            if prev and prev[1] is not None and val is not None and rd==prev[2]:
                S=(val<<16)|prev[1]
                if S in targets:
                    found.setdefault(targets[S],[]).append(prev[0])
            prev=None
        else:
            prev=None
print("== movw/movt refs ==")
for S,nm in sorted(targets.items(), key=lambda x:x[1]):
    if nm in found:
        print(f"{nm:24s} S={S:08x} movw@ {[hex(x) for x in found[nm]]}")
    else:
        print(f"{nm:24s} S={S:08x} NOT FOUND")
