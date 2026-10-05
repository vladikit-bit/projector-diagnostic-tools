#!/usr/bin/env python3
"""R8: most-frequent 32-bit words in a region (function prologue/epilogue detector)."""
import sys, struct, collections
path=sys.argv[1]; lo=int(sys.argv[2],0); hi=int(sys.argv[3],0)
b=open(path,'rb').read()[lo:hi]
print("region %s 0x%x..0x%x" % (path,lo,hi))
for endian in ('>','<'):
    n=(hi-lo)//4
    w=struct.unpack('%s%dI'%(endian,n), b[:n*4])
    c=collections.Counter(w)
    print("\n--- %s-endian top 24 (of %d words, %d unique) ---" %
          ("BIG" if endian=='>' else "LITTLE", n, len(c)))
    for v,k in c.most_common(24):
        bb = struct.pack('>I',v) if endian=='>' else struct.pack('<I',v)
        print("  0x%08x x%-6d  bytes %s" % (v,k,' '.join('%02x'%x for x in bb)))
