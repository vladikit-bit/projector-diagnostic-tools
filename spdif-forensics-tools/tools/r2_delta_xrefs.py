#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This compiler emits PC-relative references as:  ldr rX,[pc,#imm] ; ... ; add rX, pc
so the literal pool holds (target - Align(addr_add+4,4)), i.e. NOT the absolute VA.
Rebuild every such target across .text, then answer: who references X?
"""
import struct, bisect, json, sys
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
TX = SEC['.text']

dynstr = SEC['.dynstr']['off']; ds = SEC['.dynsym']
fsyms = []
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    n = rds(dynstr + st_name)
    if n and st_value and st_shndx == 14:
        fsyms.append((st_value & ~1, n, st_size))
fsyms.sort()

def nearest(va):
    i = bisect.bisect_left(fsyms, (va, '', 0))
    for j in (i - 1, i - 2, i - 3):
        if 0 <= j < len(fsyms):
            v, n, s = fsyms[j]
            return n, va - v
    return '?', 0

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True
A4 = lambda x: x & ~3

start_va = TX['addr'] | 1
code = data[TX['off']:TX['off'] + TX['size']]
ins_list = list(md.disasm(code, start_va))
print("disassembled %d instructions over .text" % len(ins_list))

# index by address
by_addr = {i.address: k for k, i in enumerate(ins_list)}

def lit_at(pc_va, imm):
    a = A4(pc_va + 4) + imm
    o = a - TX['addr'] + TX['off']
    if TX['off'] <= o < TX['off'] + TX['size'] - 4:
        return struct.unpack_from('<I', data, o)[0]
    return None

refs = {}   # target_va -> [(ldr_addr, reg)]
for k, ins in enumerate(ins_list):
    if ins.mnemonic not in ('ldr', 'ldr.w'):
        continue
    op = ins.op_str
    if '[pc' not in op or '#' not in op:
        continue
    reg = op.split(',')[0].strip()
    try:
        imm = int(op.split('#')[1].rstrip(']').strip(), 0)
    except ValueError:
        continue
    lit = lit_at(ins.address, imm)
    if lit is None:
        continue
    # find matching `add rX, pc` within the next 12 instructions
    for j in range(k + 1, min(k + 13, len(ins_list))):
        i2 = ins_list[j]
        if i2.mnemonic == 'add' and i2.op_str.endswith(', pc') and i2.op_str.split(',')[0].strip() == reg:
            tgt = (lit + A4(i2.address + 4)) & 0xFFFFFFFF
            refs.setdefault(tgt, []).append((ins.address & ~1, reg))
            break

print("resolved %d distinct delta-targets" % len(refs))
json.dump({hex(k): v for k, v in refs.items()},
          open(r'C:\firmware_temp\spdif_audio_investigation\tools\r2_delta_targets.json', 'w'))

# ---- string table in .rodata ----
RO = SEC['.rodata']
def rostr(va):
    o = va - RO['addr'] + RO['off']
    if not (RO['off'] <= o < RO['off'] + RO['size']):
        return None
    b = data[o:o + 120]
    return b[:b.index(b'\0')].decode('latin1') if b'\0' in b else None

DRR = SEC['.data.rel.ro']
def drrslot(va):
    if DRR['addr'] <= va < DRR['addr'] + DRR['size']:
        o = va - DRR['addr'] + DRR['off']
        w = struct.unpack_from('<I', data, o)[0]
        return w
    return None

def describe(va):
    if RO['addr'] <= va < RO['addr'] + RO['size']:
        s = rostr(va)
        return '.rodata %r' % s if s is not None else '.rodata <bin>'
    if DRR['addr'] <= va < DRR['addr'] + DRR['size']:
        w = drrslot(va)
        s = rostr(w) if w else None
        return '.data.rel.ro[%d] -> 0x%x %r' % ((va - DRR['addr']) // 4, w, s)
    return '<other>'

WANT = [0x3fca0, 0x3fca8, 0x3fcac, 0x3fcbc, 0x3fac0, 0x3fac4, 0x3fac8, 0x3facc,
        0x3fa98, 0x3fa9c, 0x3fab0, 0x3fabc, 0x3fc74, 0x3fc7c, 0x3fc88, 0x3fae8]
print("\n=== XREFS TO KEY TABLE SLOTS ===")
for w in WANT:
    r = refs.get(w, [])
    print("0x%06x %-46s -> %d ref" % (w, describe(w)[:46], len(r)))
    for a, reg in r:
        n, off = nearest(a)
        print("        at 0x%06x  (%s+0x%x)  reg=%s" % (a, n, off, reg))

print("\n=== XREFS TO OUR KEY STRINGS (spdif_mode etc.) ===")
keys = ['spdif_mode', 'spdif_type', 'hdmi_tx_mode', 'hdmi_tx_type', 'HDMI_ARC', 'sound_type',
        'SetSpdifOutputMode=PCM', 'SetSpdifOutputMode=AUTO', 'SetSpdifOutputMode=BYPASS',
        'SetSpdifOutputMode=TRANSCODE', 'SetSpdifOutputType=NONE', 'SetSpdifOutputType=AC3',
        'SetSpdifOutputType=DTS', 'SetHdmiTxOutputMode=AUTO', 'SetHdmiTxOutputMode=TRANSCODE',
        'SetHdmiTxOutputType=AC3P', 'SPDIF', 'spdif']
for k in keys:
    tb = k.encode()
    pos = []
    st = 0
    while True:
        i = data.find(tb, st)
        if i < 0: break
        if i + len(tb) < len(data) and data[i + len(tb)] == 0:
            va = i - RO['off'] + RO['addr']
            if RO['off'] <= i < RO['off'] + RO['size']:
                pos.append(va)
        st = i + 1
    found = False
    for va in pos:
        r = refs.get(va, [])
        if r:
            found = True
            print("  %-34s va=0x%06x ->" % (k, va))
            for a, reg in r:
                n, off = nearest(a)
                print("        at 0x%06x  (%s+0x%x)  reg=%s" % (a, n, off, reg))
    if not found:
        print("  %-34s %s -> NO XREF" % (k, ('va=' + hex(pos[0])) if pos else 'not found'))
