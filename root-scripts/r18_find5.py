#!/usr/bin/env python3
"""R18e: corrected string-reference scan.
Per-register 'movhi rX,hi' tracking (most-recent wins, any distance), then on every
'ori rD,rA,imm' build candidate VAs from BOTH rA (base) and rD (self/result) and test
against the known runtime-string VA map. Handles non-adjacent pairs and base-register
(rD != rA) construction. No brute-force branch search. Static only.
"""
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
RODATA_BASE = 0x26CD000   # VA = file_offset + RODATA_BASE  (validated R12)

# (literal bytes, canonical VA) -- VA = file_off + RODATA_BASE
TARGETS = {
    b"r2_decoder_houseKeeping": 0x0280f07c,
    b"decType change":          0x0280ea2d,
    b"dts m6 hook ok":          0x02813ac5,
    b"dts m6 init ok":          0x02813ad5,
    b"dts_licensee":            0x02813ae4,
    b"transcoder_licensee":     0x02813b17,
    b"lbr_licensee":            0x02813af5,
    b"xll_licensee":            0x02813b06,
    b"CPU MS12V2 ddp hook ok":  0x02814c98,
    b"CPU MS12V2 ddp init ok":  0x02814c80,
    b"ddp init ok":             0x02814c8b,
}
# byte range tolerance (mid-string anchors): accept VA within [base, base+len+8]
TOL = 8

b = open(BIN, 'rb').read()
N = len(b)

# build set of exact target VAs and a (lo-mask) helper
def va_in_target(va):
    for lit, base in TARGETS.items():
        if base <= va <= base + len(lit) + TOL:
            return (lit, base)
    return None

reg_hi = {}   # r -> last movhi immediate
hits = []
for off in range(0, N - 4, 4):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x30:
        reg_hi[rD] = imm
    elif op == 0x3f:
        cands = {}
        if rA in reg_hi:
            cands[rA] = reg_hi[rA]
        if rD in reg_hi and rD != rA:
            cands[rD] = reg_hi[rD]
        for base_reg, hi in cands.items():
            va = (hi << 16) | imm
            t = va_in_target(va)
            if t:
                hits.append((off, base_reg, hi, imm, va, t[0], t[1]))

print("=== R18e CODE ANCHORS (per-register movhi, base-ori tolerant) ===")
seen = set()
for (off, base_reg, hi, imm, va, lit, base) in hits:
    key = (off, va)
    if key in seen:
        continue
    seen.add(key)
    print("  %-26r  ori@0x%06x  base_reg=r%d  movhi 0x%04x  VA 0x%08x  foff 0x%06x"
          % (lit, off, base_reg, hi, va, va - RODATA_BASE))
