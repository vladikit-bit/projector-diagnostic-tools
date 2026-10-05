"""
MS12V22 + DTS-X-license experimental patch for utpa2k.ko.
Reversible: original kmods/utpa2k.ko is NEVER overwritten; output is written
to a fresh file. Earlier invalid attempt1/ artifacts preserved.

Minimum-patch design (3 NOPs, 6 bytes total):

  ADDR    | ORIGINAL 2B (Thumb-2 beq) | PATCH 2B (Thumb-2 nop) | EFFECT
  --------|---------------------------|--------------------------|-----------------------------
  0x423eec | 0x0a00 (beq +0x1e -> 0x423f0e) | 0xbf00 (nop)            | Force IP 0x12 (DTS-HD) PASS-gate -> r8=2 (0x4d8=2)
  0x4246ec | 0x0a12 (beq +0x24 -> 0x424714) | 0xbf00 (nop)            | Force IP 7 (DTS:X) PASS-gate -> r8=3 (overrides r8=2 -> 0x4d8=3)
  0x424444 | 0x0a2f (beq +0x5e -> 0x4244a6) | 0xbf00 (nop)            | Force IP 0x7d (Dolby top) PASS-gate -> r6=4 (0x4d0=4, MS12V22 image)

Each original slot is a 2-byte Thumb-2 conditional branch (encoded as
0xD0xx for beq; the second byte is signed relative offset in 2-byte
units). Replacing it with `0xbf00` (Thumb-2 NOP) preserves file size,
preserves 2-byte Thumb alignment of subsequent instructions, and
eliminates the branch (always fall through to the post-IPCheck success
path).

This produces the exact state that would result if MDrv_AUTH_IPCheck
returned 1 for IDs 0x12, 7, and 0x7d. The 42 other AUTH_IPCheck calls
in MDrv_AUDIO_CheckHashkey are NOT modified.

Effects summary (after one CheckHashkey call):
  0x4d0 = 4           (was 0/2/3)
  0x4d4 = 8           (was 0/4/6/7/8/9)  - sub-tier for 0x7d PASS
  0x4d8 = 3           (was 0)             - DTS:X level
  0x43d = 1           (was 0/1)           - Dolby premium
  0x43e = 1           (was 0/1)
  0x440 bit 4 cleared (0x7d-pass clears 0x440 & ~0x10)
  0x444 = 0x003FFE80  (set by 0x7d pass: r2|0x280 & ~2 -> 0x280 & ~2 = 0x280; r2 was 0x00ffffff, so 0xffffff80)
  0x57e = 1, 0x57f = 1 (set by 0x7d pass)
  0x582 = unchanged
  0x440 DTS bits (0x8/0x80/0x20000) NOT cleared - those need separate
        0xf/0x3a patches. But the goal of THIS experiment is to
        test MS12V22 selection, so the absence of full DTS license
        is irrelevant: this experiment shows what changes if we
        force-load MS12V22 regardless of DTS license state.
"""
import hashlib, os, sys

KO = 'kmods/utpa2k.ko'

Patches = [
    (0x423eec, b'\x0a\x00', b'\xbf\x00', '0x12 (DTS-HD) PASS -> 0x4d8=2'),
    (0x4246ec, b'\x0a\x12', b'\xbf\x00', '7   (DTS:X)   PASS -> 0x4d8=3'),
    (0x424444, b'\x0a\x2f', b'\xbf\x00', '0x7d (Dolby top) PASS -> 0x4d0=4'),
]

# Section .text: sh_addr=0, sh_offset=0xd654 (verified by probe above).
TEXT_BASE = 0xd654
# Verify by re-encoding a known function symbol: MDrv_AUDIO_CheckHashkey @ 0x423494
# -> file 0xd654 + 0x423494 = 0x430ae8.
import struct
blob = open(KO, 'rb').read()
expect = struct.unpack_from('<I', blob, 0x430ae8)[0]
# That word should be the ARM push opcode: 0xe92d47f0 (push {r4-r10,lr})
assert expect == 0xe92d47f0, f"VA->file mapping broken: got {expect:#x} at 0x430ae8"
print(f"[OK] VA->file mapping verified: 0x423494 -> file 0x430ae8, first word {expect:#x}")

def main(out_path='kmods/utpa2k_ms12v22_patched.ko'):
    out = bytearray(blob)
    for va, orig, patch, desc in Patches:
        fo = TEXT_BASE + va
        cur = bytes(out[fo:fo+2])
        if cur != orig:
            print(f"!! {va:#x}: file has {cur.hex()}, expected {orig.hex()} ({desc})")
            sys.exit(1)
        out[fo:fo+2] = patch
        print(f"  patch {va:#x} (file {fo:#x}): {orig.hex()} -> {patch.hex()}  ({desc})")
    open(out_path, 'wb').write(out)
    h = hashlib.sha256(open(out_path, 'rb').read()).hexdigest()[:16]
    print(f"wrote {out_path}  size={len(out):#x}  sha256[0..16]={h}")
    # Sanity: size must equal original
    if len(out) != len(blob):
        print(f"!! SIZE CHANGED {len(out)} vs {len(blob)}")
        sys.exit(1)
    print(f"[OK] file size preserved ({len(out)} == {len(blob)})")

if __name__ == '__main__':
    out = sys.argv[1] if len(sys.argv) > 1 else 'kmods/utpa2k_ms12v22_patched.ko'
    main(out)
