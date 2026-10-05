import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
KO='kmods/utpa2k.ko'
e=ELF32(KO); attach(e); rl=Relocs(e)

target=None
for s in e.syms:
    nm=s.get('name','')
    if 'Get_DTS_License' in nm:
        print("SYM", nm, hex(s['value']))
        target=s['value']
if target is not None:
    f=ArmFunc(e,target,name='Get_DTS_License',size=0x200)
    for i in f.insns:
        extra=''
        if i.mnemonic in ('bl','blx'):
            t=rl.call_target(i.address)
            if t: extra=f"   ; -> {t}"
        print(f"0x{i.address:08x}: {i.mnemonic:<7} {i.op_str}{extra}")

print("\n=== literal 0x112cf0 (LE bytes f0 2c 11 00) occurrences ===")
found=[]
for sec in e.sections:
    data=sec['data']
    off=0
    while True:
        idx=data.find(b'\xf0\x2c\x11\x00', off)
        if idx<0: break
        va=sec['sh_addr']+idx if sec.get('sh_addr') else idx
        found.append((sec['name'], hex(va)))
        off=idx+1
print("occurrences:", found[:30])
print("count:", len(found))
