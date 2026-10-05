#!/usr/bin/env python3
"""R8: locate AEON/OR1K code regions by top-byte (opcode<<2|rD>>3) concentration."""
import sys, struct, collections

path = sys.argv[1]
blk  = int(sys.argv[2],0) if len(sys.argv)>2 else 0x1000
b = open(path,'rb').read()

rows=[]
for off in range(0, len(b)-blk, blk):
    c = b[off:off+blk]
    w = struct.unpack('<%dI'%(blk//4), c)      # little-endian read
    tb = collections.Counter(x>>24 for x in w)
    n  = blk//4
    top1 = tb.most_common(1)[0][1]*100//n
    top3 = sum(v for _,v in tb.most_common(3))*100//n
    top8 = sum(v for _,v in tb.most_common(8))*100//n
    # candidate-opcode mass: OR1K load/store/addi/ori/movhi/br/jal/jr
    rows.append((off, top1, top3, top8, tb.most_common(6)))

rows.sort(key=lambda r: -r[3])
print("%-10s %5s %5s %5s  %s" % ("block","top1","top3","top8","top top-bytes"))
for off,t1,t3,t8,mc in rows[:45]:
    print("0x%08x %4d%% %4d%% %4d%%  %s" % (off,t1,t3,t8,
        ' '.join('%02x:%d'%(k,v) for k,v in mc)))
print("... (%d blocks total, showing 45 highest top8 concentration)" % len(rows))
