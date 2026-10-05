import sys
sys.path.insert(0, '.')
from elfx import ELF

HAL = r"C:/firmware_temp/spdif_audio_investigation/extracted/audio.primary.mt5889.so"
import glob, os
cands = glob.glob(r"C:/firmware_temp/spdif_audio_investigation/**/audio.primary.mt5889.so", recursive=True)
print("candidates:", cands[:5])
p = cands[0] if cands else HAL
E = ELF(p)
print("file:", p)

# lit, addr_of_add  (unaligned PC convention: PC = addr(add) + 4, no Align4)
cases = [
    ("A -> mi_getCodecType#1 @0x032318", 0xfffe55c2, 0x03230e),
    ("B -> mi_getCodecType#2 @0x032332", 0xfffe59e3, 0x032328),
    ("C -> mi_getCodecType#3 @0x03234a", 0xfffe6eca, 0x032340),
    ("D -> mi_getCodecType#4 @0x032364", 0xfffe86dd, 0x03235a),
]
for tag, lit, adda in cases:
    for label, pcbase in (("unaligned", adda + 4), ("aligned", (adda + 4) & ~3)):
        va = (pcbase + lit) & 0xFFFFFFFF
        off = E.va2off(va)
        s = None
        if off is not None:
            end = E.d.find(b'\0', off)
            if end > off:
                s = E.d[off:end].decode('latin-1')
        print(f"  {tag:34s} {label:9s} VA=0x{va:06x} off={off} -> {s!r}")
    print()
