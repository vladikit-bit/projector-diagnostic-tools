import sys
sys.path.insert(0, r'C:/firmware_temp/spdif_audio_investigation/tools')
from forensic_elf import ELF32
from forensic_dis import attach
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM

PATH_ORIG = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
PATH_DEV  = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase1/pulled/mik.device.ko'
FOFF = 0x9A414

e = ELF32(PATH_ORIG)
attach(e)
va = 0x97920
print("VA = 0x%x" % va)
# list symbols <= va, find closest
best = None
for s in getattr(e, 'syms', []):
    try:
        nm = s['name']; a = s['value']
    except Exception:
        continue
    if isinstance(a, str):
        continue
    if a <= va and (best is None or a > best[1]):
        best = (nm, a)
print("nearest symbol <= VA: %s @ 0x%x (delta +0x%x)" % (best[0], best[1], va-best[1]) if best else "none")
# also symbols containing
print("\nsymbols in [0x97000,0x99000]:")
for s in getattr(e, 'syms', []):
    try:
        nm = s['name']; a = s['value']
    except Exception: continue
    if isinstance(a,str): continue
    if 0x97000 <= a <= 0x99000:
        print("   0x%08x  %s" % (a, nm))

md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True
off = e.va2off(va - 0x30)
orig = open(PATH_ORIG,'rb').read()[off:off+0xA0]
dev  = open(PATH_DEV ,'rb').read()[off:off+0xA0]
cur = va - 0x30
print("\n=== ORIGINAL mik.ko @ VA 0x%x ===" % va)
for i in md.disasm(orig, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "  <<<< PATCHED BYTE" if i.address==va else ""))
print("\n=== DEPLOYED mik.ko @ VA 0x%x ===" % va)
for i in md.disasm(dev, cur):
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, "  <<<< PATCHED BYTE" if i.address==va else ""))
