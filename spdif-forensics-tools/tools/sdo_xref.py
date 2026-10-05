import sys, struct
from elftools.elf.elffile import ELFFile

LIB = 'libs/libutopia.so'

TARGETS = [
    b"DTSDecSDOPacker_API_Process",
    b"DTSDecSDOPacker_API_StartFrame",
    b"DTS_SDO_SPDIF_OUT",
    b"spdifFrmBuf",
    b"DTSXFilePlayer",
    b"DTSX_CORE2_API_SDO_Packer",
    b"DTSX_CORE2_API_Xcoder",
    b"DTS_PARAM_SDO_PACKER_SPDIF_ADD_IEC_HEADER_I32",
    b"PackSPDIFStream",
    b"DTSSPDIFPackFrame",
    b"p_file_player",
]

f = open(LIB, 'rb')
elf = ELFFile(f)
secs = []
for s in elf.iter_sections():
    if s.header['sh_type'] != 'SHT_NOBITS' and s['sh_size'] > 0:
        secs.append((s.name, s['sh_addr'], s['sh_addr'] + s['sh_size'],
                     s['sh_offset'], s['sh_size']))

blob = open(LIB, 'rb').read()

def sec_of_off(off):
    for name, a0, a1, o, sz in secs:
        if o <= off < o + sz:
            return name, a0 + (off - o)
    return '?', 0

def sec_of_va(va):
    for name, a0, a1, o, sz in secs:
        if a0 <= va < a1:
            return name
    return '?'

print("=== string occurrences ===")
occ = {}
for t in TARGETS:
    occ[t] = []
    start = 0
    while True:
        i = blob.find(t, start)
        if i < 0:
            break
        # ignore matches inside a longer word
        prev_ok = i == 0 or not (0x30 <= blob[i-1] < 0x7f)
        nxt_ok = i+len(t) < len(blob) and blob[i+len(t)] == 0
        if prev_ok and nxt_ok:
            sec, va = sec_of_off(i)
            occ[t].append((i, sec, va))
        start = i + 1
    for (i, sec, va) in occ[t]:
        print(f"{t.decode():45s} @ off {i:#010x} sec {sec:14s} va {va:#010x}")
    if not occ[t]:
        print(f"{t.decode():45s} : not found")

print()
print("=== context around first SDO packer string ===")
i0 = occ[b"DTSDecSDOPacker_API_Process"][0][0] if occ[b"DTSDecSDOPacker_API_Process"] else None
if i0:
    ctx = blob[i0-0x300:i0+0x400]
    import re
    for m in re.finditer(rb"[ -~]{6,}", ctx):
        print(f"  {i0-0x300+m.start():#010x}: {m.group().decode()[:100]}")

print()
print("=== xref scan: words equal to string VAs in .text/.data ===")
# build map va -> strings
va_map = {}
for t in TARGETS:
    for (i, sec, va) in occ[t]:
        va_map.setdefault(va, []).append(t.decode())

text = [s for s in secs if s[0] == '.text'][0]
data = [s for s in secs if s[0] == '.data'][0]

def scan_words(secname):
    name, a0, a1, o, sz = [s for s in secs if s[0] == secname][0]
    d = blob[o:o+sz]
    hits = []
    for va, names in va_map.items():
        w = struct.pack('<I', va)
        start = 0
        while True:
            j = d.find(w, start)
            if j < 0:
                break
            if j % 4 == 0:
                hits.append((a0 + j, va, names))
            start = j + 1
    return hits

for secname in ('.text', '.data', '.rodata', '.data.rel.ro'):
    hits = scan_words(secname)
    print(f"-- {secname}: {len(hits)} hits")
    for (hva, sva, names) in hits[:60]:
        print(f"   pool @{hva:#010x} -> {sva:#010x}  ({names[0]})")
