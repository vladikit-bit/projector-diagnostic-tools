"""ARM ELF disassembly with PLT resolution via .rel.plt + GOT.

Usage:
  python armdis2.py <file.so> --at <va_hex> [size]
  python armdis2.py <file.so> --callers <regex>   # who calls functions matching regex
  python armdis2.py <file.so> --syms <regex>
"""
import re
import struct
import subprocess
import sys

from capstone import CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB, Cs


class Elf:
    def __init__(self, path):
        self.path = path
        self.buf = open(path, 'rb').read()
        (self.e_type, self.e_machine, self.e_version, self.e_entry, self.e_phoff,
         self.e_shoff, self.e_flags, self.e_ehsize, self.e_phentsize, self.e_phnum,
         self.e_shentsize, self.e_shnum, self.e_shstrndx) = struct.unpack_from('<HHIIIIIHHHHHH', self.buf, 16)
        self.segs = []
        for i in range(self.e_phnum):
            o = self.e_phoff + i * self.e_phentsize
            t, off, va, _pa, fsz, msz, _fl, _al = struct.unpack_from('<IIIIIIII', self.buf, o)
            self.segs.append((t, off, va, fsz, msz))
        self.funcs = {}     # va -> (name, size)
        self.got2name = {}  # got addr -> symbol
        self.plt2name = {}  # plt addr -> symbol
        self._load()

    def _load(self):
        out = subprocess.run(['readelf', '-sW', self.path], capture_output=True, text=True).stdout
        for line in out.splitlines():
            m = re.match(r'\s*\d+:\s+([0-9a-fA-F]+)\s+(\d+)\s+FUNC\s+\S+\s+\S+\s+(\S+)\s+(\S+)\s*$', line)
            if m and int(m.group(2)) > 0:
                self.funcs[int(m.group(1), 16)] = (m.group(4), int(m.group(2)))
        out = subprocess.run(['readelf', '-SW', self.path], capture_output=True, text=True).stdout
        secs = {}
        for line in out.splitlines():
            m = re.match(r'\s*\[\s*\d+\]\s+(\S+)\s+\S+\s+([0-9a-fA-F]+)\s+([0-9a-fA-F]+)\s+([0-9a-fA-F]+)', line)
            if m:
                secs[m.group(1)] = (int(m.group(2), 16), int(m.group(3), 16), int(m.group(4), 16))
        out = subprocess.run(['readelf', '-rW', self.path], capture_output=True, text=True).stdout
        jump_slots = []
        for line in out.splitlines():
            m = re.match(r'([0-9a-fA-F]{8})\s+\S+\s+R_ARM_(JUMP_SLOT|GLOB_DAT)\s+[0-9a-fA-F]+\s+(\S+)', line)
            if m:
                self.got2name[int(m.group(1), 16)] = m.group(3)
                if m.group(2) == 'JUMP_SLOT':
                    jump_slots.append((int(m.group(1), 16), m.group(3)))
        if '.plt' in secs:
            pva, poff, psize = secs['.plt']
            entry = 12
            n = psize // entry
            # PLT0 occupies slot 0; JUMP_SLOT[i] is served by PLT slot i+1
            for i, (got, name) in enumerate(jump_slots):
                idx = i + 1
                if idx < n:
                    self.plt2name[pva + idx * entry] = name
                    self.plt2name[pva + idx * entry + 1] = name + '(t)'

    def off(self, va):
        for t, o, va0, fsz, _ in self.segs:
            if t == 1 and va0 <= va < va0 + fsz:
                return o + (va - va0)
        return None

    def resolve(self, va):
        if va in self.plt2name:
            return self.plt2name[va] + '@plt'
        if va in self.funcs:
            return self.funcs[va][0]
        if (va & ~1) in self.funcs:
            return self.funcs[va & ~1][0] + '(t)'
        return None

    def disasm(self, va, size=None, label=None):
        thumb = bool(va & 1)
        if thumb:
            va &= ~1
        if size is None:
            size = self.funcs.get(va, ('', 128))[1] or 128
        o = self.off(va)
        code = self.buf[o:o + size]
        md = Cs(CS_ARCH_ARM, CS_MODE_THUMB if thumb else CS_MODE_ARM)
        name = label or self.resolve(va)
        print('=== %s  va=0x%x size=%d %s ===' % (name, va, size, 'THUMB' if thumb else 'ARM'))
        for ins in md.disasm(code, va):
            ann = ''
            if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#0x'):
                r = self.resolve(int(ins.op_str[1:], 16))
                if r:
                    ann = '   ; %s' % r
            print('  0x%04x: %-9s %-26s%s' % (ins.address, ins.mnemonic, ins.op_str, ann))

    def callers(self, pattern):
        pat = re.compile(pattern, re.I)
        targets = {va for va, (n, _s) in self.funcs.items() if pat.search(n)}
        md_t, md_a = Cs(CS_ARCH_ARM, CS_MODE_THUMB), Cs(CS_ARCH_ARM, CS_MODE_ARM)
        for va, (name, size) in sorted(self.funcs.items()):
            o = self.off(va)
            if o is None or size > 20000:
                continue
            code = self.buf[o:o + size]
            hits = []
            for md, is_t in ((md_t, True), (md_a, False)):
                for ins in md.disasm(code, va):
                    if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#0x'):
                        d = int(ins.op_str[1:], 16)
                        if d in targets or (d & ~1) in targets:
                            hits.append((ins.address, d, self.resolve(d)))
                            break
                if hits:
                    break
            if hits:
                print('%s (0x%x, %d bytes)' % (name, va, size))
                for a, d, n in hits:
                    print('    0x%04x -> 0x%08x  %s' % (a, d, n))


if __name__ == '__main__':
    a = sys.argv[1:]
    e = Elf(a[0])
    if a[1] == '--at':
        e.disasm(int(a[2], 16), int(a[3]) if len(a) > 3 else None)
    elif a[1] == '--callers':
        e.callers(a[2])
    elif a[1] == '--syms':
        for va, (n, s) in sorted(e.funcs.items()):
            if re.search(a[2], n, re.I):
                print('0x%08x %5d  %s' % (va, s, n))
