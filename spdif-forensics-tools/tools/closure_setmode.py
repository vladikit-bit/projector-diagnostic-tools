import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/mik.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)
f=ArmFunc(e,0x989cc,name='SetHdmiAutoMode',size=0x600)
print("=== SetHdmiAutoMode tail (state store + SetMode call) ===")
for i in f.insns:
    s=f"{i.mnemonic} {i.op_str}"
    if 'SetMode' in s or '#0x7c' in s or '#0x80' in s or '#0x6c' in s or '#0x70' in s or i.mnemonic in ('str','bl') and ('r0' in s):
        extra=''
        if i.mnemonic in ('bl','blx'):
            t=rl.call_target(i.address)
            if t: extra=f"   ; -> {t}"
        print(f"0x{i.address:08x}: {s}{extra}")
