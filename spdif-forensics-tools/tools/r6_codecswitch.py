#!/usr/bin/env python3
"""R6: scan all exec sections for cmp/sub against codec ids, print function + the
branch that follows (to spot codec switches that include/exclude DTS core = 9)."""
import sys, re
sys.path.insert(0, 'tools')
from forensic_elf import ELF32
from forensic_dis import attach
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN

TARGET = {5: 'AC3', 9: 'DTS', 0xa: 'EAC3', 0xb: 'DTS-HD', 0xc: 'TRUEHD', 0xd: 'IEC61937'}

def main():
    e = attach(ELF32(sys.argv[1]))
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN)
    md.detail = True
    def fname(va):
        best=None
        for s in e.syms:
            if not s['name'] or s['shndx']==0: continue
            if s['value']<=va<s['value']+max(s['size'],1): return s['name']
            if s['value']<=va and (best is None or s['value']>best[1]): best=(s['name'],s['value'])
        if best and va-best[1]<0x4000: return f"{best[0]}+0x{va-best[1]:x}"
        return None
    for s in [x for x in e.secs if x['flags']&0x4 and x['size']]:
        code=e.b[s['off']:s['off']+s['size']]
        insns=list(md.disasm(code, s['addr']))
        for idx,i in enumerate(insns):
            m=i.mnemonic; op=i.op_str or ''
            mt=re.search(r'#(-?0x[0-9a-fA-F]+|-?\d+)', op)
            if mt and i.operands and i.operands[-1].type==2:
                val=i.operands[-1].imm
                if val in TARGET:
                    # next instruction = the conditional branch
                    nxt = insns[idx+1] if idx+1<len(insns) else None
                    nb = f"{nxt.mnemonic} {nxt.op_str}" if nxt else ''
                    print(f"0x{i.address:08x} [{fname(i.address)}] {m} {op}  ->  {nb}   ({TARGET[val]})")

if __name__=='__main__':
    main()
