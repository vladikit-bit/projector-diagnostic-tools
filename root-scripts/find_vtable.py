#!/usr/bin/env python3
"""
Locate the vtable whose slot 0x434 holds the 3D decision.

The library prelinks its vtables as R_ARM_ABS32 relocations against function
symbols, so the relocation table IS the vtable layout. A vtable base V is a
candidate when V+0x434 is a relocation onto a function and the neighbourhood is
a dense run of function relocations.
"""
import re
import subprocess
import sys
from collections import defaultdict

SO = "runs/dvcal/vendor.mediatek.api.mtktvapi@1.0.so"
READELF = r"C:\Android\android-ndk-r30\toolchains\llvm\prebuilt\windows-x86_64\bin\llvm-readelf.exe"

TEXT_LO, TEXT_HI = 0x0F1AC0, 0x0F1AC0 + 0x210F24
VT_LO, VT_HI = 0x030AC50, 0x030AC50 + 0x16B60
SLOT = 0x434

out = subprocess.run([READELF, "-r", SO], capture_output=True, text=True,
                     errors="replace").stdout

# off -> (symbol, addend)
slots = {}
for ln in out.splitlines():
    m = re.match(r"^([0-9a-f]{8})\s+\S+\s+(R_ARM_\w+)\s+([0-9a-f]{8})\s+(\S+)(.*)$", ln)
    if not m:
        continue
    off = int(m.group(1), 16)
    typ = m.group(2)
    name = m.group(4)
    tail = m.group(5)
    am = re.search(r"\+\s*(0x[0-9a-f]+)", tail)
    addend = int(am.group(1), 16) if am else 0
    if typ in ("R_ARM_ABS32", "R_ARM_RELATIVE"):
        slots[off] = (name, addend)

print(f"reloкаций-указателей: {len(slots)}")


def is_func(entry):
    name, addend = entry
    return (name.startswith("_ZN") or name.startswith("_ZTh")
            or name.startswith("_ZTv") or name.startswith("_ZTV")
            or name.startswith("_ZThn")) and not name.startswith("_ZTV")


# Candidate vtable bases: V in .data.rel.ro with a function slot at V+SLOT.
cands = []
for v in range(VT_LO, VT_HI - SLOT, 4):
    e = slots.get(v + SLOT)
    if e and is_func(e):
        # measure how dense the run around V is
        lo = v
        while lo - 4 >= VT_LO and slots.get(lo - 4) and is_func(slots[lo - 4]):
            lo -= 4
        hi = v
        while hi + 4 < VT_HI and slots.get(hi + 4) and is_func(slots[hi + 4]):
            hi += 4
        nslots = (hi - lo) // 4 + 1
        if nslots >= 64:
            cands.append((nslots, lo, hi, v, e[0]))

cands.sort(reverse=True)
print(f"кандидатов (>=64 слотов подряд): {len(cands)}\n")
for n, lo, hi, v, sym in cands[:12]:
    print(f"  vtable {lo:#010x}..{hi:#x}  слотов={n}")
    print(f"    слот 0x{SLOT:x} (индекс {SLOT//4}) = {sym}")
    print()