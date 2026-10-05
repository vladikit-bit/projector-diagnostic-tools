#!/usr/bin/env python3
"""a5: minimal 16-bit AEON subset study around the license gate (0x021f00-0x021fd2).
Step 1: island/phase map — find verified-op islands on each 4-byte phase, extract
        16-bit candidate words from phase-transition gaps.
Step 2: frequency table of gap words (branch/compare candidates).
Read-only."""
import struct, re
from collections import Counter

IMG = 'r8_out/mst_codec_r2_MS12V22.bin'
b = open(IMG, 'rb').read()
def w(off): return struct.unpack_from('>I', b, off)[0]
def h16(off): return struct.unpack_from('>H', b, off)[0]

strs = {}
for m in re.finditer(rb'[\x20-\x7e]{6,}', b[0x140000:0x149000]):
    strs[0x140000 + m.start()] = m.group().decode('latin1')

KNOWN_OPS = {0x30: 'movhi', 0x3f: 'ori', 0x3b: 'ld/st', 0x39: 'call'}

def word_known(wv):
    """word decodes as a known 32-bit op (optionally with string/arg annotation)"""
    op = wv >> 26
    return op in KNOWN_OPS

def island_scan(lo, hi):
    """for each phase, mark positions where a known-op word appears;
    an 'island' = >=3 consecutive known-op words on one phase grid"""
    res = {}
    for phase in (0, 2):
        marks = []
        off = lo + ((phase - lo) % 4)
        while off < hi - 4:
            if word_known(w(off)):
                marks.append(off)
            off += 4
        # group consecutive
        islands = []
        cur = []
        for i, off in enumerate(marks):
            if cur and off == cur[-1] + 4:
                cur.append(off)
            else:
                if len(cur) >= 3: islands.append(cur)
                cur = [off]
        if len(cur) >= 3: islands.append(cur)
        res[phase] = islands
    return res

lo, hi = 0x021e00, 0x022100
isl = island_scan(lo, hi)
print("=== islands (>=3 consecutive known-op words) in 0x021e00-0x022100 ===")
for phase in (0, 2):
    for isl_i in isl[phase]:
        print("  phase %d: 0x%06x-0x%06x (%d words)" % (phase, isl_i[0], isl_i[-1] + 4, len(isl_i)))

# gap extraction: between island end and next island start (either phase) collect raw bytes
print("\n=== inter-island gaps (16-bit candidates) in the gate region ===")
gaps = []
pts = []
for phase in (0, 2):
    for isl_i in isl[phase]:
        pts.append((isl_i[0], isl_i[-1] + 4, phase))
pts.sort()
for i in range(len(pts) - 1):
    end1, start2 = pts[i][1], pts[i + 1][0]
    if start2 <= end1: continue
    gapbytes = b[end1:start2]
    if 0 < len(gapbytes) <= 24:
        gaps.append((end1, start2, pts[i][2], pts[i + 1][2], gapbytes))
for g in gaps:
    end1, start2, p1, p2, gb = g
    words = ' '.join('%04x' % h16(end1 + 2 * i) for i in range(len(gb) // 2))
    print("  gap 0x%06x-0x%06x (phase %d->%d): %s" % (end1, start2, p1, p2, words))

# frequency of 16-bit words at gap positions over a wider window
print("\n=== 16-bit word frequency at phase-transition gap positions, 0x021c00-0x022400 ===")
cnt = Counter()
for i in range(len(pts) - 1):
    end1, start2 = pts[i][1], pts[i + 1][0]
    if start2 <= end1: continue
    n = (start2 - end1) // 2
    for k in range(n):
        cnt[h16(end1 + 2 * k)] += 1
for wv, c in cnt.most_common(24):
    print("  %04x x%d" % (wv, c))
