#!/usr/bin/env python3
"""a2: DEC DSP string-xref resolver. Pattern: rodata string VA = 0x02810000 + (file - 0x140000);
ref = movhi rX, 0x0281 (op 0x30) ... ori rX, rX, lo (op 0x3f, rd==ra) within window.
low-region (PM/code window) refs: movhi rX, 0x0001 + ori rX,rX,lo with VA = 0x10000+file.
Read-only."""
import struct, re, sys

IMG = 'r8_out/mst_codec_r2_MS12V22.bin'
b = open(IMG, 'rb').read()
def w(off): return struct.unpack_from('>I', b, off)[0]

# full string table (any region, min 8 chars)
strs = {}
for m in re.finditer(rb'[\x20-\x7e]{8,}', b):
    strs[m.start()] = m.group().decode('latin1')

def find_refs(target_sub, window=16):
    """find sites referencing any string containing target_sub"""
    out = []
    for soff, s in strs.items():
        if target_sub not in s: continue
        lo = soff & 0xffff          # works because 0x140000 (rodata base) and 0x10000 are 16-aligned
        for off in range(0xd000, 0x1d0000, 4):
            wv = w(off)
            if (wv >> 26) != 0x3f: continue
            rd = (wv >> 21) & 31; ra = (wv >> 16) & 31
            if rd != ra or (wv & 0xffff) != lo: continue
            # look back for movhi same rd with imm in {0x281 (rodata), 0x1 (low window)}
            ok = None
            for d in range(1, window+1):
                o = off - 4*d
                if o < 0: break
                w2 = w(o)
                if (w2 >> 26) == 0x30 and ((w2 >> 21) & 31) == rd:
                    imm = w2 & 0xffff
                    if imm == 0x281: ok = ('rodata', soff)
                    elif imm == 0x1: ok = ('low', (0x10000 | lo) - 0x10000)
                    break
            if ok:
                out.append((off, rd, ok[0], soff, s))
    return out

targets = sys.argv[1:] if len(sys.argv) > 1 else [
    'Invalid Spdif license', 'Invalid Hdmi license', 'spdif_type', 'arm->r2',
    'r2_spdifOutput_control', 'r2_outputSpdifFrame', 'Mstar_DTS_Hdmi_Packer',
    'ES SR:%d, SPDIF info', 'cdMode:%d, frameSize', 'Cap[dsp:%x,r2:%x]',
    'r2_decoder_select', 'DTS_VirtualX', 'lic[%d',
]
for t in targets:
    refs = find_refs(t)
    print("=== %r : %d refs ===" % (t, len(refs)))
    for off, rd, kind, soff, s in refs:
        print("  code 0x%06x  rd=r%d  [%s] str@0x%06x %r" % (off, rd, kind, soff, s[:64]))
