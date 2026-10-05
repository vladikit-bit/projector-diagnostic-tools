#!/usr/bin/env python3
"""OBJ 3: search R2 DSP images + audio modules for transport-layer evidence."""
import os, re
BASE = "C:/firmware_temp/spdif_audio_investigation"
files = [
    f"{BASE}/r2img/mst_snd_r2.bin",
    f"{BASE}/r2img/mst_snd_r2_MS12V22.bin",
    f"{BASE}/r2img/mst_codec_r2.bin",
    f"{BASE}/r2img/mst_codec_r2_MS12V22.bin",
    f"{BASE}/kmods/mik.ko",
    f"{BASE}/kmods/utpa2k.ko",
]
pats = [b'IEC61937',b'61937',b'IEC-61937',b'DTS',b'SPDIF',b'spdif',b'burst',b'BURST',
        b'PAUSE',b'iec',b'Pcms',b'non-PCM',b'nonpcm',b'compressed',b'transcode',b'Transcode',
        b'SDO',b'sdo',b'formatter',b'Formatter',b'PCM',b'pcm']
out = open(f"{BASE}/tools/final_r2.txt","w")
for fn in files:
    data = open(fn,'rb').read()
    # detect ELF
    is_elf = data[:4]==b'\x7fELF'
    out.write(f"\n=== {os.path.basename(fn)}  size={len(data)}  elf={is_elf} ===\n")
    seen=set()
    for p in pats:
        for m in re.finditer(re.escape(p), data):
            start=max(0,m.start()-30); end=min(len(data),m.end()+30)
            seg=data[start:end]
            # printable-ish
            txt=''.join(chr(c) if 32<=c<127 else '.' for c in seg)
            key=(p, txt)
            if key in seen: continue
            seen.add(key)
            out.write(f"  [{p.decode()}] ...{txt}...\n")
            break  # one example per pattern per file
out.close()
print("wrote tools/final_r2.txt")
