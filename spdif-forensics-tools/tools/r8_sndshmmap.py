#!/usr/bin/env python3
"""R8: fully enumerate HAL_SND_R2_Set_SHM_PARAM's param -> SND SHM offset map
    by resolving the ARM jump table and scanning each handler for str/ldr immediates."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN
import importlib.util
spec = importlib.util.spec_from_file_location('r6_reloc', os.path.join(os.path.dirname(os.path.abspath(__file__)),'r6_reloc.py'))
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)

KO   = sys.argv[1] if len(sys.argv)>1 else 'kmods/utpa2k_expB_0x4d8_3_dts_license.ko'
TBL  = 0x459e70
BASE = 0x59
N    = 0x76 + 1

e = ELF32(KO)
er = m.ELF32R(KO)
reloc = {}
for (rn,ro),(symidx,rtype,rs) in er.reloc.items():
    sym = er.syms[symidx] if symidx < len(er.syms) else None
    reloc[ro] = (sym['name'] if sym else None, rtype, sym['value'] if sym else 0, rs)

md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN); md.detail=True; md.skipdata=True

def rd(va, n): return e.read_va(va, n)

print("SND SHM param map  (jump table @0x%08x, params 0x%02x..0x%02x)" % (TBL, BASE, BASE+N-1))
print("%-8s %-10s %s" % ("param","handler","SHM access (ldr/str with [r6|rX,#imm])"))
rows=[]
for i in range(N):
    ent = TBL + i*4
    raw = struct.unpack('<I', rd(ent,4))[0]
    tgt = raw
    if ent in reloc:
        sn,rt,sv,rs = reloc[ent]
        tgt = (raw + sv) & 0xffffffff
    accs=[]
    code = rd(tgt, 0x120)
    for ins in md.disasm(code, tgt):
        if ins.mnemonic in ('b','bl','bx','pop','push','it'):
            if ins.mnemonic in ('pop','b'): pass
        if '[' in ins.op_str and '#' in ins.op_str and ins.mnemonic in (
                'str','strb','strh','ldr','ldrb','ldrh','ldrsh','ldrsw','ldrsb','ldrd','strd'):
            accs.append("%s %s" % (ins.mnemonic, ins.op_str))
        if ins.mnemonic in ('pop','b','bx') and len(accs)>0 and ins.mnemonic=='pop':
            break
    rows.append((BASE+i, tgt, accs))

for p,t,a in rows:
    print("0x%02x    0x%08x  %s" % (p, t, ' | '.join(a[:6]) if a else '(no immediate mem access in 0x120)'))
