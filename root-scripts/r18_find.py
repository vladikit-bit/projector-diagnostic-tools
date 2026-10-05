#!/usr/bin/env python3
"""R18: locate runtime string anchors in the DEC R2 image and find their code
references via the validated AEON scheme:
  rodata VA = file_offset + 0x26CD000
  code anchor = movhi rX,0x0281  (op0x30 imm16=0x0281)  followed (same rD, rA==rD)
                by ori  rX,rX,lo  (op0x3f)  => VA = (0x0281<<16)|lo
Instruction word (big-endian): |op(6)|rD(5)|rA(5)|imm16(16)|.
No ISA reverse-engineering; only movhi/ori string resolution + linear 32-bit read.
"""
import struct, sys

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
RODATA_BASE = 0x26CD000

TARGETS = [
    b"r2_decoder_houseKeeping",
    b"decType change",
    b"type[81] -> type[4]",
    b"type[4] -> type[81]",
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
print("image size = 0x%06x (%d)" % (N, N))

def find_all(t):
    out = []
    off = 0
    while True:
        i = b.find(t, off)
        if i < 0:
            break
        out.append(i)
        off = i + 1
    return out

# ---- string offsets ----
print("\n===== STRING OFFSETS (file) =====")
strva = {}
for t in TARGETS:
    hits = find_all(t)
    print("%-28r -> %s" % (t, ", ".join("0x%06x" % h for h in hits) or "NOT FOUND"))
    for h in hits:
        strva.setdefault(t, []).append(h)

# ---- movhi/ori anchor scan ----
# Build list of (off, rD, lo) for movhi 0x0281
movhi = []
for off in range(0, N - 4, 2):   # scan all phases; validate by pair semantics
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; imm = v & 0xffff
    if op == 0x30 and imm == 0x0281:
        movhi.append((off, rD))

print("\n===== movhi 0x0281 sites: %d =====" % len(movhi))

# For each, look for ori rD,rD,lo within +/-0x40 bytes that resolves to a known string VA
def resolve_pairs():
    anchors = {}  # string -> list of code offsets
    for (moff, rD) in movhi:
        # scan forward up to 0x40 bytes for ori rD,rD,lo
        for ooff in range(moff, min(moff + 0x44, N - 4), 2):
            v = struct.unpack_from('>I', b, ooff)[0]
            op = v >> 26; rd = (v >> 21) & 0x1f; ra = (v >> 16) & 0x1f; lo = v & 0xffff
            if op == 0x3f and rd == rD and ra == rD:
                va = (0x0281 << 16) | lo
                foff = va - RODATA_BASE
                # does any target string start at foff (or contain it)?
                for t, hits in strva.items():
                    for h in hits:
                        if foff == h or (foff >= h and foff < h + len(t) + 4):
                            anchors.setdefault(t, []).append((moff, ooff, va, foff))
    return anchors

anchors = resolve_pairs()
print("\n===== CODE ANCHORS (movhi 0x0281 + ori -> string VA) =====")
for t in TARGETS:
    a = anchors.get(t)
    if not a:
        print("%-28r : no anchor" % t)
        continue
    seen = set()
    for (moff, ooff, va, foff) in a:
        key = (moff, ooff)
        if key in seen:
            continue
        seen.add(key)
        print("%-28r : code 0x%06x (movhi@0x%06x ori@0x%06x) -> VA 0x%08x file 0x%06x"
              % (t, moff, moff, ooff, va, foff))
