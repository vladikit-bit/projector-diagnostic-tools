#!/usr/bin/env python3
"""
Correlate the [Common] triple with the nearest PRECEDING decType inside ONE log.

Necessary because the R2 log accumulates sessions: a bare `uniq -c` over all
[Common] lines mixes AC-3 and DTS and produces a meaningless histogram.
"""
import re
import sys
from collections import Counter

COMMON = re.compile(r"\[Common\]\s*ES SR:(-?\d+),\s*SPDIF info:(-?\d+),\s*HDMI info:(-?\d+)")
DECTYPE = re.compile(r"r2_decoder_select: dec:(\d+), decType:(0x[0-9a-f]+)")

CODEC = {0x0: "none", 0x1: "AC-3", 0x3: "ddp_only/ms11", 0x4: "DTS", 0xFF: "?"}

path = sys.argv[1]
cur = None
seen = Counter()

with open(path, "rb") as fh:
    for raw in fh:
        line = raw.decode("utf-8", errors="replace")
        m = DECTYPE.search(line)
        if m:
            cur = int(m.group(2), 16)
            continue
        c = COMMON.search(line)
        if c and cur is not None:
            key = (cur, c.group(1), c.group(2), c.group(3))
            seen[key] += 1

print(f"{'codec':<16} {'SR':>6} {'SPDIF':>6} {'HDMI':>6} {'count':>7}")
for (dt, sr, spdif, hdmi), n in sorted(seen.items(), key=lambda kv: -kv[1]):
    print(f"{CODEC.get(dt, hex(dt)):<16} {sr:>6} {spdif:>6} {hdmi:>6} {n:>7}")
