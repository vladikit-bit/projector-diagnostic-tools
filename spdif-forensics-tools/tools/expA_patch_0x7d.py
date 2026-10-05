"""
Experiment A: 0x4d0=4 / MS12V22 image switch via 0x7d fail-bypass only.

Single instruction modified:
  VA 0x424444 (file offset 0x431a98, .text)
  Original:  0x0a00002f  (ARM beq +0x5e -> 0x424508; IPID 0x7d fail-gate)
  Patched:   0xe320f000  (ARM canonical NOP)

Effect: forces IP 0x7d success path, so r6 (0x4d0 register) reaches the
value 4 that the success path assigns. This is a single-instruction
ARM NOP, file size preserved.

NOT a DTS license bypass. NOT an EDID/HDMI modification.
Other 42 AUTH_IPCheck calls in MDrv_AUDIO_CheckHashkey are NOT modified.

Reversible: original kmods/utpa2k.ko is NEVER overwritten.
Output: kmods/utpa2k_expA_0x4d0_eq4.ko (new unique name; previous
artifacts in kmods/ and attempt1/ are preserved untouched).
"""
import hashlib, os, struct, sys

KO = 'kmods/utpa2k.ko'
TEXT_BASE = 0xd654
VA = 0x424444
FO = TEXT_BASE + VA
ORIG = 0x0a00002f   # ARM beq +0x5e
NEW  = 0xe320f000   # ARM NOP

def main():
    blob = bytearray(open(KO, 'rb').read())

    # Sanity: signature probe
    sig_off = TEXT_BASE + 0x423494
    sig = struct.unpack_from('<I', blob, sig_off)[0]
    assert sig == 0xe92d47f0, f"signature mismatch at {sig_off:#x}: {sig:#x}"
    print(f"[OK] signature at CheckHashkey: {sig:#x} (ARM push {{r4-r10,lr}})")

    # Verify original 4B at the target
    cur = struct.unpack_from('<I', blob, FO)[0]
    assert cur == ORIG, f"unexpected original at file {FO:#x}: {cur:#010x} (expected {ORIG:#010x})"
    print(f"[OK] target VA {VA:#x} (file {FO:#x}): original word = {cur:#010x} (ARM beq +0x5e)")

    # Patch (only this byte range)
    struct.pack_into('<I', blob, FO, NEW)

    # Verify file size unchanged
    assert len(blob) == os.path.getsize(KO), "size changed!"
    print(f"[OK] file size preserved: {len(blob)} bytes")

    out = 'kmods/utpa2k_expA_0x4d0_eq4.ko'
    if os.path.exists(out):
        sys.exit(f"refusing to overwrite existing {out}")
    open(out, 'wb').write(blob)
    h_sha = hashlib.sha256(open(out, 'rb').read()).hexdigest()
    h_md5 = hashlib.md5(open(out, 'rb').read()).hexdigest()
    print(f"wrote {out}  size={len(blob)}  md5={h_md5}  sha256={h_sha}")

    # Show the diff at byte level
    orig = open(KO, 'rb').read()
    diffs = [(i, orig[i], blob[i]) for i in range(len(orig)) if orig[i] != blob[i]]
    print(f"\nbyte-level diff: {len(diffs)} byte(s) changed")
    for off, ob, nb in diffs:
        print(f"  file {off:#x}: {ob:02x} -> {nb:02x}   (VA {off-TEXT_BASE:#x})")

if __name__ == '__main__':
    main()
