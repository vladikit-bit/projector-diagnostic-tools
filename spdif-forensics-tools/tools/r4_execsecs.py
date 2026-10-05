from elftools.elf.elffile import ELFFile
for FN in ["libs/libutopia.so","kmods/utpa2k.ko","libs/audio.primary.mt5889.so"]:
    f=open(FN,'rb'); elf=ELFFile(f)
    tot=0; secs=[]
    for s in elf.iter_sections():
        fl=s['sh_flags']
        if fl & 0x4:  # SHF_EXECINSTR
            secs.append((s['sh_addr'], s['sh_size'], s.name)); tot+=s['sh_size']
    secs.sort()
    print(f"=== {FN}: {len(secs)} exec sections, total {tot:#x} bytes")
    for a,sz,nm in secs[:15]:
        print(f"    {nm:40s} {a:08x} {sz:#x}")
    if len(secs)>15: print(f"    ... ({len(secs)-15} more)")
    f.close()
