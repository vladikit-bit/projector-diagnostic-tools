"""Disassemble a function from a 32-bit ARM ELF and resolve call targets.

Usage:
  python armdis.py <file.so> <va_hex> [size_bytes]
  python armdis.py <file.so> --list | grep <regex>   # list FUNC symbols
  python armdis.py <file.so> --calls <regex>         # list functions calling <regex>
"""
import re
import struct
import subprocess
import sys

from capstone import CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB, Cs

THUMB_BIT = 1


class Elf32:
    def __init__(self, path):
        self.path = path
        with open(path, 'rb') as fh:
            self.buf = fh.read()
        (self.e_type, self.e_machine, self.e_version, self.e_entry, self.e_phoff,
         self.e_shoff, self.e_flags, self.e_ehsize, self.e_phentsize, self.e_phnum,
         self.e_shentsize, self.e_shnum, self.e_shstrndx) = struct.unpack_from('<HHIIIIIHHHHHH', self.buf, 16)
        self.segments = []
        for i in range(self.e_phnum):
            off = self.e_phoff + i * self.e_phentsize
            (p_type, p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_flags,
             p_align) = struct.unpack_from('<IIIIIIII', self.buf, off)
            self.segments.append((p_type, p_offset, p_vaddr, p_filesz, p_memsz))
        self.syms = {}
        self.plt = []
        self._read_symbols()

    def _read_symbols(self):
        out = subprocess.run(['readelf', '-sW', self.path], capture_output=True, text=True).stdout
        for line in out.splitlines():
            m = re.match(r'\s*\d+:\s+([0-9a-fA-F]+)\s+(\d+)\s+(FUNC|OBJECT)\s+.*\s+(\S+)\s*$', line)
            if m:
                va = int(m.group(1), 16)
                size = int(m.group(2))
                name = m.group(4)
                if name not in self.syms or size:
                    self.syms.setdefault(va, name)

    def va_to_off(self, va):
        for p_type, p_offset, p_vaddr, p_filesz, _memsz in self.segments:
            if p_type == 1 and p_vaddr <= va < p_vaddr + p_filesz:
                return p_offset + (va - p_vaddr)
        return None

    def thumb_at(self, va):
        """Heuristic: a FUNC symbol whose low bit is set is Thumb."""
        return False

    def sym(self, va):
        if va in self.syms:
            return self.syms[va]
        # thumb: the symbol table stores even addrs
        if (va & ~1) in self.syms:
            return self.syms[va & ~1] + '+0 (thumb?)'
        for cand in (va & ~1, va):
            pass
        return None

    def nearest_sym(self, va):
        best = None
        for sva, name in self.syms.items():
            if sva <= va and (best is None or sva > best[0]):
                best = (sva, name)
        if best:
            return '%s+0x%x' % (best[1], va - best[0])
        return None


def list_funcs(path, pattern):
    e = Elf32(path)
    pat = re.compile(pattern, re.I)
    rows = []
    for va, name in sorted(e.syms.items()):
        if pat.search(name):
            rows.append((va, name))
    for va, name in rows:
        print('%08x  %s' % (va, name))


def list_callers(path, pattern):
    """Naive: scan all FUNC symbols, disassemble, look for BL to matching symbol."""
    e = Elf32(path)
    pat = re.compile(pattern, re.I)
    targets = {va for va, n in e.syms.items() if pat.search(n)}
    readelf = subprocess.run(['readelf', '-sW', path], capture_output=True, text=True).stdout
    funcs = []
    for line in readelf.splitlines():
        m = re.match(r'\s*\d+:\s+([0-9a-fA-F]+)\s+(\d+)\s+FUNC\s+\S+\s+\S+\s+\S+\s+(\S+)\s*$', line)
        if m and int(m.group(2)) > 0:
            funcs.append((int(m.group(1), 16), int(m.group(2)), m.group(3)))
    md_arm = Cs(CS_ARCH_ARM, CS_MODE_ARM)
    md_thm = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
    for va, size, name in funcs:
        off = e.va_to_off(va)
        if off is None:
            continue
        code = e.buf[off:off + size]
        for md, tag in ((md_thm, 't'), (md_arm, 'a')):
            hits = []
            for ins in md.disasm(code, va):
                if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#0x'):
                    dst = int(ins.op_str[1:], 16)
                    if dst in targets:
                        hits.append((ins.address, dst, e.syms.get(dst, '?')))
            if hits:
                print('%s %s  (0x%x, %d bytes, %s)' % (tag, name, va, size, 'THUMB' if tag == 't' else 'ARM'))
                for a, d, n in hits:
                    print('    0x%04x -> 0x%08x  %s' % (a, d, n))
                break


def disasm(path, va, size=None):
    e = Elf32(path)
    thumb = False
    name = e.syms.get(va & ~1, '?')
    if va & 1:
        thumb = True
        va &= ~1
    if size is None:
        size = 128
    off = e.va_to_off(va)
    if off is None:
        sys.exit('no segment for va 0x%x' % va)
    code = e.buf[off:off + size]
    md = Cs(CS_ARCH_ARM, CS_MODE_THUMB if thumb else CS_MODE_ARM)
    print('--- %s  va=0x%x  size=%d  %s ---' % (name, va, size, 'THUMB' if thumb else 'ARM'))
    for ins in md.disasm(code, va):
        ann = ''
        if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#0x'):
            dst = int(ins.op_str[1:], 16)
            s = e.sym(dst)
            ann = '   ; %s' % (s if s else (e.nearest_sym(dst) or '?'))
        print('  0x%04x: %-9s %-28s%s' % (ins.address, ins.mnemonic, ins.op_str, ann))


if __name__ == '__main__':
    a = sys.argv[1:]
    if a[0] == '--list':
        list_funcs(a[1], a[2] if len(a) > 2 else '.')
    elif a[0] == '--calls':
        list_callers(a[1], a[2] if len(a) > 2 else '.')
    else:
        disasm(a[0], int(a[1], 16), int(a[2]) if len(a) > 2 else None)
