#!/usr/bin/env python3
"""R8 step 1b: resolve firmware blob SYMBOLS (mst_snd_r2 etc) -> section, value(addr), size."""
import struct

P = r"C:\firmware_temp\spdif_audio_investigation\kmods\utpa2k_expB_0x4d8_3_dts_license.ko"
b = open(P, 'rb').read()

e_shoff, = struct.unpack_from('<I', b, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', b, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    f = struct.unpack_from('<10I', b, o)
    secs.append(dict(nameoff=f[0], type=f[1], flags=f[2], addr=f[3], off=f[4], size=f[5], link=f[6], info=f[7], align=f[8], entsize=f[9]))
shstr = secs[e_shstrndx]
def sname(off):
    end = b.index(b'\0', shstr['off'] + off)
    return b[shstr['off'] + off:end].decode('latin1')
for s in secs:
    s['nm'] = sname(s['nameoff'])

# --- symtab ---
sym = [s for s in secs if s['nm'] == '.symtab'][0]
stroff = secs[sym['link']]['off']
def symname(x):
    end = b.index(b'\0', stroff + x)
    return b[stroff + x:end].decode('latin1')

n = sym['size'] // 16
syms = []
for i in range(n):
    o = sym['off'] + i * 16
    nameoff, value, size, info, other, shndx = struct.unpack_from('<IIIBBH', b, o)
    syms.append(dict(nameoff=nameoff, value=value, size=size, info=info, shndx=shndx,
                     nm=symname(nameoff), bind=info >> 4, typ=info & 0xf))

print("total syms: %d" % len(syms))

KEYS = ['mst_snd', 'mst_codec', 'MS12V22', 'r2_', '_r2']
print("\n=== firmware candidate symbols ===")
for s in syms:
    nm = s['nm']
    if any(k in nm for k in KEYS) and s['size'] > 0:
        sh = secs[s['shndx']]['nm'] if s['shndx'] < len(secs) and s['shndx'] != 0 else 'ABS/UNDEF'
        print("  %-40s value=0x%08x size=0x%08x (%10d) shndx=%d(%s) bind=%d type=%d" %
              (nm, s['value'], s['size'], s['size'], s['shndx'], sh, s['bind'], s['typ']))

print("\n=== ALL symbols with size > 100000 (big blobs) ===")
big = sorted([s for s in syms if s['size'] > 100000], key=lambda s: -s['size'])
for s in big:
    sh = secs[s['shndx']]['nm'] if s['shndx'] < len(secs) and s['shndx'] != 0 else 'ABS/UNDEF'
    print("  %-44s value=0x%08x size=0x%08x (%10d) shndx=%d(%s)" %
          (s['nm'], s['value'], s['size'], s['size'], s['shndx'], sh))
