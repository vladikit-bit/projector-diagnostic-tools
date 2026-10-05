#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Resolve PLT thunk VA -> imported symbol (via .got.plt + .rel.plt)."""
import struct
SO = r'C:\firmware_temp\spdif_audio_investigation\libs\audio.primary.mt5889.so'
data = open(SO, 'rb').read()
e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    f = struct.unpack_from('<10I', data, o)
    secs.append(dict(name_off=f[0], addr=f[3], off=f[4], size=f[5]))
sh = secs[e_shstrndx]['off']
def rds(o):
    b = data[o:]; return b[:b.index(b'\0')].decode('latin1')
for s in secs: s['name'] = rds(sh + s['name_off'])
SEC = {s['name']: s for s in secs}

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr'])
    return None

# .rel.plt: (r_offset, r_info)  r_offset is GOT slot VA, r_info>>8 = dynsym idx
plt = SEC['.rel.plt']; dynstr = SEC['.dynstr']['off']; ds = SEC['.dynsym']
symname = {}
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    symname[i] = rds(dynstr + st_name)

gotplt = SEC['.got.plt']
# PLT thunk @ va: it is in .plt. The stub:  ldr pc, [pc, #imm]  (the second instruction) loads GOT slot.
# Standard PLT: thunk at VA, code:
#   push {lr}        (Thumb)  OR  ldr ip,[pc,#-4] ... varies
# We'll just: for a given thunk VA, read the LDR that loads [pc,#imm], compute GOT VA, read GOT,
# cross-reference .rel.plt by r_offset == GOT VA.
TX = SEC['.text']
import capstone
md = capstone.Cs(capstone.CS_ARCH_ARM, capstone.CS_MODE_THUMB); md.detail = True
def thunk_sym(va):
    o = va2off(va)
    code = data[o:o + 16]
    for ins in md.disasm(code, va | 1):
        if ins.mnemonic in ('ldr', 'ldr.w') and '[pc' in ins.op_str and '#' in ins.op_str:
            imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
            got_va = ((ins.address & ~1) + 4 & ~3) + imm
            # find rel.plt entry with r_offset == got_va
            for i in range(plt['size'] // 12):
                ro = plt['off'] + i * 12
                r_offset, r_info = struct.unpack_from('<II', data, ro)
                if r_offset == got_va:
                    return symname[r_info >> 8]
    return None

want = [0x3d110, 0x3d100, 0x3d130, 0x3d460, 0x3d2a0, 0x3d2d0, 0x3d2f0, 0x3d340,
        0x3d350, 0x3d360, 0x3d1a0, 0x3d170, 0x3d180, 0x3d190, 0x3d1c0,
        0x3d160, 0x3d240, 0x3d250, 0x3d270]
for w in want:
    print("  0x%06x -> %s" % (w, thunk_sym(w)))
