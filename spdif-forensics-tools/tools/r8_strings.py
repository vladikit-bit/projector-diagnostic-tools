#!/usr/bin/env python3
"""R8: comprehensive string + symbol mining inside extracted DSP blobs."""
import sys, os, re, struct

def strings(b, minlen=5):
    out = []
    cur = b''
    start = 0
    for i, c in enumerate(b):
        if 32 <= c < 127:
            if not cur:
                start = i
            cur += bytes([c])
        else:
            if len(cur) >= minlen:
                out.append((start, cur.decode('ascii')))
            cur = b''
    if len(cur) >= minlen:
        out.append((start, cur.decode('ascii')))
    return out

def wordstrings(b, minlen=4):
    """32-bit BE / LE sequences of ASCII formed as 2 chars per word (MStar style)."""
    return strings(b, minlen)

if __name__ == '__main__':
    path = sys.argv[1]
    mode = sys.argv[2] if len(sys.argv) > 2 else 'all'
    b = open(path, 'rb').read()
    print("file=%s size=0x%x (%d)" % (path, len(b), len(b)))
    ss = strings(b, 5)
    print("total printable strings >=5 : %d" % len(ss))
    filt = sys.argv[3] if len(sys.argv) > 3 else None
    for off, s in ss:
        if filt and filt.lower() not in s.lower():
            continue
        print("  0x%06x: %s" % (off, s))
