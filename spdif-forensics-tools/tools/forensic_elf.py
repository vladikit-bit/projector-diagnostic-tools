#!/usr/bin/env python3
"""Independent ELF symbol/section helper for the C50A forensic audit.

Standalone (no pyelftools). 32-bit ARM ELF only (kernel .ko + vendor .so).
"""
import struct, sys, re


class ELF32:
    def __init__(self, path):
        self.path = path
        self.b = open(path, 'rb').read()
        b = self.b
        assert b[:4] == b'\x7fELF' and b[4] == 1, "not 32-bit ELF"
        e_shoff, = struct.unpack_from('<I', b, 0x20)
        e_shentsize, = struct.unpack_from('<H', b, 0x2e)
        e_shnum, = struct.unpack_from('<H', b, 0x30)
        e_shstrndx, = struct.unpack_from('<H', b, 0x32)
        secs = []
        for i in range(e_shnum):
            o = e_shoff + i * e_shentsize
            (name, typ, flags, addr, off, size, link, info,
             align, entsize) = struct.unpack_from('<10I', b, o)
            secs.append(dict(nameoff=name, type=typ, flags=flags, addr=addr,
                             off=off, size=size, link=link, info=info,
                             entsize=entsize))
        sh = secs[e_shstrndx]
        def sname(n):
            e = b.index(b'\0', sh['off'] + n)
            return b[sh['off'] + n:e].decode('latin1')
        for s in secs:
            s['name'] = sname(s['nameoff'])
        self.secs = secs
        self.text = self.sec('.text')
        self.rodata = self.sec('.rodata')
        self.data = self.sec('.data')
        self._load_symbols()

    def sec(self, name):
        for s in self.secs:
            if s['name'] == name:
                return s
        return None

    def _load_symbols(self):
        sym = self.sec('.symtab')
        self.syms = []
        if sym is None:
            return
        strtab = self.secs[sym['link']]
        sb = self.b
        for i in range(sym['size'] // 16):
            o = sym['off'] + i * 16
            nameoff, value, size, info, other, shndx = struct.unpack_from(
                '<IIIBBH', sb, o)
            e = sb.index(b'\0', strtab['off'] + nameoff)
            nm = sb[strtab['off'] + nameoff:e].decode('latin1')
            self.syms.append(dict(name=nm, value=value, size=size,
                                  type=info & 0xf, bind=info >> 4, shndx=shndx))
        self.sym_by_name = {}
        for s in self.syms:
            self.sym_by_name.setdefault(s['name'], []).append(s)

    def find(self, pattern):
        rx = re.compile(pattern)
        return [s for s in self.syms if rx.search(s['name'])]

    def va2off(self, va, sec=None):
        sec = sec or self.text
        return sec['off'] + va - sec['addr']

    def off2va(self, off, sec=None):
        sec = sec or self.text
        return sec['addr'] + off - sec['off']

    def read_va(self, va, n, sec=None):
        o = self.va2off(va, sec)
        return self.b[o:o + n]

    def word(self, va, sec=None):
        return struct.unpack('<I', self.read_va(va, 4, sec))[0]


if __name__ == '__main__':
    e = ELF32(sys.argv[1])
    pat = sys.argv[2] if len(sys.argv) > 2 else '.'
    for s in e.find(pat):
        if s['name']:
            print(f"{s['value']:08x}  size={s['size']:<7} type={s['type']} "
                  f"shndx={s['shndx']:<3} {s['name']}")
