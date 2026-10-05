#!/usr/bin/env python3
"""a4: dual-phase context dump around DEC-DSP code sites.
Prints the 4-byte grid in BOTH phases with the cracked ops annotated
(movhi=0x30, ori=0x3f, addi=0x3b) + string resolution in the rodata window."""
import struct, re, sys

IMG = 'r8_out/mst_codec_r2_MS12V22.bin'
b = open(IMG, 'rb').read()
def w(off): return struct.unpack_from('>I', b, off)[0]

strs = {}
for m in re.finditer(rb'[\x20-\x7e]{6,}', b[0x140000:0x149000]):
    strs[0x140000 + m.start()] = m.group().decode('latin1')

def ann(wv):
    op, rd, ra, imm = wv >> 26, (wv >> 21) & 31, (wv >> 16) & 31, wv & 0xffff
    n = ''
    if op == 0x30: n = 'movhi r%d, 0x%x' % (rd, imm << 16)
    elif op == 0x3f: n = 'ori   r%d, r%d, 0x%04x' % (rd, ra, imm)
    elif op == 0x3b: n = 'addi  r%d, r%d, 0x%04x' % (rd, ra, imm)
    if imm >= 0x100:
        fo = 0x140000 | imm
        if fo in strs and len(strs[fo]) >= 6:
            n += '   ; STR %r' % strs[fo][:52]
    return op, rd, ra, imm, n

def dump(site, back=14, fwd=16):
    for phase in (0, 2):
        base = (site - phase) & ~3
        print("  --- phase %d grid ---" % phase)
        for i in range(-back, fwd):
            off = base + 4 * i
            if off < 0 or off + 4 > len(b): continue
            wv = w(off)
            op, rd, ra, imm, n = ann(wv)
            mark = ''
            if phase == 0 and off <= site < off + 4 and site % 4 == phase: mark = ' <<<< SITE'
            if phase == 2 and off <= site < off + 4 and site % 4 == phase: mark = ' <<<< SITE'
            print("  0x%06x: %08x  %s%s" % (off, wv, n, mark))

for arg in sys.argv[1:]:
    site = int(arg, 0)
    print("=== site 0x%06x ===" % site)
    dump(site)
    print()
