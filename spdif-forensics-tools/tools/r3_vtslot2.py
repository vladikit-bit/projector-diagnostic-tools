import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
print("=== ALL sections ===")
for s in E.secs:
    if s['addr']:
        print(f"  {s['name']:22s} type={s['type']:2d} addr=0x{s['addr']:06x} off=0x{s['off']:06x} size=0x{s['size']:x}")

for tgt, label in ((0x322d5, "dump-dispatcher"), (0x328d1, "mi_getCodecType")):
    print(f"\n=== ALL-section scan for 0x{tgt:06x} ({label}) ===")
    found = []
    for s in E.secs:
        if s['type'] == 8 or not s['addr']:
            continue
        d = E.d[s['off']:s['off'] + s['size']]
        for i in range(0, len(d) - 3, 4):
            if struct.unpack_from('<I', d, i)[0] == tgt:
                found.append((s['name'], s['addr'] + i, i))
    if not found:
        print("  NOT FOUND as a static pointer -> table is built at runtime (adev_open)")
    else:
        for n, va, i in found:
            print(f"  {n} +0x{i:x} VA 0x{va:06x}")
