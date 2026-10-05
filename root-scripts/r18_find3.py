#!/usr/bin/env python3
"""R18c: VA-aware string-reference scan. For each target string compute hi/lo of
its rodata VA (file+0x26CD000) and find 'movhi rX,hi' + 'ori rX,rX,lo' (per-register,
within 0x2000). Catches both 0x0280xxxx and 0x0281xxxx pages."""
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
RODATA_BASE = 0x26CD000

TARGETS = [
    b"r2_decoder_houseKeeping",
    b"decType change",
    b"dts m6 hook ok",
    b"dts m6 init ok",
    b"dts_licensee",
    b"transcoder_licensee",
    b"lbr_licensee",
    b"xll_licensee",
    b"CPU MS12V2 ddp hook ok",
    b"CPU MS12V2 ddp init ok",
    b"ddp init ok",
]

b = open(BIN, 'rb').read()
N = len(b)

items = []  # (va, hi, lo, name)
for t in TARGETS:
    off = 0
    while True:
        i = b.find(t, off)
        if i < 0:
            break
        va = i + RODATA_BASE
        items.append((va, va >> 16, va & 0xffff, t, i))
        off = i + 1

print("target VAs:")
for va, hi, lo, t, f in items:
    print("  0x%08x  hi=0x%04x lo=0x%04x  %r  (file 0x%06x)" % (va, hi, lo, t, f))

# single horizontal pass
last_movhi = {}   # (rD, hi) -> off
hits = []
for off in range(0, N - 4, 2):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x30:
        last_movhi[(rD, imm)] = off
    elif op == 0x3f and rA == rD:
        # does this lo match any target with same (rD,hi)?
        for (va, hi, lo, t, f) in items:
            if lo == imm:
                m = last_movhi.get((rD, hi))
                if m is not None and 0 <= off - m <= 0x2000:
                    hits.append((m, off, va, hi, lo, t, f))

print("\n=== CODE ANCHORS ===")
seen = set()
for (m, off, va, hi, lo, t, f) in hits:
    key = (m, off, va)
    if key in seen:
        continue
    seen.add(key)
    print("  %-26r code 0x%06x  (movhi@0x%06x ori@0x%06x) VA 0x%08x hi=0x%04x lo=0x%04x file 0x%06x"
          % (t, m, m, off, va, hi, lo, f))
