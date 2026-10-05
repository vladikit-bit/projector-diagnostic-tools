#!/usr/bin/env python3
"""R8 step 1: locate embedded DSP firmware images (mst_snd_r2 / mst_codec_r2 / MS12V22) in utpa2k.ko."""
import sys, os, struct

P = r"C:\firmware_temp\spdif_audio_investigation\kmods\utpa2k_expB_0x4d8_3_dts_license.ko"
b = open(P, 'rb').read()
print("file size = 0x%x (%d)" % (len(b), len(b)))

# --- section table ---
print("\n=== ELF sections ===")
e_shoff, = struct.unpack_from('<I', b, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', b, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    name, styp, flags, addr, off, size, link, info, align, entsize = struct.unpack_from('<10I', b, o)
    secs.append(dict(nameoff=name, type=styp, flags=flags, addr=addr, off=off, size=size, entsize=entsize))
shstr = secs[e_shstrndx]
def sname(off):
    end = b.index(b'\0', shstr['off'] + off)
    return b[shstr['off'] + off:end].decode('latin1')
# relevant sections: big ones, data/rodata
rows = []
for s in secs:
    s['nm'] = sname(s['nameoff'])
    rows.append(s)
big = sorted([s for s in rows if s['size'] > 0x10000], key=lambda s: -s['size'])
for s in big:
    print("  %-24s type=%2d addr=0x%08x off=0x%08x size=0x%08x (%d)" % (s['nm'], s['type'], s['addr'], s['off'], s['size'], s['size']))
print("  (total %d sections)" % len(rows))

# --- search for firmware name strings ---
print("\n=== firmware name string hits ===")
NEEDLES = [b"mst_snd_r2", b"mst_codec_r2", b"MS12V22", b"mst_snd", b"mst_codec", b"_r2"]
for nd in NEEDLES:
    hits = []
    st = 0
    while True:
        i = b.find(nd, st)
        if i < 0 or len(hits) >= 40:
            break
        hits.append(i)
        st = i + 1
    print("  %-14s : %d hits -> %s" % (nd.decode('latin1'), len(hits),
          ", ".join("0x%x" % h for h in hits[:20])))

# --- for each mst_snd_r2 / mst_codec_r2 hit, dump context (string table region) ---
def sec_of(off):
    for s in rows:
        if s['off'] <= off < s['off'] + s['size'] and s['type'] != 8:
            return s['nm']
    return "?"

print("\n=== context around 'mst_' hits (string table walk) ===")
seen = set()
for nd in (b"mst_snd_r2", b"mst_codec_r2"):
    st = 0
    while True:
        i = b.find(nd, st)
        if i < 0:
            break
        # walk back to start of this string blob region and print a window of NUL-separated strings
        base = max(0, i - 256)
        win = b[base:i+512]
        strs = [x.decode('latin1') for x in win.split(b'\0') if len(x) >= 4]
        key = (i//1024)
        if key not in seen:
            seen.add(key)
            print("\n-- hit @0x%x (sec %s) --" % (i, sec_of(i)))
            for s in strs[:60]:
                print("     %s" % s)
        st = i + 1
