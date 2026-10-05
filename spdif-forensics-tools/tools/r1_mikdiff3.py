import sys, struct
sys.path.insert(0, r'C:/firmware_temp/spdif_audio_investigation/tools')
from forensic_elf import ELF32
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM

PATH_ORIG = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
PATH_DEV  = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase1/pulled/mik.device.ko'
FOFF = 0x9A414

e = ELF32(PATH_ORIG)
# find .text section index
text_idx = None
for i, s in enumerate(e.secs):
    if s['name'] == '.text':
        text_idx = i
print(".text section index =", text_idx, "off=0x%x size=0x%x" % (s['off'], s['size']))
REL = FOFF - s['off']
print("file offset 0x%x -> .text relative 0x%x" % (FOFF, REL))

# filter symbols belonging to .text
cands = []
for sym in getattr(e, 'syms', []):
    try:
        nm = sym['name']; val = sym['value']; shndx = sym.get('shndx', None)
    except Exception:
        continue
    if isinstance(val, str): continue
    if shndx == text_idx:
        cands.append((val, nm))
cands.sort()
best = None
for v, nm in cands:
    if v <= REL:
        best = (v, nm)
print("\nnearest .text symbol <= 0x%x :  %s @ 0x%x  (delta +0x%x)" % (REL, best[1], best[0], REL-best[0]) if best else "none")
print("\n.text symbols near (sorted, showing window):")
for v, nm in cands:
    if best and best[0]-0x400 <= v <= best[0]+0x2000:
        print("   0x%08x  %s" % (v, nm))

md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True
orig = open(PATH_ORIG,'rb').read()[FOFF-0x28:FOFF+0x48]
dev  = open(PATH_DEV ,'rb').read()[FOFF-0x28:FOFF+0x48]
cur  = REL-0x28
print("\n=== ORIGINAL mik.ko (.text+0x%x) ===" % REL)
for i in md.disasm(orig, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "   <<<< PATCHED" if i.address==REL else ""))
print("\n=== DEPLOYED mik.ko (.text+0x%x) ===" % REL)
for i in md.disasm(dev, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "   <<<< PATCHED" if i.address==REL else ""))
