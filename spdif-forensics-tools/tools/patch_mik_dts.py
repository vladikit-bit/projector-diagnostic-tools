#!/usr/bin/env python3
"""
patch_mik_dts.py — 1-byte patch in mik.ko _MI_AOUT_SetHdmiAutoMode (0x989cc, ARM).

DTS case (codecType 0x09/0x0a/0x0b/0x17), "EDID has no DTS bit" branch:
  0x98a54: mov r5, #1   (0xE3A05001)
  0x98a58: mov r6, #0   (0xE3A06000)  ->  mov r6, #1 (0xE3A06001)
r6=1 => downstream r4=2 (SPDIF bypass) regardless of HDMI-TX EDID DTS bit.

Byte change: file offset (sh_offset(.text)+0x98a58): 0x00 -> 0x01.
Usage: python patch_mik_dts.py <orig.ko> <out.ko>
"""
import struct, sys, hashlib
from elftools.elf.elffile import ELFFile

ADDR = 0x98a58
ORIG = 0xE3A06000   # mov r6, #0  (ARM)
NEW  = 0xE3A06001   # mov r6, #1  (ARM)

def main(src, dst):
    blob = bytearray(open(src, 'rb').read())
    elf = ELFFile(open(src, 'rb'))
    text = elf.get_section_by_name('.text')
    fo = text['sh_offset'] + ADDR
    w = struct.unpack_from('<I', blob, fo)[0]
    assert w == ORIG, f"{ADDR:#x}: found {w:08x}, expected {ORIG:08x}"
    struct.pack_into('<I', blob, fo, NEW)
    open(dst, 'wb').write(blob)
    orig = open(src,'rb').read()
    diff = [(i, a, b) for i,(a,b) in enumerate(zip(orig, blob)) if a != b]
    print(f"patched {ADDR:#x} (file {fo:#x}): {ORIG:08x} -> {NEW:08x}")
    print(f"byte diffs: {[(hex(i), hex(a), hex(b)) for i,a,b in diff]}")
    print("orig md5:", hashlib.md5(orig).hexdigest())
    print("out  md5:", hashlib.md5(blob).hexdigest())

main(sys.argv[1], sys.argv[2])
