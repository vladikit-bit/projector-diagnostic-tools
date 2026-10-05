#!/usr/bin/env python3
"""R4 helper: disassemble a HAL function by VA, annotating literals (rodata strings),
PC-delta names, and cross-references to MI_* / MI_AUDIO_* / MI_PCM_* symbols.

Usage: r4_func.py <HAL.so> <va_start> [va_end]
If va_end omitted, the function is auto-bounded via .ARM.exidx func_starts.
"""
import sys, struct, bisect
sys.path.insert(0, '.')
from elfx import ELF, func_starts, make_func_of
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
from capstone.arm import ARM_OP_IMM

HAL = sys.argv[1]
START = int(sys.argv[2], 16)
END = int(sys.argv[3], 16) if len(sys.argv) > 3 else None

E = ELF(HAL)
TX = E.SEC['.text']
starts = func_starts(E)
func_of = make_func_of(starts)
if END is None:
    a, b, sym = func_of(START)
    START, END = a, b
    print(f"// function 0x{START:06x}..0x{END:06x} (0x{END-START:x} bytes)"
          + (f"  [{sym}]" if sym else ""))
print(f"// HAL = {HAL}")

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
md.detail = True
md.skipdata = True

# preload dynsym names for X-ref annotation
symnames = {}
for s in E.dynsyms():
    symnames.setdefault(s['value'] & ~1, s['name'])

# collect PC-delta literal targets -> strings for annotation
ldrs, adds = [], []
for ins in md.disasm(E.d[TX['off']:TX['off'] + TX['size']], TX['addr'] | 1):
    t = ins.op_str.replace(' ', '')
    if ins.mnemonic == 'ldr' and '[pc,' in t and '#' in t:
        try:
            imm = int(t.split('#')[1].split(']')[0], 16)
        except Exception:
            continue
        ldrs.append((ins.address, t.split(',')[0], ((ins.address + 4) & ~3) + imm))
    elif ins.mnemonic == 'add' and t.endswith(',pc'):
        adds.append((ins.address, t.split(',')[0]))
from collections import defaultdict
L = defaultdict(list)
for a, r, lv in ldrs:
    L[r].append((a, lv))
for r in L:
    L[r].sort()

def lit_string(va):
    o = E.va2off(va)
    if o is None:
        return None
    end = E.d.find(b'\0', o)
    if end > o:
        s = E.d[o:end]
        if 0 < len(s) < 200 and s.isascii():
            return s.decode('latin1')
    return None

def resolve_pc_delta_add(A, R):
    for a, lv in L.get(R, []):
        if a <= A <= a + 64:
            o = E.va2off(lv)
            if o is None:
                continue
            W = struct.unpack_from('<I', E.d, o)[0]
            tgt = (W + (A + 4)) & 0xFFFFFFFF
            return tgt
    return None

for ins in md.disasm(E.d[TX['off'] + START - TX['addr']:TX['off'] + END - TX['addr']], START | 1):
    extra = ""
    # literal annotation
    if ins.mnemonic in ('ldr',) and '[pc' in ins.op_str:
        try:
            imm = int(ins.op_str.split('#')[1].split(']')[0], 16)
            lv = ((ins.address + 4) & ~3) + imm
            o = E.va2off(lv)
            if o is not None:
                W = struct.unpack_from('<I', E.d, o)[0]
                if 0x1000 < W < 0x60000:
                    s = lit_string(W)
                    if s:
                        extra = f"   ; @0x{W:06x} '{s}'"
                    else:
                        extra = f"   ; @0x{W:06x}"
                else:
                    sym = symnames.get(W)
                    if sym:
                        extra = f"   ; -> {sym}"
        except Exception:
            pass
    # bl/blx target annotation
    if ins.mnemonic in ('bl', 'blx'):
        for op in ins.operands:
            if op.type == ARM_OP_IMM:
                tgt = op.imm & 0xFFFFFFFF
                tn = symnames.get(tgt & ~1)
                if tn:
                    extra += f"   --> {tn}"
                else:
                    extra += f"   --> 0x{tgt & ~1:06x}"
    # detected 'add rX,pc' PC-delta name annotation
    if ins.mnemonic == 'add' and ins.op_str.endswith(',pc'):
        R = ins.op_str.split(',')[0]
        tgt = resolve_pc_delta_add(ins.address, R)
        if tgt is not None:
            s = lit_string(tgt)
            extra += f"   ; delta->0x{tgt:06x}" + (f" '{s}'" if s else "")
    print(f"0x{ins.address & ~1:06x}: {ins.mnemonic:9s} {ins.op_str}{extra}")
