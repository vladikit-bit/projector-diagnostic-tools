#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Find BnAudioFlinger::onTransact and dump its transaction-code switch."""
import struct, sys
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
SO = r'C:\firmware_temp\spdif_audio_investigation\libs_host\libaudioflinger.so'
data = open(SO, 'rb').read()
e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    f = struct.unpack_from('<10I', data, o)
    secs.append(f)
sh = secs[e_shstrndx][4]
def rds(o):
    b = data[o:]; return b[:b.index(b'\0')].decode('latin1')
TX = None
for i in range(e_shnum):
    if rds(sh + secs[i][0]) == '.text':
        TX = secs[i]
DYNS = None
for i in range(e_shnum):
    if secs[i][1] == 11:
        DYNS = secs[i]
# descriptor string
desc = b'android.media.IAudioFlinger'
idx = data.find(desc)
print("descriptor at off 0x%x" % idx)
# find references to descriptor (literal pool loads)
# build word index over .text
def va2off(va):
    for s in secs:
        if s[3] and s[4] <= va - s[3] + s[4] < s[4] + s[5]:
            return s[4] + (va - s[3])
    return None
md = Cs(CS_ARCH_ARM, CS_ARCH_ARM and CS_MODE_THUMB)
md.skipdata = True
# Try to find onTransact: search for function referencing descriptor
# descriptor VA:
dva = idx - TX[4] + TX[3]
# disasm whole .text, find ldr loading dva and note function
# Simpler: scan for the switch. onTransact does cmp rX,#N in a chain.
# Let's find all functions that reference the descriptor.
code = data[TX[4]:TX[4] + TX[5]]
A4 = lambda x: x & ~3
refs = []
for ins in md.disasm(code, TX[3] | 1):
    if ins.mnemonic in ('ldr', 'ldr.w') and '[pc' in ins.op_str and '#' in ins.op_str:
        try:
            imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
            lit = A4(ins.address + 4) + imm
            lo = lit - TX[3] + TX[4]
            if 0 <= lo < len(data) - 4:
                w = struct.unpack_from('<I', data, lo)[0]
                if w == dva:
                    refs.append(ins.address & ~1)
        except Exception:
            pass
print("descriptor referenced at %d instruction(s):" % len(refs))
for r in refs[:10]:
    print("   0x%06x" % r)
# disassemble a window around each ref (likely onTransact is the function containing the last ref chain)
# For each ref, find the function start by scanning backward for a 'push' prologue
def find_func_start(va):
    o = va2off(va)
    # scan backward up to 0x200 for push {...
    for off in range(o, max(TX[4], o - 0x800), -2):
        b = data[off:off + 2]
        if b[0] == 0xb4 or b[0] == 0xb5 or (b[0] & 0xf0) == 0xb0:  # push
            return off - TX[4] + TX[3]
    return va
for r in refs[:6]:
    fs = find_func_start(r)
    print("\n;; onTransact candidate func @0x%06x" % fs)
    fo = va2off(fs)
    for ins in md.disasm(data[fo:fo + 0x600], fs | 1):
        op = ins.op_str
        if ins.mnemonic in ('cmp',) and '#' in op:
            print("   0x%06x: %s %s" % (ins.address & ~1, ins.mnemonic, op))
        if ins.mnemonic.startswith('b') and '#' in op:
            print("   0x%06x: %s %s" % (ins.address & ~1, ins.mnemonic, op))
