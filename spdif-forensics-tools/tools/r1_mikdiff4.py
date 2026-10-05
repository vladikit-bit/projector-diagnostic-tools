import sys
sys.path.insert(0, r'C:/firmware_temp/spdif_audio_investigation/tools')
from forensic_elf import ELF32
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM

PATH_ORIG = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
PATH_DEV  = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase1/pulled/mik.device.ko'
FOFF = 0x9A414

e = ELF32(PATH_ORIG)
TEXT_IDX = None; TEXT = None
for i, s in enumerate(e.secs):
    if s['name'] == '.text':
        TEXT_IDX = i; TEXT = dict(s); break
print(".text: index=%d off=0x%x size=0x%x" % (TEXT_IDX, TEXT['off'], TEXT['size']))
REL = FOFF - TEXT['off']
print("file off 0x%x -> .text+0x%x" % (FOFF, REL))

cands = []
for sym in getattr(e, 'syms', []):
    nm = sym.get('name'); val = sym.get('value'); shndx = sym.get('shndx')
    if isinstance(val, str) or val is None: continue
    if shndx == TEXT_IDX:
        cands.append((val, nm))
cands.sort()
best = None
for v, nm in cands:
    if v <= REL: best = (v, nm)
print("\nCONTAINING FUNCTION: %s @ .text+0x%x   (patched insn at +0x%x)" % (best[1], best[0], REL-best[0]) if best else "none")
print("\n.text symbols around:")
for v, nm in cands:
    if best and best[0] <= v <= best[0]+0x3000:
        print("   .text+0x%08x  %s" % (v, nm))

md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True
orig = open(PATH_ORIG,'rb').read()[FOFF-0x20:FOFF+0x40]
dev  = open(PATH_DEV ,'rb').read()[FOFF-0x20:FOFF+0x40]
cur  = REL-0x20
print("\n=== ORIGINAL mik.ko (.text+0x%x) ===" % REL)
for i in md.disasm(orig, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "   <<<< PATCHED INSN" if i.address==REL else ""))
print("\n=== DEPLOYED mik.ko (.text+0x%x) ===" % REL)
for i in md.disasm(dev, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "   <<<< PATCHED INSN" if i.address==REL else ""))
