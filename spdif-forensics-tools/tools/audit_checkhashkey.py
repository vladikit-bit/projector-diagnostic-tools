#!/usr/bin/env python3
"""Independent audit of MDrv_AUDIO_CheckHashkey.

Recovers, for every MDrv_AUTH_IPCheck(id) call:
  * the IPID (immediate loaded into r0 immediately before the call)
  * the conditional branch that dispatches on the return value
  * the full instruction window until the next IPCheck call

No prior report is trusted: everything is re-derived from the binary.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from forensic_dis import ArmFunc, attach
from relocs import Relocs
from capstone.arm import (ARM_OP_IMM, ARM_OP_REG, ARM_REG_R0, ARM_REG_R1,
                          ARM_REG_R2, ARM_REG_R3)

KO = sys.argv[1] if len(sys.argv) > 1 else 'kmods/utpa2k.ko'
CHK = 0x423494

e = ELF32(KO)
attach(e)
rl = Relocs(e)
f = ArmFunc(e, CHK, name='MDrv_AUDIO_CheckHashkey')
ins = f.insns


def imm_before(idx, reg, limit=12):
    for j in range(idx - 1, max(-1, idx - limit), -1):
        i = ins[j]
        if i.mnemonic in ('bl', 'blx') and reg in (ARM_REG_R0, ARM_REG_R1,
                                                   ARM_REG_R2, ARM_REG_R3):
            return None
        ops = i.operands
        if ops and ops[0].type == ARM_OP_REG and ops[0].reg == reg:
            if len(ops) == 2 and ops[1].type == ARM_OP_IMM:
                return (i.mnemonic, ops[1].imm)
            return None
    return None


sites = []
for n, i in enumerate(ins):
    if i.mnemonic not in ('bl', 'blx'):
        continue
    if rl.call_target(i.address) != 'MDrv_AUTH_IPCheck':
        continue
    sites.append((n, i.address, imm_before(n, ARM_REG_R0)))

verbose = '-v' in sys.argv
print(f";;; MDrv_AUDIO_CheckHashkey @ 0x{CHK:x}  size 0x{f.size:x}")
print(f";;; MDrv_AUTH_IPCheck call sites: {len(sites)}")
print()
print(f"{'#':>3} {'call@':<10} {'IPID':>7}  {'dispatch after call'}")
print('-' * 104)
for k, (n, a, ipid) in enumerate(sites):
    nx = ins[n + 1] if n + 1 < len(ins) else None
    nx2 = ins[n + 2] if n + 2 < len(ins) else None
    d = f"{nx.mnemonic} {nx.op_str}" if nx else ''
    if nx2 and nx2.mnemonic.startswith('b') and nx2.mnemonic not in ('bl', 'blx'):
        try:
            tgt = nx2.operands[0].imm
            d += f"  ;  {nx2.mnemonic} 0x{tgt:08x}"
        except Exception:
            pass
    ids = f"0x{ipid[1]:x}" if ipid else '??'
    print(f"{k:>3} 0x{a:08x}  {ids:>7}  {d}")

if verbose:
    print()
    print(";;; ---- full windows ----")
    for k, (n, a, ipid) in enumerate(sites):
        end = sites[k + 1][0] if k + 1 < len(sites) else len(ins)
        ids = f"0x{ipid[1]:x}" if ipid else '??'
        print(f"\n; === site {k}: IPID {ids}  call @0x{a:08x} ===")
        for j in range(n, min(end, n + 70)):
            i = ins[j]
            extra = ''
            if i.mnemonic in ('bl', 'blx'):
                t = rl.call_target(i.address)
                if t:
                    extra = f"   ; -> {t}"
            print(f"  0x{i.address:08x}: {i.mnemonic:<7} {i.op_str}{extra}")
