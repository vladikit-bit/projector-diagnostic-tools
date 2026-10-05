import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
KO='kmods/utpa2k.ko'
e=ELF32(KO)
print("=== literal 0x112cf0 (LE bytes f0 2c 11 00) occurrences ===")
found=[]
for sec in e.secs:
    data=e.b[sec['off']:sec['off']+sec['size']]
    off=0
    while True:
        idx=data.find(b'\xf0\x2c\x11\x00', off)
        if idx<0: break
        va=sec['addr']+idx if sec.get('addr') else idx
        found.append((sec['name'], hex(va)))
        off=idx+1
print("count:", len(found))
for x in found[:40]: print("  ", x)
