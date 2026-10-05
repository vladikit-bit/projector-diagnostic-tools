#!/usr/bin/env python3
"""R18j: histogram of movhi hi values (top 30) + disassemble around dts m6 init anchor."""
import struct
from collections import Counter
BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b = open(BIN, 'rb').read(); N = len(b)
OPS = {0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}
hi = Counter()
for off in range(0, N - 4, 4):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD=(v>>21)&0x1f; rA=(v>>16)&0x1f; imm=v&0xffff
    if op==0x30: hi[imm]+=1
print("=== top movhi hi values (hex) ===")
for h,c in hi.most_common(30):
    print("  0x%04x : %d" % (h,c))

# disassemble around dts m6 init anchor 0x01e66c (file offset)
center = 0x01e66c
half = 120
print("\n=== disasm around 0x%06x (dts m6 init ok anchor) ===" % center)
for off in range(center-half*4, center+half*4, 4):
    if off < 0 or off+4 > N: continue
    v = struct.unpack_from('>I', b, off)[0]
    op=v>>26; rD=(v>>21)&0x1f; rA=(v>>16)&0x1f; imm=v&0xffff
    nm=OPS.get(op,'op%02x'%op)
    mark=' <<<' if off==center else ''
    print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"%(off,v,nm,rD,rA,imm,mark))
