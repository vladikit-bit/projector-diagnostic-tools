#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
R2 Objective 1/2/3 helper.
Full-file xref scan for target strings in audio.primary.mt5889.so, plus dump of the
.data.rel.ro pointer table, and resolution of the setParameters handler.
"""
import struct, sys, bisect

SO = r'C:\firmware_temp\spdif_audio_investigation\libs\audio.primary.mt5889.so'
data = open(SO, 'rb').read()

# ---------------- ELF ----------------
e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    (sh_name, sh_type, sh_flags, sh_addr, sh_offset, sh_size,
     sh_link, sh_info, sh_addralign, sh_entsize) = struct.unpack_from('<10I', data, o)
    secs.append(dict(i=i, name_off=sh_name, type=sh_type, flags=sh_flags, addr=sh_addr,
                     off=sh_offset, size=sh_size, link=sh_link, entsize=sh_entsize))

shstr_off = secs[e_shstrndx]['off']
def sname(s):
    b = data[shstr_off + s['name_off']:]
    return b[:b.index(b'\0')].decode('latin1')

for s in secs:
    s['name'] = sname(s)

SEC = {s['name']: s for s in secs}

print("=== SECTIONS ===")
for s in secs:
    print("  %2d %-18s addr=0x%08x off=0x%08x size=0x%06x end=0x%08x" %
          (s['i'], s['name'], s['addr'], s['off'], s['size'], s['addr'] + s['size']))

# ---------------- dynamic symbols + PLT ----------------
dynsym = SEC.get('.dynsym'); dynstr_off = SEC['.dynstr']['off']
ds_n = dynsym['size'] // 16 if dynsym else 0
dynsyms = []
for i in range(ds_n):
    o = dynsym['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    b = data[dynstr_off + st_name:]
    nm = b[:b.index(b'\0')].decode('latin1')
    dynsyms.append(dict(name=nm, value=st_value, size=st_size, info=st_info, shndx=st_shndx))

plt_map = {}
for relname in ('.rel.plt', '.rela.plt'):
    s = SEC.get(relname)
    if not s:
        continue
    esz = 12 if relname == '.rel.plt' else 12
    n = s['size'] // esz
    for i in range(n):
        o = s['off'] + i * esz
        r_offset, r_info = struct.unpack_from('<II', data, o)
        symidx = r_info >> 8
        if symidx < len(dynsyms):
            plt_map[r_offset] = dynsyms[symidx]['name']

print("\n%d dynsyms, %d plt entries" % (len(dynsyms), len(plt_map)))

# ---------------- address helpers ----------------
# Determine whether sh_addr is load-relative or 0-based in this image
print("\n=== VA vs OFFSET policy ===")
print("  .text addr=0x%x off=0x%x  .rodata addr=0x%x off=0x%x" %
      (SEC['.text']['addr'], SEC['.text']['off'], SEC['.rodata']['addr'], SEC['.rodata']['off']))

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr']), s['name']
    return None, None
def off2va(off):
    for s in secs:
        if s['size'] and s['off'] <= off < s['off'] + s['size']:
            return s['addr'] + (off - s['off']), s['name']
    return None, None

# ---------------- locate strings ----------------
targets = ['spdif_mode', 'spdif_type', 'hdmi_tx_mode', 'hdmi_tx_type', 'HDMI_ARC',
           'SetSpdifOutputMode=PCM', 'SetSpdifOutputMode=AUTO', 'SetSpdifOutputMode=BYPASS',
           'SetSpdifOutputMode=TRANSCODE', 'SetSpdifOutputType=NONE', 'SetSpdifOutputType=AC3',
           'SetSpdifOutputType=DTS', 'SetHdmiTxOutputMode=AUTO', 'SetHdmiTxOutputMode=TRANSCODE',
           'SetHdmiTxOutputType=AC3P', 'sound_type', 'spdif', 'SPDIF',
           'audio_capability', 'sound_output', 'SPDIF_OUTPUT', 'digital']

found = []
for t in targets:
    tb = t.encode()
    start = 0
    hits = []
    while True:
        i = data.find(tb, start)
        if i < 0:
            break
        # must be NUL-terminated for exact match
        if data[i + len(tb)] == 0:
            hits.append(i)
        start = i + 1
    if hits:
        found.append((t, hits))

print("\n=== STRING LOCATIONS (file offsets) ===")
strva = {}
for t, hits in found:
    for h in hits:
        va, sn = off2va(h)
        strva[t] = va
        print("  0x%06x (va=0x%x, %s)  %r" % (h, va if va else -1, sn, t))

# ---------------- FULL-FILE xref scan ----------------
# Build a byte->positions index for speed: scan all 4-byte aligned words once.
words = {}
for off in range(0, len(data) - 3, 4):
    w = struct.unpack_from('<I', data, off)[0]
    words.setdefault(w, []).append(off)

print("\n=== XREF SCAN (any 4-byte LE occurrence of the string VA anywhere in the file) ===")
for t, va in strva.items():
    if va is None:
        continue
    refs = words.get(va, []) + words.get(va | 1, [])
    if not refs:
        print("  %-34s va=0x%08x  -> NO REF" % (t, va))
    else:
        for r in refs:
            sname_ = None
            for s in secs:
                if s['size'] and s['off'] <= r < s['off'] + s['size']:
                    sname_ = s['name']; break
            print("  %-34s va=0x%08x  -> ref at off=0x%06x (va=0x%x, %s)" %
                  (t, va, r, r, sname_))

# ---------------- dump .data.rel.ro ----------------
print("\n=== .data.rel.ro POINTER TABLE ===")
drr = SEC.get('.data.rel.ro')
if drr:
    base = drr['addr']
    n = drr['size'] // 4
    for i in range(n):
        o = drr['off'] + i * 4
        w, = struct.unpack_from('<I', data, o)
        va = drr['addr'] + i * 4
        desc = ""
        if w:
            to, sn = va2off(w)
            if to is not None:
                b = data[to:to + 80]
                b = b[:b.index(b'\0')] if b'\0' in b else b
                try:
                    desc = "-> %s:%r" % (sn, b.decode('latin1'))
                except Exception:
                    desc = "-> %s:?" % sn
        print("  0x%08x [%3d] off=0x%06x  0x%08x  %s" % (va, i, o, w, desc))

# ---------------- find functions containing the xrefs ----------------
print("\n=== PLT THUNK RESOLUTION for likely callees ===")
for nm in ('strcmp', 'strstr', 'strncmp', 'atoi', 'strtol', '__system_property_get',
           'property_get', 'AudioSystem::setParameters', 'setParameters'):
    for d in dynsyms:
        if nm in d['name'] and d['name']:
            print("  dynsym %-40s value=0x%x" % (d['name'], d['value']))
            break
