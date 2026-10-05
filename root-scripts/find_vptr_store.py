#!/usr/bin/env python3
"""
Identify the true vtable address points.

Structure of an Itanium-ABI vtable in this library:
    [X-8]  typeinfo pointer   (has an R_ARM_ABS32 relocation)
    [X-4]  offset-to-top      (0 for a primary vtable -> NO relocation)
    [X]    first virtual function slot  <-- the address point

`videoinfo_get_value` does `ldr rX,[obj]` then `ldr.w r4,[rX,#0x434]`, so the
address point of the object it holds is one of these X.
"""
import re
import subprocess

SO = "runs/dvcal/vendor.mediatek.api.mtktvapi@1.0.so"
READELF = r"C:\Android\android-ndk-r30\toolchains\llvm\prebuilt\windows-x86_64\bin\llvm-readelf.exe"
VT_LO, VT_HI = 0x030AC50, 0x030AC50 + 0x16B60
SLOT = 0x434

out = subprocess.run([READELF, "-r", SO], capture_output=True, text=True,
                     errors="replace").stdout

relocs = {}
for ln in out.splitlines():
    m = re.match(r"^([0-9a-f]{8})\s+\S+\s+(R_ARM_\w+)\s+([0-9a-f]{8})\s+(\S+)", ln)
    if m:
        relocs[int(m.group(1), 16)] = (m.group(2), m.group(4))

print(f"всего указательных релокаций: {len(relocs)}")

points = []
for x in range(VT_LO + 8, VT_HI, 4):
    if x in relocs:
        continue                    # offset-to-top must be a plain 0
    if (x - 8) not in relocs:
        continue                    # no typeinfo before it
    # how long is the following run of function relocations?
    n = 0
    while (x + 4 * n) in relocs and relocs[x + 4 * n][0] in (
            "R_ARM_ABS32", "R_ARM_RELATIVE"):
        n += 1
    if n >= 8:
        points.append((n, x))

points.sort(reverse=True)
print(f"кандидатов-точек с >=8 слотами: {len(points)}\n")
for n, x in points:
    slot = relocs.get(x + SLOT)
    name = slot[1] if slot else "<нет релокации>"
    print(f"  точка {x:#010x}  слотов={n}")
    print(f"    слот +0x{SLOT:x} (индекс {SLOT//4}) = {name}")
    print(f"    первые 6: " + ", ".join(
        relocs[x + 4 * i][1][:52] for i in range(6) if (x + 4 * i) in relocs))
    print()