#!/usr/bin/env python3
"""
Measure the reference pattern on screen against its known sRGB values.

The pattern has three bands:
  top    grey ramp 0..255, 16 steps   -> reveals any cast on neutral
  middle 10 colour patches, exact sRGB -> reveals per-channel error
  bottom 10 dark patches 16..64       -> reveals black-lift ("milk")

Usage: measure_ref.py <screencap.png> [label]
"""
import sys
from PIL import Image

W, H = 1920, 1080
GREY = [0,16,32,48,64,80,96,112,128,144,160,176,192,208,224,255]
COLOUR = [("червоний",(255,0,0)),("зелений",(0,255,0)),("синій",(0,0,255)),
          ("жовтий",(255,255,0)),("бірюз",(0,255,255)),("пурпур",(255,0,255)),
          ("білий",(255,255,255)),("чорний",(0,0,0)),
          ("сірий50",(128,128,128)),("світло-чер",(255,128,128))]
DARK = [("R64",(64,0,0)),("G64",(0,64,0)),("B64",(0,0,64)),
        ("R32",(32,0,0)),("G32",(0,32,0)),("B32",(0,0,32)),
        ("Y32",(32,32,0)),("C32",(0,32,32)),("M32",(32,0,32)),("K16",(16,16,16))]


def avg(px, x0, x1, y0, y1):
    n = 0
    s = [0, 0, 0]
    for y in range(y0, y1):
        for x in range(x0, x1):
            p = px[x, y]
            s[0] += p[0]; s[1] += p[1]; s[2] += p[2]; n += 1
    return [v / n for v in s]


def main():
    path = sys.argv[1]
    label = sys.argv[2] if len(sys.argv) > 2 else ""
    im = Image.open(path).convert("RGB")
    px = im.load()
    print(f"=== {label}  ({im.size[0]}x{im.size[1]}) ===")

    print("\nСІРА ДРАБИНА (нейтраль) — має бути R=G=B:")
    bw = W // len(GREY)
    err = []
    for i, v in enumerate(GREY):
        x0 = i * bw + 8
        a = avg(px, x0, x0 + bw - 16, 40, 240)
        spread = max(a) - min(a)
        err.append(spread)
        flag = "  <- жорсткий нахил" if spread > 12 else ""
        print(f"  задано {v:3d}  отримано R={a[0]:5.1f} G={a[1]:5.1f} B={a[2]:5.1f}"
              f"  розкид={spread:5.1f}{flag}")
    mid = err[len(err)//2]
    print(f"  --> середній розкид на средніх ступенях: {mid:.1f} "
          f"({'нейтраль порушена' if mid > 8 else 'нейтраль в межах'})")

    print("\nКОЛЬОРОВІ ПЛЯМИ (точні значення sRGB):")
    pw = W // len(COLOUR)
    for i, (name, ref) in enumerate(COLOUR):
        x0 = i * pw + 8
        a = avg(px, x0, x0 + pw - 16, 340, 680)
        print(f"  {name:<11} задано {str(ref):<15} отримано "
              f"R={a[0]:5.1f} G={a[1]:5.1f} B={a[2]:5.1f}   "
              f"зб.{a[0]-ref[0]:+6.1f} {a[1]-ref[1]:+6.1f} {a[2]-ref[2]:+6.1f}")

    print("\nТЕМНІ ПЛЯМИ (де видно «молоко»):")
    pw2 = W // len(DARK)
    for i, (name, ref) in enumerate(DARK):
        x0 = i * pw2 + 8
        a = avg(px, x0, x0 + pw2 - 16, 780, 1020)
        lum = 0.299*a[0] + 0.587*a[1] + 0.114*a[2]
        rl = 0.299*ref[0] + 0.587*ref[1] + 0.114*ref[2]
        print(f"  {name:<5} задано {str(ref):<13} отримано "
              f"R={a[0]:5.1f} G={a[1]:5.1f} B={a[2]:5.1f}   "
              f"яскравість {lum:5.1f} (очікувалась {rl:4.1f})")


if __name__ == "__main__":
    main()