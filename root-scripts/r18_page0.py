#!/usr/bin/env python3
"""R18i: enumerate all movhi 0x0280 + ori(lo) self-pairs and show resulting VAs.
Reveals how the 0x0280-page strings (decType change / houseKeeping) are addressed.
"""
import struct
BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b = open(BIN, 'rb').read(); N = len(b)
reg_hi = {}
pairs = []
movhi0280 = 0
for off in range(0, N - 4, 4):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x30:
        reg_hi[rD] = imm
        if imm == 0x0280:
            movhi0280 += 1
    elif op == 0x3f and rA == rD and rD in reg_hi and reg_hi[rD] == 0x0280:
        va = (0x0280 << 16) | imm
        pairs.append((off, rD, imm, va))
print("total movhi 0x0280:", movhi0280, " self-ori pairs:", len(pairs))
print("=== pairs producing VA in rodata 0x0280e000..0x02813fff ===")
for (off, rD, imm, va) in pairs:
    if 0x0280e000 <= va <= 0x02813fff:
        print("  0x%06x  r%d  ori 0x%04x -> VA 0x%08x" % (off, rD, imm, va))
print("=== first 40 pairs overall (to see the pattern) ===")
for (off, rD, imm, va) in pairs[:40]:
    print("  0x%06x  r%d  ori 0x%04x -> VA 0x%08x" % (off, rD, imm, va))
