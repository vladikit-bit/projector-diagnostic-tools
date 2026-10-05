#!/usr/bin/env python3
"""OBJ 4: trace persist.vendor.audio.* in audio.primary.mt5889.so (Thumb-2)."""
import os, sys, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
hal = ELF32(f"{BASE}/libs/audio.primary.mt5889.so")
try: Relocs(hal)
except Exception as ex: print("Relocs fail",ex)
try: attach(hal)
except: pass

out = open(f"{BASE}/tools/final_hal.txt","w")

# 1) property strings present?
data = hal.b
out.write("### property strings in HAL\n")
for m in re.finditer(rb'persist\.vendor\.audio\.[a-z_.]+', data):
    s=m.group().decode()
    out.write(f"  0x{m.start():08x}: {s}\n")
for m in re.finditer(rb'spdif\.[a-z]+|hdmi_tx\.[a-z]+|hdmi_arc\.[a-z]+|digital setting|SetSpdifOutputType|SetHdmiTxOutputMode', data):
    s=m.group().decode()
    out.write(f"  0x{m.start():08x}: {s}\n")

# 2) symbols of interest
out.write("\n### relevant HAL symbols\n")
for s in getattr(hal,'syms',[]):
    if s['name'] and any(k in s['name'].lower() for k in ('digital','setdigitalmode','getdigital','spdif','applydigital','output_mode')):
        if s['shndx']!=0:
            out.write(f"  0x{s['value']:08x}  {s['name']}  size={s['size']:#x}\n")

# 3) disassemble utils_get_digital_output_mode / utils_ApplyDigitalOutputSetting / MI_AOUT_SetDigitalMode if present
defs={}
for s in getattr(hal,'syms',[]):
    if s['name'] in ('utils_get_digital_output_mode','utils_ApplyDigitalOutputSetting','MI_AOUT_SetDigitalMode') and s['shndx']!=0:
        defs[s['name']]=s['value']
out.write(f"\n### defs found: {defs}\n")
for nm,va in defs.items():
    out.write(f"\n### {nm} @0x{va:x}\n")
    f = ArmFunc(hal, va, 0x300, thumb=True, name=nm)
    f.dump(out)
    out.write("  calls:\n")
    for a,t,m in f.calls():
        ts=f"0x{t:x}" if t is not None else "REG"
        out.write(f"    0x{a:08x}: -> {m or 'DYN'}({ts})\n")

out.close()
print("wrote tools/final_hal.txt")
