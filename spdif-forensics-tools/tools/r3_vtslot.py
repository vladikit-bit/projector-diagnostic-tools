import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")

DATA = ['.data.rel.ro', '.data', '.data.rel.ro.local', '.rodata', '.bss']
for tgt, label in ((0x322d5, "adev_dump dispatcher"), (0x328d1, "mi_getCodecType")):
    print(f"\n=== scan for pointer 0x{tgt:06x} ({label}) ===")
    hit = False
    for n in DATA:
        s = E.SEC.get(n)
        if not s or s['type'] == 8:
            continue
        d = E.d[s['off']:s['off'] + s['size']]
        for i in range(0, len(d) - 3, 4):
            if struct.unpack_from('<I', d, i)[0] == tgt:
                hit = True
                va = s['addr'] + i
                print(f"  {n} +0x{i:x}  VA 0x{va:06x}")
                if tgt == 0x322d5:
                    base = max(0, i - 0x2c)
                    print(f"    -- neighbourhood (base of table approx +0x{base:x}) --")
                    for j in range(base, min(len(d), i + 0x14), 4):
                        vv = struct.unpack_from('<I', d, j)[0]
                        mk = "   <<<< ENTRY" if j == i else ""
                        print(f"      sec+0x{j:04x}  VA 0x{s['addr']+j:06x}  -> 0x{vv:06x}{mk}")
    if not hit:
        print("  (not found)")
