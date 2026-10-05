#!/usr/bin/env python3
"""v2: v1 (7 sites) + force-pass DTS-suite IPCheck(9)/(10)/(0x7d) in CheckHashkey.
Adds maskB DTS bits + level fields exactly as a licensed DTS device computes."""
import struct, sys, hashlib
from elftools.elf.elffile import ELFFile
SITES = [
    (0x423514, 0x0a00000c, 0xe1a00000, "IPCheck(0xb): beq fail -> nop"),
    (0x423594, 0x0a000011, 0xe1a00000, "IPCheck(0xc): beq fail -> nop"),
    (0x4242f4, 0x0a000016, 0xe1a00000, "IPCheck(9):   beq fail -> nop (maskB clear 0x200, lvl=4, 0x43d=1)"),
    (0x424390, 0x0a00001d, 0xe1a00000, "IPCheck(0xa):  beq fail -> nop (maskB|0x280&~2, lvl=4, 0x43e=1)"),
    (0x424444, 0x0a00002f, 0xe1a00000, "IPCheck(0x7d): beq fail -> nop (maskB|0x280&~2, 0x43d=1)"),
    (0x42487c, 0xe5c0743e, 0xe3a07001, "mov r7,#1"),
    (0x424880, 0xe5c0a43d, 0xe5c0743e, "strb r7,[r0,#0x43e]"),
    (0x424884, 0x0a000007, 0xe3a0a001, "mov sl,#1"),
    (0x424888, 0xe59004c8, 0xe5c0a43d, "strb sl,[r0,#0x43d]"),
    (0x42488c, 0xe3500003, 0xea000005, "b 0x4248a8"),
]
def main(src, dst):
    blob=bytearray(open(src,'rb').read())
    elf=ELFFile(open(src,'rb')); sh=elf.get_section_by_name('.text')['sh_offset']
    for a,o,n,_ in SITES:
        w=struct.unpack_from('<I',blob,sh+a)[0]
        assert w==o, f"{a:#x}: {w:08x}!={o:08x}"
    for a,o,n,_ in SITES: struct.pack_into('<I',blob,sh+a,n)
    open(dst,'wb').write(blob)
    print("v2 md5:", hashlib.md5(blob).hexdigest())
    orig=open(src,'rb').read()
    d=sum(1 for x,y in zip(orig,blob) if x!=y)
    print(f"byte diff: {d} (expect 40)")
main(sys.argv[1], sys.argv[2])
