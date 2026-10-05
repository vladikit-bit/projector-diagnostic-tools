#!/usr/bin/env python3
"""R5 Phase D items 11+12 — control-flow proof on the OUTPUT binary.

Locates the gate function containing VA 0x98a58, finds every write to r6/r5/r4
and every capability-bit test, and traces the paths that reach
MApi_AUDIO_SPDIF_SetMode.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from capstone import *
from capstone.arm import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase5/mik_r5_patched.ko'
PATCH_VA = 0x98a58
REGION = (0x98684, 0x9a7dc)

BR = ('b', 'bl', 'bx', 'blx', 'beq', 'bne', 'blo', 'bhi', 'bcs', 'bcc',
      'bge', 'blt', 'bgt', 'ble', 'bpl', 'bmi', 'bvs', 'bvc', 'bhs', 'bls')
COND = ('beq', 'bne', 'blo', 'bhi', 'bcs', 'bcc', 'bge', 'blt', 'bgt',
        'ble', 'bpl', 'bmi', 'bvs', 'bvc', 'bhs', 'bls')


def main():
    e = ELF32(PATH); r = Relocs(e)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True; md.skipdata = True
    va0, va1 = REGION
    insns = list(md.disasm(e.b[e.va2off(va0):e.va2off(va0) + (va1 - va0)], va0))
    byaddr = {i.address: i for i in insns}

    # ---- locate function start: nearest preceding "push {...lr}" -----------
    start = None
    for i in insns:
        if i.address >= PATCH_VA:
            break
        if i.mnemonic == 'push' and 'lr' in i.op_str:
            start = i.address
    print('gate function start (nearest push{..lr} before 0x%x): 0x%x' % (PATCH_VA, start))

    # nearest preceding symbol
    best = None
    try:
        for name, val in getattr(e, 'symbols', {}).items():
            if isinstance(val, (int, float)) and val <= PATCH_VA:
                if best is None or val > best[1]:
                    best = (name, val)
    except Exception:
        pass
    print('nearest symbol at or before 0x%x : %s' % (PATCH_VA, best))

    fn_end = None
    for i in insns:
        if start is not None and i.address > start and i.mnemonic.startswith('pop') \
           and 'pc' in i.op_str:
            fn_end = i.address
            break
    print('gate function end (pop{..pc})     : 0x%x' % fn_end)
    print()

    # ---- all capability tests and r4/r5/r6 writes inside the fn ------------
    print('=' * 92)
    print('CAPABILITY-BIT TESTS and r4/r5/r6 WRITES inside the gate function')
    print('=' * 92)
    BITS = {0x4: 'AC3', 0x80: 'DTS-core', 0x400: 'E-AC3', 0x800: 'DTS-HD',
            0x1000: 'MLP(TrueHD)'}
    reg_writes = []
    for i in insns:
        if start is not None and not (start <= i.address <= (fn_end or va1)):
            continue
        note = ''
        if i.mnemonic == 'tst':
            for op in i.operands:
                if op.type == ARM_OP_IMM and op.imm in BITS:
                    note = '   <<<< TEST  bit 0x%-4x = %s' % (op.imm, BITS[op.imm])
        elif i.mnemonic in ('mov', 'movw', 'movt'):
            s = i.op_str
            if s.startswith(('r4,', 'r5,', 'r6,')):
                note = '   <<<< WRITE %s' % s
                reg_writes.append((i.address, s))
        elif i.mnemonic.startswith('bl'):
            tgt = r.call_target(i.address)
            note = '   [-> %s]' % (tgt or '?')
        if note:
            print('  0x%08x: %-8s %-9s %-26s%s' %
                  (i.address, i.bytes.hex(), i.mnemonic, i.op_str, note))

    # ---- basic blocks ------------------------------------------------------
    print()
    print('=' * 92)
    print('BASIC BLOCKS reaching the patched instruction 0x%x (backward slice)' % PATCH_VA)
    print('=' * 92)
    # leaders
    leaders = set()
    for i in insns:
        if i.mnemonic in BR:
            for op in i.operands:
                if op.type == ARM_OP_IMM:
                    leaders.add(op.imm)
    # block containing PATCH_VA: walk back to nearest leader / branch
    lo = PATCH_VA
    for i in reversed(insns):
        if i.address >= PATCH_VA:
            continue
        if i.address in leaders or i.mnemonic.startswith('b'):
            lo = i.address + i.size
            break
    print('block containing 0x%x starts at 0x%x' % (PATCH_VA, lo))
    print('--- instructions from block start through the selector ---')
    for i in insns:
        if lo <= i.address <= 0x98c80:
            mark = '   <<<< PATCHED' if i.address == PATCH_VA else ''
            print('  0x%08x: %-8s %-9s %-30s%s' %
                  (i.address, i.bytes.hex(), i.mnemonic, i.op_str, mark))


main()
