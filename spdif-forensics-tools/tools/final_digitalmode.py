#!/usr/bin/env python3
"""OBJ 4: disassemble mik.ko MI_AOUT_SetDigitalMode @0x7faf8 to see whether the
property-driven digital output type reaches the EDID capability bitmap or only a
'desired' type field."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
mik = ELF32(f"{BASE}/kmods/mik.ko"); Relocs(mik); attach(mik)
out = open(f"{BASE}/tools/final_digitalmode.txt","w")
f = ArmFunc(mik, 0x7faf8, 0x258, thumb=False, name="MI_AOUT_SetDigitalMode")
f.dump(out)
out.write("\n--- calls ---\n")
for a,t,m in f.calls():
    ts=f"0x{t:x}" if t is not None else "REG"
    out.write(f"  0x{a:08x}: -> {m or 'DYN'}({ts})\n")
# show all str/strb immediates to see which struct offsets it touches
out.write("\n--- store immediates (str/strb) ---\n")
import struct
b=mik.b; sec=mik.text
start=0x7faf8; n=0x258
off0=sec['off']+start-sec['addr']
for o in range(off0, off0+n-4, 4):
    w=struct.unpack_from('<I', b, o)[0]
    if (w&0xFFF00000)==0xE5800000:  # str
        rn=(w>>16)&0xf; rt=(w>>12)&0xf; imm=w&0xfff
        va=start+o-off0
        out.write(f"  0x{va:08x}: str r{rt},[r{rn},#0x{imm:x}]\n")
    elif (w&0xFFF00000)==0xE5C00000:  # strb
        rn=(w>>16)&0xf; rt=(w>>12)&0xf; imm=w&0xfff
        va=start+o-off0
        out.write(f"  0x{va:08x}: strb r{rt},[r{rn},#0x{imm:x}]\n")
out.close()
print("wrote tools/final_digitalmode.txt")
