#!/usr/bin/env python3
"""R6: scan a function, flag codec-id cmp/sub, DTS-state field access, and
calls into SDO/NonPCM/SetOutputType machinery. Prints to stdout.

Usage: r6_scanfunc.py <module.ko> <symbol> [extra_context] [size]
"""
import sys, re
sys.path.insert(0, 'tools')
from forensic_elf import ELF32
from forensic_dis import attach, ArmFunc

# DTS-relevant state field offsets (g_AudioVars2 / AOUT object) to watch
DTS_FIELDS = {0x440, 0x444, 0x4c4, 0x4c8, 0x4d0, 0x4d4, 0x4d8, 0x582, 0x4c0, 0x4cc}
# codec-id-ish immediates (AC3=5, DTS=9, EAC3=0xa, DTS-HD=0xb, TRUEHD=0xc, IEC=0xd)
CODEC_IMM = {5, 9, 0xa, 0xb, 0xc, 0xd, 0x80, 0x400, 0x800, 0x1000}

def main():
    path, name = sys.argv[1], sys.argv[2]
    ctx = int(sys.argv[3], 0) if len(sys.argv) > 3 else 0
    size = int(sys.argv[4], 0) if len(sys.argv) > 4 else None
    e = attach(ELF32(path))
    s = [x for x in e.syms if x['name'] == name]
    if not s:
        print("not found:", name); return
    s = s[0]
    va, sz = s['value'], s['size']
    if size: sz = size
    start = va - ctx if ctx else va
    f = ArmFunc(e, start, sz + ctx, name=name)
    print(f";;; SCAN {name} @0x{va:x} size 0x{sz:x}")
    for i in f.insns:
        a = i.address
        m = i.mnemonic
        op = i.op_str or ''
        flags = []
        # calls
        if m in ('bl', 'blx') and i.operands and i.operands[0].type == 2:
            t = i.operands[0].imm
            nm = e.nearest_sym(t)
            if nm and ('SDO' in nm or 'NonPCM' in nm or 'SetOutputType' in nm or
                       'SetMode' in nm or 'ApplySetting' in nm or 'DTSELoad' in nm or
                       'Transcode' in nm or 'PcmMode' in nm or 'Bypass' in nm or
                       'AutoMode' in nm or 'DigitalTx' in nm or 'DTS' in nm):
                flags.append(f'CALL→{nm}@{t:x}')
        # cmp/sub immediate = codec id
        for opx in i.operands:
            if opx.type == 2:  # IMM
                val = opx.imm
                if val in CODEC_IMM:
                    flags.append(f'CODEC_IMM#{val}')
        # ldr/str to DTS-state field offset
        if m in ('ldr', 'ldrb', 'str', 'strb', 'strh'):
            mo = re.search(r'\[r[0-9]+?,?\s*#?(-?0x[0-9a-fA-F]+|-?\d+)?\]', op)
            # match [rX, #imm] form
            mm = re.search(r'#(-?0x[0-9a-fA-F]+|-?\d+)', op)
            if mm:
                off = int(mm.group(1), 0)
                if off in DTS_FIELDS:
                    flags.append(f'DTSFIELD#{off:x}')
        if flags:
            print(f"0x{a:08x}: {m} {op}   <<< {' ; '.join(flags)}")

if __name__ == '__main__':
    main()
