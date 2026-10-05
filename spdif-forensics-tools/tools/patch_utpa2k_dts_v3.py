#!/usr/bin/env python3
"""
v3: v2 + fix GetAudioInfo2 DTS SHM_INFO(0x36) failure by making r7==0 handler unconditional.

Changes in HAL_MAD_GetAudioInfo2 (utpa2k.ko):
  0x45ea04: 03A00000 -> E3A00000  (moveq r0,#0 -> mov r0,#0)
  0x45ea08: 05890000 -> E5890000  (streq r0,[sb] -> str r0,[sb])

This makes the DTS SHM_INFO(0x36) success path unconditional for any r7 value.
"""
import struct, sys, hashlib
from elftools.elf.elffile import ELFFile

SITES = [
    # v1: 7 sites
    (0x423514, 0x0a00000c, 0xe1a00000, "IPCheck(0xb): beq fail -> nop"),
    (0x423594, 0x0a000011, 0xe1a00000, "IPCheck(0xc): beq fail -> nop"),
    (0x4242f4, 0x0a000016, 0xe1a00000, "IPCheck(9): beq fail -> nop"),
    (0x424390, 0x0a00001d, 0xe1a00000, "IPCheck(0xa): beq fail -> nop"),
    (0x424444, 0x0a00002f, 0xe1a00000, "IPCheck(0x7d): beq fail -> nop"),
    (0x42487c, 0xe5c0743e, 0xe3a07001, "mov r7,#1"),
    (0x424880, 0xe5c0a43d, 0xe5c0743e, "strb r7,[r0,#0x43e]"),
    (0x424884, 0x0a000007, 0xe3a0a001, "mov sl,#1"),
    (0x424888, 0xe59004c8, 0xe5c0a43d, "strb sl,[r0,#0x43d]"),
    (0x42488c, 0xe3500003, 0xea000005, "b 0x4248a8"),
    # v3: 2 sites for DTS SHM_INFO fix
    (0x45ea04, 0x03a00000, 0xe3a00000, "moveq->mov: unconditional r0=0 for DTS SHM"),
    (0x45ea08, 0x05890000, 0xe5890000, "streq->str: unconditional store for DTS SHM"),
]

def main(src, dst):
    blob = bytearray(open(src, 'rb').read())
    elf = ELFFile(open(src, 'rb'))
    text = elf.get_section_by_name('.text')
    sh = text['sh_offset']
    for a, o, n, _ in SITES:
        w = struct.unpack_from('<I', blob, sh + a)[0]
        assert w == o, f"{a:#x}: found {w:08x}, expected {o:08x}"
    for a, o, n, _ in SITES:
        struct.pack_into('<I', blob, sh + a, n)
    open(dst, 'wb').write(blob)
    print("v3 md5:", hashlib.md5(blob).hexdigest())
    orig = open(src, 'rb').read()
    d = [(i, a, b) for i, (a, b) in enumerate(zip(orig, blob)) if a != b]
    print(f"byte diff: {len(d)} bytes")
    for i, a, b in d[:20]:
        print(f"  {i:#x}: {a:02x} -> {b:02x}")

if __name__ == '__main__':
    import sys, hashlib
    main(sys.argv[1], sys.argv[2])
