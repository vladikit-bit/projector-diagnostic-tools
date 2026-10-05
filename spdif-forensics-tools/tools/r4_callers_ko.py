from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
import re
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
base=text['sh_addr']; data=text.data(); sz=text['sh_size']
# build symbol name lookup for caller resolution
symsec=elf.get_section_by_name('.symtab')
syms=[]
for s in symsec.iter_symbols():
    if s['st_value']!=0 and s.name and not s.name.startswith('.L'):
        syms.append((s['st_value'],s.name))
syms.sort()
def nm(addr):
    # nearest symbol <= addr
    lo=0; hi=len(syms)-1; best=None
    while lo<=hi:
        mid=(lo+hi)//2
        if syms[mid][0]<=addr: best=syms[mid]; lo=mid+1
        else: hi=mid-1
    if best and addr-best[0]<0x4000: return best[1]
    return "??"
WATCH={
 0x44428c:"HAL_AUDIO_SPDIF_Tx_SetNonPCM",
 0x448a10:"HAL_AUDIO_SPDIF_SetMode",
 0x44678c:"HAL_AUDIO_SPDIF_ApplySetting",
 0x44660c:"HAL_AUDIO_DigitalTx_SPDIFConfig",
 0x444010:"HAL_AUDIO_DTSELoadCode",
 0x444f40:"HAL_AUDIO_SPDIF_BypassMode",
 0x445504:"HAL_AUDIO_SPDIF_TranscodeMode",
 0x44914:"HAL_AUDIO_SPDIF_AutoMode",
 0x45dbc:"HAL_AUDIO_SPDIF_PcmMode",
 0x44a2c4:"HAL_AUDIO_SPDIF_SetOutputType",
 0x422aa0:"MDrv_AUDIO_Get_DTS_License",
 0x464958:"HAL_MAD_GetDtsInfo",
}
# bound scan to audio mapi region
LO=0x3d0000; HI=0x4c0000
md=Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail=True
import collections
hits=collections.defaultdict(list)
off0=LO-base
# need to align to Thumb (odd) addresses; disassemble from LO (odd)
code=data[off0:HI-base]
addr=LO|1
end=HI
i=0
while addr<end:
    try:
        for insn in md.disasm(code[i:], addr):
            if insn.id in (24,25): # ARM_INS_BL=24, BLX=25 (capstone ARM)
                # operand: first op is immediate target
                tgt=None
                for op in insn.operands:
                    if op.type==2: # immediate
                        tgt=op.imm; break
                if tgt is None:
                    # blx reg: skip
                    addr=insn.address+2; i+=insn.size; continue
                t=tgt&~1
                if t in WATCH:
                    hits[WATCH[t]].append((insn.address, nm(insn.address)))
                addr=insn.address+insn.size
                i+=insn.size
            else:
                addr=insn.address+insn.size
                i+=insn.size
        break
    except Exception as e:
        # skipdata
        i+=2; addr+=2
for fn,calls in hits.items():
    print(f"\n### CALLERS of {fn} ({len(calls)}):")
    for ca,nn in calls:
        print(f"   bl @ {ca:08x}  in {nn}")
if not hits:
    print("no callers found in region")
