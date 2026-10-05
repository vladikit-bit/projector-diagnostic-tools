#!/usr/bin/env python3
"""OBJ 1: EDID source/override chain in mik.ko + dtv_driver.ko.

- Who calls MI_DISP_IMPL_XC_HDMIRx_SetEDID (mik @0x17ef00)?
- EDID autosetup / config-file load path (mi_aout_EdidAutoSetup, _MI_SYS_CfgLoadHdmiEdidInfo*)
- Hard-coded EDID blob search (.rodata 0x00FFFFFF...00)
- RX vs TX EDID distinction
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
mik = ELF32(f"{BASE}/kmods/mik.ko"); Relocs(mik); attach(mik)
dtv = ELF32(f"{BASE}/kmods/dtv_driver.ko"); Relocs(dtv); attach(dtv)

out = open(f"{BASE}/tools/final_edid.txt", "w")

def func_of(e, va):
    best=None
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0:
            continue
        if s['value'] <= va < s['value'] + max(s['size'],1):
            return s['name'], s['value'], s['size']
    for s in e.syms:
        if not s['name'] or s['name'].startswith('.') or s['shndx']==0:
            continue
        if s['value'] <= va and (best is None or s['value']>best[1]):
            best=(s['name'],s['value'],s['size'])
    return (best[0]+f"+0x{va-best[1]:x}" if best else "??", best[1] if best else 0, 0)

# 1) caller of MI_DISP_IMPL_XC_HDMIRx_SetEDID in mik @0x17ef00
nm, fva, fsz = func_of(mik, 0x17ef00)
out.write(f"### MI_DISP_IMPL_XC_HDMIRx_SetEDID caller in mik: 0x17ef00 inside {nm} @0x{fva:x} size=0x{fsz:x}\n\n")
f = ArmFunc(mik, fva, max(fsz,0x200), thumb=False, name=nm)
f.dump(out)
out.write("\n--- calls in that function ---\n")
for a,t,m in f.calls():
    out.write(f"  0x{a:08x}: -> {m or 'DYN'}(0x{t:x})\n")

# 2) EDID autosetup / config load path in mik
for nm2, va, sz in [("mi_aout_EdidAutoSetup",0x0008c2d4,0x90),
                    ("mi_aout_GetCurEdid",0x0008c364,0xd0)]:
    out.write(f"\n### {nm2} @0x{va:x}\n")
    f = ArmFunc(mik, va, sz, thumb=False, name=nm2); f.dump(out)
    for a,t,m in f.calls():
        out.write(f"  0x{a:08x}: -> {m or 'DYN'}(0x{t:x})\n")

# find _MI_SYS_CfgLoadHdmiEdidInfo* function addresses (non-.L)
for s in mik.syms:
    if s['name'].startswith('_MI_SYS_Cfg') and 'Edid' in s['name'] and not s['name'].startswith('.'):
        out.write(f"\n### {s['name']} @0x{s['value']:x} size=0x{s['size']:x}\n")
        f = ArmFunc(mik, s['value'], max(s['size'],0x100), thumb=False, name=s['name']); f.dump(out)
        for a,t,m in f.calls():
            out.write(f"  0x{a:08x}: -> {m or 'DYN'}(0x{t:x})\n")

# 3) hard-coded EDID blob search in .rodata of mik and dtv
import struct
def find_edid(e, sec):
    if sec is None: return
    b = e.b[sec['off']:sec['off']+sec['size']]
    pat = b'\x00\xff\xff\xff\xff\xff\xff\x00'
    i=0; cnt=0
    while True:
        j = b.find(pat, i)
        if j<0: break
        va = sec['addr'] + j
        out.write(f"\n  EDID-blob candidate @ VA 0x{va:08x} (file off {sec['off']+j:#x}) in {e.path.split('/')[-1]}\n")
        chunk = b[j:j+128]
        out.write("  " + chunk.hex() + "\n")
        # decode header
        out.write(f"  raw: " + ' '.join(f'{x:02x}' for x in chunk[:16]) + "\n")
        cnt+=1; i=j+8
        if cnt>=6: break
    return cnt
out.write("\n### EDID blob search (.rodata)\n")
c1 = find_edid(mik, mik.rodata)
c2 = find_edid(dtv, dtv.rodata)
out.write(f"\nmik EDID blobs found: {c1}; dtv EDID blobs found: {c2}\n")

# 4) strings: edid file paths / vendor / config in mik
import re
def strings_search(e, pat):
    data = e.b
    rx = re.compile(pat.encode(), re.I)
    res=[]
    for m in rx.finditer(data):
        start=m.start()
        # include a reasonable run
        end=start
        while end<len(data) and 32<=data[end]<127:
            end+=1
        s=data[start:end].decode('latin1')
        res.append((start,s))
    return res
out.write("\n### EDID-related strings in mik.ko\n")
for off,s in strings_search(mik, r'edid|\.bin|hdmi.*info|edid.*path|vendor|cfgload'):
    if len(s)>3:
        out.write(f"  0x{off:08x}: {s}\n")

out.close()
print("wrote tools/final_edid.txt")
