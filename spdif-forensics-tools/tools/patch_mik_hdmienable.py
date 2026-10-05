#!/usr/bin/env python3
"""
Patch _bHdmiInfoEnable check in _MI_AOUT_MonitorTask (mik.ko).

Function: _MI_AOUT_MonitorTask @ 0x971a8
Location: 0x97840
Original: bne #0x97c54  (opcode 0x1a000103)
Patch: NOP (0xE1A00000) - makes the check always pass
"""
import struct, sys, hashlib
from elftools.elf.elffile import ELFFile

SITES = [
    (0x97840, 0x1A000103, 0xE1A00000, "bne #0x97c54 -> nop (skip _bHdmiInfoEnable check)"),
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
    print("patched md5:", hashlib.md5(blob).hexdigest())
    orig = open(src,'rb').read()
    diff = [(i, a, b) for i,(a,b) in enumerate(zip(open(src,'rb').read(), blob)) if a!=b]
    print(f"byte diff: {len(diff)} bytes")
    for i,a,b in diff[:10]:
        print(f"  {i:#x}: {a:02x} -> {b:02x}")

if __name__ == '__main__':
    import sys, hashlib
    main(sys.argv[1], sys.argv[2])
