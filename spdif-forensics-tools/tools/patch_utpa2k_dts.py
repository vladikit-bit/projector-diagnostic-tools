#!/usr/bin/env python3
"""
patch_utpa2k_dts.py — Solution A offline patcher for utpa2k.ko (MT5889/C50A)

Forces DTS-licensed host state inside MDrv_AUDIO_CheckHashkey @0x423494:
  - IPCheck(0xb) (DTS core)  : fail-branch NOP'd -> pass path (no maskA |= 1)
  - IPCheck(0xc) (DTS-HD)    : fail-branch NOP'd -> pass path (maskA &= ~1, 0x581 |= 1)
  - final stores 0x43e = 1, 0x43d = 1 (debug summary-log block skipped)
Dolby/MS12 state (0x4d0/0x4d4/0x4d8) untouched.

Usage: python patch_utpa2k_dts.py <orig.ko> <out.ko>
ET_REL: .text st_value == section-relative offset; file offset = sh_offset + addr.
"""
import struct, sys, hashlib
from elftools.elf.elffile import ELFFile

SITES = [
    # (addr,      original,   patched,   comment)
    (0x423514, 0x0a00000c, 0xe1a00000, "IPCheck(0xb): beq fail-branch -> nop (forced PASS)"),
    (0x423594, 0x0a000011, 0xe1a00000, "IPCheck(0xc): beq fail-branch -> nop (forced PASS, maskA &= ~1)"),
    (0x42487c, 0xe5c0743e, 0xe3a07001, "strb r7,[r0,#0x43e] -> mov r7,#1"),
    (0x424880, 0xe5c0a43d, 0xe5c0743e, "strb sl,[r0,#0x43d] -> strb r7,[r0,#0x43e]  (0x43e=1)"),
    (0x424884, 0x0a000007, 0xe3a0a001, "beq log -> mov sl,#1"),
    (0x424888, 0xe59004c8, 0xe5c0a43d, "ldr r0,[r0,#0x4c8] -> strb sl,[r0,#0x43d]  (0x43d=1)"),
    (0x42488c, 0xe3500003, 0xea000005, "cmp r0,#3 -> b 0x4248a8 (HAL_AUDIO_GET_INIT_FLAG)"),
]

def main(orig_path, out_path):
    blob = bytearray(open(orig_path, 'rb').read())
    elf = ELFFile(open(orig_path, 'rb'))
    text = elf.get_section_by_name('.text')
    sh_off, sh_size = text['sh_offset'], text['sh_size']
    assert text['sh_addr'] == 0

    # sanity: expected original whole-file hash
    md5o = hashlib.md5(blob).hexdigest()
    sha256o = hashlib.sha256(blob).hexdigest()
    print(f"ORIGINAL : md5={md5o} sha256={sha256o} size={len(blob)}")

    for addr, orig, new, _ in SITES:
        fo = sh_off + addr
        w = struct.unpack_from('<I', blob, fo)[0]
        assert w == orig, f"{addr:#x}: found {w:08x}, expected {orig:08x}"

    for addr, orig, new, comment in SITES:
        fo = sh_off + addr
        struct.pack_into('<I', blob, fo, new)
        print(f"patched {addr:#x} (file {fo:#x}): {orig:08x} -> {new:08x}   # {comment}")

    open(out_path, 'wb').write(blob)
    md5p = hashlib.md5(blob).hexdigest()
    sha256p = hashlib.sha256(blob).hexdigest()
    print(f"PATCHED  : md5={md5p} sha256={sha256p} size={len(blob)}")
    diff = sum(a != b for a, b in zip(open(orig_path,'rb').read(), blob))
    print(f"byte diff vs original: {diff} bytes (expect {4*len(SITES)})")

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
