#!/usr/bin/env python3
"""R18m: pin dts m6 init ok anchor (ori 0x3ae2) + disassemble; chase 0x81 load @0x1208a0."""
import struct
BIN="C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b=open(BIN,'rb').read();N=len(b)
OPS={0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}

def disasm(center,half,name):
    print("\n=== %s : disasm 0x%06x (+/-%d) ==="%(name,center,half))
    for off in range(center-half*4,center+half*4,4):
        if off<0 or off+4>N: continue
        v=struct.unpack_from('>I',b,off)[0]
        op=v>>26;rD=(v>>21)&0x1f;rA=(v>>16)&0x1f;imm=v&0xffff
        nm=OPS.get(op,'op%02x'%op)
        mark=' <<<' if off==center else ''
        print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"%(off,v,nm,rD,rA,imm,mark))

# find ori imm 0x3ae2 with preceding movhi 0x0281 (dts m6 init ok), tolerant
for off in range(0,N-4,4):
    v=struct.unpack_from('>I',b,off)[0]
    op=v>>26;rD=(v>>21)&0x1f;rA=(v>>16)&0x1f;imm=v&0xffff
    if op==0x3f and imm==0x3ae2:
        # look back up to 0x80 for movhi 0x0281 into rA or rD
        for j in range(off-4,max(-1,off-0x200),-4):
            m=struct.unpack_from('>I',b,j)[0]
            mo=m>>26;mA=(m>>21)&0x1f;mimm=m&0xffff
            if mo==0x30 and mimm==0x0281 and (mA==rA or mA==rD):
                print("dts m6 init ok anchor: ori@0x%06x movhi@0x%06x base=r%d"%(off,j,mA))
                disasm(off,60,"dts m6 init ok")
                break

# chase 0x81 load at 0x1208a0
disasm(0x1208a0,50,"0x81 type load @0x1208a0")
