#!/usr/bin/env python3
# R21 focused store-search: from each `ori rAddr, rBase, 0x4f1x` destination site,
# trace rAddr forward to a mem op (candidate store), then trace the value reg backward to its source.
# Also: from each 0xe30000 literal load candidate, link to the store.
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_snd_r2_MS12V22.bin"
data = open(BIN, "rb").read()
N = len(data)
def be32(o): return struct.unpack(">I", data[o:o+4])[0]
def dec(o):
    w = be32(o); return (w>>26)&0x3F, (w>>21)&0x1F, (w>>16)&0x1F, (w&0xFFFF)-0x10000 if (w&0x8000) else (w&0xFFFF), w
def dis(o):
    op,rD,rA,im,w = dec(o)
    if op==0x30: return "%08x  movhi r%d, 0x%x"%(w,rD,im&0xFFFF if im>=0 else im+0x10000)
    if op==0x32: return "%08x  li    r%d, r%d, 0x%x"%(w,rD,rA,im&0xFFFF) if rA else "%08x  li    r%d, 0x%x"%(w,rD,im&0xFFFF)
    if op==0x3f: return "%08x  ori   r%d, r%d, 0x%x"%(w,rD,rA,im&0xFFFF)
    if op==0x3b: return "%08x  mem   r%d, [r%d + 0x%x]"%(w,rD,rA,im)
    if op==0x39: return "%08x  call  (r%d + 0x%x)"%(w,rA,im)
    return "%08x  op%02X r%d, r%d, 0x%x"%(w,op,rD,rA,im&0xFFFF)

def fwd_trace(start, reg, maxi=200):
    """forward from start+4; return list of (off,str,kind) until reg redefined (known writer) or unknown op."""
    out=[]; o=start+4
    while o+4<=N and len(out)<maxi:
        op,rD,rA,im,w = dec(o)
        if op in (0x30,0x32,0x3f):
            if rD==reg:
                out.append((o,dis(o),"REDEF(r%d)"%reg)); break
            if rA==reg or (op in (0x3f,0x32) and rD==reg):
                out.append((o,dis(o),"use"))
        elif op==0x3b:
            if rA==reg or rD==reg:
                out.append((o,dis(o),"mem(r%d)"%reg))
        elif op==0x39:
            if rA==reg or rD==reg: out.append((o,dis(o),"call"))
        else:
            if rD==reg or rA==reg: out.append((o,dis(o),"UNKNOWN")); break
        o+=4
    return out

def back_trace(start, reg, maxi=200):
    """backward from start-4; find last definition (known writer / mem load) of reg."""
    out=[]; o=start-4
    while o>=0 and len(out)<maxi:
        op,rD,rA,im,w = dec(o)
        if op in (0x30,0x32,0x3f):
            if rD==reg:
                out.append((o,dis(o),"DEF(r%d)"%reg)); break
            if rA==reg: out.append((o,dis(o),"use"))
        elif op==0x3b:
            if rD==reg: out.append((o,dis(o),"LOAD->r%d"%reg)); break
            if rA==reg: out.append((o,dis(o),"use"))
        elif op==0x39:
            if rA==reg or rD==reg: out.append((o,dis(o),"call"))
        else:
            if rD==reg or rA==reg: out.append((o,dis(o),"UNKNOWN")); break
        o-=4
    return out

# base 0x301 -> 0x03010000 ; offsets of interest
DESTS = {0x4f17:[(0xb98a4,1,16),(0xc5800,12,8)],
         0x4f18:[(0x8ea24,0,0),(0x1085d8,5,24)],
         0x4f1a:[(0xff230,11,3),(0xff374,17,29)]}

lines=[]
def L(s): lines.append(s)
L("="*78)
L("R21 focused store-search: destination 0x4f17/0x4f18/0x4f1a -> mem op -> value source")
L("="*78)

for off, rAddr, rBase in [s for v in DESTS.values() for s in v]:
    if rAddr==0 and rBase==0:
        L("\n[SKIP no-op site @ 0x%x (r0 = r0 | imm)]"%off); continue
    L("\n"+"-"*70)
    L("destination ori @ 0x%x : r%d = r%d | 0x%x"%(off, rAddr, rBase, dec(off)[3]&0xFFFF))
    # forward trace of rAddr
    ft = fwd_trace(off, rAddr)
    L("  forward r%d (address reg):"%rAddr)
    store=None
    for a,d,k in ft:
        L("    0x%05x: %s   [%s]"%(a,d,k))
        if k.startswith("mem") and "r%d"%rAddr in d and "r%d +"%rAddr in d:
            store=a  # candidate store: mem rD,[rAddr+imm]
    if store is None:
        L("    (no mem op using r%d as address within 200i -> store UNRESOLVED at instr level)"%rAddr)
        continue
    # value reg = rD of the store (if store is 'mem rD,[rAddr+imm]')
    sop,srD,srA,sim,sw = dec(store)
    L("  CANDIDATE STORE @ 0x%x : %s"%(store,dis(store)))
    L("    -> value reg r%d ; trace backward:"%srD)
    bt = back_trace(store, srD)
    for a,d,k in bt:
        L("    0x%05x: %s   [%s]"%(a,d,k))
    # also show a small window around the store
    L("  window around store:")
    lo=max(0,store-40); lo-=lo%4
    for o in range(lo, min(N-4, store+44), 4):
        L("    0x%05x: %s%s"%(o, dis(o), "   <== STORE" if o==store else ""))

open("C:/firmware_temp/r21_out/store_search.txt","w").write("\n".join(lines))
print("\n".join(lines))
print("\n[written r21_out/store_search.txt]")
