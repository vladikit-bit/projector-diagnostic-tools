#!/usr/bin/env python3
"""R8 step 1d: find code sites in utpa2k.ko that reference the firmware blob symbols."""
import struct

KO = r"C:\firmware_temp\spdif_audio_investigation\kmods\utpa2k_expB_0x4d8_3_dts_license.ko"
b = open(KO, 'rb').read()
e_shoff, = struct.unpack_from('<I', b, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', b, 0x2e)
secs = []
for i in range(e_shnum):
    f = struct.unpack_from('<10I', b, e_shoff + i * e_shentsize)
    secs.append(dict(nameoff=f[0], type=f[1], flags=f[2], addr=f[3], off=f[4], size=f[5],
                     link=f[6], info=f[7], align=f[8], entsize=f[9]))
shstr = secs[e_shstrndx]
def sname(off): return b[shstr['off'] + off:b.index(b'\0', shstr['off'] + off)].decode('latin1')
for s in secs: s['nm'] = sname(s['nameoff'])

sym = [s for s in secs if s['nm'] == '.symtab'][0]
stroff = secs[sym['link']]['off']
def symname(x): return b[stroff + x:b.index(b'\0', stroff + x)].decode('latin1')
nsym = sym['size'] // 16
syms = []
for i in range(nsym):
    o = sym['off'] + i*16
    nameoff, value, size, info, other, shndx = struct.unpack_from('<IIIBBH', b, o)
    syms.append((symname(nameoff), value, size, info & 0xf, info >> 4, shndx))

TARGETS = {'mst_snd_r2', 'mst_codec_r2', 'mst_snd_r2_MS12V22', 'mst_codec_r2_MS12V22'}
tgt_idx = {i for i, s in enumerate(syms) if s[0] in TARGETS}
print("target symtab indices:")
for i in sorted(tgt_idx):
    nm, val, sz, typ, bind, shndx = syms[i]
    print("   idx=%d %-24s val=0x%08x size=0x%08x shndx=%d" % (i, nm, val, sz, shndx))

print("\n=== relocation sites referencing firmware symbols ===")
hits = []
for s in secs:
    if s['type'] != 9:  # SHT_REL
        continue
    tgtsec = secs[s['info']]
    n = s['size'] // 8
    for i in range(n):
        r_off, r_info = struct.unpack_from('<II', b, s['off'] + i*8)
        r_sym = r_info >> 8
        r_type = r_info & 0xff
        if r_sym in tgt_idx:
            hits.append((tgtsec['nm'], r_off, r_type, syms[r_sym][0]))
for tsec, off, rtyp, nm in sorted(hits, key=lambda x: (x[0], x[1])):
    print("  sec=%-16s site=0x%08x type=0x%02x  sym=%s" % (tsec, off, rtyp, nm))
print("\n  total relocation hits: %d" % len(hits))

# group by section and show unique sites sorted
from collections import defaultdict
bysec = defaultdict(list)
for tsec, off, rtyp, nm in hits:
    bysec[tsec].append((off, rtyp, nm))
for tsec, lst in bysec.items():
    print("\n  %s : %d hits, sites: %s" % (tsec, len(lst), ", ".join("0x%x/0x%02x/%s" % (o,t,n) for o,t,n in sorted(lst)[:40])))
