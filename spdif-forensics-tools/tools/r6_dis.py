#!/usr/bin/env python3
"""R6: disassemble a named function from a .ko (ARM) and write to r6_out/<name>.asm

Usage: r6_dis.py <module.ko> <symbol> [size] [extra_context_bytes]
"""
import sys, os
sys.path.insert(0, 'tools')
from forensic_elf import ELF32
from forensic_dis import attach, ArmFunc

def main():
    path, name = sys.argv[1], sys.argv[2]
    size = int(sys.argv[3], 0) if len(sys.argv) > 3 else None
    ctx = int(sys.argv[4], 0) if len(sys.argv) > 4 else 0
    e = attach(ELF32(path))
    syms = [s for s in e.syms if s['name'] == name]
    if not syms:
        print("symbol not found:", name)
        # try regex
        for s in e.find(name):
            print("  candidate:", hex(s['value']), s['name'])
        return
    s = syms[0]
    va, sz = s['value'], s['size']
    if size:
        sz = size
    # optional pre-context
    start = va - ctx if ctx else va
    f = ArmFunc(e, start, sz + ctx, name=name)
    os.makedirs('r6_out', exist_ok=True)
    out = f'r6_out/{name}.asm'
    with open(out, 'w') as fp:
        f.dump(out=fp)
    print(f"wrote {out}  ({len(f.insns)} insns, va=0x{va:x}, size=0x{sz:x})")

if __name__ == '__main__':
    main()
