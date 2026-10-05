#!/usr/bin/env python3
"""ARM32 (ARM-state) disassembler helper built on capstone for the forensic audit.

Usage:
  from forensic_dis import ArmFunc
  f = ArmFunc(elf, 'MDrv_AUDIO_CheckHashkey')   # elf = forensic_elf.ELF32
  f.dump()
"""
import struct
from capstone import (Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB,
                      CS_MODE_LITTLE_ENDIAN, CS_ARCH_X86)


class ArmFunc:
    def __init__(self, elf, va, size=None, thumb=False, name=''):
        self.elf = elf
        self.va = va
        self.thumb = thumb
        self.name = name
        if size is None:
            for s in elf.syms:
                if s['value'] == va and s['size']:
                    size = s['size']
                    break
        self.size = size or 0x200
        self.end = va + self.size
        code = elf.read_va(va, self.size)
        mode = CS_MODE_THUMB if thumb else CS_MODE_ARM
        self.md = Cs(CS_ARCH_ARM, mode | CS_MODE_LITTLE_ENDIAN)
        self.md.detail = True
        self.insns = list(self.md.disasm(code, va))
        self.by_addr = {i.address: i for i in self.insns}

    def dump(self, out=None, show_bytes=False):
        out = out or __import__('sys').stdout
        print(f";;; {self.name} @ 0x{self.va:x} size 0x{self.size:x} "
              f"({'Thumb' if self.thumb else 'ARM'})", file=out)
        for i in self.insns:
            bs = ''
            if show_bytes:
                bs = i.bytes.hex() + '  '
            print(f"0x{i.address:08x}: {bs}{i.mnemonic:<8} {i.op_str}", file=out)

    def calls(self):
        """Return [(addr, target_va_or_None, symbol_name)] for bl/blx instructions."""
        res = []
        for i in self.insns:
            if i.mnemonic in ('bl', 'blx', 'bx'):
                if i.operands and i.operands[0].type == 2:  # IMM
                    t = i.operands[0].imm
                    nm = self.elf.nearest_sym(t)
                    res.append((i.address, t, nm))
                else:
                    res.append((i.address, None, None))
        return res


def nearest_sym(elf, va):
    best = None
    for s in elf.syms:
        if not s['name'] or s['shndx'] == 0:
            continue
        if s['value'] <= va < s['value'] + max(s['size'], 1):
            return s['name']
        if s['value'] <= va and (best is None or s['value'] > best['value']):
            best = s
    if best and va - best['value'] < 0x10000:
        return f"{best['name']}+0x{va - best['value']:x}"
    return None


ELF32 = None  # patched by caller


def attach(elf):
    elf.nearest_sym = lambda va: nearest_sym(elf, va)
    return elf
