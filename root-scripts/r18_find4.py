#!/usr/bin/env python3
"""R18d: string-reference scan, page-aware, mid-string-offset tolerant.
Track last 'movhi rX,hi' for hi in {target pages}; on 'ori rX,rX,lo' compute VA and
test whether VA-RODATA_BASE lies within any target string's byte range.
"""
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

ranges = []  # (start_file, end_file, name)
his = set()
for t in TARGETS:
    off = 0
    while True:
        i = b.find(t, off)
        if i < 0:
            break
        ranges.append((i, i + len(t) + 8, t))
        his.add((i + RODATA_BASE) >> 16)
        off = i + 1

print("pages(hi):", ["0x%04x" % h for h in sorted(his)])
last_movhi = {}   # (rD, hi) -> off
hits = []
for off in range(0, N - 4, 2):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x30 and imm in his:
        last_movhi[(rD, imm)] = off
    elif op == 0x3f and rA == rD:
        m = last_movhi.get((rD, imm >> 16))   # imm here is lo; hi from last_movhi key
        # recompute properly: we need the hi that was last movhi'd into rD
        # find any (rD,hi) in last_movhi with smallest distance
        best = None
        for (rd, hii), mo in last_movhi.items():
            if rd == rD and 0 <= off - mo <= 0x2000:
                if best is None or mo > best[1]:
                    best = (hii, mo)
        if best is not None:
            hi, moff = best
            va = (hi << 16) | imm
            foff = va - RODATA_BASE
            for (s, e, t) in ranges:
                if s <= foff <= e:
                    hits.append((moff, off, va, foff, t))
                    break

print("\n=== CODE ANCHORS (mid-string tolerant) ===")
seen = set()
for (moff, off, va, foff, t) in hits:
    key = (moff, off, va)
    if key in seen:
        continue
    seen.add(key)
    print("  %-26r code 0x%06x (movhi@0x%06x ori@0x%06x) VA 0x%08x file 0x%06x"
          % (t, moff, moff, off, va, foff))
