#!/usr/bin/env python3
"""R18k: wide disasm of dts m6 init region, annotating DM globals + type constants."""
import struct
BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b = open(BIN, 'rb').read(); N = len(b)
OPS = {0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}
RODATA_BASE = 0x26CD000
# rodata strings for annotation
strings = {
 0x02813ac5:b"dts m6 hook ok",0x02813ad5:b"dts m6 init ok",0x02813ae4:b"dts_licensee",
 0x02813af5:b"lbr_licensee",0x02813b06:b"xll_licensee",0x02813b17:b"transcoder_licensee",
 0x02814c80:b"CPU MS12V2 ddp init ok",0x02814c98:b"CPU MS12V2 ddp hook ok",0x02814c8b:b"ddp init ok",
 0x0280f07c:b"r2_decoder_houseKeeping",0x0280ea2d:b"decType change"}
def rodata_str(va):
    f = va - RODATA_BASE
    if 0 <= f < N:
        return b[f:f+48].split(b'\x00')[0].decode('latin1')
    return None

START=0x01e3e0; END=0x01ef00
print("=== disasm 0x%06x..0x%06x (dts m6 init region) ===" % (START,END))
off=START
while off < END:
    if off+4 > N: break
    v=struct.unpack_from('>I',b,off)[0]
    op=v>>26; rD=(v>>21)&0x1f; rA=(v>>16)&0x1f; imm=v&0xffff
    nm=OPS.get(op,'op%02x'%op)
    ann=''
    if op==0x30:
        ann='r%d = 0x%04x0000'%(rD,imm)
    elif op==0x3f:
        if rA==rD:
            va=(imm if imm>>15 else 0)|(( (0x0281<<16) if imm<0x8000 else 0))  # not reliable
            ann='r%d |= 0x%04x'%(rD,imm)
        else:
            ann='r%d = r%d|0x%04x'%(rD,rA,imm)
    elif op==0x3b:
        # ld/st to absolute DM? treat imm as offset from rA; if rA known global base, annotate
        ann='r%d,[r%d+0x%04x]'%(rD,rA,imm)
        if (imm & 0xff00)==0x1c00 or imm==0x1c01:
            ann+='  [DM]'
        if imm>>8==0x1c and (imm&0xff00)==0x1c00:
            ann+='  [DM 0x%04x]'%(imm)
    elif op==0x39:
        ann='call 0x%04x'%(imm)
    # flag type constants
    flag=''
    if imm in (0x0081,0x0004,0x0080,0x0000):
        flag='   <== type/const %d'%imm
    if op==0x3f and rA==rD and imm in (0x0081,0x0004):
        flag='   <== SET TYPE 0x%02x'%imm
    # annotate rodata string if this ori builds one
    if op==0x3f:
        pass
    print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x  %-30s%s"%(off,v,nm,rD,rA,imm,ann,flag))
    off+=4
