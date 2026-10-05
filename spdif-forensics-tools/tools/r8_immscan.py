#!/usr/bin/env python3
"""R8: determine the load/store opcode by correlating candidate imm16 values with
    SHM offsets the host is known to touch (HAL_SND_R2_init_SHM_param)."""
import sys, struct, collections

path=sys.argv[1]
b=open(path,'rb').read()
n=len(b)//4

# SHM offsets written by HAL_SND_R2_init_SHM_param / Set_SHM_PARAM (known host side)
interesting = [0xf8,0xec,0x104,0x10c,0x110,0x114,0x118,0x11c,0x120,0x124,
               0x13c,0x140,0x144,0x148,0x14c,0x154,0x158,0x15c,0x164,0x168,
               0x16c,0x170,0x174,0x180,0x184,0x188,0x18c,0x190,0x198,
               0x328,0x32c,0x330,0x334,0x338,0x858]
iset=set(interesting)

for endian in ('>','<'):
    print("\n===== %s-endian word read =====" % ("BIG" if endian=='>' else "LITTLE"))
    w=struct.unpack('%s%dI'%(endian,n), b[:n*4])
    # baseline: how often does an arbitrary imm16 appear?
    hits=collections.Counter()   # top16 -> count
    tot=collections.Counter()
    for v in w:
        imm = v & 0xffff
        tot[imm]+=1
        if imm in iset: hits[v>>16]+=1
    print("occurrences of the %d SHM offsets as imm16 (total %d words):" % (len(iset), n))
    for k,v in hits.most_common(25):
        print("   top16=0x%04x  count=%-5d  (op=0x%02x rD=%d rA=%d)" %
              (k, v, k>>10, (k>>5)&0x1f, k&0x1f))
    # baseline expectation
    base = sum(tot[i] for i in iset)/len(iset)
    print("baseline: mean count for a random imm16 = %.1f" % base)
