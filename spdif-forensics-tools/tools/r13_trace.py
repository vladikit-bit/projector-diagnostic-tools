#!/usr/bin/env python3
"""R13: mixed-width AEON instruction trace between two known 32-bit anchors.

AEON is mixed 16/32-bit. Known 32-bit ops: 0x30 movhi | 0x3f ori | 0x3b ld/st | 0x39 call.
DP over even offsets: step 4 (known op -> +10, unknown -> 0) or step 2 (-3 penalty).
Usage: r13_trace.py <image> <start> <end> [rodata_base]
"""
import sys, struct

IMG = sys.argv[1]; ST = int(sys.argv[2], 0); EN = int(sys.argv[3], 0)
BASE = int(sys.argv[4], 0) if len(sys.argv) > 4 else None
b = open(IMG, 'rb').read()
OPS = {0x30: 'movhi', 0x3f: 'ori', 0x3b: 'ld/st', 0x39: 'call'}

def w(off): return struct.unpack_from('>I', b, off)[0]
def h(off): return struct.unpack_from('>H', b, off)[0]

NEG = -10**9
best = {ST: (0, None, None)}     # off -> (score, prev_off, size)
order = list(range(ST, EN + 1, 2))
for off in order:
    if off not in best: continue
    sc = best[off][0]
    # 4-byte step
    if off + 4 <= EN:
        v = w(off); s = sc + (10 if (v >> 26) in OPS else 0)
        if s > best.get(off + 4, (NEG,))[0]: best[off + 4] = (s, off, 4)
    # 2-byte step
    if off + 2 <= EN:
        s = sc - 3
        if s > best.get(off + 2, (NEG,))[0]: best[off + 2] = (s, off, 2)

if EN not in best:
    print("no path %s -> %s" % (hex(ST), hex(EN))); sys.exit(1)

path = []; cur = EN
while cur is not None:
    p = best[cur]
    path.append((cur, p[2]))
    cur = p[1]
path.reverse()

print("=== trace %s -> %s  (score %d) ===" % (hex(ST), hex(EN), best[EN][0]))
prev_hi = {}
for off, sz in path:
    if sz is None: continue
    if sz == 4:
        v = w(off); op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f
        imm = v & 0xffff
        nm = OPS.get(op, 'op%02x' % op)
        ann = ''
        if op == 0x30:
            prev_hi[rD] = imm; ann = 'r%d = 0x%04x_0000' % (rD, imm)
        elif op == 0x3f:
            if rA == rD and rD in prev_hi:
                va = (prev_hi[rD] << 16) | imm
                ann = 'r%d = 0x%08x' % (rD, va)
                if BASE is not None:
                    f = va - BASE
                    if 0 <= f < len(b):
                        ann += '  "%s"' % b[f:f+60].split(b'\x00')[0].decode('latin1')[:56]
                elif (va >> 16) == 0x1c01:
                    ann += '  [DM 0x%04x]' % (va & 0xffff)
            else:
                ann = 'r%d |= 0x%04x' % (rD, imm)
        elif op == 0x3b:
            ann = 'rD%d <- [r%d + 0x%04x]' % (rD, rA, imm)
            if rA in prev_hi and (prev_hi[rA] << 16) if False else False: pass
        print("  0x%06x %08x  %-6s r%-2d,r%-2d,0x%04x  %s" % (off, v, nm, rD, rA, imm, ann))
    else:
        print("  0x%06x   %04x        (16-bit)" % (off, h(off)))
