#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Find onTransact switch in libaudioflinger and list transaction codes."""
import struct
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
SO = r'C:\firmware_temp\spdif_audio_investigation\libs_host\libaudioflinger.so'
data = open(SO, 'rb').read()
e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    f = struct.unpack_from('<10I', data, e_shoff + i * e_shentsize)
    secs.append(f)
sh = secs[e_shstrndx][4]
def rds(o):
    b = data[o:]; return b[:b.index(b'\0')].decode('latin1')
def secname(i): return rds(sh + secs[i][0])
TX = next(s for s in secs if secname(s[0] if False else secs.index(s)) == '.text') if False else None
TX = None
for s in secs:
    if rds(sh + s[0]) == '.text':
        TX = s
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.skipdata = True
A4 = lambda x: x & ~3
# Find the onTransact: heuristic - function with the most distinct `cmp rN,#<1..48>` constants
# that are small and sequential-ish. Disasm whole .text.
code = data[TX[4]:TX[4] + TX[5]]
ins_all = list(md.disasm(code, TX[3] | 1))
# group by function using 'push' prologues
funcs = {}
cur = None
for ins in ins_all:
    if ins.mnemonic in ('push', 'push.w', 'sub', 'sub.w') and ('{' in ins.op_str or '#' in ins.op_str):
        cur = ins.address & ~1
        funcs.setdefault(cur, [])
    if cur is not None:
        funcs[cur].append(ins)
best = None
bestscore = 0
for start, il in funcs.items():
    codes = set()
    for ins in il:
        if ins.mnemonic == 'cmp':
            try:
                imm = int(ins.op_str.split('#')[1].strip().split(',')[0], 0)
                if 1 <= imm <= 60:
                    codes.add(imm)
            except Exception:
                pass
    if len(codes) > bestscore:
        bestscore = len(codes); best = (start, codes, il)
print("best onTransact candidate @0x%06x with %d distinct small cmp codes" % (best[0], len(best[1])))
print("sorted codes:", sorted(best[1]))
# print the cmp chain
print("\n--- cmp instructions in best candidate ---")
for ins in best[2]:
    if ins.mnemonic == 'cmp' and '#' in ins.op_str:
        imm = int(ins.op_str.split('#')[1].strip().split(',')[0], 0)
        if 1 <= imm <= 60:
            print("  0x%06x: %s" % (ins.address & ~1, ins.op_str))
