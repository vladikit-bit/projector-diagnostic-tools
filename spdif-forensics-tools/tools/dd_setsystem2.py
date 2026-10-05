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
    # highlight 0x4d8/0x4d0 reads and any byte select / store
    if '#0x4d8' in s or '#0x4d0' in s or '#0x4d4' in s or '0x4d8' in s or '0x4d0' in s or i.mnemonic in ('strb','str'):
        print(f"0x{i.address:08x}: {s}{extra}")
