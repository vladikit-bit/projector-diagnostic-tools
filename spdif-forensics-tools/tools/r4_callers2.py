#!/usr/bin/env python3
"""Bounded caller finder: scan only .text in [VA_LO, VA_HI]. Targets = named exports.
Usage: r4_callers2.py <lib.so> <va_lo> <va_hi> <symname> [symname ...]
"""
import sys
sys.path.insert(0, '.')
from elfx import ELF, func_starts, make_func_of
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
from capstone.arm import ARM_OP_IMM

f = sys.argv[1]
VA_LO, VA_HI = int(sys.argv[2], 16), int(sys.argv[3], 16)
E = ELF(f)
TX = E.SEC['.text']
want = set()
for name in sys.argv[4:]:
    for s in E.dynsyms():
        if s['name'] == name:
            want.add(s['value'] & ~1); break
    else:
        print(f"  (not found: {name})")
print(f"// targets={[hex(w) for w in want]}  scanVA 0x{VA_LO:06x}..0x{VA_HI:06x}")
starts = func_starts(E); fo = make_func_of(starts)
callers = {w: set() for w in want}
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True
base = TX['addr'] | 1
off0 = TX['off'] + (VA_LO - TX['addr'])
off1 = TX['off'] + (VA_HI - TX['addr'])
for ins in md.disasm(E.d[off0:off1], VA_LO | 1):
    if ins.mnemonic in ('bl', 'blx'):
        for op in ins.operands:
            if op.type == ARM_OP_IMM and (op.imm & ~1) in want:
                callers[op.imm & ~1].add(ins.address)
for w in want:
    print(f"\n=== callers of 0x{w:06x} ({len(callers[w])}) ===")
    for c in sorted(callers[w]):
        a, b, sym = fo(c)
        print(f"   @0x{c:06x}  in 0x{a:06x}..0x{b:06x}  ['{(sym or '')[:34]}']")
