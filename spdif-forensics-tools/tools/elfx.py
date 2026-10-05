#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Reusable ARM/Thumb ELF analysis helpers for the MStar MT5889 audio HAL investigation.

Verified facts about audio.primary.mt5889.so (and libmi3.so):
  * PLT entries are the classic 3-instruction ARM form
        add ip, pc, #A ;  add ip, ip, #B ;  ldr pc, [ip, #C]
    padded to 16 bytes.  Capstone mis-decodes "add ip, pc, #0, #12", so the
    thunks are decoded here with raw bit tests (see decode_plt).
  * Literal pools use the PC-DELTA idiom:
        ldr rX, [pc, #imm]     ; literal word W at Align(addr+4,4)+imm
        add rX, pc             ; target = (W + (addr(add) + 4)) & 0xFFFFFFFF
    NOTE: the 'add rX, pc' delta is computed against addr+4 WITHOUT the
    4-byte alignment used by the LDR literal.  Using Align(PC,4) puts every
    target 2 bytes low whenever 'add' sits at a 2-mod-4 address.
"""
import struct, bisect, os

BASE = r'C:\firmware_temp\spdif_audio_investigation'


class ELF(object):
    def __init__(self, path):
        self.path = path
        self.d = open(path, 'rb').read()
        d = self.d
        (e_shoff,) = struct.unpack_from('<I', d, 0x20)
        e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', d, 0x2e)
        secs = []
        for i in range(e_shnum):
            o = e_shoff + i * e_shentsize
            f = struct.unpack_from('<10I', d, o)
            secs.append(dict(name_off=f[0], type=f[1], addr=f[3], off=f[4],
                             size=f[5], entsize=f[9]))
        sh = secs[e_shstrndx]['off']

        def rds(o):
            b = d[o:]
            return b[:b.index(b'\0')].decode('latin1')
        for s in secs:
            s['name'] = rds(sh + s['name_off'])
        self.secs = secs
        self.SEC = {s['name']: s for s in secs}

    def va2off(self, va):
        for s in self.secs:
            if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
                return s['off'] + (va - s['addr'])
        return None

    def u32(self, va):
        o = self.va2off(va)
        return struct.unpack_from('<I', self.d, o)[0] if o is not None else None

    def u16(self, va):
        o = self.va2off(va)
        return struct.unpack_from('<H', self.d, o)[0] if o is not None else None

    def dynamic(self):
        out = []
        s = self.SEC.get('.dynamic')
        if not s:
            return out
        for i in range(s['size'] // 8):
            tag, val = struct.unpack_from('<II', self.d, s['off'] + i * 8)
            out.append((tag, val))
            if tag == 0:
                break
        return out

    def needed(self):
        dyn = self.dynamic()
        strtab = next((v for t, v in dyn if t == 5), None)
        names = []
        for t, v in dyn:
            if t == 1:  # DT_NEEDED
                o = self.va2off(strtab + v) if strtab is not None else self.va2off(v)
                if o is None:
                    continue
                b = self.d[o:]
                names.append(b[:b.index(b'\0')].decode('latin1'))
        return names

    def dynsyms(self):
        out = []
        ds = self.SEC.get('.dynsym')
        dn = self.SEC.get('.dynstr')
        if not ds or not dn:
            return out
        esz = ds['entsize'] or 16
        for i in range(ds['size'] // esz):
            o = ds['off'] + i * esz
            st_name, st_value, st_size, st_info, st_other, st_shndx = \
                struct.unpack_from('<IIIBBH', self.d, o)
            off = dn['off'] + st_name
            b = self.d[off:]
            out.append(dict(name=b[:b.index(b'\0')].decode('latin1'),
                            value=st_value, size=st_size, info=st_info,
                            shndx=st_shndx))
        return out

    def relocs(self, secname):
        out = []
        R = self.SEC.get(secname)
        if not R:
            return out
        esz = R['entsize'] or (24 if secname.endswith('rela') else 8)
        for i in range(R['size'] // esz):
            o = R['off'] + i * esz
            if secname.endswith('rela'):
                ro, ri, ra = struct.unpack_from('<IIi', self.d, o)
            else:
                ro, ri = struct.unpack_from('<II', self.d, o)
            out.append((ro, ri >> 8, ri & 0xFF))
        return out

    # ---------------------------------------------------------------- strings
    def rodata_strings(self, sec='.rodata'):
        S = self.SEC.get(sec)
        out = {}
        if not S:
            return out
        i = S['off']
        while i < S['off'] + S['size']:
            j = self.d.find(b'\0', i)
            if j < 0 or j > S['off'] + S['size']:
                break
            c = self.d[i:j]
            if len(c) >= 3 and all(32 <= x < 127 for x in c):
                out[S['addr'] + (i - S['off'])] = c.decode('latin1')
            i = j + 1
        return out


def arm_imm(w):
    r = 2 * ((w >> 8) & 0xF)
    imm8 = w & 0xFF
    return (((imm8 >> r) | (imm8 << (32 - r))) & 0xFFFFFFFF) if r else imm8


def is_add_imm(w, rd, rn):
    return (((w >> 26) & 3) == 0 and ((w >> 25) & 1) == 1 and ((w >> 21) & 0xF) == 0x4
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn)


def is_ldr_imm(w, rd, rn):
    return (((w >> 26) & 3) == 1 and ((w >> 25) & 1) == 0 and ((w >> 20) & 1) == 1
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn
            and ((w >> 23) & 1) == 1)


def decode_plt(E):
    """-> {thunk_va: (symbol_name, got_slot_va)}"""
    rel_map = {}
    dyn = E.dynsyms()
    for off, si, ty in E.relocs('.rel.plt') + E.relocs('.rela.plt'):
        if 0 <= si < len(dyn):
            rel_map[off] = dyn[si]['name']
    PLT = E.SEC['.plt']
    out = {}
    for off in range(0, PLT['size'] - 12 + 1, 4):
        va = PLT['addr'] + off
        fo = PLT['off'] + off
        if fo + 12 > len(E.d):
            break
        w0, w1, w2 = struct.unpack_from('<III', E.d, fo)
        if is_add_imm(w0, 12, 15) and is_add_imm(w1, 12, 12) and is_ldr_imm(w2, 15, 12):
            got = (va + 8 + arm_imm(w0) + arm_imm(w1) + (w2 & 0xFFF)) & 0xFFFFFFFF
            if got in rel_map:
                out[va] = (rel_map[got], got)
    return out


def func_starts(E):
    """Function starts from .ARM.exidx prel31 entries, limited to .text."""
    TX = E.SEC['.text']
    EX = E.SEC['.ARM.exidx']
    s = set()
    for i in range(EX['size'] // 8):
        (w,) = struct.unpack_from('<I', E.d, EX['off'] + i * 8)
        v = w & 0x7FFFFFFF
        if w & 0x80000000:
            v -= 0x80000000
        s.add((EX['addr'] + i * 8 + v) & 0xFFFFFFFF)
    out = sorted(x for x in s if TX['addr'] <= x < TX['addr'] + TX['size'])
    out.append(TX['addr'] + TX['size'])
    return out


def make_func_of(starts, syms=None):
    def func_of(va):
        i = bisect.bisect_right(starts, va) - 1
        if i < 0 or i + 1 >= len(starts):
            return None, None, None
        a = starts[i]
        return a, starts[i + 1], (syms or {}).get(a)
    return func_of


def disasm_text(E, thumb=True):
    from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
    TX = E.SEC['.text']
    md = Cs(CS_ARCH_ARM, CS_MODE_THUMB if thumb else CS_MODE_ARM)
    md.skipdata = True
    md.detail = True
    base = TX['addr'] | (1 if thumb else 0)
    return list(md.disasm(E.d[TX['off']:TX['off'] + TX['size']], base)), md
