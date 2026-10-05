#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Find .text xrefs to the .data.rel.ro tables (output names, mode names, format names)."""
import struct
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

# build word index over .text only (file offsets)
TX = SEC['.text']
words = {}
for off in range(TX['off'], TX['off'] + TX['size'] - 3, 2):
    w = struct.unpack_from('<I', data, off)[0]
    words.setdefault(w, []).append(off)

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr'])
def off2va(o):
    return o - TX['off'] + TX['addr']

# dynsym for nearest-function naming
dynstr = SEC['.dynstr']['off']; ds = SEC['.dynsym']
fsyms = []
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    n = rds(dynstr + st_name)
    if n and st_value and st_shndx == 14:
        fsyms.append((st_value & ~1, n, st_size))
fsyms.sort()
import bisect
def nearest(va):
    i = bisect.bisect_left(fsyms, (va, '', 0))
    best = None
    for j in (i - 1, i):
        if 0 <= j < len(fsyms) and fsyms[j][0] <= va <= fsyms[j][0] + fsyms[j][2]:
            return fsyms[j]
    for j in (i - 1, i - 2):
        if 0 <= j < len(fsyms):
            return (fsyms[j][0], fsyms[j][1] + ' +0x%x' % (va - fsyms[j][0]), 0)
    return None

TABLES = [
    (0x3fca0, 'OUTPUT_NAME_TABLE_base (ALL)'),
    (0x3fca8, 'OUTPUT_NAME[SPDIF]'),
    (0x3fcac, 'OUTPUT_NAME[HDMI_TX]'),
    (0x3fcbc, 'OUTPUT_NAME[HDMI_ARC]'),
    (0x3fac0, 'MODE_NAME[pcm]'),
    (0x3fac4, 'MODE_NAME[auto]'),
    (0x3fac8, 'MODE_NAME[bypass]'),
    (0x3facc, 'MODE_NAME[transcode]'),
    (0x3fa98, 'FMT_NAME[0]=pcm'),
    (0x3fa9c, 'FMT_NAME[1]=ac3'),
    (0x3fab0, 'FMT_NAME[?]=dts'),
    (0x3fabc, 'FMT_NAME[?]=eac3'),
    (0x3fc74, 'CAP_NAME[dd]'),
    (0x3fc7c, 'CAP_NAME[dts]'),
    (0x3fc88, 'CAP_NAME[dtshd]'),
    (0x3fae8, 'PARAMKEY "Device Set Digital Output Setting"'),
]

for va, label in TABLES:
    refs = words.get(va, [])
    print("0x%06x %-42s -> %d ref(s)" % (va, label, len(refs)))
    for r in refs:
        tva = off2va(r)
        nf = nearest(tva)
        # nearest preceding exported function within 0x3000
        cand = None
        for v, n, s in fsyms:
            if v <= tva and tva - v < 0x4000:
                cand = (v, n, tva - v)
        print("      text VA 0x%06x (off 0x%05x)   %s+0x%x" % (tva, r, cand[1] if cand else '?', cand[2] if cand else 0))
