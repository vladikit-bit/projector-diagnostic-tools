import sys
sys.path.insert(0, r'C:/firmware_temp/spdif_audio_investigation/tools')
from forensic_elf import ELF32
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM

ORIG = r'C:/firmware_temp/spdif_audio_investigation/kmods/mik.ko'
DEV  = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase1/pulled/mik.device.ko'
FOFF = 0x9A334
e = ELF32(ORIG)
TEXT = [s for s in e.secs if s['name']=='.text'][0]
REL = FOFF - TEXT['off']
print("patched insn at .text+0x%x  (inside _MI_AOUT_MonitorTask @ .text+0x971a8, +0x%x)\n" % (REL, REL-0x971a8))
md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True
o = open(ORIG,'rb').read(); d = open(DEV,'rb').read()

def dump(tag, foff, vabase, n=0x60):
    print("=== %s  (.text+0x%x) ===" % (tag, vabase))
    data = (o if tag.startswith("ORIG") else d)[foff:foff+n]
    for i in md.disasm(data, vabase):
        mark = "   <<<< PATCHED (bne -> mov r0,r0 NOP)" if i.address==REL else ""
        print("0x%08x: %-10s %s%s" % (i.address, i.mnemonic, i.op_str, mark))
    print()

# patch site
dump("ORIGINAL - patch site", TEXT['off']+0x97800, 0x97800, 0x60)
dump("DEPLOYED - patch site", TEXT['off']+0x97800, 0x97800, 0x60)
# bne target region (original) : PC=0x97840 -> 0x97848 + 0x40C = 0x97C54
print("### original bne target = 0x97848 + 0x40C = 0x97C54\n")
dump("ORIGINAL - bne target region", TEXT['off']+0x97C40, 0x97C40, 0x50)
