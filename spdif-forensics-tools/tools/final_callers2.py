#!/usr/bin/env python3
"""OBJ 5: characterize the two extra mik.ko callers of MApi_AUDIO_SPDIF_SetMode
(0x7dd64, 0x7de40) and name their enclosing functions (exclude giant blob syms)."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
mik = ELF32(f"{BASE}/kmods/mik.ko"); Relocs(mik); attach(mik)
out = open(f"{BASE}/tools/final_callers2.txt","w")

def fnname(e, va):
    # prefer a real function symbol (size <= 0x4000) whose range contains va
    best=None
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0: continue
        if s['size']>0x4000: continue
        if s['value']<=va<s['value']+max(s['size'],1):
            return s['name'],s['value'],s['size']
    # fallback: nearest preceding symbol of any size
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0: continue
        if s['value']<=va and (best is None or s['value']>best[1]):
            best=(s['name'],s['value'],s['size'])
    return (best[0] if best else "??", best[1] if best else 0, 0)

for va in (0x7dd64,0x7de40,0x98ddc):
    nm,fva,fsz = fnname(mik, va)
    out.write(f"\n##### caller @0x{va:08x}  ->  function '{nm}' (base 0x{fva:08x} size 0x{fsz:x})\n")
    # disassemble from the function base (or a window) up to ~0x400
    start = fva if (fva and fva<=va and va-fva<0x800) else max(va-0x80,0)
    f = ArmFunc(mik, start, 0x300, thumb=False, name=nm)
    f.dump(out)
    out.write("  calls in window:\n")
    for a,t,m in f.calls():
        ts=f"0x{t:x}" if t is not None else "REG"
        out.write(f"    0x{a:08x}: -> {m or 'DYN'}({ts})\n")
    # also show what's just before the call site
    out.write(f"\n  --- window around the call 0x{va:08x} ---\n")
    f2 = ArmFunc(mik, max(va-0x60,0), 0x140, thumb=False, name=nm+"_call")
    f2.dump(out)

out.close()
print("wrote tools/final_callers2.txt")
