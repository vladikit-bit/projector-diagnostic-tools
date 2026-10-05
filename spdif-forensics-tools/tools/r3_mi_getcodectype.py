#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
R3: resolve mi_getCodecType() in audio.primary.mt5889.so.
  * correct string->VA (strings live in .rodata, not .text)
  * find the function containing each log tag
  * dump it with PLT resolution + literal-pool annotation
  * find its callers (xrefs) and the argument setup at each call site
"""
import struct, bisect, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r3_static import ELF, decode_plt, arm_imm  # reuse loaders

BASE = r'C:\firmware_temp\spdif_audio_investigation'
SO = os.path.join(BASE, 'libs', 'audio.primary.mt5889.so')

E = ELF(SO)
TX = E.SEC['.text']
dynsyms = E.dynsyms()
SYM = {d['value'] & ~1: d['name'] for d in dynsyms if d['name'] and d['value']}
rel_map = {}
for off, si, ty in E.relocs('.rel.plt') + E.relocs('.rela.plt'):
    if 0 <= si < len(dynsyms):
        rel_map[off] = dynsyms[si]['name']
thunk = decode_plt(E, rel_map)
thunk_sym = {v: s for v, (s, g) in thunk.items()}

# function map
EX = E.SEC['.ARM.exidx']
starts = set()
for i in range(EX['size'] // 8):
    (w,) = struct.unpack_from('<I', E.d, EX['off'] + i * 8)
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


def sec_of_fileoff(pos):
    for s in E.secs:
        if s['type'] != 8 and s['size'] and s['off'] <= pos < s['off'] + s['size']:
            return s
    return None


def find_string(s):
    """Return list of (fileoff, VA, section) for exact byte string."""
    sb = s.encode()
    out = []
    pos = E.d.find(sb)
    while pos >= 0:
        sec = sec_of_fileoff(pos)
        va = (sec['addr'] + pos - sec['off']) if sec and sec['addr'] else None
        out.append((pos, va, sec['name'] if sec else '?'))
        pos = E.d.find(sb, pos + 1)
    return out


print("=== string locations (correct VA math) ===")
TAGS = ['mi_getCodecType', 'MI_AUDIO_GetHandle failed', 'MI_AUDIO_GetAttr failed',
        'MI_AUDIO_GetType failed', 'MI_AUDIO_Start failed']
TAGINFO = {}
for s in TAGS:
    r = find_string(s)
    if not r:
        print("  %-30r NOT FOUND" % s)
        continue
    for pos, va, sn in r:
        print("  %-30r fileoff=0x%06x  VA=0x%06x  (%s)" % (s, pos, va, sn))
    TAGINFO[s] = r[0]

# locate rodata VA -> which function references it (via PC-delta literal idiom)
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
md.skipdata = True
md.detail = True
code = E.d[TX['off']:TX['off'] + TX['size']]
ins_list = list(md.disasm(code, TX['addr'] | 1))
A4 = lambda x: x & ~3

print("\n=== which HAL functions reference each tag string (PC-delta literals) ===")
for s, info in TAGINFO.items():
    if info is None:
        continue
    pos, sva, sn = info
    hits = []
    for k, ins in enumerate(ins_list):
        if ins.mnemonic.startswith('ldr') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
            except Exception:
                continue
            lit = A4((ins.address & ~1) + 4) + imm
            if lit != sva:
                continue
            reg = ins.op_str.split(',')[0].strip()
            # look for 'add rX, pc'
            for j in range(k + 1, min(k + 13, len(ins_list))):
                i2 = ins_list[j]
                if (i2.mnemonic == 'add' and i2.op_str.endswith(', pc')
                        and i2.op_str.split(',')[0].strip() == reg):
                    a, b, nm = func_of(ins.address & ~1)
                    hits.append((ins.address & ~1, a, nm))
                    break
    if hits:
        for site, fa, nm in hits:
            print("  %-30r referenced at 0x%06x in func 0x%06x %s" % (s, site, fa, nm or '?'))
    else:
        print("  %-30r (no direct PC-delta reference found)" % s)

# ---------------------------------------------------------------- dump function
def dump_func(a, b, label, maxn=600):
    o = E.va2off(a)
    sz = (b - a) if b else 0x800
    print("\n" + "=" * 100)
    print("=== %s : 0x%06x .. 0x%06x (0x%x bytes) ===" % (label, a, a + sz, sz))
    print("=" * 100)
    n = 0
    for ins in md.disasm(E.d[o:o + sz], a | 1):
        extra = ''
        if ins.mnemonic.startswith('b') and '#' in ins.op_str:
            try:
                tgt = int(ins.op_str.split('#')[1].strip(), 0)
                if tgt in thunk_sym:
                    extra = '   --> %s()' % thunk_sym[tgt]
                elif tgt in SYM:
                    extra = '   --> %s()' % SYM[tgt]
            except Exception:
                pass
        if ins.mnemonic.startswith('ldr') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
                lit = A4((ins.address & ~1) + 4) + imm
                w = E.u32(lit)
                if w is not None:
                    s = None
                    sec = sec_of_fileoff(E.va2off(w)) if E.va2off(w) else None
                    if sec and sec['name'] not in ('.text', '.plt'):
                        ro = E.va2off(w)
                        if ro:
                            bb = E.d[ro:ro + 90]
                            if b'\0' in bb:
                                cand = bb[:bb.index(b'\0')].decode('latin1')
                                if len(cand) >= 3 and all(32 <= c < 127 for c in cand.encode('latin1')):
                                    s = cand
                    extra += '   ; lit 0x%08x%s' % (w, (' = %r' % s) if s else '')
            except Exception:
                pass
        print("0x%06x: %-8s %-34s%s" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra))
        n += 1
        if n > maxn:
            print("   ... truncated")
            break


# candidate: function at 0x0328d0 (calls MI_AUDIO_GetHandle then MI_AUDIO_GetAttr)
for cand in (0x0328d0,):
    a, b, nm = func_of(cand)
    dump_func(a, b, "candidate mi_getCodecType @0x%06x (%s)" % (cand, nm or '?'))

# ------------------------------------------------------- callers of 0x0328d0
print("\n=== callers (xrefs) of the candidate function ===")
for ins in ins_list:
    if ins.mnemonic.startswith('bl') and '#' in ins.op_str:
        try:
            tgt = int(ins.op_str.split('#')[1].strip(), 0)
        except Exception:
            continue
        if tgt == 0x0328d0:
            a, b, nm = func_of(ins.address & ~1)
            print("  call at 0x%06x from func 0x%06x %s" % (ins.address & ~1, a, nm or '?'))
