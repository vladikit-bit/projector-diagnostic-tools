#!/usr/bin/env python3
"""R18h: raw 4-byte BE pointer search for each target string VA.
Finds literal-pool / global storage of string pointers (mechanism the in-register
scanner cannot see). Reports every file offset where the VA bytes appear, and the
instruction that immediately follows (to spot a `ld`-fed pool entry vs code).
"""
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
TARGETS = {
    0x0280f07c: b"r2_decoder_houseKeeping",
    0x0280ea2d: b"decType change",
    0x02813ac5: b"dts m6 hook ok",
    0x02813ad5: b"dts m6 init ok",
    0x02813ae4: b"dts_licensee",
    0x02813af5: b"lbr_licensee",
    0x02813b06: b"xll_licensee",
    0x02813b17: b"transcoder_licensee",
    0x02814c80: b"CPU MS12V2 ddp init ok",
    0x02814c98: b"CPU MS12V2 ddp hook ok",
    0x02814c8b: b"ddp init ok",
}
b = open(BIN, 'rb').read()
N = len(b)

for va, lit in TARGETS.items():
    pat = struct.pack('>I', va)
    off = 0
    hits = []
    while True:
        i = b.find(pat, off)
        if i < 0:
            break
        hits.append(i)
        off = i + 1
    if hits:
        print("%-24r VA 0x%08x : %d raw occurrence(s) at file 0x%06x %s"
              % (lit, va, len(hits),
                 hits[0], " ".join("0x%06x" % h for h in hits[1:6]) + (" ..." if len(hits) > 6 else "")))
        # show what immediately follows the first hit (could be a pool: next ptr or code)
        h = hits[0]
        nxt = b[h+4:h+8]
        print("    follow bytes @0x%06x: %s" % (h+4, nxt.hex()))
    else:
        print("%-24r VA 0x%08x : NOT STORED AS 4-BYTE BE CONSTANT" % (lit, va))
