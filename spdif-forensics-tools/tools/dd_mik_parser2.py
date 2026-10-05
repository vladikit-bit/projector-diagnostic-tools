import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/mik.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)
f=ArmFunc(e,0xd3380,name='ParseDispatch',size=0x320)
for i in f.insns:
    s=f"{i.mnemonic} {i.op_str}"
    # highlight tst/orr/bic with immediates and bit computations
    if i.mnemonic in ('tst','orr','bic','and','eor') or 'lsl' in s or 'lsr' in s:
        print(f"0x{i.address:08x}: {s}")
