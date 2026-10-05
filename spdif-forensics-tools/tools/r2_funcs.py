#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Build a function map from .ARM.exidx (prel31 function starts) + dynsym names,
then disassemble arbitrary VAs with PLT callee resolution.
Usage: python r2_funcs.py <va> [<size>]  (va may be hex with 0x)
"""
import struct, sys, bisect, json
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

SO = r'C:\firmware_temp\spdif_audio_investigation\libs\audio.primary.mt5889.so'
data = open(SO, 'rb').read()

e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    f = struct.unpack_from('<10I', data, o)
    secs.append(dict(name_off=f[0], addr=f[3], off=f[4], size=f[5]))
sh = secs[e_shstrndx]['off']
def rds(o):
    b = data[o:]; return b[:b.index(b'\0')].decode('latin1')
for s in secs: s['name'] = rds(sh + s['name_off'])
SEC = {s['name']: s for s in secs}
TX = SEC['.text']; RO = SEC['.rodata']; DRR = SEC['.data.rel.ro']

dynstr = SEC['.dynstr']['off']; ds = SEC['.dynsym']
dynsyms = []
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    dynsyms.append(dict(name=rds(dynstr + st_name), value=st_value, size=st_size, shndx=st_shndx))
SYM = {}
for d in dynsyms:
    if d['name'] and d['value']:
        SYM[d['value'] & ~1] = d['name']

plt_map = {}
for rn in ('.rel.plt', '.rela.plt'):
    s = SEC.get(rn)
    if not s: continue
    for i in range(s['size'] // 12):
        o = s['off'] + i * 12
        r_offset, r_info = struct.unpack_from('<II', data, o)
        idx = r_info >> 8
        if idx < len(dynsyms):
            plt_map[r_offset] = dynsyms[idx]['name']

# ---- .ARM.exidx -> function starts (prel31 relative to the exidx entry) ----
EX = SEC['.ARM.exidx']
starts = set()
for i in range(EX['size'] // 8):
    o = EX['off'] + i * 8
    w, = struct.unpack_from('<I', data, o)
    v = (w & 0x7FFFFFFF)
    if w & 0x80000000:
        v -= 0x80000000
    fn = (EX['addr'] + i * 8 + v) & 0xFFFFFFFF
    starts.add(fn)
starts = sorted(starts)
starts.append(TX['addr'] + TX['size'])

def func_of(va):
    i = bisect.bisect_right(starts, va) - 1
    if i < 0 or i + 1 >= len(starts): return None, None, None
    a = starts[i]; b = starts[i + 1]
    return a, b, SYM.get(a, None)

def rostr(va):
    o = va - RO['addr'] + RO['off']
    if not (RO['off'] <= o < RO['off'] + RO['size']): return None
    b = data[o:o + 100]
    return b[:b.index(b'\0')].decode('latin1') if b'\0' in b else None

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True

def dis(va, size=None, stop_at_ret=False, out=sys.stdout):
    a, b, nm = func_of(va)
    if size is None:
        size = (b - va) if b else 0x400
    o = va - TX['addr'] + TX['off']
    code = data[o:o + size]
    print(";; ==== disasm @0x%06x  (func 0x%06x..0x%06x %s) size=0x%x ====" %
          (va, a or 0, b or 0, nm or '<static>', size), file=out)
    n = 0
    for ins in md.disasm(code, va | 1):
        n += 1
        extra = ''
        t = ins.operands
        # direct branch target
        if ins.mnemonic.startswith('bl') or (ins.mnemonic == 'b' and '#' in ins.op_str):
            try:
                tgt = int(ins.op_str.split('#')[1].strip(), 0)
            except Exception:
                tgt = None
            if tgt is not None:
                if tgt in plt_map:
                    extra = '  ; PLT -> %s' % plt_map[tgt]
                elif tgt in SYM:
                    extra = '  ; -> %s' % SYM[tgt]
                else:
                    fa, fb, fn = func_of(tgt & ~1)
                    extra = '  ; -> 0x%06x %s' % (tgt, fn if fn else '')
        if ins.mnemonic in ('blx', 'bx') and '#' in ins.op_str:
            try:
                tgt = int(ins.op_str.split('#')[1].strip(), 0)
                if tgt in plt_map:
                    extra = '  ; PLT -> %s' % plt_map[tgt]
            except Exception:
                pass
        # literal pool resolution
        if ins.mnemonic in ('ldr', 'ldr.w') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
                lit_va = ((ins.address & ~1) + 4 & ~3) + imm
                lo = lit_va - TX['addr'] + TX['off']
                if 0 <= lo < len(data) - 4:
                    w = struct.unpack_from('<I', data, lo)[0]
                    s = rostr(w)
                    extra += '  ; lit=0x%08x%s' % (w, (' %r' % s) if s else '')
            except Exception:
                pass
        print("0x%06x: %-9s %s%s" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra), file=out)
        if stop_at_ret and ins.mnemonic in ('bx',) and ins.op_str == 'lr':
            break
    return n

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("func starts: %d" % len(starts))
        for va in (0x2072b, 0x21bf1, 0x24f17, 0x28684, 0x20d12, 0x22844):
            a, b, nm = func_of(va)
            print("  0x%06x -> func 0x%06x..0x%06x size=0x%x  %s" % (va, a, b, b - a, nm or '<static>'))
        sys.exit(0)
    va = int(sys.argv[1], 0) & ~1
    size = int(sys.argv[2], 0) if len(sys.argv) > 2 else None
    dis(va, size)
