#!/usr/bin/env python3
"""R5 Phase D item 12 — forward path trace from the patched block to SetMode.

Enumerates every acyclic path from the block containing 0x98a58 to the block
containing the MApi_AUDIO_SPDIF_SetMode call (0x98ddc), and reports whether r6
is re-written anywhere along the way (i.e. whether the patched value survives).
Also reports, for each other codec's r6-write site, whether it can be reached
from the patched block  => if not, that codec's path is provably disjoint.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from capstone import *
from capstone.arm import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase5/mik_r5_patched.ko'
FN_START, FN_END = 0x989cc, 0x98f80
PATCH_VA   = 0x98a58
SETMODE_VA = 0x98ddc

UNCOND = ('b', 'bl', 'bx', 'blx')
CONDS  = ('beq','bne','blo','bhi','bcs','bcc','bge','blt','bgt','ble',
          'bpl','bmi','bvs','bvc','bhs','bls')

CODEC_R6 = {
    0x98aa4: ('AC3|E-AC3|MLP present (tst 0x1404)', 1),
    0x98b2c: ('DTS-HD (r5=0xb)', 3),
    0x98b50: ('E-AC3 (r5=0xa)', 3),
    0x98ba0: ('fallback (r5=1)', 0),
    0x98bcc: ('MLP/TrueHD (r5=2)', 1),
    0x98c08: ('DTS-core PRESENT (r5=7)', 1),
    0x98c84: ('no-caps default (r5=1)', 0),
    0x98cb0: ('MLP (r5=0xc)', 3),
    0x98d10: ('AC3 (r5=1)', 0),
    0x98d28: ('AC3 (r5=1)', 0),
    0x98d54: ('AC3 (r5=2)', 1),
    0x98e98: ('DTS-HD (r5=0xb)', 3),
}


def main():
    e = ELF32(PATH); r = Relocs(e)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True; md.skipdata = True
    off = e.va2off(FN_START)
    insns = list(md.disasm(e.b[off:off + (FN_END - FN_START)], FN_START))
    byaddr = {i.address: i for i in insns}

    def tgts(i):
        return [op.imm for op in i.operands if op.type == ARM_OP_IMM] \
            if (i.mnemonic in UNCOND or i.mnemonic in CONDS) else []

    leaders = {insns[0].address}
    for i in insns:
        if i.mnemonic in CONDS or i.mnemonic in UNCOND:
            leaders.add(i.address + i.size)
            for t in tgts(i):
                if FN_START <= t < FN_END:
                    leaders.add(t)
    blks, cur = {}, None
    for i in insns:
        if i.address in leaders:
            cur = i.address; blks[cur] = []
        blks[cur].append(i)

    def blk_of(va):
        for s, b in blks.items():
            if b[0].address <= va < b[-1].address + b[-1].size:
                return s
        return None

    def succs(s):
        """[(next_block_va, edge_label, branch_insn_or_None)]
        CORRECT control-flow model:
          - conditional branch : fall-through + target
          - 'b'  (uncond jump) : target only
          - 'bl'/'blx' (CALL)  : FALL-THROUGH ONLY (the call returns)
          - 'pop{..pc}'/bx lr  : no successor (return)
          - anything else      : fall-through
        """
        b = blks[s]; l = b[-1]; out = []
        fall = l.address + l.size
        if l.mnemonic.startswith('pop') and 'pc' in l.op_str:
            return []                                   # function return
        if l.mnemonic == 'bx':
            return []                                   # indirect return tail
        if l.mnemonic in CONDS:
            out.append((fall, 'cond NOT taken', l))
            for t in tgts(l):
                out.append((t, 'cond TAKEN', l))
        elif l.mnemonic == 'b':
            for t in tgts(l):
                out.append((t, 'uncond', l))
        elif l.mnemonic in ('bl', 'blx'):
            out.append((fall, 'after call', l))         # call returns
        else:
            out.append((fall, 'fallthrough', None))
        return [(t, lab, br) for (t, lab, br) in out if t in blks]

    start, goal = blk_of(PATCH_VA), blk_of(SETMODE_VA)
    print('patched block  : 0x%x' % start)
    print('SetMode block  : 0x%x' % goal)
    print()

    # ---- enumerate acyclic paths ------------------------------------------
    paths, dead = [], []
    def dfs(s, seen, hist):
        if s == goal:
            paths.append(list(hist)); return
        if s in seen:
            return
        for (t, lab, br) in succs(s):
            if t == goal:
                paths.append(hist + [(t, lab, br)]); continue
            if t in seen:
                continue
            dfs(t, seen | {s}, hist + [(t, lab, br)])

    # walk forward from the patched block (skip the patch insn itself)
    for (t, lab, br) in succs(start):
        dfs(t, {start}, [(t, lab, br)])

    print('=' * 94)
    print('FORWARD PATHS  0x%x -> MApi_AUDIO_SPDIF_SetMode' % PATCH_VA)
    print('=' * 94)
    print('acyclic paths found: %d' % len(paths))
    r6safe = 0
    for n, p in enumerate(paths, 1):
        vas = [start] + [step[0] for step in p]
        overwrites = []
        for s in vas:
            for i in blks[s]:
                if i.address <= PATCH_VA:
                    continue
                if i.mnemonic in ('mov', 'movw') and i.op_str.startswith('r6,'):
                    overwrites.append((i.address, i.op_str))
                if i.mnemonic.startswith('bl') and i.address != SETMODE_VA:
                    pass
                if i.mnemonic == 'pop':
                    overwrites.append((i.address, 'RETURN'))
        survives = not overwrites
        r6safe += survives
        print('\n  path %d: %s' % (n, ' -> '.join('0x%x' % v for v in vas)))
        if overwrites:
            for va, s in overwrites:
                print('      r6 RE-WRITTEN at 0x%08x : %s' % (va, s))
            print('      => patched r6 does NOT survive on this path')
        else:
            print('      r6 = 1 SURVIVES (no further r6 write) -> reaches selector')

    print()
    print('  paths where patched r6=1 survives to the selector: %d / %d'
          % (r6safe, len(paths)))

    # ---- reachability of other codec r6 sites from the patched block ------
    print()
    print('=' * 94)
    print('DISJOINTNESS: can the patched block reach any OTHER codec r6-write site?')
    print('=' * 94)
    reach = set()
    def walk(s, seen):
        if s in seen:
            return
        reach.add(s)
        for (t, lab, br) in succs(s):
            walk(t, seen | {s})
    walk(start, set())

    print('%-10s %-38s %-12s %s' % ('VA', 'codec path', 'r6 value', 'reachable from patched blk?'))
    print('-' * 94)
    for va in sorted(CODEC_R6):
        desc, val = CODEC_R6[va]
        b = blk_of(va)
        yes = b in reach
        print('0x%08x  %-38s r6=%-9d  %s' % (va, desc, val, 'YES' if yes else 'NO  (disjoint)'))
    print()
    print('NOTE: sites marked NO are on paths that branch away BEFORE 0x98a58 is')
    print('      reached; they cannot be affected by the single changed byte.')


main()
