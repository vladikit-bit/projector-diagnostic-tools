#!/usr/bin/env python3
"""R8: compare two DSP blobs + scan for IEC61937 / burst-info constants."""
import sys, struct

A=open(sys.argv[1],'rb').read()
B=open(sys.argv[2],'rb').read()
print("%s  size=0x%x" % (sys.argv[1], len(A)))
print("%s  size=0x%x" % (sys.argv[2], len(B)))
n=min(len(A),len(B))
blk=0x1000

# first divergence
d = next((i for i in range(n) if A[i]!=B[i]), n)
print("\nfirst differing byte: 0x%x" % d)
al = next((i for i in range(n) if A[i]==B[i] and i>d), None)
print("common prefix length: 0x%x" % d)

same=diff=0; firstdiff=None; blocks=[]
for off in range(0, n-blk, blk):
    if A[off:off+blk]==B[off:off+blk]: same+=1
    else:
        diff+=1
        if firstdiff is None: firstdiff=off
        blocks.append(off)
print("4K blocks: identical=%d  differing=%d (of %d comparable)" % (same,diff,same+diff))
print("identical prefix blocks up to 0x%x" % (firstdiff if firstdiff is not None else n))
print("differing-block range: 0x%x .. 0x%x" % (blocks[0], blocks[-1]) if blocks else "none")

# ---- IEC61937 / burst constant scan ----
CONSTS = {
 'IEC61937 sync1 0xF872 BE': b'\xf8\x72',
 'IEC61937 sync1 0x72F8 LE': b'\x72\xf8',
 'IEC61937 sync2 0x4E1F BE': b'\x4e\x1f',
 'IEC61937 sync2 0x1F4E LE': b'\x1f\x4e',
 'Pa 0xF8724E1F (AC3/DTS sync, BE)': b'\xf8\x72\x4e\x1f',
 'Pa 0x72F81F4E (LE)': b'\x72\xf8\x1f\x4e',
 'Pb AC3 0x03E0/0x0BE0': b'\x03\xe0',
 'IEC 0x0000 filler 8x': b'\x00'*8,
}
print("\n--- IEC61937 sync-word scan ---")
for name, pat in CONSTS.items():
    for tag, blob in (('snd',A),('snd_MS12V22',B)):
        c=blob.count(pat)
        print("  %-38s %-13s count=%d" % (name, tag, c))
