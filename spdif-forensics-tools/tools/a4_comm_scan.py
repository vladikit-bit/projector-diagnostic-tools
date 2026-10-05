#!/usr/bin/env python3
"""a4: DEC-DSP comm/output state hunt — NEW evidence only.
1) String-ref rescan at 2-BYTE alignment (mixed-width ISA: refs may sit in either phase).
2) Jump/dispatch-table scan (pure data analysis): runs of words pointing into code windows.
Read-only."""
import struct, re
from collections import Counter

IMG = 'r8_out/mst_codec_r2_MS12V22.bin'
b = open(IMG, 'rb').read()
N = len(b)

def w(off): return struct.unpack_from('>I', b, off)[0]

strs = {}
for m in re.finditer(rb'[\x20-\x7e]{6,}', b[0x140000:0x149000]):
    strs[0x140000 + m.start()] = m.group().decode('latin1')

targets = {
    'Invalid Spdif license': 0x144904,
    'Invalid Hdmi license': 0x14482a,
    'spdif_type=': 0x14318e,
    'arm->r2 %d': 0x1427ce,
    'lic[%d,%d,%d]': 0x142892,
    'Mstar_DTS_Hdmi_Packer': 0x1469ee,
    'r2_outputSpdifFrame': 0x141166,
    'r2_spdifOutput_control': 0x14114f,
    'ES SR:%d, SPDIF info': 0x143c62,
    'cdMode:%d, frameSize': 0x143c04,
    'sel:%x,{->arm: Cap': 0x1439ee,
    'r2_decoder_select': None,
    'DTS_VirtualX_enable': 0x14437b,
    'Invalid Hdmi license:%d': 0x14482a,
}
# fill the one None
for soff, s in strs.items():
    if s.startswith('r2_decoder_select'):
        targets['r2_decoder_select'] = soff

print("=== 1. string-ref rescan at 2-BYTE alignment (imm16 == lo16 of target VA) ===")
for name, soff in targets.items():
    lo = soff & 0xffff
    hits = []
    for off in range(0, N - 4, 2):          # 2-aligned grid, covers both phases
        wv = w(off)
        if (wv & 0xffff) == lo:
            op, rd, ra = wv >> 26, (wv >> 21) & 31, (wv >> 16) & 31
            # plausible ref ops: ori-family/addi (0x3b/0x3f/0x32/0x11/0x13/0x02) with any rd/ra
            hits.append((off, op, rd, ra))
    # keep hits that look like instructions (op != 0x00..0x0f junk filter is wrong; report all, cluster by op)
    byop = Counter((h[1], h[3]) for h in hits)
    interesting = [(o, op, rd, ra) for o, op, rd, ra in hits if (op, ra) in [(0x3f, x) for x in range(32)] or op in (0x3b, 0x32, 0x11, 0x13)]
    print("%-26r lo=0x%04x: %d raw hits (%d instr-like); (op,ra) top: %s" % (
        name, lo, len(hits), len(interesting), byop.most_common(4)))
    for o, op, rd, ra in interesting[:6]:
        # validate: same-rd movhi 0x281 within +-48 words (2-aligned search)
        val = None
        for d in range(-96, 97, 2):
            o2 = o + 4 * d
            if 0 <= o2 < N - 4:
                w2 = w(o2)
                if (w2 >> 26) == 0x30 and ((w2 >> 21) & 31) == rd and (w2 & 0xffff) == 0x281:
                    val = d
                    break
        if val is not None:
            print("    VALIDATED ref: site 0x%06x op=0x%02x rd=%d ra=%d (movhi 0x281 at %+d words)" % (o, op, rd, ra, val))

print("\n=== 2. jump/dispatch table scan (runs of words pointing into code windows) ===")
def in_code(v):
    return 0x10000 <= v < 0x150000 or 0x02810000 <= v < 0x02900000
runs = []
run = []
for off in range(0, N - 4, 4):
    v = w(off)
    if in_code(v):
        run.append((off, v))
    else:
        if len(run) >= 5:
            runs.append(run)
        run = []
if len(run) >= 5:
    runs.append(run)
print("runs of >=5 consecutive code-window words: %d" % len(runs))
for r in runs[:20]:
    lo_f = r[0][0]
    print("  @0x%06x len=%d : 0x%08x .. 0x%08x" % (lo_f, len(r), r[0][1], r[-1][1]))
    for off, v in r[:14]:
        print("      0x%06x -> 0x%08x" % (off, v))
