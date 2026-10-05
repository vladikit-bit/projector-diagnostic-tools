#!/usr/bin/env python3
"""a3: controlled single-byte differential patch (verification-only, NO deploy).
Source : kmods/utpa2k_expB_0x4d8_3_dts_license.ko  (== deployed Exp-B, md5 4c5e6fbb...)
Change : file offset 0x45a840, byte 0x97 -> 0x04  (word 0x03001097 -> 0x03001004,
         'movweq r1,#0x97' -> 'movweq r1,#0x04' @ VA 0x44d1ec)
Output : kmods/utpa2k_expB_dts_cmd04.ko  (new unique file)
"""
import struct, hashlib, sys

SRC = 'kmods/utpa2k_expB_0x4d8_3_dts_license.ko'
DST = 'kmods/utpa2k_expB_dts_cmd04.ko'
OFF = 0x45a840
CTX_LO, CTX_HI = 0x45a830, 0x45a850
EXP_B_NOP_SITES = [0x4310d8, 0x431254, 0x431540, 0x431a98, 0x431d40]  # VA+0xd654 = file

def h(b): return hashlib.md5(b).hexdigest(), hashlib.sha256(b).hexdigest()

src = open(SRC, 'rb').read()
print("== SOURCE ==")
m5, s25 = h(src)
print("md5    =", m5)
print("sha256 =", s25)
print("size   =", len(src))

# --- pre-checks on source
assert src[OFF] == 0x97, "source byte @0x45a840 is 0x%02x, expected 0x97" % src[OFF]
w = struct.unpack_from('<I', src, OFF)[0]
assert w == 0x03001097, "source word @0x45a840 is 0x%08x, expected 0x03001097" % w
print("\nsource byte @0x45a840 = 0x97 ; word = 0x03001097  [OK]")

def ctxdump(b, label):
    print("\ncontext %s (0x%x..0x%x):" % (label, CTX_LO, CTX_HI))
    for o in range(CTX_LO, CTX_HI, 4):
        word = struct.unpack_from('<I', b, o)[0]
        mark = '   <-- PATCH BYTE' if o <= OFF < o+4 else ''
        print("  0x%06x: %08x   %s%s" % (o, word, ' '.join('%02x' % c for c in b[o:o+4]), mark))
ctxdump(src, "BEFORE")

# --- build patched image
out = bytearray(src)
out[OFF] = 0x04
out = bytes(out)

# --- full binary diff
diffs = [i for i in range(len(src)) if src[i] != out[i]]
print("\n== DIFF source -> output ==")
print("changed bytes: %d" % len(diffs))
for i in diffs:
    print("  offset 0x%06x: 0x%02x -> 0x%02x" % (i, src[i], out[i]))
assert len(diffs) == 1 and diffs[0] == OFF, "unexpected diff"

wo = struct.unpack_from('<I', out, OFF)[0]
assert wo == 0x03001004, "output word is 0x%08x, expected 0x03001004" % wo
print("output word @0x45a840 = 0x03001004  [OK]")

# --- Exp-B patch sites preserved (must be identical to source)
for site in EXP_B_NOP_SITES:
    ws = struct.unpack_from('<I', src, site)[0]
    wop = struct.unpack_from('<I', out, site)[0]
    assert ws == wop == 0xe320f000, "Exp-B NOP site 0x%x altered: 0x%08x/0x%08x" % (site, ws, wop)
print("all 5 Exp-B/Exp-A NOP sites (0x4310d8/0x431254/0x431540/0x431a98/0x431d40 = e320f000) preserved [OK]")

# --- size sanity
assert len(out) == len(src) == 25381336
print("size unchanged: %d bytes [OK]" % len(out))

# --- write output, then re-verify from disk
open(DST, 'wb').write(out)
chk = open(DST, 'rb').read()
m5o, s2o = h(chk)
print("\n== OUTPUT (re-read from disk) ==")
print("path   =", DST)
print("md5    =", m5o)
print("sha256 =", s2o)
print("size   =", len(chk))
assert chk == out
diffs2 = [i for i in range(len(src)) if src[i] != chk[i]]
assert diffs2 == [OFF]
print("re-read diff vs source: exactly 1 byte @0x45a840  [OK]")
ctxdump(chk, "AFTER")
print("\nALL CHECKS PASSED")
