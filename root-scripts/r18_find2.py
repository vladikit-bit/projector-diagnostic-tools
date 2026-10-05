#!/usr/bin/env python3
"""R18b: robust string-reference scan.
Horizontal per-register tracking of last 'movhi rX,0x0281', then on each
'ori rX,rX,lo' compute VA=(0x0281<<16)|lo and test against known string VAs
(file+0x26CD000). Reports every hit + the specific decType-change VA 0x02811A2D.
"""
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
RODATA_BASE = 0x26CD000

TARGETS = {
    b"r2_decoder_houseKeeping": None,
    b"decType change": None,
    b"dts m6 hook ok": None,
    b"dts m6 init ok": None,
    b"dts_licensee": None,
    b"transcoder_licensee": None,
    b"lbr_licensee": None,
    b"xll_licensee": None,
    b"CPU MS12V2 ddp hook ok": None,
    b"CPU MS12V2 ddp init ok": None,
    b"ddp init ok": None,
}

b = open(BIN, 'rb').read()
N = len(b)

# map string VA -> name
strva = {}
for t in list(TARGETS):
    off = 0
    while True:
        i = b.find(t, off)
        if i < 0:
            break
        va = i + RODATA_BASE
        strva.setdefault(va, []).append(t)
        off = i + 1

print("string VAs:")
for va, ts in sorted(strva.items()):
    print("  0x%08x  %s  (file 0x%06x)" % (va, ts, va - RODATA_BASE))

# horizontal scan
last_movhi = {}   # rD -> off
hits = []
DECVA = 0x141a2d + RODATA_BASE
for off in range(0, N - 4, 2):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x30 and imm == 0x0281:
        last_movhi[rD] = off
    elif op == 0x3f and rA == rD and rD in last_movhi:
        moff = last_movhi[rD]
        if 0 <= off - moff <= 0x2000:
            va = (0x0281 << 16) | imm
            foff = va - RODATA_BASE
            ts = strva.get(va)
            if ts or va == DECVA:
                hits.append((moff, off, va, foff, ts))

print("\ncode anchors (movhi 0x0281 ... ori rX,rX,lo -> string VA), dist<=0x2000:")
seen = set()
for (moff, off, va, foff, ts) in hits:
    key = (moff, off, va)
    if key in seen:
        continue
    seen.add(key)
    tag = ",".join(x.decode('latin1') for x in ts) if ts else "<<DECVA target?>>"
    print("  code 0x%06x  movhi@0x%06x ori@0x%06x  VA 0x%08x  file 0x%06x  %s"
          % (moff, moff, off, va, foff, tag))

# direct: any ori whose imm combined with SOME movhi 0x0281 gives exactly DECVA
print("\nDirect DECVA 0x%08x search (ori imm==0x%04x with any rD, paired if movhi 0x0281 same rD nearby):"
      % (DECVA, DECVA & 0xffff))
dec_lo = DECVA & 0xffff
for off in range(0, N - 4, 2):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    if op == 0x3f and rA == rD and imm == dec_lo:
        m = last_movhi.get(rD)
        if m is not None and 0 <= off - m <= 0x2000:
            print("  FOUND ori@0x%06x rD=%d  (movhi@0x%06x)" % (off, rD, m))
