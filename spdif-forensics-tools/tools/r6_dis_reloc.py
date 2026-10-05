#!/usr/bin/env python3
"""R6: relocation-aware ARM disassembly.

Disassembles a function and annotates each instruction whose VA has a
relocation entry: branch targets -> callee symbol; MOVW/MOVT -> loaded symbol.
Also flags cmp/sub against codec-id immediates (3/5/9/0xa/0xb/0xc/0xd).

Usage: r6_dis_reloc.py <module.ko> <symbol> [size]
"""
import sys
sys.path.insert(0,'tools')
from forensic_elf import ELF32
from forensic_dis import attach, ArmFunc
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN
from capstone.arm_const import ARM_GRP_JUMP, ARM_GRP_CALL

RELOC_SYM = {}  # va -> (symname, rtype)

def load_relocs(e, reloc_sym):
    # reuse r6_reloc's ELF32R relocation scan
    import importlib.util
    spec = importlib.util.spec_from_file_location('r6_reloc','tools/r6_reloc.py')
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    er = m.ELF32R(e.path)
    for (rn,ro),(symidx,rtype,rs) in er.reloc.items():
        sym = er.syms[symidx] if symidx < len(er.syms) else None
        reloc_sym[ro] = (sym['name'] if sym else None, rtype)

def main():
    path, name = sys.argv[1], sys.argv[2]
    size = int(sys.argv[3],0) if len(sys.argv)>3 else None
    e = attach(ELF32(path))
    syms=[s for s in e.syms if s['name']==name]
    if not syms:
        print('not found', name); return
    s=syms[0]; va=sz=s['value']; sz=s['size']
    if size: sz=size
    reloc_sym={}
    load_relocs(e, reloc_sym)
    md=Cs(CS_ARCH_ARM, CS_MODE_ARM|CS_MODE_LITTLE_ENDIAN)
    md.detail=True
    code=e.read_va(va,sz)
    off=0
    for i in md.disasm(code, va):
        ann=''
        if i.address in reloc_sym:
            sn,rt=reloc_sym[i.address]
            ann=f'   <<< REL type=0x{rt:02x} sym={sn}'
        # codec-id immediate detection on cmp/sub
        cod=''
        if i.mnemonic in ('cmp','sub','mov') and i.op_str:
            for tok in i.op_str.replace(',',' ').split():
                tok=tok.strip()
                if tok.startswith('#'):
                    try:
                        v=int(tok[1:],0)
                        if v in (3,5,9,0xa,0xb,0xc,0xd):
                            cod=f'   [CODEC_IMM {v}]'
                    except: pass
        print(f'0x{i.address:08x}: {i.mnemonic:10s} {i.op_str}{ann}{cod}')
        off=i.address-va+4
        if off>=sz: break

if __name__=='__main__':
    main()
