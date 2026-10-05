#!/usr/bin/env python3
"""R12: enumerate every absolute-address reference in a DSP image by finding
    movhi(hi16)+ori(lo16) register pairs on both 4-byte phases.
AEON 32-bit subset: op0x30=movhi, op0x3f=ori, op0x3b=ld/st, op0x39=call.
Usage: r12_dmxref.py <image> <hi16> [rodata_base]
"""
import sys, struct
from collections import Counter

img = sys.argv[1]
hi  = int(sys.argv[2], 0)
base = int(sys.argv[3], 0) if len(sys.argv) > 3 else None
b = open(img, 'rb').read()

def rd(off):
    return struct.unpack_from('>I', b, off)[0] if off + 4 <= len(b) else None

print("### movhi(0x%04x)+ori pairs in %s ###" % (hi, img))
found = []
for phase in (0, 2):
    off = phase
    prev_movhi = {}          # rD -> (offset, imm16)
    while off + 4 <= len(b):
        v = rd(off)
        op = v >> 26
        rD = (v >> 21) & 0x1f
        rA = (v >> 16) & 0x1f
        imm = v & 0xffff
        if op == 0x30:
            prev_movhi[rD] = (off, imm)
        elif op == 0x3f:
            if rD in prev_movhi and prev_movhi[rD][1] == hi and rA == rD:
                found.append((phase, prev_movhi[rD][0], off, rD, imm))
        off += 4

print("pairs found: %d" % len(found))
c = Counter(x[4] for x in found)
print("\n-- lo16 histogram (%d distinct) --" % len(c))
for lo, n in c.most_common(60):
    va = (hi << 16) | lo
    extra = ''
    if base is not None:
        f = va - base
        if 0 <= f < len(b):
            s = b[f:f+56].split(b'\x00')[0]
            extra = '  file 0x%06x  "%s"' % (f, s.decode('latin1')[:52])
    print("  0x%04x x%-4d  VA 0x%08x%s" % (lo, n, va, extra))

print("\n-- first 40 pair sites --")
for phase, mh, o, rD, lo in found[:40]:
    va = (hi << 16) | lo
    print("  phase%d movhi@0x%06x ori@0x%06x  r%-2d -> 0x%08x" % (phase, mh, o, rD, va))
