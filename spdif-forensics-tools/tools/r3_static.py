#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
R3 static: caller-graph + argument trace for MI_AUDIO_GetHandle / MI_AUDIO_GetAttr /
MI_AUDIO_Start in audio.primary.mt5889.so.

Fixes vs v1:
  * Raw bit-level ARM PLT decoder (capstone mis-decodes "add ip, pc, #0, #12").
  * Correct .dynstr offset handling.
  * DT_NEEDED dump + implementation-layer resolution across libmi3.so / libutopia.so.
"""
import struct, bisect, json, os, sys

BASE = r'C:\firmware_temp\spdif_audio_investigation'
SO = os.path.join(BASE, 'libs', 'audio.primary.mt5889.so')
data = open(SO, 'rb').read()


# ----------------------------------------------------------------- ELF helpers
class ELF(object):
    def __init__(self, path):
        self.path = path
        self.data = open(path, 'rb').read()
        d = self.data
        (e_shoff,) = struct.unpack_from('<I', d, 0x20)
        e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', d, 0x2e)
        secs = []
        for i in range(e_shnum):
            o = e_shoff + i * e_shentsize
            f = struct.unpack_from('<10I', d, o)
            secs.append(dict(name_off=f[0], type=f[1], addr=f[3], off=f[4],
                             size=f[5], link=f[6], entsize=f[9]))
        sh = secs[e_shstrndx]['off']

        def rds(o):
            b = d[o:]
            return b[:b.index(b'\0')].decode('latin1')
        for s in secs:
            s['name'] = rds(sh + s['name_off'])
        self.secs = secs
        self.SEC = {s['name']: s for s in secs}
        self.d = d

    def va2off(self, va):
        for s in self.secs:
            if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
                return s['off'] + (va - s['addr'])
        return None

    def u32(self, va):
        o = self.va2off(va)
        if o is None or o + 4 > len(self.d):
            return None
        return struct.unpack_from('<I', self.d, o)[0]

    # ---- dynamic section
    def dynamic(self):
        out = []
        for s in self.secs:
            if s['name'] in ('.dynamic',):
                o = s['off']
                for i in range(s['size'] // 8):
                    tag, val = struct.unpack_from('<II', self.d, o + i * 8)
                    out.append((tag, val))
                    if tag == 0:
                        break
        return out

    def needed(self):
        DT_NEEDED, DT_STRTAB, DT_SYMTAB, DT_SYMENT, DT_STRSZ = 1, 5, 6, 11, 10
        dyn = self.dynamic()
        strtab_va = None
        for t, v in dyn:
            if t == DT_STRTAB:
                strtab_va = v
        names = []
        for t, v in dyn:
            if t == DT_NEEDED:
                o = self.va2off(strtab_va + v) if strtab_va is not None else None
                if o is None:
                    # fall back: first alloc section containing v
                    o = self.va2off(v)
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
            nm = b[:b.index(b'\0')].decode('latin1')
            out.append(dict(name=nm, value=st_value, size=st_size,
                            info=st_info, shndx=st_shndx))
        return out

    def relocs(self, secname):
        out = []
        R = self.SEC.get(secname)
        if not R:
            return out
        esz = 24 if secname.endswith('rela') else 8
        esz = R['entsize'] or esz
        for i in range(R['size'] // esz):
            o = R['off'] + i * esz
            if secname.endswith('rela'):
                r_offset, r_info, r_addend = struct.unpack_from('<IIi', self.d, o)
            else:
                r_offset, r_info = struct.unpack_from('<II', self.d, o)
            out.append((r_offset, r_info >> 8, r_info & 0xFF))
        return out


# ------------------------------------------------------- raw ARM PLT decoding
def arm_imm(w):
    """Decode ARM immediate (ror of imm8 by 2*rot)."""
    rot = (w >> 8) & 0xF
    imm8 = w & 0xFF
    v = imm8
    r = 2 * rot
    if r:
        v = ((v >> r) | (v << (32 - r))) & 0xFFFFFFFF
    return v


def is_add_imm(w, rd, rn):
    return (((w >> 26) & 3) == 0 and ((w >> 25) & 1) == 1
            and ((w >> 21) & 0xF) == 0x4
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn)


def is_ldr_imm(w, rd, rn):
    return (((w >> 26) & 3) == 1 and ((w >> 25) & 1) == 0
            and ((w >> 20) & 1) == 1
            and ((w >> 12) & 0xF) == rd and ((w >> 16) & 0xF) == rn
            and ((w >> 23) & 1) == 1)


def decode_plt(E, rel_map):
    """Classic ARM PLT slot:
         add  ip, pc, #A
         add  ip, ip, #B
         ldr  pc, [ip, #C]
       GOT slot = (slot_va + 8) + A + B + C
    """
    PLT = E.SEC['.plt']
    out = {}
    for off in range(0, PLT['size'] - 12 + 1, 4):
        va = PLT['addr'] + off
        fo = PLT['off'] + off
        if fo + 12 > len(E.d):
            break
        w0, w1, w2 = struct.unpack_from('<III', E.d, fo)
        if (is_add_imm(w0, 12, 15) and is_add_imm(w1, 12, 12)
                and is_ldr_imm(w2, 15, 12)):
            got = (va + 8 + arm_imm(w0) + arm_imm(w1) + (w2 & 0xFFF)) & 0xFFFFFFFF
            if got in rel_map:
                out[va] = (rel_map[got], got)
    return out


# --------------------------------------------------------------------- load HAL
E = ELF(SO)
TX = E.SEC['.text']
dynsyms = E.dynsyms()
SYM = {}
for d in dynsyms:
    if d['name'] and d['value']:
        SYM[d['value'] & ~1] = d['name']
SYMNAME = {d['name']: d for d in dynsyms if d['name']}

rel_map = {}
for off, si, ty in E.relocs('.rel.plt') + E.relocs('.rela.plt'):
    if 0 <= si < len(dynsyms):
        rel_map[off] = dynsyms[si]['name']

PLT = E.SEC['.plt']
print("PLT      : addr=0x%06x off=0x%06x size=%d" % (PLT['addr'], PLT['off'], PLT['size']))
print(".rel.plt : %d relocs, %d with known symbol" % (
    len(E.relocs('.rel.plt') or E.relocs('.rela.plt')), len(rel_map)))

thunk = decode_plt(E, rel_map)
thunk_sym = {v: (s, g) for v, (s, g) in thunk.items()}
print("PLT thunks resolved by raw decode: %d" % len(thunk_sym))

print("\n=== DT_NEEDED (audio.primary.mt5889.so) ===")
for n in E.needed():
    print("   ", n)

# --------------------------------------------------- function map (.ARM.exidx)
EX = E.SEC['.ARM.exidx']
starts = set()
for i in range(EX['size'] // 8):
    o = EX['off'] + i * 8
    (w,) = struct.unpack_from('<I', E.d, o)
    v = (w & 0x7FFFFFFF)
    if w & 0x80000000:
        v -= 0x80000000
    fn = (EX['addr'] + i * 8 + v) & 0xFFFFFFFF
    starts.add(fn)
starts = sorted(s for s in starts if TX['addr'] <= s < TX['addr'] + TX['size'])
starts.append(TX['addr'] + TX['size'])


def func_of(va):
    i = bisect.bisect_right(starts, va) - 1
    if i < 0 or i + 1 >= len(starts):
        return None, None, None
    return starts[i], starts[i + 1], SYM.get(starts[i], None)


print("\n.text    : addr=0x%06x size=0x%x ; %d function starts" % (
    TX['addr'], TX['size'], len(starts) - 1))

# -------------------------------------------------------------- all MI_AUDIO imports
print("\n=== All MI_AUDIO_* / mi_* imported symbols in HAL ===")
mi_imp = sorted(n for n in SYMNAME if n.startswith('MI_') or n.startswith('mi_'))
for n in mi_imp:
    d = SYMNAME[n]
    print("   %-34s value=0x%08x shndx=%d (0=UNDEF/import,>0=defined)" % (
        n, d['value'], d['shndx']))

# -------------------------------------------------------------- disassemble .text
try:
    from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
except ImportError:
    print("capstone missing")
    sys.exit(1)
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
md.skipdata = True
md.detail = True
code = E.d[TX['off']:TX['off'] + TX['size']]
ins_list = list(md.disasm(code, TX['addr'] | 1))
print("\ndisassembled %d instructions" % len(ins_list))

by_addr = {i.address & ~1: i for i in ins_list}

# ------------------------------------------------- callers of imported functions
callers = {}
for ins in ins_list:
    if ins.mnemonic.startswith('bl') and '#' in ins.op_str:
        try:
            tgt = int(ins.op_str.split('#')[1].strip(), 0)
        except Exception:
            continue
        if tgt in thunk_sym:
            sym = thunk_sym[tgt][0]
            a, b, nm = func_of(ins.address & ~1)
            callers.setdefault(sym, []).append((ins.address & ~1, a, nm or '?'))

print("\n=== Callers (in HAL) of each imported MI_AUDIO symbol ===")
for sym in sorted(callers):
    if not (sym.startswith('MI_') or sym.startswith('mi_')):
        continue
    cs = callers[sym]
    byf = {}
    for site, fa, nm in cs:
        byf.setdefault((fa, nm), []).append(site)
    print("  %-34s : %d site(s) / %d func(s)" % (sym, len(cs), len(byf)))
    for (fa, nm), sites in sorted(byf.items()):
        print("      0x%06x %-28s sites %s" % (
            fa, nm, ' '.join('0x%06x' % s for s in sorted(sites))))

# --------------------------------------------------------- string -> function
def find_func_with_string(s, first=True):
    sb = s.encode()
    res = []
    pos = E.d.find(sb)
    while pos >= 0:
        va = pos - TX['off'] + TX['addr']
        if TX['addr'] <= va < TX['addr'] + TX['size']:
            a, b, nm = func_of(va)
            res.append(dict(va=va, func_a=a, func_b=b, func_nm=nm, fileoff=pos))
        if first:
            break
        pos = E.d.find(sb, pos + 1)
    return res


print("\n=== Error / tag strings ===")
STRINGS = ['mi_getCodecType', 'MI_AUDIO_GetHandle failed', 'MI_AUDIO_GetAttr failed',
           'MI_AUDIO_GetType failed', 'MI_AUDIO_Start failed', 'MI_AUDIO_Open failed',
           'MI_AUDIO_SetAttr failed']
str_func = {}
for s in STRINGS:
    r = find_func_with_string(s)
    str_func[s] = r[0] if r else None
    print("  %-30r -> %s" % (s, r[0] if r else 'NOT FOUND'))

# ------------------------------------------------- dump the mi_getCodecType func
def dump_func(a, b, label, maxn=400, annotate=True):
    o = E.va2off(a)
    sz = (b - a) if b else 0x600
    print("\n=== %s : func 0x%06x .. 0x%06x (0x%x bytes) ===" % (label, a, a + sz, sz))
    n = 0
    for ins in md.disasm(E.d[o:o + sz], a | 1):
        extra = ''
        if ins.mnemonic.startswith('bl') and '#' in ins.op_str:
            try:
                tgt = int(ins.op_str.split('#')[1].strip(), 0)
                if tgt in thunk_sym:
                    extra = '  ; CALL ' + thunk_sym[tgt][0]
                elif tgt in SYM:
                    extra = '  ; CALL ' + SYM[tgt]
            except Exception:
                pass
        if annotate and ins.mnemonic.startswith('ldr') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
                lit = ((ins.address & ~1) + 4 & ~3) + imm
                w = E.u32(lit)
                if w is not None:
                    s = None
                    if not (TX['addr'] <= w < TX['addr'] + TX['size']):
                        ro = E.va2off(w)
                        if ro:
                            bb = E.d[ro:ro + 80]
                            if b'\0' in bb and all(32 <= c < 127 for c in bb[:bb.index(b'\0')]) \
                                    and bb.index(b'\0') >= 3:
                                s = bb[:bb.index(b'\0')].decode('latin1')
                    extra += '  ; lit=0x%08x%s' % (w, (' %r' % s) if s else '')
            except Exception:
                pass
        print("0x%06x: %-8s %s%s" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra))
        n += 1
        if n > maxn:
            print("   ... truncated")
            break


mg = str_func.get('mi_getCodecType')
if mg and mg['func_a']:
    dump_func(mg['func_a'], mg['func_b'], 'mi_getCodecType function (contains tag string)')

# ------------------------------------------------ which layer implements the API
print("\n=== Implementation layer for MI_AUDIO_GetHandle / GetAttr / Start ===")
cands = ['MI_AUDIO_GetHandle', 'MI_AUDIO_GetAttr', 'MI_AUDIO_Start', 'MI_AUDIO_Open']
for lib in ('libmi3.so', 'libutopia.so', 'libalsautils.so', 'libaudioparser.so'):
    p = os.path.join(BASE, 'libs', lib)
    if not os.path.exists(p):
        continue
    L = ELF(p)
    ds = L.dynsyms()
    have = {d['name']: d for d in ds if d['name'] in cands}
    exp = [d for d in ds if d['name'] in cands and d['shndx'] != 0]
    imp = [d for d in ds if d['name'] in cands and d['shndx'] == 0]
    print("  %-18s : exported(defined)=%d  imported(undef)=%d" % (lib, len(exp), len(imp)))
    for d in exp:
        print("        DEF  %-24s va=0x%08x size=%d" % (d['name'], d['value'], d['size']))
    for d in imp:
        print("        UND  %-24s" % d['name'])
