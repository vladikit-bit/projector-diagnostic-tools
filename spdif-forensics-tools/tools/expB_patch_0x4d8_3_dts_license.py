"""
Experiment B: keep Experiment A active + add 4 DTS-AUTH fail-branch NOPs.

Base file: kmods/utpa2k_expA_0x4d0_eq4.ko (md5 939cac247eff097f212fef872131df5c)
            which already has the 0x7d NOP at VA 0x424444 (Experiment A).

Four additional ARM BEQs are NOPped to force the success paths for the
DTS-specific AUTH_IPCheck IDs:

  VA        file_off    original           patched
  0x423a84  0x4310d8    0x0a00000d (beq)   0xe320f000 (NOP)   IPID 0x0f  (DTS core)
  0x423c00  0x431254    0x0a00000c (beq)   0xe320f000 (NOP)   IPID 0x3a  (DTS family)
  0x423eec  0x431540    0x0a00000f (beq)   0xe320f000 (NOP)   IPID 0x12  (DTS-HD)
  0x4246ec  0x431d40    0x0a000012 (beq)   0xe320f000 (NOP)   IPID 0x07  (DTS:X)

NOTE: 0x423eec and 0x4246ec WERE planned for the earlier "MS12V22
       3-NOP v3 patch" but the v3 patch was not actually applied on
       device; only the single NOP at 0x424444 was. So the
       "Experiment A" file is the real on-disk baseline and both
       0x423eec and 0x4246ec still contain their original beq
       instructions (verified above). This patch fixes them now.

Resulting state after CheckHashkey runs:
  0x4d0 = 4  (MS12V22, from 0x7d NOP)
  0x4d4 = 8  (sub-tier for 0x7d PASS)
  0x4d8 = 3  (DTS:X level, last-writer from IP 7 PASS)
  0x43d = 1  (Dolby premium, 0x7d PASS)
  0x43e = 1
  0x440 :  all DTS-missing bits cleared (0x8/0x80/0x20000)
          0x440 |= 0x10 (0x7d PASS also writes 0x10) and 0x440 &~ 0x10
          (0x7d PASS bic). Net 0x440 bit 4 toggle.
  0x444 :  Dolby premium bits written
  0x57e/0x57f = 1
  0x582 = 1  (IP 7 PASS)

File size preserved (5 * 4 = 20 bytes of NOPs).

Source: kmods/utpa2k_expA_0x4d0_eq4.ko
Output: kmods/utpa2k_expB_0x4d8_3_dts_license.ko
"""
import hashlib, os, struct, sys

BASE = 'kmods/utpa2k_expA_0x4d0_eq4.ko'
OUT  = 'kmods/utpa2k_expB_0x4d8_3_dts_license.ko'
TEXT_BASE = 0xd654
ARM_NOP   = 0xe320f000

# These 4 patches: (VA, expected original 4B word, IPID, semantic)
Patches = [
    (0x423a84, 0x0a00000d, '0x0f  (DTS core) -> clears 0x440 bit 3; not on r8'),
    (0x423c00, 0x0a00000c, '0x3a  (DTS fam)  -> clears 0x440 bit 7'),
    (0x423eec, 0x0a00000f, '0x12  (DTS-HD)  -> r5=9, r6=3, sl=1; r8=2 (will be overridden by IP 7)'),
    (0x4246ec, 0x0a000012, '0x07  (DTS:X)   -> r8=3, r6=4, sl=1; 0x582=1'),
]

def main():
    blob = bytearray(open(BASE, 'rb').read())

    # Sanity: signature probe (MDrv_AUDIO_CheckHashkey @ VA 0x423494)
    sig_off = TEXT_BASE + 0x423494
    sig = struct.unpack_from('<I', blob, sig_off)[0]
    assert sig == 0xe92d47f0, f"signature mismatch at {sig_off:#x}: {sig:#x}"
    print(f"[OK] signature at CheckHashkey: {sig:#x} (ARM push)")

    # Sanity: Experiment A's 0x7d NOP is still there
    expA_off = TEXT_BASE + 0x424444
    expA_word = struct.unpack_from('<I', blob, expA_off)[0]
    assert expA_word == ARM_NOP, f"Experiment A NOP missing at {expA_off:#x}: {expA_word:#x}"
    print(f"[OK] Experiment A NOP at 0x424444 (file {expA_off:#x}): {expA_word:#x}")

    # Apply the four new NOPs
    for va, exp, desc in Patches:
        fo = TEXT_BASE + va
        cur = struct.unpack_from('<I', blob, fo)[0]
        if cur != exp:
            print(f"!! VA {va:#x} (file {fo:#x}): file has {cur:#010x}, expected {exp:#010x} ({desc})")
            sys.exit(1)
        struct.pack_into('<I', blob, fo, ARM_NOP)
        print(f"  patch {va:#x} (file {fo:#x}): {cur:#010x} -> {ARM_NOP:#010x}  ({desc})")

    # Verify file size unchanged
    assert len(blob) == os.path.getsize(BASE), f"size changed: {len(blob)} vs {os.path.getsize(BASE)}"
    print(f"[OK] file size preserved: {len(blob)} bytes")

    # Refuse to overwrite existing
    if os.path.exists(OUT):
        sys.exit(f"refusing to overwrite existing {OUT}")
    open(OUT, 'wb').write(blob)
    h_sha = hashlib.sha256(open(OUT, 'rb').read()).hexdigest()
    h_md5 = hashlib.md5(open(OUT, 'rb').read()).hexdigest()
    print(f"wrote {OUT}  size={len(blob)}  md5={h_md5}  sha256={h_sha}")

    # Show byte-level diff against BASE
    orig = open(BASE, 'rb').read()
    diffs = [(i, orig[i], blob[i]) for i in range(len(orig)) if orig[i] != blob[i]]
    print(f"\nbyte-level diff vs {BASE}: {len(diffs)} byte(s) changed")
    # group by 4-byte slot
    slot = None
    for off, ob, nb in diffs:
        if slot is None or off != slot[0] + 4:
            slot = (off, bytes([ob] * 4 if off + 4 <= len(blob) else b''))
        print(f"  file {off:#x}: {ob:02x} -> {nb:02x}")
    # Sanity: 4 NEW NOPs (each 4 bytes) = 16 bytes; the 0x7d NOP from Exp A
    # is already in BASE and is therefore NOT counted as a diff.
    assert len(diffs) == 16, f"expected 16 byte diffs (4 new NOPs), got {len(diffs)}"
    print(f"[OK] total NEW diffs = 16 bytes (4 new NOPs); 5th NOP (0x7d) was already in BASE")

if __name__ == '__main__':
    main()
