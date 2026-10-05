from elftools.elf.elffile import ELFFile
import re
LIB="libs/libutopia.so"
f=open(LIB,'rb'); elf=ELFFile(f)
print("has .symtab:", elf.get_section_by_name('.symtab') is not None)
print("has .dynsym:", elf.get_section_by_name('.dynsym') is not None)
# string VAs
targets={
 "SPDIF out codec prev":"SPDIF out codec prev(%d), new(%d)",
 "eDigitalOutfMode":"eDigitalOutfMode  = %x, eNonPcmPath = %x",
 "Fail switch SPDIF":"Fail to switch SPDIF mode",
 "HAL SPDIF Non-PCM":"HAL SPDIF set as Non-PCM",
 "HAL SPDIF PCM":"HAL SPDIF set as PCM output",
 "Hash Key DTSX Fail":"Hash Key Check DTSX Fail, no DTSX license",
 "Hash-key Support DTSX":"Hash-key Support DTSX.",
 "Tx_NonPCM":"Tx_NonPCM",
 "SPDIF mode set to":"SPDIF mode set to %s",
 "Invalid SPDIF Path":"Invalid SPDIF Path",
 "DTSXEncode cur":"DTSXEncode current(%d), next(%d)",
 "R2NonPcmSetting":"R2NonPcmSetting = %x",
}
for sn in ['.rodata','.rodata1','.data','.data.ro']:
    sec=elf.get_section_by_name(sn)
    if not sec: continue
    data=sec.data(); base=sec['sh_addr']
    for key,sub in targets.items():
        idx=data.find(sub.encode())
        if idx>=0:
            print(f"[{sn}] {key}: va={base+idx:08x}  '{sub}'")
# enclosing function via symtab
symsec=elf.get_section_by_name('.symtab')
if symsec:
    syms=[(s['st_value'],s.name) for s in symsec.iter_symbols() if s['st_value']!=0 and s.name and not s.name.startswith('.L')]
    syms.sort()
    def enclosing(va):
        best=None
        for v,nm in syms:
            if v<=va: best=(v,nm)
            else: break
        return best
    # re-find VAs quickly for the decision strings
    for sn in ['.rodata','.data','.data.ro']:
        sec=elf.get_section_by_name(sn)
        if not sec: continue
        data=sec.data(); base=sec['sh_addr']
        for key,sub in targets.items():
            idx=data.find(sub.encode())
            if idx>=0:
                va=base+idx
                b=enclosing(va)
                if b: print(f"   -> enclosing fn: {b[1]} @ {b[0]:08x} (off {va-b[0]:x})")
