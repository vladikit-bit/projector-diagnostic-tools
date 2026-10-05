#!/usr/bin/env python3
"""a2: DEC DSP (mst_codec_r2_MS12V22.bin) structure map + movhi/ori string-xref scan.
AEON tentative: word = BE32, op(6) rD(5) rA(5) imm16(16); op 0x30 = movhi (rD = imm<<16),
op 0x32 = ori (rD = rA | imm). DSP VA = file_off + 0x10000 (validated from boot stub).
Read-only; prints to stdout.
"""
import struct, sys, re

IMG = sys.argv[1] if len(sys.argv) > 1 else 'r8_out/mst_codec_r2_MS12V22.bin'
BASE = int(sys.argv[2], 0) if len(sys.argv) > 2 else 0x10000
b = open(IMG, 'rb').read()

# ---- 1. region map per 4K block
print("=== region map (C=code-ish, S=string/ascii, Z=zeros, F=ff, ?=mixed) ===")
def classify(blk):
    if blk == b'\x00'*len(blk): return 'Z'
    if blk == b'\xff'*len(blk): return 'F'
    printable = sum(1 for c in blk if 32 <= c < 127)
    if printable > len(blk)*0.5: return 'S'
    zeros = blk.count(0); ff = blk.count(0xff)
    if zeros + ff > len(blk)*0.9: return 'z'
    return 'C'
runs = []
prev = None
for off in range(0, len(b), 0x1000):
    c = classify(b[off:off+0x1000])
    if c != prev:
        runs.append([off, off+0x1000, c]); prev = c
    else:
        runs[-1][1] = off+0x1000
for s, e, c in runs:
    print("  0x%06x-0x%06x %s" % (s, e, c))

# ---- 2. string table
strings = {}
for m in re.finditer(rb'[\x20-\x7e]{6,}', b):
    s = m.group().decode('latin1')
    # keep only plausible message strings (has a letter, not binary junk)
    if re.search(r'[A-Za-z]{3}', s):
        strings[m.start()] = s
print("total strings: %d" % len(strings))

# ---- 3. movhi/ori pair scan over the whole image (words must be in 'C' or unknown regions)
words = len(b)//4
def w(off): return struct.unpack_from('>I', b, off)[0]
pairs = []   # (site_off, rd, va)
i = 0
for off in range(0, len(b)-8, 4):
    w1 = w(off)
    if (w1 >> 26) != 0x30: continue
    rd = (w1 >> 21) & 31
    hi = w1 & 0xffff
    # look ahead up to 10 words for ori rd, rD
    for d in range(1, 11):
        o2 = off + 4*d
        w2 = w(o2)
        if (w2 >> 26) == 0x32 and ((w2 >> 21) & 31) == rd and ((w2 >> 16) & 31) == rd:
            va = (hi << 16) | (w2 & 0xffff)
            pairs.append((off, rd, va))
            break
        # intervening instruction with different rd: keep scanning only if not another movhi on rd
        if (w2 >> 26) == 0x30 and ((w2 >> 21) & 31) == rd:
            break
print("movhi/ori pairs: %d" % len(pairs))

# ---- 4. match pair VAs to string offsets (va - BASE == string_off)
hits = {}
for site, rd, va in pairs:
    off = va - BASE
    if off in strings:
        hits.setdefault(off, []).append(site)
print("pairs resolving to strings: %d (covering %d distinct strings)" % (sum(len(v) for v in hits.values()), len(hits)))

# ---- 5. report xrefs for target strings
targets = ['Invalid Spdif license', 'Invalid Hdmi license', 'spdif_type', 'arm->r2', 'lic[',
           'r2_spdifOutput_control', 'r2_outputSpdifFrame', 'Mstar_DTS_Hdmi_Packer',
           'ES SR:%d, SPDIF info', 'DTS', 'dts', 'spdif', 'Spdif', 'SPDIF']
print("\n=== target string xrefs ===")
for off in sorted(strings):
    s = strings[off]
    if any(t in s for t in targets):
        xrefs = hits.get(off, [])
        print("str 0x%06x (VA 0x%06x) refs=%d  %r" % (off, off+BASE, len(xrefs), s[:70]))
        for x in xrefs[:8]:
            print("     ref from code 0x%06x (VA 0x%06x)" % (x, x+BASE))
