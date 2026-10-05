#!/usr/bin/env python3
"""R8: (a) exhaustive IEC61937 / DTS sync-word search over all rotations+endianness
       (b) targeted search for the SHM-base immediate 0xa000 using the recovered
           AEON load-immediate encoding (op 0x32: byte0 in c8..cb)."""
import sys, struct, collections

def search(b, pat, name):
    offs=[]
    i=b.find(pat)
    while i!=-1:
        offs.append(i); i=b.find(pat, i+1)
    return name, offs

def main(path):
    b=open(path,'rb').read()
    print("=== %s (size 0x%x) ===" % (path, len(b)))
    print("\n(a) sync-word search  (random 4-byte expectation in this file = %.2f)"
          % (len(b)/(2**32) if False else len(b)/4294967296*1.0))
    print("    note: for a 4-byte pattern, expected random hits = %.4f" % (len(b)/4294967296))
    cands = {
      'IEC Pa  F8724E1F (BE)':        b'\xf8\x72\x4e\x1f',
      'IEC Pa  72F81F4E (LE)':        b'\x72\xf8\x1f\x4e',
      'IEC Pa  1F4E72F8 (BE swap16)': b'\x1f\x4e\x72\xf8',
      'IEC Pa  4E1FF872 (LE swap16)': b'\x4e\x1f\xf8\x72',
      'DTS 16b BE  7FFE8001':         b'\x7f\xfe\x80\x01',
      'DTS 16b LE  FE7F0180':         b'\xfe\x7f\x01\x80',
      'DTS 14b BE  1FFFE800':         b'\x1f\xff\xe8\x00',
      'DTS 14b LE  FF1F00E8':         b'\xff\x1f\x00\xe8',
    }
    for name,pat in cands.items():
        _,o = search(b,pat,name)
        print("    %-28s hits=%-3d %s" % (name, len(o), o[:8]))

    print("\n(b) SHM-base immediate candidates: op0x32 load-imm with imm16=0xa000")
    hits=[]
    for off in range(0, len(b)-4):
        if b[off+2]==0xa0 and b[off+3]==0x00 and b[off] in (0xc8,0xc9,0xca,0xcb):
            hits.append(off)
    print("    hits=%d" % len(hits))
    for off in hits[:40]:
        print("      0x%06x  %02x %02x %02x %02x   (rD=%d rA=%d)" %
              (off, b[off],b[off+1],b[off+2],b[off+3],
               ((b[off]&3)<<3)|(b[off+1]>>5), b[off+1]&0x1f))

    print("\n(c) same scan for imm16 = 0xf8 (possible direct SHM+0xf8 access)")
    h2=[off for off in range(0,len(b)-4) if b[off+2]==0x00 and b[off+3]==0xf8
        and b[off] in (0xc8,0xc9,0xca,0xcb)]
    print("    hits=%d" % len(h2))
    for off in h2[:20]:
        print("      0x%06x  %02x %02x %02x %02x" % (off, b[off],b[off+1],b[off+2],b[off+3]))

if __name__=='__main__':
    main(sys.argv[1])
