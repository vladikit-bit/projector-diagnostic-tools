#!/usr/bin/env python3
"""R19 confirmatory census:
(1) Every `ori` with imm 0x4 or 0x81 -> classify clean-immediate (rA==r0) vs OR-into-existing (rA!=r0).
(2) Localize runtime diagnostic strings in the binary (rodata). Byte offsets only (loader-resolved refs not statically reachable).
Static only.
"""
import struct, os
os.makedirs("C:/firmware_temp/r19_out", exist_ok=True)
BIN="C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b=open(BIN,'rb').read();N=len(b)
OPS={0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}

def dis(off):
    v=struct.unpack_from('>I',b,off)[0]
    return v>>26,(v>>21)&0x1f,(v>>16)&0x1f,v&0xffff,v

out=[]
# (1) ori census for imm 0x4 and 0x81
clean4=[];flag4=[];clean81=[];flag81=[]
off=0
while off+4<=N:
    op,rD,rA,imm,v=dis(off)
    if op==0x3f:  # ori
        if imm==0x4:
            (clean4 if rA==0 else flag4).append((off,rD,rA,imm,v))
        elif imm==0x81:
            (clean81 if rA==0 else flag81).append((off,rD,rA,imm,v))
    off+=4

out.append("===== ori immediate census (imm==0x4 / imm==0x81) =====")
out.append("CLEAN immediate 0x4 (ori rX, r0, 0x4): %d"%len(clean4))
for o in clean4: out.append("  %06x  ori r%d, r0, 0x0004  (v=%08x)"%(o[0],o[1],o[4]))
out.append("OR-into-existing 0x4 (ori rX, rA!=0, 0x4): %d"%len(flag4))
for o in flag4: out.append("  %06x  ori r%d, r%d, 0x0004  (v=%08x)"%(o[0],o[1],o[2],o[4]))
out.append("CLEAN immediate 0x81 (ori rX, r0, 0x81): %d"%len(clean81))
for o in clean81: out.append("  %06x  ori r%d, r0, 0x0081  (v=%08x)"%(o[0],o[1],o[4]))
out.append("OR-into-existing 0x81 (ori rX, rA!=0, 0x81): %d"%len(flag81))
for o in flag81: out.append("  %06x  ori r%d, r%d, 0x0081  (v=%08x)"%(o[0],o[1],o[2],o[4]))

# (2) string localization
out.append("\n===== runtime diagnostic string localization (byte offsets in binary) =====")
strings=[b"decType change", b"type[", b"licencee", b"dts m6 init", b"es:1536", b"pcm:"]
for s in strings:
    idx=0; hits=[]
    while True:
        p=b.find(s,idx)
        if p<0: break
        hits.append(p); idx=p+1
        if len(hits)>5: break
    out.append("  %-16s -> %d hit(s) at file_off %s"%(s.decode('latin1','replace'), len(hits),
              ", ".join("0x%06x"%h for h in hits[:6])))

txt="\n".join(out)
open("C:/firmware_temp/r19_out/scan2.txt","w").write(txt)
print(txt)
