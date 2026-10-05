#!/usr/bin/env python3
"""R12: rodata-VA xref over a DSP image.
AEON 32-bit subset (cracked R10/R11): op0x30=movhi, op0x3f=ori, op0x3b=ld/st, op0x39=call.
A rodata reference is a movhi(hi16) + ori(lo16) pair.
Usage: r12_xref.py <image> <rodata_base> <hi16> <lo16> [lo16b ...]
"""
import sys, struct

def main():
    img = sys.argv[1]; base = int(sys.argv[2], 0)
    hi  = int(sys.argv[3], 0)
    los = [int(x, 0) for x in sys.argv[4:]]
    b = open(img, 'rb').read()
    n = len(b) // 4
    w = struct.unpack('>%dI' % n, b[:n*4])

    print("image=%s  rodataVA = file + 0x%x   target hi16=0x%04x" % (img, base, hi))
    for lo in los:
        va = (hi << 16) | lo
        print("\n### target VA 0x%08x  (file 0x%x) ###" % (va, va - base))
        # movhi sites with imm16 == hi
        mh = [i*4 for i, v in enumerate(w) if (v >> 26) == 0x30 and (v & 0xffff) == hi]
        # ori sites with imm16 == lo
        ori= [i*4 for i, v in enumerate(w) if (v >> 26) == 0x3f and (v & 0xffff) == lo]
        print("  movhi(0x%04x) sites: %d" % (hi, len(mh)))
        print("  ori(0x%04x)   sites: %d" % (lo, len(ori)))
        hits = []
        for o in ori:
            # look back up to 12 words for a movhi with the same rD
            rd = (w[o//4] >> 21) & 0x1f
            for back in range(1, 13):
                p = o - 4*back
                if p < 0: break
                v = w[p//4]
                if (v >> 26) == 0x30 and (v & 0xffff) == hi and ((v >> 21) & 0x1f) == rd:
                    hits.append((p, o, rd)); break
        for p, o, rd in hits:
            print("   PAIR @ movhi 0x%06x / ori 0x%06x  r%d" % (p, o, rd))
            lo2 = max(0, p - 0x40)
            for r in range(lo2, min(len(b), o + 0x50), 16):
                d = b[r:r+16]
                mark = ''
                if r <= p < r+16: mark += ' <MOVHI'
                if r <= o < r+16: mark += ' <ORI'
                print("      %06x  %-47s |%s|%s" % (r, ' '.join('%02x'%c for c in d),
                      ''.join(chr(c) if 32<=c<127 else '.' for c in d), mark))

if __name__ == '__main__':
    main()
