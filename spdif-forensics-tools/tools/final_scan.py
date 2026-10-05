#!/usr/bin/env python3
"""Final pass: symbol + caller scan across all audio/firmware modules.

OBJ 1: EDID source/override chain  (EDID symbols, SetEDID def+callers, Rx/Tx split)
OBJ 2: MApi_AUDIO_SPDIF_SetMode definition + impl location
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach

BASE = "C:/firmware_temp/spdif_audio_investigation"
MODS = {
    "mik":      f"{BASE}/kmods/mik.ko",
    "utpa2k":   f"{BASE}/kmods/utpa2k.ko",
    "dtv":      f"{BASE}/kmods/dtv_driver.ko",
    "hal":      f"{BASE}/libs/audio.primary.mt5889.so",
    "libmi3":   f"{BASE}/libs/libmi3.so",
    "libutopia":f"{BASE}/libs/libutopia.so",
}

def load(name):
    try:
        e = ELF32(MODS[name])
        try:
            e.rl = Relocs(e)
        except Exception as ex:
            e.rl = None
            print(f";; warn: Relocs({name}) failed: {ex}", file=sys.stderr)
        try:
            attach(e)
        except Exception:
            pass
        return e
    except Exception as ex:
        print(f";; ERROR loading {name}: {ex}", file=sys.stderr)
        return None

elfs = {n: load(n) for n in MODS}
elfs = {n: e for n, e in elfs.items() if e is not None}

def def_status(e, name):
    syms = getattr(e, 'sym_by_name', {}).get(name, [])
    for s in syms:
        if s['shndx'] != 0:
            return s['value'], s['size']
    return None, None

def refs_of(e, name):
    rl = getattr(e, 'rl', None)
    if rl is None:
        return []
    return rl.by_target.get(name, [])

print("="*78)
print("OBJ 1 + 2  SYMBOL DEFINITION / EXTERNAL STATUS  (value!=0 => defined here)")
print("="*78)
targets = [
    "MApi_AUDIO_SPDIF_SetMode",
    "MI_DISP_IMPL_XC_HDMIRx_SetEDID",
    "_MI_AOUT_SetHdmiAutoMode",
    "_MI_AOUT_ParseEdidAudioDataBlock",
    "_MApi_HDMITx_GetEDIDData",
    "_MApi_HDMITx_GetRxAudioFormatFromEDID",
    "_MApi_HDMITx_EDID_HDMISupport",
    "_MI_AOUT_HdmiInfoMonitor",
    "_astHdmiInfo",
    "_bHdmiInfoEnable",
    "MI_AOUT_SetDigitalMode",
    "MApi_AUDIO_HDMI_SetNonpcm",
    "MDrv_AUDIO_SPDIF_SetMode",
]
for t in targets:
    print(f"\n### {t}")
    for n, e in elfs.items():
        val, sz = def_status(e, t)
        if val is None:
            refs = refs_of(e, t)
            ext = "  [external, called from:" + ",".join(f"0x{v:x}" for v,_ in refs[:6]) + ("]" if refs else " (no refs)")
            print(f"   {n:10s}: EXTERNAL/undefined{ext}")
        else:
            print(f"   {n:10s}: DEFINED @0x{val:08x} size=0x{sz:x}")

print("\n" + "="*78)
print("OBJ 2  ALL DEFINED SYMBOLS MATCHING SPDIF.*SetMode / SPDIF.*Mode")
print("="*78)
for n, e in elfs.items():
    for s in getattr(e, 'syms', []):
        if s['name'] and 'SPDIF' in s['name'].upper() and ('MODE' in s['name'].upper() or 'SETP' in s['name'].upper()):
            if s['shndx'] != 0:
                print(f"   {n:10s}: 0x{s['value']:08x}  {s['name']}  size={s['size']:#x}")

print("\n" + "="*78)
print("OBJ 1  ALL SYMBOLS MATCHING EDID / SETEDID / HDMIINFO / RX / TX (defined only)")
print("="*78)
for n, e in elfs.items():
    hits = [s for s in getattr(e,'syms',[]) if s['shndx']!=0 and
            any(k in s['name'].upper() for k in ('EDID','SETEDID','HDMIINFO','RX_EDID','TX_EDID'))]
    if hits:
        print(f"\n-- {n} ({len(hits)} defined symbols) --")
        for s in hits:
            print(f"   0x{s['value']:08x}  {s['name']}  size={s['size']:#x}")

print("\n" + "="*78)
print("OBJ 1  CALLERS OF MI_DISP_IMPL_XC_HDMIRx_SetEDID (across all modules)")
print("="*78)
for n, e in elfs.items():
    refs = refs_of(e, "MI_DISP_IMPL_XC_HDMIRx_SetEDID")
    if refs:
        print(f"   callers in {n}: " + ", ".join(f"0x{v:x}(type {t})" for v,t in refs))

print("\n" + "="*78)
print("OBJ 2  CALLERS OF MApi_AUDIO_SPDIF_SetMode (across all modules)")
print("="*78)
for n, e in elfs.items():
    refs = refs_of(e, "MApi_AUDIO_SPDIF_SetMode")
    if refs:
        print(f"   callers in {n}: " + ", ".join(f"0x{v:x}(type {t})" for v,t in refs))
    for alt in ("MDrv_AUDIO_SPDIF_SetMode","MAD_AUDIO_SPDIF_SetMode"):
        refs2 = refs_of(e, alt)
        if refs2:
            print(f"   callers of {alt} in {n}: " + ", ".join(f"0x{v:x}" for v,t in refs2))
