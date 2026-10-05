import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/utpa2k.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)
# CheckHashkey spans ~0x423494 .. 0x4248xx
f=ArmFunc(e,0x423494,name='CheckHashkey',size=0x1100)
print("=== CheckHashkey: any AbsReadReg / 0x112cf0 strap access? ===")
hits=0
for i in f.insns:
    s=f"{i.mnemonic} {i.op_str}"
    if 'AbsReadReg' in s or (i.mnemonic in ('movw','movt') and ('0x2cf0' in s or '0x11' in s)):
        print(f"0x{i.address:08x}: {s}")
        hits+=1
print("strap-related hits in CheckHashkey:", hits)
# Also: does MDrv_AUTH_IPCheck read the strap? find its body.
for s in e.syms:
    if s.get('name')=='MDrv_AUTH_IPCheck':
        print("MDrv_AUTH_IPCheck @", hex(s['value']))
