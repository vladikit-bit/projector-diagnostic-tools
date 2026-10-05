#!/usr/bin/env python3
"""R12: annotated AEON 32-bit subset disassembler for a DSP image region.
Known ops: 0x30 movhi | 0x3f ori | 0x3b ld/st | 0x39 call   (cracked R10/R11)
Annotates: movhi+ori -> absolute VA, rodata string (if base given), DM window 0x1c01xxxx.
Usage: r12_dis.py <image> <start> <len> <phase> [rodata_base]
"""
import sys, struct

IMG = sys.argv[1]; start = int(sys.argv[2], 0); ln = int(sys.argv[3], 0)
phase = int(sys.argv[4], 0)
base = int(sys.argv[5], 0) if len(sys.argv) > 5 else None
b = open(IMG, 'rb').read()

OPS = {0x30: 'movhi', 0x3f: 'ori', 0x3b: 'ld/st', 0x39: 'call'}

def s_at(f):
    if base is None: return None
    f = f - base
    if not (0 <= f < len(b)): return None
    return b[f:f+80].split(b'\x00')[0].decode('latin1')

prev = {}
off = start + ((phase - start) % 4)
print("=== %s  0x%06x..0x%06x  phase %d ===" % (IMG, off, start+ln, phase))
while off < start + ln - 4:
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    nm = OPS.get(op, 'op%02x' % op)
    ann = ''
    if op == 0x30:
        prev[rD] = imm
        ann = 'r%d = 0x%04x0000' % (rD, imm)
    elif op == 0x3f:
        if rA == rD and rD in prev:
            va = (prev[rD] << 16) | imm
            ann = 'r%d = 0x%08x' % (rD, va)
            s = s_at(va)
            if s: ann += '   "%s"' % s[:64]
            elif (va >> 16) == 0x1c01: ann += '   [DM 0x%04x]' % (va & 0xffff)
        else:
            ann = 'r%d |= 0x%04x' % (rD, imm)
    elif op == 0x3b:
        ann = 'r%d, 0x%04x(r%d)' % (rD, imm, rA)
    elif op == 0x39:
        ann = 'r%d/r%d 0x%04x' % (rD, rA, imm)
    print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x   %s" % (off, v, nm, rD, rA, imm, ann))
    off += 4
