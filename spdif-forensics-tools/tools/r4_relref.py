from elftools.elf.elffile import ELFFile
import struct
LIB="libs/libutopia.so"
f=open(LIB,'rb'); elf=ELFFile(f)
targets={
 0x1656ca:"SPDIF out codec prev", 0x165546:"Hash Key DTSX Fail",
 0x1a7700:"eDigitalOutfMode", 0x1ad63e:"Fail switch SPDIF",
 0x17d9cc:"HAL SPDIF Non-PCM", 0x147653:"HAL SPDIF PCM",
 0x1acf12:"Hash-key Support DTSX", 0x1a74c8:"Tx_NonPCM",
 0x1b8d53:"SPDIF mode set to", 0x16b49b:"Invalid SPDIF Path",
 0x13b6f5:"DTSXEncode cur", 0x1a7738:"R2NonPcmSetting",
}
print("sections:", [(s.name,hex(s['sh_addr']),hex(s['sh_size'])) for s in elf.iter_sections() if s.name in ('.text','.rodata','.data','.data.rel.ro','.bss','.got','.got.plt','.rel.dyn','.rel.plt','.dynsym','.dynstr')])
hits={}
for relsec in [elf.get_section_by_name('.rel.dyn'), elf.get_section_by_name('.rel.plt')]:
    if not relsec: continue
    print(f"\n-- {relsec.name}")
    for r in relsec.iter_relocations():
        add=getattr(r,'r_addend',None)
        if add is None: continue
        if add in targets:
            hits.setdefault(targets[add],[]).append((r['r_offset'], r['r_info_type']))
            print(f"   {targets[add]:24s} addend={add:08x} -> slot={r['r_offset']:08x} type={r['r_info_type']}")
print("\n== summary ==")
for nm in targets.values():
    print(f"{nm:24s}: {'SLOT '+hex(hits[nm][0][0]) if nm in hits else 'no reloc'}")
