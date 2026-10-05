from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM
import re, collections
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
text=elf.get_section_by_name('.text')
tdata=text.data(); tbase=text['sh_addr']; tsz=text['sh_size']
symsec=elf.get_section_by_name('.symtab')
syms=sorted([(s['st_value'],s.name) for s in symsec.iter_symbols()
             if s['st_value']!=0 and s.name and not s.name.startswith('.L')])
def nm(a):
    lo,hi,best=0,len(syms)-1,None
    while lo<=hi:
        m=(lo+hi)//2
        if syms[m][0]<=a: best=syms[m]; lo=m+1
        else: hi=m-1
    return (best[1] if best and a-best[0]<0x3000 else "??")
WATCH={
 0x44428c:"HAL_AUDIO_SPDIF_Tx_SetNonPCM",
 0x448a10:"HAL_AUDIO_SPDIF_SetMode",
 0x44678c:"HAL_AUDIO_SPDIF_ApplySetting",
 0x44660c:"HAL_AUDIO_DigitalTx_SPDIFConfig",
 0x444010:"HAL_AUDIO_DTSELoadCode",
 0x444f40:"HAL_AUDIO_SPDIF_BypassMode",
 0x445504:"HAL_AUDIO_SPDIF_TranscodeMode",
 0x444914:"HAL_AUDIO_SPDIF_AutoMode",
 0x445dbc:"HAL_AUDIO_SPDIF_PcmMode",
 0x44a2c4:"HAL_AUDIO_SPDIF_SetOutputType",
 0x422aa0:"MDrv_AUDIO_Get_DTS_License",
 0x464958:"HAL_MAD_GetDtsInfo",
 0x464888:"HAL_MAD_SetDTSCommonCtrl",
 0x444398:"HAL_AUDIO_HDMI_ARC_SetNonPCM",
 0x4444b4:"HAL_AUDIO_HDMI_eARC_SetNonPCM",
 0x4448fc:"HAL_AUDIO_SPDIF_Set_OmxOutputPcmMode",
 0x445edc:"HAL_AUDIO_DigitalTx_ApplySetting",
}
def imm(op):
    s=op.strip()
    m=re.match(r'#0x([0-9a-fA-F]+)$', s)
    if m: return int(m.group(1),16)
    m=re.match(r'#(\d+)$', s)
    if m: return int(m.group(1))
    return None
md=Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail=False; md.skipdata=True
hits=collections.defaultdict(list)
nbr=0
CH=0x40000
for off in range(0, tsz, CH):
    chunk=tdata[off:off+CH]
    addr=(tbase+off)
    for ins in md.disasm(chunk, addr):
        mn=ins.mnemonic
        if mn.startswith('bl') or mn.startswith('blx'):
            nbr+=1
            t=imm(ins.op_str)
            if t is not None:
                t&=~1
                if t in WATCH:
                    hits[WATCH[t]].append(ins.address)
print(f"total bl/blx seen: {nbr}")
if not hits:
    print("NO direct callers found")
for fn,cs in hits.items():
    print(f"\n### {fn}  ({len(cs)} callers)")
    for c in cs:
        print(f"    bl @ {c:08x}   in {nm(c)}")
