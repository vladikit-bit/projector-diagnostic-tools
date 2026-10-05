from elftools.elf.elffile import ELFFile
import re
for KO in ["kmods/utpa2k.ko"]:
    f=open(KO,'rb'); elf=ELFFile(f)
    print("====",KO)
    for sec in elf.iter_sections():
        if sec.name=='.text':
            print(f".text addr={sec['sh_addr']:08x} size={sec['sh_size']} off={sec['sh_offset']}")
    symsec=elf.get_section_by_name('.symtab')
    want=re.compile(r'SPDIF|NonPCM|Nonpcm|SetNonPCM|DTS|SDO|DigitalTx|SetOutputType|SetMode|Bypass|Transcode|PcmMode|AutoMode|Enc|Mad', re.I)
    items=[]
    if symsec:
        for s in symsec.iter_symbols():
            nm=s.name
            if nm and want.search(nm) and s['st_value']!=0:
                items.append((s['st_value'],nm))
    items.sort()
    for v,nm in items:
        print(f"{v:08x} {nm}")
