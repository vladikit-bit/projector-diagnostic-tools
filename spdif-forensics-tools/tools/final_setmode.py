#!/usr/bin/env python3
"""OBJ 2: disassemble the real MApi_AUDIO_SPDIF_SetMode implementation chain."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from forensic_dis import attach, ArmFunc

BASE = "C:/firmware_temp/spdif_audio_investigation"
utp = ELF32(f"{BASE}/kmods/utpa2k.ko")
Relocs(utp); attach(utp)

out = open(f"{BASE}/tools/final_setmode.txt", "w")
def D(va, size, name):
    f = ArmFunc(utp, va, size, thumb=False, name=name)
    f.dump(out)
    out.write("\n--- calls in %s ---\n" % name)
    for a, t, nm in f.calls():
        ts = f"0x{t:x}" if t is not None else "REG"
        out.write(f"  0x{a:08x}: -> {nm or 'DYN'}({ts})\n")

# real implementation chain
D(0x003f5668, 0x108, "MApi_AUDIO_SPDIF_SetMode")
D(0x003e7540, 0x90,  "_MApi_AUDIO_SPDIF_SetMode")
D(0x0040587c, 0xa8,  "MDrv_AUDIO_SPDIF_SetMode")
D(0x00448a10, 0x250, "HAL_AUDIO_SPDIF_SetMode")
D(0x00449ca0, 0x14,  "_HAL_AUDIO_SPDIF_GetMode")

# mode name->enum table
tbl = utp.read_va(0x0016a8d0, 0x38)
out.write("\n--- sSpdifModeNameToEnumTable @0x16a8d0 (0x38 bytes) ---\n")
out.write(tbl.hex() + "\n")
# try to interpret as 4-byte enum pairs (ptr,val) or (val,val)
for i in range(0, 0x38, 8):
    a,b = utp.word(0x0016a8d0+i), utp.word(0x0016a8d0+i+4)
    out.write(f"  +0x{i:02x}: 0x{a:08x} 0x{b:08x}\n")

# related: SPDIF_AutoMode / BypassMode / TranscodeMode / PcmMode entry tails to see mode values
for nm, va, sz in [("HAL_AUDIO_SPDIF_AutoMode",0x00444914,0x62c),
                   ("HAL_AUDIO_SPDIF_BypassMode",0x00444f40,0x5c4),
                   ("HAL_AUDIO_SPDIF_TranscodeMode",0x00445504,0x8b8),
                   ("HAL_AUDIO_SPDIF_PcmMode",0x00445dbc,0x120)]:
    D(va, sz, nm)

out.close()
print("wrote tools/final_setmode.txt")
