from elftools.elf.elffile import ELFFile
import re
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
symsec=elf.get_section_by_name('.symtab')
want=re.compile(r'HAL_AUDIO_SPDIF|HAL_AUDIO_HDMI.*NonPCM|HAL_AUDIO_HDMI.*SetNon|SetNonPCM|SPDIF_Tx|SPDIF_Bypass|SPDIF_Transcode|SPDIF_Pcm|SPDIF_Auto|SPDIF_SetOutputType|SPDIF_SetMode|DigitalTx|HAL_AUDIO_DTSE|Get_DTS_License|HAL_MAD_GetDts|DTS_Enc|HAL_MAD_SetDTS|SetDTSCommonCtrl|HAL_MAD_Monitor_DDPlus', re.I)
items=[]
for s in symsec.iter_symbols():
    nm=s.name
    if nm and want.search(nm) and s['st_value']!=0 and not nm.startswith('.L'):
        items.append((s['st_value'],nm))
items.sort()
for v,nm in items:
    print(f"{v:08x} {nm}")
