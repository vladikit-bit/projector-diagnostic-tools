#!/usr/bin/env python3
"""OBJ 5: who else calls MApi_AUDIO_SPDIF_SetMode (mik.ko callers 0x7dd64,0x7de40,0x98ddc)
and is there any LATER writer of the SPDIF/HDMI mode fields.
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
mik = ELF32(f"{BASE}/kmods/mik.ko"); Relocs(mik); attach(mik)
utp = ELF32(f"{BASE}/kmods/utpa2k.ko"); Relocs(utp); attach(utp)

out = open(f"{BASE}/tools/final_callers.txt","w")

def fnof(e, va):
    best=None
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0: continue
        if s['value']<=va<s['value']+max(s['size'],1):
            return s['name'],s['value'],s['size']
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0: continue
        if s['value']<=va and (best is None or s['value']>best[1]):
            best=(s['name'],s['value'],s['size'])
    return ((best[0]+f"+0x{va-best[1]:x}") if best else "??", best[1] if best else 0, 0)

out.write("### mik.ko callers of MApi_AUDIO_SPDIF_SetMode\n")
for va in (0x7dd64,0x7de40,0x98ddc):
    nm,fva,fsz = fnof(mik, va)
    out.write(f"\n0x{va:08x}  in  {nm}  (func base 0x{fva:08x} size 0x{fsz:x})\n")
    if fsz:
        f = ArmFunc(mik, fva, min(max(fsz,0x200),0x600), thumb=False, name=nm)
        f.dump(out)
        out.write("  calls:\n")
        for a,t,m in f.calls():
            ts = f"0x{t:x}" if t is not None else "REG"
            out.write(f"    0x{a:08x}: -> {m or 'DYN'}({ts})\n")
    else:
        # disassemble a window around va
        f = ArmFunc(mik, max(va-0x40,0), 0x200, thumb=False, name=nm)
        f.dump(out)

# All mik.ko functions that reference the mode-state offsets 0x6c/0x70/0x7c/0x80
# (store instructions str rX,[rY,#imm] with imm in {0x6c,0x70,0x7c,0x80})
out.write("\n### mik.ko: str to mode offsets 0x6c/0x70/0x7c/0x80 (any function)\n")
import struct
b = mik.b; sec = mik.text
for off in range(sec['off'], sec['off']+sec['size']-8, 4):
    w = struct.unpack_from('<I', b, off)[0]
    # str rT,[rN,#imm] encoding: 0xE5 8 N T imm  (imm is low byte, bits[11:0] offset up to 0xfff)
    if (w & 0xFFF00000)==0xE5800000 or (w & 0xFFF00000)==0xE5800000:
        rn=(w>>16)&0xf; rt=(w>>12)&0xf; imm=w&0xfff
        if imm in (0x6c,0x70,0x7c,0x80):
            va = sec['addr']+off-sec['off']
            nm,_,_ = fnof(mik, va)
            out.write(f"  0x{va:08x} (imm 0x{imm:x}) in {nm}\n")
out.write("\n### utpa2k.ko: str to mode offsets 0x14/0x18 (SetMode state fields)\n")
sec=utp.text; b=utp.b
for off in range(sec['off'], sec['off']+sec['size']-8, 4):
    w = struct.unpack_from('<I', b, off)[0]
    if (w & 0xFFF00000)==0xE5800000:
        imm=w&0xfff
        if imm in (0x14,0x18):
            va = sec['addr']+off-sec['off']
            nm,_,_ = fnof(utp, va)
            out.write(f"  0x{va:08x} (imm 0x{imm:x}) in {nm}\n")

# dtv / hal / libmi3 SetMode callers already known none; confirm HAL has MApi_AUDIO_SPDIF_SetMode def? no.
out.close()
print("wrote tools/final_callers.txt")
