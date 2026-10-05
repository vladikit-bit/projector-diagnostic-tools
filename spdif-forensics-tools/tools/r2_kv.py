#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Disassemble small regions around known xref sites with literal annotations."""
import sys, importlib.util, io, contextlib
spec = importlib.util.spec_from_file_location('f', r'C:\firmware_temp\spdif_audio_investigation\tools\r2_funcs.py')
m = importlib.util.module_from_spec(spec)
with contextlib.redirect_stdout(io.StringIO()):
    spec.loader.exec_module(m)
md = m.md; TX = m.TX

def dump(va, size, label):
    o = va - TX['addr'] + TX['off']
    code = m.data[o:o + size]
    print("\n;; ##### %s  @0x%06x (size 0x%x) #####" % (label, va, size))
    for ins in md.disasm(code, va | 1):
        extra = ''
        if ins.mnemonic in ('ldr', 'ldr.w') and '[pc' in ins.op_str and '#' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
                lit_va = ((ins.address & ~1) + 4 & ~3) + imm
                lo = lit_va - TX['addr'] + TX['off']
                if 0 <= lo < len(m.data) - 4:
                    w = m.__class__ and __import__('struct').unpack_from('<I', m.data, lo)[0]
                    s = m.rostr(w)
                    extra += '  ; lit=0x%08x%s' % (w, ('  %r' % s) if s else '')
            except Exception:
                pass
        if ins.mnemonic.startswith('bl') or (ins.mnemonic == 'b' and '#' in ins.op_str):
            try:
                tgt = int(ins.op_str.split('#')[1].strip(), 0)
                if tgt in m.plt_map:
                    extra += '  ; PLT -> %s' % m.plt_map[tgt]
                elif tgt in m.SYM:
                    extra += '  ; -> %s' % m.SYM[tgt]
            except Exception:
                pass
        print("0x%06x: %-9s %s%s" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra))

# get_parameters key sites
dump(0x20e60, 0x1a0, "get_parameters: hdmi_tx_mode/spdif_type reads (0x20d12,0x20e92,0x20f86)")
dump(0x20f40, 0x160, "get_parameters: spdif_type read @0x20f86")
# set_parameters key sites
dump(0x22100, 0x1a0, "set_parameters: hdmi_tx_mode @0x22184,0x221ec")
dump(0x22380, 0x120, "set_parameters: spdif_type @0x2239c,0x22404")
dump(0x22980, 0x140, "set_parameters: sound_type @0x229e8")
