from elftools.elf.elffile import ELFFile
import re
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
print("== SYMTAB (audio-related) ==")
symsec=elf.get_section_by_name('.symtab')
want=re.compile(r'SPDIF|NonPCM|NonPcm|DTS|SDO|AOUT|MAD_|DigitalTx|SetMode|SetOutputType|Transcode|IEC|Bypass|Monitor|Enc', re.I)
cnt=0; hits=[]
if symsec:
    for s in symsec.iter_symbols():
        nm=s.name
        if nm and want.search(nm):
            cnt+=1; hits.append((s['st_value'],nm))
    hits.sort()
    for v,nm in hits[:200]:
        print(f"{v:08x} {nm}")
    print("total audio syms:",cnt)
else:
    print("no .symtab")
# find target decision strings in rodata/data
print("== TARGET STRINGS (VA) ==")
targets=[
 "SPDIF out codec prev",
 "eDigitalOutfMode",
 "eNonPcmPath",
 "Fail to switch SPDIF mode",
 "HAL SPDIF set as Non-PCM",
 "HAL SPDIF set as PCM output",
 "Hash Key Check DTSX Fail",
 "Hash-key Support DTSX",
 "Tx_NonPCM",
 "Mstar_DTS_Hdmi_Packer error",
 "DTSX_CORE2_API_SDO_Packer",
 "Invalid SPDIF Path",
 "SPDIF AUDIO FREQUENCY UNVALID",
 "Set SPDIF Audio Delay",
 "spdif ISR",
 "D2A_DTSXENC",
]
for sec in [elf.get_section_by_name(n) for n in ['.rodata','.rodata.str','.data','.data.ro','.data.str']]:
    if not sec: continue
    data=sec.data()
    base=sec['sh_addr']
    for t in targets:
        idx=data.find(t.encode())
        if idx>=0:
            print(f"  [{sec.name}+{idx:06x}] va={base+idx:08x}  '{t}'")
