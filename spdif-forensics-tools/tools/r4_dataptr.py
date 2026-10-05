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
scan=[s for s in elf.iter_sections() if s.name in ('.data','.data.rel.ro','.got','.rodata','.dynstr','.dynsym','.bss')]
print("== pointer slots holding string VAs ==")
res={}
for s in scan:
    try: d=s.data()
    except Exception: continue
    base=s['sh_addr']
    for S,nm in targets.items():
        pat=struct.pack('<I', S)
        idx=d.find(pat)
        if idx>=0:
            slot=base+idx
            res.setdefault(nm,[]).append((s.name,slot))
            print(f"{nm:24s} S={S:08x} -> slot [{s.name}] {slot:08x}")
print("\n== not found as pointer ==")
for nm in targets.values():
    if nm not in res: print(f"   {nm}")
