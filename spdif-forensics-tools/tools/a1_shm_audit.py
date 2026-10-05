#!/usr/bin/env python3
"""a1 (independent audit): full SHM_PARAM dispatch map + caller census for utpa2k.ko.
Read-only. Writes nothing except stdout.
Usage: a1_shm_audit.py <utpa2k.ko>
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN
import importlib.util
import struct

spec = importlib.util.spec_from_file_location('r6_reloc', os.path.join(os.path.dirname(os.path.abspath(__file__)), 'r6_reloc.py'))
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)

KO = sys.argv[1]
e = ELF32(KO)
er = m.ELF32R(KO)

# ---- relocation map: VA -> (symname, rtype)
reloc = {}
for (rn, ro), (symidx, rtype, rs) in er.reloc.items():
    sym = er.syms[symidx] if symidx < len(er.syms) else None
    reloc[ro] = (sym['name'] if sym else None, rtype)

# ---- symbol helpers
funcs = [s for s in e.syms if s.get('type') == 2 and s.get('size')]
funcs.sort(key=lambda s: s['value'])
def enclosing(va):
    best = None
    for s in funcs:
        if s['value'] <= va < s['value'] + s['size']:
            if best is None or s['size'] < best['size']:
                best = s
    return best

def symva(name):
    for s in e.syms:
        if s['name'] == name:
            return s['value'], s.get('size', 0)
    return None, None

md = Cs(CS_ARCH_ARM, CS_MODE_ARM | CS_MODE_LITTLE_ENDIAN)
md.detail = True
md.skipdata = True

def dis(va, size):
    code = e.read_va(va, size)
    if code is None:
        return []
    return list(md.disasm(code, va))

SND_FUNC = 0x459dfc
DEC_FUNC = 0x45a434

# ---------------- 1. jump table decode ----------------
def decode_table(table_va, n, index_base, name):
    print("=== %s jump table @0x%x, %d entries (param = index + 0x%x) ===" % (name, table_va, n, index_base))
    pmap = {}
    for i in range(n):
        w = struct.unpack_from('<I', e.read_va(table_va + 4*i, 4))[0]
        param = i + index_base
        pmap[param] = w
    return pmap

def handler_summary(hva, insns=10):
    lines = []
    for i in dis(hva, insns*4):
        ann = ''
        if i.address in reloc:
            sn, rt = reloc[i.address]
            if sn: ann = ' <<< REL %s' % sn
        lines.append('0x%08x: %-9s %s%s' % (i.address, i.mnemonic, i.op_str, ann))
        if i.mnemonic == 'b' and not ann:
            break
    return lines

# SND table: at 0x459e70, indexed by param-0x59, bound 0x76 -> 119 entries
SND_TABLE = 0x459e70
snd_map = decode_table(SND_TABLE, 0x77, 0x59, 'SND')
# DEC table: at 0x45a4c0, indexed by param directly, bound 0xd0 -> 209 entries
DEC_TABLE = 0x45a4c0
dec_map = decode_table(DEC_TABLE, 0xd1, 0, 'DEC')

print("\n=== SND handler -> SHM store offset map ===")
snd_off = {}
for param in sorted(snd_map):
    lines = handler_summary(snd_map[param], 8)
    off = None
    for L in lines:
        if 'str' in L and '#0x' in L:
            try:
                off = int(L.split('#')[1].split(']')[0], 16)
            except Exception:
                off = None
            if off is not None and 'r6' in L:
                snd_off[param] = off
                break
    print("param 0x%02x -> handler 0x%08x : %s" % (param, snd_map[param], ('[r6,+0x%x]' % off) if off is not None else 'special'))

print("\n=== DEC handler -> SHM store offset map (base r0 = shm+0x1590) ===")
dec_off = {}
for param in sorted(dec_map):
    lines = handler_summary(dec_map[param], 8)
    off = None
    for L in lines:
        if 'str' in L and '#0x' in L:
            try:
                off = int(L.split('#')[1].split(']')[0], 16)
            except Exception:
                off = None
            if off is not None:
                dec_off[param] = off
                break
    print("param 0x%02x -> handler 0x%08x : %s" % (param, dec_map[param], ('[r0,+0x%x]' % off) if off is not None else 'special'))

# ---------------- 2. caller census ----------------
print("\n=== ALL call sites of HAL_SND_R2_Set_SHM_PARAM / HAL_DEC_R2_Set_SHM_PARAM ===")
for target_name, tva in (('SND', SND_FUNC), ('DEC', DEC_FUNC)):
    sites = [va for va, (sn, rt) in reloc.items() if sn == ('HAL_SND_R2_Set_SHM_PARAM' if tva == SND_FUNC else 'HAL_DEC_R2_Set_SHM_PARAM')]
    sites.sort()
    print("\n-- %s (%d call sites) --" % (target_name, len(sites)))
    for site in sites:
        fn = enclosing(site)
        # disassemble back 0x40 bytes to catch the argument setup
        back = dis(site - 0x40, 0x44)
        params = []
        vals = []
        for i in back:
            if i.mnemonic == 'mov' and i.op_str.startswith('r0, #'):
                try:
                    v = int(i.op_str.split('#')[1], 0)
                    if v <= 0xff: params.append((i.address, v))
                except Exception: pass
            if i.mnemonic in ('mov', 'mvn', 'and', 'ldr', 'add', 'sub', 'orr') and i.op_str.startswith('r2,'):
                vals.append('0x%08x: %s %s' % (i.address, i.mnemonic, i.op_str))
        pname = ''
        if fn: pname = '%s@0x%x' % (fn['name'], fn['value'])
        else: pname = 'sub_0x%x' % (site & ~0xf)
        print("  call 0x%08x in %s  params(r0)=%s  last r2-setup: %s" % (
            site, pname,
            ['0x%x' % p[1] for p in params[-2:]],
            vals[-2:] if vals else '?'))
