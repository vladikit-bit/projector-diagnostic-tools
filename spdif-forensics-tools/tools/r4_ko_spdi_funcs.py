from elftools.elf.elffile import ELFFile
import re,json
KO="kmods/utpa2k.ko"
f=open(KO,'rb'); elf=ELFFile(f)
symsec=elf.get_section_by_name('.symtab')
want=re.compile(r'SPDIF|NonPCM|Nonpcm|SetNonPCM|DTS|SDO|DigitalTx|SetOutputType|BypassMode|TranscodeMode|PcmMode|AutoMode|Enc', re.I)
items=[]
for s in symsec.iter_symbols():
    nm=s.name
    if nm and want.search(nm) and s['st_value']!=0 and not nm.startswith('.L'):
        items.append((s['st_value'],nm))
items.sort()
for v,nm in items:
    print(f"{v:08x} {nm}")
