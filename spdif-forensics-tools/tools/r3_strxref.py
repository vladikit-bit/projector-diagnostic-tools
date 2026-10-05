#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
R3: build a complete string->code xref map for audio.primary.mt5889.so,
using the verified PC-delta literal idiom:
      ldr   rX, [pc, #imm]        ; literal pool word W
      add   rX, pc                ; target = (W + Align(addr(add)+4, 4)) & 0xFFFFFFFF
Then resolve the functions containing each reference, and dump them.
"""
import struct, bisect, os, sys, json

BASE = r'C:\firmware_temp\spdif_audio_investigation'
d = open(os.path.join(BASE, 'libs', 'audio.primary.mt5889.so'), 'rb').read()

e_shoff, = struct.unpack_from('<I', d, 0x20)
esz, esh, eshstr = struct.unpack_from('<HHH', d, 0x2e)
secs = []
for i in range(esh):
    o = e_shoff + i * esz
    f = struct.unpack_from('<10I', d, o)
    secs.append(dict(no=f[0], addr=f[3], off=f[4], size=f[5], entsize=f[9]))
sh = secs[eshstr]['off']
def rds(o):
    b = d[o:]
    return b[:b.index(b'\0')].decode('latin1')
for s in secs:
    s['name'] = rds(sh + s['no'])
SEC = {s['name']: s for s in secs}
TX = SEC['.text']
RO = SEC['.rodata']

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + va - s['addr']
    return None

# ---------------- rodata string table ----------------
strs = {}
i = RO['off'] if RO['addr'] == 0 else RO['off']
base = RO['addr']
i = RO['off']
while i < RO['off'] + RO['size']:
    j = d.find(b'\0', i)
    if j < 0 or j > RO['off'] + RO['size']:
        break
    chunk = d[i:j]
    if len(chunk) >= 3 and all(32 <= c < 127 for c in chunk):
        strs[base + (i - RO['off'])] = chunk.decode('latin1')
    i = j + 1
REV = {}
for va, s in strs.items():
    REV.setdefault(s, []).append(va)

# ---------------- dynsym ----------------
dn = SEC['.dynstr']; ds = SEC['.dynsym']
dynsyms = []
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', d, o)
    dynsyms.append(dict(name=rds(dn['off'] + st_name), value=st_value, shndx=st_shndx))
SYM = {x['value'] & ~1: x['name'] for x in dynsyms if x['name'] and x['value']}

# ---------------- PLT ----------------
def arm_imm(w):
    rot = (w >> 8) & 0xF; imm8 = w & 0xFF
    r = 2 * rot
    return ((imm8 >> r) | (imm8 << (32 - r))) & 0xFFFFFFFF if r else imm8
def is_add_imm(w, rd, rn):
    return (((w >> 26) & 3) == 0 and ((w >> 25) & 1) == 1 and ((w >> 21) & 0xF) == 0x4
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn)
def is_ldr_imm(w, rd, rn):
    return (((w >> 26) & 3) == 1 and ((w >> 25) & 1) == 0 and ((w >> 20) & 1) == 1
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn and ((w >> 23) & 1) == 1)

rel_map = {}
for sname in ('.rel.plt', '.rela.plt'):
    R = SEC.get(sname)
    if not R:
        continue
    e = 24 if sname.endswith('rela') else 8
    e = R['entsize'] or e
    for k in range(R['size'] // e):
        o = R['off'] + k * e
        if sname.endswith('rela'):
            ro, ri, ra = struct.unpack_from('<IIi', d, o)
        else:
            ro, ri = struct.unpack_from('<II', d, o)
        si = ri >> 8
        if 0 <= si < len(dynsyms):
            rel_map[ro] = dynsyms[si]['name']

PLT = SEC['.plt']
thunk_sym = {}
for off in range(0, PLT['size'] - 12 + 1, 4):
    va = PLT['addr'] + off
    fo = PLT['off'] + off
    if fo + 12 > len(d):
        break
    w0, w1, w2 = struct.unpack_from('<III', d, fo)
    if is_add_imm(w0, 12, 15) and is_add_imm(w1, 12, 12) and is_ldr_imm(w2, 15, 12):
        got = (va + 8 + arm_imm(w0) + arm_imm(w1) + (w2 & 0xFFF)) & 0xFFFFFFFF
        if got in rel_map:
            thunk_sym[va] = rel_map[got]

# ---------------- function starts ----------------
EX = SEC['.ARM.exidx']
starts = set()
for i in range(EX['size'] // 8):
    (w,) = struct.unpack_from('<I', d, EX['off'] + i * 8)
    v = (w & 0x7FFFFFFF)
    if w & 0x80000000:
        v -= 0x80000000
    starts.add((EX['addr'] + i * 8 + v) & 0xFFFFFFFF)
starts = sorted(s for s in starts if TX['addr'] <= s < TX['addr'] + TX['size'])
starts.append(TX['addr'] + TX['size'])
def func_of(va):
    i = bisect.bisect_right(starts, va) - 1
    if i < 0 or i + 1 >= len(starts):
        return None, None, None
    return starts[i], starts[i + 1], SYM.get(starts[i], None)

# ---------------- disassemble .text ----------------
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.skipdata = True; md.detail = True
ins_list = list(md.disasm(d[TX['off']:TX['off'] + TX['size']], TX['addr'] | 1))
A4 = lambda x: x & ~3
by_addr = {i.address & ~1: i for i in ins_list}

# ---------------- build string xrefs ----------------
lits = []   # (ldr_addr, reg, literal_addr, word)
for i in ins_list:
    if i.mnemonic.startswith('ldr') and '[pc' in i.op_str and '#' in i.op_str:
        try:
            imm = int(i.op_str.split('#')[1].rstrip(']').strip(), 0)
        except Exception:
            continue
        lit = A4((i.address & ~1) + 4) + imm
        o = va2off(lit)
        if o is None or o + 4 > len(d):
            continue
        (w,) = struct.unpack_from('<I', d, o)
        lits.append((i.address & ~1, i.op_str.split(',')[0].strip(), lit, w))

# index add-with-pc instructions
# NOTE (verified empirically on this binary): this compiler emits
#     ldr rX,[pc,#imm]  ;  add rX, pc
# and the delta literal is computed against  PC = addr(add) + 4  WITHOUT
# the 4-byte alignment that LDR-literal uses.  Using Align(PC,4) puts every
# target 2 bytes low when the 'add' sits at a 2-mod-4 address.
adds = {}
for i in ins_list:
    if i.mnemonic.startswith('add') and i.op_str.endswith('pc'):
        reg = i.op_str.split(',')[0].strip().rstrip(',')
        adds.setdefault(reg, []).append(i.address & ~1)

strxref = {}   # str_va -> [(ldr_addr, reg, word, add_addr, target)]
for (a, reg, lit, w) in lits:
    Ts = set()
    for na in adds.get(reg, []):
        if a <= na <= a + 64:
            Ts.add((w + (na + 4)) & 0xFFFFFFFF)          # unaligned PC
            Ts.add((w + A4(na + 4)) & 0xFFFFFFFF)        # aligned PC (fallback)
    for T in Ts:
        if T in strs:
            strxref.setdefault(T, []).append((a, reg, w, lit))

print("functions=%d  ins=%d  literal-loads=%d  strings=%d  resolved-str-xrefs=%d"
      % (len(starts) - 1, len(ins_list), len(lits), len(strs), sum(len(v) for v in strxref.values())))

# ---------------- report on key strings ----------------
KEY = ['mi_getCodecType',
       '%s: can get MI_AUDIO_GetHandle, ret = %d',
       '%s: MI_AUDIO_GetHandle failed!!! ret = %d',
       '%s: MI_AUDIO_GetHandle failed!!! ret = %d.',
       '%s: MI_AUDIO_GetAttr failed, ret=0x%x !!',
       '%s: MI_AUDIO_Start failed, handle=0x%08x, ret=0x%x !!',
       '%s not support codec type: %d',
       '%s: mode(%s), codec(%s) ',
       '%s audio codec type: ',
       '%s: MI_AUDIO_Open failed, ret=0x%x !!',
       '%s: MI_AUDIO_SetAttr E_MI_AUDIO_ATTR_TYPE_CODEC_DATA failed, ret %d.',
       '%s: MI_AUDIO_GetAttr E_MI_AUDIO_ATTR_TYPE_CODEC_DATA fail, ret %d.']

print("\n" + "=" * 104)
print("=== STRING -> CODE XREFS (key R3 strings) ===")
print("=" * 104)
targets = {}
for s in KEY:
    vas = REV.get(s, [])
    if not vas:
        print("  %-62r NOT IN RODATA" % s)
        continue
    for va in vas:
        refs = strxref.get(va, [])
        fa_set = set()
        for (a, reg, w, lit) in refs:
            fa, fb, nm = func_of(a)
            fa_set.add((fa, nm))
        targets.setdefault((va, s), []).extend(refs)
        print("  VA=0x%06x  %r" % (va, s))
        if refs:
            for (a, reg, w, lit) in refs:
                fa, fb, nm = func_of(a)
                print("        ref @0x%06x  %s  (func 0x%06x %s)"
                      % (a, reg, fa, nm or '?'))
        else:
            print("        (no code reference)")

# ---------------- callers of a function ----------------
def callers_of(fva):
    out = []
    for i in ins_list:
        if i.mnemonic.startswith('bl') and '#' in i.op_str:
            try:
                t = int(i.op_str.split('#')[1].strip(), 0)
            except Exception:
                continue
            if t == fva:
                fa, fb, nm = func_of(i.address & ~1)
                out.append((i.address & ~1, fa, nm))
    return out

# ---------------- dump function ----------------
def dump_func(a, b, label, maxn=500):
    o = va2off(a)
    sz = (b - a) if b else 0x800
    print("\n" + "=" * 104)
    print("=== %s : 0x%06x .. 0x%06x (0x%x bytes) ===" % (label, a, a + sz, sz))
    print("=" * 104)
    n = 0
    for ins in md.disasm(d[o:o + sz], a | 1):
        extra = ''
        if ins.mnemonic.startswith('b') and '#' in ins.op_str:
            try:
                t = int(ins.op_str.split('#')[1].strip(), 0)
                if t in thunk_sym:
                    extra = '  --> %s()' % thunk_sym[t]
                elif t in SYM:
                    extra = '  --> %s()' % SYM[t]
            except Exception:
                pass
        if ins.mnemonic.startswith('ldr') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
                lit = A4((ins.address & ~1) + 4) + imm
                o2 = va2off(lit)
                (w,) = struct.unpack_from('<I', d, o2)
                s = None
                if RO['addr'] <= w < RO['addr'] + RO['size']:
                    s = strs.get(w)
                extra += '  ; lit 0x%08x%s' % (w, (' = %r' % s) if s else '')
            except Exception:
                pass
        print("0x%06x: %-8s %-36s%s" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra))
        n += 1
        if n > maxn:
            print("   ... truncated")
            break

if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'report'
    if mode == 'xrefs':
        # dump every function that references ANY of the key strings
        done = set()
        for (va, s), refs in sorted(targets.items()):
            for (a, reg, w, lit) in refs:
                fa, fb, nm = func_of(a)
                if fa in done:
                    continue
                done.add(fa)
                dump_func(fa, fb, "func 0x%06x %s  [refs %r]" % (fa, nm or '?', s))
                for (cs, cfa, cnm) in callers_of(fa):
                    print("   <<< called from 0x%06x (func 0x%06x %s)" % (cs, cfa, cnm or '?'))
    elif mode.startswith('fn:'):
        a = int(mode[3:], 16)
        fa, fb, nm = func_of(a)
        dump_func(fa, fb, "func 0x%06x %s" % (fa, nm or '?'))
        for (cs, cfa, cnm) in callers_of(fa):
            print("   <<< called from 0x%06x (func 0x%06x %s)" % (cs, cfa, cnm or '?'))
