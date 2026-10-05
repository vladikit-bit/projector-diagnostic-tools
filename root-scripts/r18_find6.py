#!/usr/bin/env python3
"""R18f: target-driven reference scan + context disassembly.
For each runtime string, enumerate every byte offset (mid-string tolerant) -> (hi,lo).
Scan the image for `ori rD,rA,lo` whose lo matches, then look BACK (window 0x4000, step4)
for a `movhi rX,hi` into rA or rD. Report producer + disassemble +/-N instructions.
Static only; no brute-force branch search.
"""
import struct
from collections import defaultdict

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
RODATA_BASE = 0x26CD000

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
TOL = 8

b = open(BIN, 'rb').read()
N = len(b)

# candidate (lo,hi) pairs per target
cand = {}   # (lo,hi) -> list of (lit, va_k)
for lit, base in TARGETS.items():
    for k in range(0, len(lit) + TOL + 1):
        va_k = base + k
        cand.setdefault((va_k & 0xffff, va_k >> 16), []).append((lit, va_k))

insns = []
for off in range(0, N - 4, 4):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    insns.append((off, op, rD, rA, imm))

idx = {off: i for i, (off, *_ ) in enumerate(insns)}
ori_by_imm = defaultdict(list)
for i, (off, op, rD, rA, imm) in enumerate(insns):
    if op == 0x3f:
        ori_by_imm[imm].append(i)

hits = []
for (lo, hi) in cand:
    for i in ori_by_imm.get(lo, []):
        off, op, rD, rA, imm = insns[i]
        for j in range(i - 1, max(-1, i - 0x1000), -1):
            moff, mop, mD, mA, mimm = insns[j]
            if mop == 0x30 and mimm == hi and (mD == rA or mD == rD):
                for (lit, va_k) in cand[(lo, hi)]:
                    hits.append((off, moff, rD, rA, mD, hi, lo, va_k, lit))
                break

print("=== R18f PRODUCER ANCHORS ===")
seen = set()
producers = {}
for (off, moff, rD, rA, mD, hi, lo, va_k, lit) in hits:
    key = (off, va_k)
    if key in seen:
        continue
    seen.add(key)
    print("  %-24r ori@0x%06x movhi@0x%06x rD=r%d rA=r%d base=r%d VA 0x%08x"
          % (lit, off, moff, rD, rA, mD, va_k))
    producers[off] = lit

OPS = {0x30: 'movhi', 0x3f: 'ori', 0x3b: 'ld/st', 0x39: 'call'}
def disasm_around(center, half=44):
    ci = idx.get(center)
    if ci is None:
        return
    lo = max(0, ci - half); hi = min(len(insns), ci + half)
    print("\n--- disasm around 0x%06x (%s) ---" % (center, producers.get(center, '?')))
    for i in range(lo, hi):
        off, op, rD, rA, imm = insns[i]
        nm = OPS.get(op, 'op%02x' % op)
        mark = ' <<<' if off == center else ''
        print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"
              % (off, struct.unpack_from('>I', b, off)[0], nm, rD, rA, imm, mark))

for off in producers:
    disasm_around(off)
