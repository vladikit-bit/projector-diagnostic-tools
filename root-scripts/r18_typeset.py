#!/usr/bin/env python3
"""R18l: locate writes of decoder-type values (0x81 / 0x4) to DM globals (0x1c01xxxx).
The store of 0x81 (passthrough) vs 0x4 (PCM) to the decoder-type global IS the decision.
Track reg values (movhi high + ori low); flag ld/st whose value reg == 0x81/0x4 and whose
base reg was established via movhi 0x1c01. Static only.
"""
import struct
from collections import defaultdict
BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b = open(BIN,'rb').read(); N=len(b)
OPS={0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}
insns=[]
for off in range(0,N-4,4):
    v=struct.unpack_from('>I',b,off)[0]
    op=v>>26;rD=(v>>21)&0x1f;rA=(v>>16)&0x1f;imm=v&0xffff
    insns.append((off,op,rD,rA,imm))
idx={off:i for i,(off,*_) in enumerate(insns)}
ori_by_imm=defaultdict(list)
for i,(off,op,rD,rA,imm) in enumerate(insns):
    if op==0x3f: ori_by_imm[imm].append(i)

reg={}
# first pass: find all movhi 0x1c01 establishing a base, record (off, reg)
dm_base={}  # reg -> list of off where movhi 0x1c01 set it
for off,op,rD,rA,imm in insns:
    if op==0x30 and imm==0x1c01:
        dm_base.setdefault(rD,[]).append(off)

# second pass: propagation, flag stores of 0x81/0x4 to a 0x1c01-based global
reg={}
TYPEVALS={0x81,0x4}
cands=[]
for off,op,rD,rA,imm in insns:
    if op==0x30:
        reg[rD]=(imm<<16)&0xffffffff
    elif op==0x3f:
        base=reg.get(rA) if (rA in reg and reg[rA] is not None) else (reg.get(rD) if (rD in reg and reg[rD] is not None) else 0)
        reg[rD]=(base|imm)&0xffffffff
    else:
        reg[rD]=None
    # for a store: value in rD, base in rA. AEON ld/st: rD is both addr(target) for load and value for store;
    # ambiguous. Heuristic: if reg[rD] in TYPEVALS and rA is a known 0x1c01 base -> store of type.
    if op==0x3b and rA in dm_base and (reg.get(rD) in TYPEVALS):
        cands.append((off,rD,rA,reg[rD],imm))

print("=== candidate decoder-type stores to 0x1c01 globals (value reg == 0x81/0x4) ===")
seen=set()
for (off,rD,rA,val,imm) in cands:
    if off in seen: continue
    seen.add(off)
    print("  0x%06x  st r%d=0x%02x -> [r%d+0x%04x]   (base r%d = DM 0x1c01xxxx)"%(off,rD,val,rA,imm,rA))

# also: where 0x81 / 0x4 constants are loaded (ori imm) -> show context to find compare/branch gating
print("\n=== context around ori-imm 0x0081 / 0x0004 loads (potential type set / compare) ===")
for tgt in (0x0081,0x0004):
    for i in ori_by_imm.get(tgt,[]):
        off,op,rD,rA,imm=insns[i]
        lo=max(0,i-12);hi=min(len(insns),i+10)
        print("\n-- ori 0x%04x @ 0x%06x (r%d=r%d|0x%04x) --"%(imm,off,rD,rA,imm))
        for j in range(lo,hi):
            o2,op2,rD2,rA2,imm2=insns[j]
            nm=OPS.get(op2,'op%02x'%op2)
            mark=' <<<' if j==i else ''
            print("    %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"%(o2,struct.unpack_from('>I',b,o2)[0],nm,rD2,rA2,imm2,mark))
