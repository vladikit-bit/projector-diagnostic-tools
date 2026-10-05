import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs

KO = 'kmods/mik.ko'
e = ELF32(KO)
attach(e)
rl = Relocs(e)

def disasm(va, size, name):
    f = ArmFunc(e, va, name=name, size=size)
    print(f"\n=== {name} @0x{va:x} size 0x{size:x} ===")
    for i in f.insns:
        extra=''
        if i.mnemonic in ('bl','blx'):
            t = rl.call_target(i.address)
            if t: extra=f"   ; -> {t}"
        print(f"0x{i.address:08x}: {i.mnemonic:<7} {i.op_str}{extra}")

# SetHdmiAutoMode full-ish
disasm(0x989cc, 0x700, '_MI_AOUT_SetHdmiAutoMode')
# parser dispatch continuation
disasm(0xd3380, 0x400, 'ParseDispatch')
