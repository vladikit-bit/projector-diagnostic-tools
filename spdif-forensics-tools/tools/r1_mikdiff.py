import sys, struct
sys.path.insert(0, r'C:/firmware_temp/spdif_audio_investigation/tools')
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach

PATH_ORIG = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
FOFF = 0x9A414

e = ELF32(PATH_ORIG)
attach(e)
print("sections:")
for s in e.secs:
    print("  %-16s off=0x%08x addr=0x%08x size=0x%x" % (s['name'], s['off'], s['addr'], s['size']))

# map file offset -> VA
va = None
for s in e.secs:
    if s['off'] and s['off'] <= FOFF < s['off'] + s['size']:
        va = s['addr'] + (FOFF - s['off'])
        print("\nfile offset 0x%x lies in section %s -> VA 0x%x" % (FOFF, s['name'], va))
        break
if va is None:
    print("\ncould not map offset"); sys.exit(0)

sym = e.nearest_sym(va)
print("nearest symbol: %s @ 0x%x  (delta +0x%x)" % (sym[0], sym[1], va - sym[1]) if sym else "none")

# disassemble a window around it (original bytes)
off = e.va2off(va - 0x40)
data = open(PATH_ORIG,'rb').read()[off:off+0xC0]
f = ArmFunc.__new__(ArmFunc)
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM
md = Cs(CS_ARCH_ARM, CS_MODE_ARM)
md.detail = True
print("\n=== disassembly around VA 0x%x (ORIGINAL mik.ko) ===" % va)
cur = va - 0x40
for i in md.disasm(data, cur):
    mark = " <<<< PATCHED" if i.address == va else ""
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, mark))

# device bytes
dev = open(r'C:/firmware_temp/spdif_audio_investigation/runtime_phase1/pulled/mik.device.ko','rb').read()[off:off+0xC0]
print("\n=== disassembly around VA 0x%x (DEPLOYED mik.ko) ===" % va)
for i in md.disasm(dev, cur):
    mark = " <<<< PATCHED" if i.address == va else ""
    print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, mark))
