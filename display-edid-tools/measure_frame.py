#!/usr/bin/env python3
"""Measure one DV frame from the projector and print a milk signature.

Usage:  python measure_frame.py <label>
Captures via adb, then reports the luminance histogram, the range compression
and the per-range colour cast. Re-run it for every A/B comparison: the numbers
are only comparable between captures of the SAME content.
"""
import subprocess, sys, collections
import colorsys
from PIL import Image

ADB = r"C:\Android\platform-tools-latest-windows\platform-tools\adb.exe"
REMOTE = "/sdcard/_mf.png"
LABEL = sys.argv[1] if len(sys.argv) > 1 else "frame"

subprocess.run([ADB, "shell", f"screencap -p {REMOTE}"],
               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
subprocess.run([ADB, "pull", REMOTE, "mf.png"],
               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

im = Image.open("mf.png").convert("RGB")
W, H = im.size
px = im.load()

hist = [0] * 256
buckets = collections.defaultdict(lambda: [0, 0, 0, 0])
sats = []
peak = (0, (0, 0, 0))
for y in range(0, H, 2):
    for x in range(0, W, 2):
        r, g, b = px[x, y]
        l = int(0.299 * r + 0.587 * g + 0.114 * b)
        hist[l] += 1
        if l > peak[0]:
            peak = (l, (r, g, b))
        _, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
        if v > 0.15:
            sats.append(s)
        name = ("тінь" if l <= 15 else "темно" if l <= 60 else
                "середньо" if l <= 110 else "світло" if l <= 180 else "яскраво")
        k = buckets[name]
        k[0] += r; k[1] += g; k[2] += b; k[3] += 1

tot = sum(hist)
sats.sort()
med = sats[len(sats) // 2] if sats else 0.0

print(f"=== {LABEL} ===  {W}x{H}")
print(f"макс Y = {peak[0]}  колір {peak[1]}")
print(f"насиченість медіана = {med*100:.1f}%")
print()
print("зайнятість діапазонів:")
for name in ("тінь", "темно", "середньо", "світло", "яскраво"):
    k = buckets[name]
    print(f"  {name:9} {100*k[3]/tot:6.2f}%  n={k[3]}")
print()
print("колірний відтінк (R−G, B−G):")
for name in ("середньо", "світло", "яскраво"):
    k = buckets[name]
    if k[3]:
        r, g, b = k[0]/k[3], k[1]/k[3], k[2]/k[3]
        print(f"  {name:9} R={r:6.1f} G={g:6.1f} B={b:6.1f}   "
              f"R−G={r-g:+6.1f}  B−G={b-g:+6.1f}")