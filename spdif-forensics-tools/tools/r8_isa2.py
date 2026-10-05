#!/usr/bin/env python3
"""R8 step 2b: ISA analysis restricted to the CODE window (first 0xa000 bytes)."""
import struct, collections

P = r"C:\firmware_temp\spdif_audio_investigation\r8_out\mst_snd_r2_MS12V22.bin"
b = open(P, 'rb').read()
CODE = b[0:0xa000]
print("code window size = 0x%x" % len(CODE))

def hx(d, n, base=0):
    return '\n'.join("%08x  %-47s  |%s|" % (base+i, ' '.join('%02x'%c for c in d[i:i+16]),
          ''.join(chr(c) if 32<=c<127 else '.' for c in d[i:i+16])) for i in range(0, min(n,len(d)), 16))

print("\n--- bytes 0x000-0x060 ---"); print(hx(CODE, 0x60, 0))
print("\n--- bytes 0x0f0-0x180 (OR1K reset vector is at 0x100) ---"); print(hx(CODE[0xf0:0x180], 0x90, 0xf0))
print("\n--- bytes 0x9f80-0xa000 (end of code window) ---"); print(hx(CODE[0x9f80:], 0x80, 0x9f80))

n = len(CODE)//4
for en, name in (('>','BIG'), ('<','LITTLE')):
    ws = struct.unpack('%s%dI' % (en, n), CODE[:n*4])
    c = collections.Counter((w >> 26) & 0x3f for w in ws)
    print("\n--- %s-endian opcode histogram over code window (top 16) ---" % name)
    for op, k in c.most_common(16):
        print("   op=0x%02x (%3d) %6d %6.2f%%" % (op, op, k, 100.0*k/len(ws)))
    print("   l.nop(0x15000000)=%d  zero-words=%d" % (ws.count(0x15000000), ws.count(0)))
    cw = collections.Counter(ws)
    print("   top words: %s" % ", ".join("0x%08x x%d" % (w,k) for w,k in cw.most_common(8)))

# OR1K branch/jump sanity: op 0x00 = l.j (26-bit imm). Check target spread for BE.
ws = struct.unpack('>%dI' % n, CODE[:n*4])
js = [w for w in ws if (w >> 26) == 0x00]
print("\nBE op=0x00 (OR1K l.j) count=%d" % len(js))
if js:
    tgts = [((w & 0x03ffffff) << 2) for w in js[:2000]]
    print("   sample jump targets (<<2): min=0x%x max=0x%x" % (min(tgts), max(tgts)))
    print("   first 12: %s" % ", ".join("0x%x" % t for t in tgts[:12]))
jsal = [w for w in ws if (w >> 26) == 0x01]
print("BE op=0x01 (OR1K l.jal) count=%d" % len(jsal))
