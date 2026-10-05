#!/usr/bin/env python3
"""R8 step 2: determine DSP ISA/endianness. Test OpenRISC (OR1K/AEON) hypothesis."""
import struct, collections

P = r"C:\firmware_temp\spdif_audio_investigation\r8_out\mst_snd_r2_MS12V22.bin"
b = open(P, 'rb').read()
print("blob size=0x%x" % len(b))

# first non-zero
i = 0
while i < len(b) and b[i] == 0:
    i += 1
print("first non-zero byte at 0x%x (zero prefix = %d bytes)" % (i, i))

def hist(words, label, shift=26):
    c = collections.Counter((w >> shift) & 0x3f for w in words)
    tot = len(words)
    print("\n--- %s : top-6-bit opcode histogram (top 22 of %d) ---" % (label, tot))
    for op, n in c.most_common(22):
        print("   op=0x%02x (%3d)  %8d  %5.2f%%" % (op, op, n, 100.0*n/tot))

n = (len(b)//4)*4
be = struct.unpack('>%dI' % (n//4), b[:n])
le = struct.unpack('<%dI' % (n//4), b[:n])

hist(be, "BIG-endian words")
hist(le, "LITTLE-endian words")

# OR1K tell: l.nop == 0x15000000 (BE). Should be very common (delay slots).
for name, ws in (("BE", be), ("LE", le)):
    nop = ws.count(0x15000000)
    print("\n%s: count of 0x15000000 (OR1K l.nop) = %d  (%.3f%%)" % (name, nop, 100.0*nop/len(ws)))

# most common full words, both endians (delay-slot nops / common insns)
for name, ws in (("BE", be), ("LE", le)):
    c = collections.Counter(ws)
    print("\n%s: top 15 most common 32-bit words:" % name)
    for w, k in c.most_common(15):
        print("   0x%08x  x%d" % (w, k))
