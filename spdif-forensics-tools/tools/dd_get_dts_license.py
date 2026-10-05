import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/utpa2k.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)
f=ArmFunc(e,0x41fb20,name='MDrv_AUDIO_Get_DTS_License',size=0x120)
for i in f.insns:
    extra=''
    if i.mnemonic in ('bl','blx'):
        t=rl.call_target(i.address)
        if t: extra=f"   ; -> {t}"
    print(f"0x{i.address:08x}: {i.mnemonic:<7} {i.op_str}{extra}")
