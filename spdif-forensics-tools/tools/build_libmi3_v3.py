#!/usr/bin/env python3
"""
build_libmi3_v3.py — rebuild libmi3 v3 (DTS-family caps bits) from ORIGINAL libmi3.so.

Patches MI_AUDIO_GetCaps attr-copy loop @ va 0x6263e (file 0x6163e):
  original: flag-check + conditional memset tail
  v2 (runtime-proven for AC3): OR 0x2E1 into caps value [r5,#-4], force r4=0, b.w join
  v3: same + movt -> OR 0x070002E1  (adds family bits 24/25/26: DTS/DTS-HD/IEC)

Usage: python build_libmi3_v3.py <orig.so> <out.so>
"""
import sys, struct, hashlib
seq = bytes.fromhex('55f8041c' '40f2e122' 'c0f20072' '1143' '45f8041c' '0024' '00f001b8')
OFF = 0x6163e
orig = open(sys.argv[1],'rb').read()
assert len(orig)==750608
blob = bytearray(orig)
blob[OFF:OFF+len(seq)] = seq
open(sys.argv[2],'wb').write(blob)
print("orig :", hashlib.md5(orig).hexdigest())
print("out  :", hashlib.md5(blob).hexdigest(), hashlib.sha256(blob).hexdigest())
