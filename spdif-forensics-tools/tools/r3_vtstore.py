import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
raw = b'\xd5\x22\x03\x00'   # 0x000322d5 LE
d = E.d[T['off']:T['off']+T['size']]
print("=== raw 0x322d5 occurrences in .text (literal pool entries) ===")
i = d.find(raw)
while i != -1:
    va = T['addr'] + i
    print(f"  literal @ VA 0x{va:06x} (file off 0x{T['off']+i:06x})")
    i = d.find(raw, i+1)

# also movw/movt encoding of 0x322d5
print("\n=== movw/movt 0x322d5 encodings ===")
lo = 0x22d5; hi = 0x0003
w0 = 0xF2400000 | ((lo & 0x800) << 15) | ((lo & 0xF000) << 4) | ((lo & 0xFF) << 0) | ((lo & 0x700) << 20)
# simpler: brute scan for movw with imm 0x22d5 followed by movt imm 3
def enc_movw(rd, imm):
    i4 = (imm >> 12) & 0xF; i8 = (imm >> 8) & 0x7; il = imm & 0xFF
    return 0xF2400000 | (i4 << 16) | (i8 << 12) | (il << 0) | (rd << 8) | (0 << 4) | ((imm >> 11) & 1) << 26
def enc_movt(rd, imm):
    i4 = (imm >> 12) & 0xF; i8 = (imm >> 8) & 0x7; il = imm & 0xFF
    return 0xF2C00000 | (i4 << 16) | (i8 << 12) | (il << 0) | (rd << 8) | (0 << 4) | ((imm >> 11) & 1) << 26
for rd in range(12):
    for off in range(0, len(d) - 8, 2):
        a = struct.unpack_from('<H', d, off)[0]
        b = struct.unpack_from('<H', d, off+2)[0]
        if a == enc_movw(rd, 0x22d5) and b == enc_movt(rd, 0x0003):
            va = T['addr'] + off
            print(f"  movw/movt r{rd},#0x322d5 @ VA 0x{va:06x}")
