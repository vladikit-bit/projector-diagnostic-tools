#!/usr/bin/env python3
"""R6 harness: locate ioctl cmd xrefs + build caller index in a .ko (ARM).

Usage:
  r6_ioctl.py <module.ko> [const1,const2,...] [--syms "regex"]

Scans every SHF_EXECINSTR section once (ARM mode), collecting:
  * caller index: target_va -> [call_site_va]   (bl/blx)
  * constant xrefs: ldr-literal / movw-movt pairs matching any target constant

Then prints:
  * symbols matching --syms regex (function VAs)
  * constant xref sites with containing function name
  * callers of each --callers function (by name or va)
"""
import sys, re, struct
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN
sys.path.insert(0, 'tools')
from forensic_elf import ELF32
from forensic_dis import attach

PY = 'C:/Users/k0994/.workbuddy-ai/binaries/python/envs/default/Scripts/python.exe'

def main():
    path = sys.argv[1]
    consts = set()
    syms_pat = None
    callers_pat = None
    args = sys.argv[2:]
    i = 0
    while i < len(args):
        a = args[i]
        if a == '--syms':
            syms_pat = args[i+1]; i += 2
        elif a == '--callers':
            callers_pat = args[i+1]; i += 2
        else:
            consts.add(int(a, 0)); i += 1

    e = attach(ELF32(path))
    exec_secs = [s for s in e.secs if s['flags'] & 0x4 and s['size']]
    print(f";;; {path}")
    print(f";;; exec sections: " + ", ".join(f"{s['name']}(addr=0x{s['addr']:x},off=0x{s['off']:x},size=0x{s['size']:x})" for s in exec_secs))

    md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN)
    md.detail = True

    caller = {}          # target_va -> [site]
    const_hits = []      # (insn_va, mnemonic, op_str, const_val)
    # track movw per reg to reconstruct movw/movt pairs
    movw = {}
    sym_by_va = {}
    for s in e.syms:
        sym_by_va.setdefault(s['value'], s['name'])

    def func_of(va):
        # nearest symbol whose range contains va
        best = None
        for s in e.syms:
            if not s['name'] or s['shndx'] == 0:
                continue
            if s['value'] <= va < s['value'] + max(s['size'], 1):
                return s['name']
            if s['value'] <= va and (best is None or s['value'] > best[1]):
                best = (s['name'], s['value'])
        if best and va - best[1] < 0x2000:
            return f"{best[0]}+0x{va-best[1]:x}"
        return None

    for s in exec_secs:
        code = e.b[s['off']:s['off']+s['size']]
        base = s['addr']
        for ins in md.disasm(code, base):
            # caller index
            if ins.mnemonic in ('bl', 'blx'):
                for op in ins.operands:
                    if op.type == 2:  # IMM
                        caller.setdefault(op.imm & ~1, []).append(ins.address)
                        break
            # constant search
            if ins.mnemonic == 'movw':
                for op in ins.operands:
                    if op.type == 2:
                        movw[ins.operands[0].reg if ins.operands[0].type==1 else -1] = (ins.address, op.imm & 0xffff)
            elif ins.mnemonic == 'movt':
                for op in ins.operands:
                    if op.type == 2:
                        reg = ins.operands[0].reg if ins.operands[0].type==1 else -1
                        lo = movw.get(reg, (None, 0))[1]
                        val = (op.imm << 16) | lo
                        if val in consts:
                            const_hits.append((ins.address, ins.mnemonic, ins.op_str, val))
            elif ins.mnemonic == 'ldr' and ins.op_str.endswith('pc'):
                # ldr rd, [pc, #imm]
                m = re.search(r'#(-?0x[0-9a-fA-F]+|-?\d+)', ins.op_str)
                if m:
                    imm = int(m.group(1), 0)
                    tgt = (ins.address + 8) + imm
                    # read the word at tgt if within file
                    for sec in e.secs:
                        if sec['addr'] <= tgt < sec['addr'] + sec['size']:
                            off = sec['off'] + (tgt - sec['addr'])
                            if off + 4 <= len(e.b):
                                w = struct.unpack_from('<I', e.b, off)[0]
                                if w in consts:
                                    const_hits.append((ins.address, ins.mnemonic, ins.op_str, w))
                            break

    if syms_pat:
        print(f"\n=== symbols matching {syms_pat!r} ===")
        for s in e.find(syms_pat):
            print(f"  0x{s['value']:08x}  size=0x{s['size']:x}  {s['name']}")

    if consts:
        print(f"\n=== constant xrefs (search set: {[hex(c) for c in consts]}) ===")
        for va, mn, ops, val in sorted(const_hits):
            print(f"  0x{va:08x}: {mn} {ops}   => const 0x{val:x}  in {func_of(va)}")

    if callers_pat:
        print(f"\n=== callers of functions matching {callers_pat!r} ===")
        rx = re.compile(callers_pat)
        for s in e.syms:
            if s['name'] and rx.search(s['name']):
                sites = caller.get(s['value'], [])
                print(f"\n  {s['name']} @0x{s['value']:x}  ({len(sites)} direct callers):")
                for st in sites[:40]:
                    print(f"    0x{st:08x}  ({func_of(st)})")

if __name__ == '__main__':
    main()
