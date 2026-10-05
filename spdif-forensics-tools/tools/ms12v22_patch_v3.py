"""
MS12V22 + DTS-X-license experimental patch for utpa2k.ko.
3 NOPs, 12 bytes total. Reversible: original kmods/utpa2k.ko is NEVER
overwritten. Earlier invalid artifacts in attempt1/ preserved.

VA->file mapping (verified):
  .text sh_addr=0, sh_offset=0xd654 -> file_offset = 0xd654 + VA
  .data sh_addr=0, sh_offset=0x6592a0
  CheckHashkey at 0x423494 -> file 0x430ae8 (first word 0xe92d47f0 = ARM push)

Three ARM-mode (4-byte) beq instructions targeted:

  ADDR    | ORIG (4B)        | TARGET (decoded)              | EFFECT of NOP
  --------|------------------|-------------------------------|-------------------------------
  0x423eec | 0x0a00000f       | beq +0x1c -> 0x423f30          | IP 0x12 (DTS-HD) -> 0x4d8=2
  0x4246ec | 0x0a000012       | beq +0x24 -> 0x42473c          | IP 7 (DTS:X)     -> 0x4d8=3
  0x424444 | 0x0a00002f       | beq +0x5e -> 0x424508          | IP 0x7d (Dolby)  -> 0x4d0=4

Each NOP replaces 4-byte ARM 'beq +offset' with ARM canonical NOP
0xe320f000. File size preserved (3*4 = 12 bytes total, same as original).
This forces the post-IPCheck success path: the 'fail' branch (which
prints errors and does NOT touch the tier registers) is skipped, so
the success-path registers (r5/r6/r7/r8/sl/0x440/0x444/0x57e/0x57f)
are written as if the IPASS returned 1.

State after a single CheckHashkey call (all other AUTH_IPCheck
results unchanged):
  0x4d0 = 4 (MS12V22 image)
  0x4d4 = 8 (sub-tier for 0x7d PASS)
  0x4d8 = 3 (DTS:X level)
  0x43d = 1 (Dolby premium)
  0x43e = 1
  0x440 bit4 cleared (0x7d-pass clears 0x440 & ~0x10)
  0x444 = 0x00ffffff | 0x280 & ~2 = 0xfffff80
  0x57e = 1, 0x57f = 1
  0x440 DTS bits (0x8/0x80/0x20000) NOT cleared - separate patches.
        This experiment does NOT enable DTS licensing; it tests only
        what changes when MS12V22 images are loaded.
"""
import hashlib, os, struct, sys

KO = 'kmods/utpa2k.ko'
TEXT_BASE = 0xd654   # sh_offset of .text section
ARM_NOP   = 0xe320f000

Patches = [
    (0x423eec, 0x0a00000f, 'IP 0x12 (DTS-HD) PASS -> 0x4d8=2'),
    (0x4246ec, 0x0a000012, 'IP 7 (DTS:X)     PASS -> 0x4d8=3'),
    (0x424444, 0x0a00002f, 'IP 0x7d (Dolby)  PASS -> 0x4d0=4'),
]

def main(out_path='kmods/utpa2k_ms12v22_patched.ko'):
    blob = bytearray(open(KO, 'rb').read())
    # Sanity probe: CheckHashkey at file offset 0xd654 + 0x423494 must be 0xe92d47f0
    sig_off = TEXT_BASE + 0x423494
    sig = struct.unpack_from('<I', blob, sig_off)[0]
    assert sig == 0xe92d47f0, f"signature mismatch at {sig_off:#x}: {sig:#x}"
    print(f"[OK] signature at CheckHashkey: {sig:#x} (ARM push {{r4-r10,lr}})")

    for va, exp, desc in Patches:
        fo = TEXT_BASE + va
        cur = struct.unpack_from('<I', blob, fo)[0]
        if cur != exp:
            print(f"!! VA {va:#x} (file {fo:#x}): file has {cur:#010x}, expected {exp:#010x} ({desc})")
            sys.exit(1)
        struct.pack_into('<I', blob, fo, ARM_NOP)
        print(f"  patch {va:#x} (file {fo:#x}): {cur:#010x} -> {ARM_NOP:#010x}  ({desc})")

    if len(blob) != os.path.getsize(KO):
        print(f"!! size mismatch after patch: {len(blob)} vs {os.path.getsize(KO)}")
        sys.exit(1)

    open(out_path, 'wb').write(blob)
    h = hashlib.sha256(open(out_path, 'rb').read()).hexdigest()[:16]
    print(f"wrote {out_path}  size={len(blob):#x}  sha256[0..16]={h}")

if __name__ == '__main__':
    out = sys.argv[1] if len(sys.argv) > 1 else 'kmods/utpa2k_ms12v22_patched.ko'
    main(out)
