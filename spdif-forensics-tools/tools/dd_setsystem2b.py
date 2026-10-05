import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/utpa2k.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)
f=ArmFunc(e,0x44d0b0,name='HAL_AUDIO_SetSystem2',size=0x360)
for i in f.insns:
    s=f"{i.mnemonic} {i.op_str}"
    extra=''
    if i.mnemonic in ('bl','blx'):
        t=rl.call_target(i.address)
        if t: extra=f"   ; -> {t}"
    va=i.address
    # print region around the 0x4d8 read and any byte/decoder selection
    if va>=0x44d120 and va<=0x44d2e0:
        print(f"0x{va:08x}: {s}{extra}")
