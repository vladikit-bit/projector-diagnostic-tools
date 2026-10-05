#!/usr/bin/env python3
"""Resolve R_ARM_CALL / R_ARM_JUMP24 / R_ARM_PC24 / R_ARM_ABS32 relocations
for an unlinked ARM32 kernel module, so external call targets become visible.
"""
import struct, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32

R_ARM_NONE = 0
R_ARM_PC24 = 1
R_ARM_ABS32 = 2
R_ARM_CALL = 28
R_ARM_JUMP24 = 29
R_ARM_MOVW_ABS_NC = 43
R_ARM_MOVT_ABS = 44
R_ARM_THM_CALL = 10
R_ARM_THM_JUMP24 = 30

BRANCH_RELOCS = {R_ARM_PC24, R_ARM_CALL, R_ARM_JUMP24}
DATA_RELOCS = {R_ARM_ABS32, R_ARM_MOVW_ABS_NC, R_ARM_MOVT_ABS}


class Relocs:
    def __init__(self, elf: ELF32):
        self.elf = elf
        b = elf.b
        self.branch = {}   # va -> (symname, symvalue, addend_from_insn)
        self.data = {}     # va -> (symname, symvalue)
        self.by_target = {}
        for s in elf.secs:
            if s['type'] not in (4, 9):      # SHT_RELA / SHT_REL
                continue
            if not s['name'].startswith('.rel'):
                continue
            # SHT_RELA=4 / SHT_REL=9.  r_offset is the offset WITHIN the
            # section named by sh_info (for a .ko, .text sh_addr == 0, so
            # r_offset == virtual address).  Do NOT treat it as a file offset.
            tgt_sec = elf.secs[s['info']] if s['info'] < len(elf.secs) else None
            base = tgt_sec['addr'] if tgt_sec else 0
            secname = tgt_sec['name'] if tgt_sec else '?'
            symtab = elf.secs[s['link']]
            strtab = elf.secs[symtab['link']]
            ent = 12 if s['type'] == 9 else 8
            n = s['size'] // ent
            for i in range(n):
                try:
                    o = s['off'] + i * ent
                    if ent == 12:
                        off, info, addend = struct.unpack_from('<IIi', b, o)
                    else:
                        off, info = struct.unpack_from('<II', b, o)
                        addend = None
                    rtype = info & 0xff
                    symidx = info >> 8
                    so = symtab['off'] + symidx * 16
                    if so + 16 > len(b):
                        continue
                    snameoff, sval, ssize, sinfo, sother, sshndx = struct.unpack_from(
                        '<IIIBBH', b, so)
                    end = strtab['off'] + snameoff
                    if end < 0 or end >= len(b):
                        continue
                    se = b.index(b'\0', end)
                    sname = b[end:se].decode('latin1')
                    va = base + off
                    rec = (sname, sval, rtype, addend, off, secname)
                    if rtype in BRANCH_RELOCS:
                        self.branch[va] = rec
                    elif rtype in DATA_RELOCS:
                        self.data[va] = rec
                    self.by_target.setdefault(sname, []).append((va, rtype))
                except Exception:
                    continue

    def call_target(self, va):
        """Given the VA of a bl instruction, return symbol name it calls."""
        return self.branch.get(va, (None,))[0]

    def calls_to(self, name):
        return [(va, r[1]) for va, r in self.branch.items() if r[0] == name]


if __name__ == '__main__':
    from forensic_elf import ELF32
    e = ELF32(sys.argv[1])
    r = Relocs(e)
    pat = sys.argv[2] if len(sys.argv) > 2 else 'MDrv_AUTH_IPCheck'
    print(f"branch relocs: {len(r.branch)}   data relocs: {len(r.data)}")
    for va, (nm, sv, rt, ad, off) in sorted(r.branch.items()):
        if pat in (nm or ''):
            print(f"  0x{va:08x}  -> {nm} (symval 0x{sv:x}, type {rt})")
