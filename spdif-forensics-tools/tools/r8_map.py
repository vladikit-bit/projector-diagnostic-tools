#!/usr/bin/env python3
"""R8: structural map of a DSP blob - per-0x1000 block stats."""
import sys, struct, collections

def run(path, lo=0, hi=None, blk=0x1000):
    b = open(path, 'rb').read()
    if hi is None: hi = len(b)
    print("%s  size=0x%x  window 0x%x..0x%x" % (path, len(b), lo, hi))
    print("%-10s %6s %6s %6s %6s %6s  %s" % ("block","zero%","ff%","uniq32","uniq16","nz16%","note"))
    prev = None
    for off in range(lo, hi, blk):
        c = b[off:off+blk]
        if len(c) < blk: break
        w = struct.unpack('<%dI' % (blk//4), c)
        z = sum(1 for x in w if x == 0)
        f = sum(1 for x in w if x == 0xffffffff)
        u32 = len(set(w))
        h = struct.unpack('<%dH' % (blk//2), c)
        nz = sum(1 for x in h if x not in (0x0000, 0xffff))
        u16 = len(set(h))
        note = ''
        if z*100//(blk//4) > 60: note = 'ZEROFILL'
        elif f*100//(blk//4) > 60: note = 'FFFILL'
        elif u32 > blk//4 * 0.7: note = 'HIGH-ENTROPY'
        print("0x%08x %5d%% %5d%% %6d %6d %5d%%  %s" % (
            off, z*100//(blk//4), f*100//(blk//4), u32, u16, nz*100//(blk//2), note))

if __name__ == '__main__':
    p = sys.argv[1]
    lo = int(sys.argv[2],0) if len(sys.argv)>2 else 0
    hi = int(sys.argv[3],0) if len(sys.argv)>3 else None
    run(p, lo, hi)
