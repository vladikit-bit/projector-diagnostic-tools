#!/usr/bin/env python3
"""R8 step 1c: extract the 4 DSP firmware blobs from .data and characterize format/ISA."""
import struct, os, re

KO = r"C:\firmware_temp\spdif_audio_investigation\kmods\utpa2k_expB_0x4d8_3_dts_license.ko"
OUT = r"C:\firmware_temp\spdif_audio_investigation\r8_out"
os.makedirs(OUT, exist_ok=True)
b = open(KO, 'rb').read()

# .data section
e_shoff, = struct.unpack_from('<I', b, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', b, 0x2e)
secs = []
for i in range(e_shnum):
    f = struct.unpack_from('<10I', b, e_shoff + i * e_shentsize)
    secs.append(dict(nameoff=f[0], type=f[1], flags=f[2], addr=f[3], off=f[4], size=f[5], link=f[6]))
shstr = secs[e_shstrndx]
def sname(off):
    return b[shstr['off'] + off:b.index(b'\0', shstr['off'] + off)].decode('latin1')
for s in secs: s['nm'] = sname(s['nameoff'])
DATA = [s for s in secs if s['nm'] == '.data'][0]
print(".data: off=0x%x size=0x%x addr=0x%x" % (DATA['off'], DATA['size'], DATA['addr']))

FW = {
    'mst_codec_r2':          (0x0016be18, 0x0029c0f4),
    'mst_codec_r2_MS12V22':  (0x00407f0c, 0x001e401c),
    'mst_snd_r2':            (0x005fb81c, 0x0017e948),
    'mst_snd_r2_MS12V22':    (0x0077a164, 0x001c1330),
}

def hexdump(d, n=256, base=0):
    out = []
    for i in range(0, min(n, len(d)), 16):
        ch = d[i:i+16]
        h = ' '.join('%02x' % c for c in ch)
        a = ''.join(chr(c) if 32 <= c < 127 else '.' for c in ch)
        out.append("%08x  %-47s  |%s|" % (base+i, h, a))
    return '\n'.join(out)

for nm, (val, size) in FW.items():
    foff = DATA['off'] + val
    blob = b[foff:foff+size]
    path = os.path.join(OUT, nm + '.bin')
    open(path, 'wb').write(blob)
    z = blob.count(0)
    # crude ascii string scan
    strs = re.findall(rb'[ -~]{6,}', blob)
    print("\n" + "="*78)
    print("%s : .data+0x%x -> file 0x%x  size=0x%x (%d)  zeros=%.1f%%  nstrings=%d"
          % (nm, val, foff, size, size, 100.0*z/size, len(strs)))
    print("  -> %s" % path)
    print("--- first 256 bytes ---")
    print(hexdump(blob, 256))
    if strs:
        print("--- sample ascii strings (first 25) ---")
        for s in strs[:25]:
            print("     %s" % s.decode('latin1'))
