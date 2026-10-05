#!/usr/bin/env python3
"""R8: hunt for an embedded function-name / symbol table inside a DSP blob."""
import sys, re, struct, collections

path = sys.argv[1]
b = open(path,'rb').read()

# collect printable runs
runs=[]
cur=b''; start=0
for i,c in enumerate(b):
    if 32 <= c < 127:
        if not cur: start=i
        cur += bytes([c])
    else:
        if len(cur)>=4: runs.append((start, cur.decode()))
        cur=b''
if len(cur)>=4: runs.append((start,cur.decode()))

ident = re.compile(r'^[A-Za-z_][A-Za-z0-9_]{3,40}$')
ids = [(o,s) for o,s in runs if ident.match(s)]
print("total runs>=4: %d   identifier-like: %d" % (len(runs), len(ids)))

# cluster identifier-like strings that sit at tight, regular spacing (a name table)
# look for runs where consecutive strings are separated by small constant gaps
gaps = collections.Counter()
prev=None
for o,s in ids:
    if prev is not None:
        gaps[o-prev[0]] += 1
    prev=(o,s)
print("top gaps between consecutive identifier-like strings: %s" % gaps.most_common(8))

# find dense windows of identifier-like strings
win=0x1000
cnt=collections.Counter(o//win for o,_ in ids)
print("\ndensest 4K windows of identifier-like strings:")
for k,v in cnt.most_common(15):
    print("  0x%08x : %d" % (k*win, v))

arg = sys.argv[2] if len(sys.argv)>2 else None
if arg:
    print("\nidentifier-like strings matching %r:" % arg)
    for o,s in ids:
        if arg.lower() in s.lower():
            print("  0x%06x  %s" % (o,s))
