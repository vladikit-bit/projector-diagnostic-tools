#!/usr/bin/env python3
"""R2: resolve audio.primary.mt5889.so digital-output path.

- builds PLT -> imported symbol map
- finds cross-references to the spdif/hdmi_tx mode/type strings
- disassembles utils_ApplyDigitalOutputSetting with resolved callees
"""
import struct, sys, bisect
from capstone import *

SO = r'C:\firmware_temp\spdif_audio_investigation\libs\audio.primary.mt5889.so'

data = open(SO, 'rb').read()
assert data[:4] == b'\x7fELF'

# ---- ELF32 header ----
(e_type, e_machine, e_version, e_entry, e_phoff, e_shoff, e_flags,
 e_ehsize, e_phentsize, e_phnum, e_shentsize, e_shnum,
 e_shstrndx) = struct.unpack_from('<HHIIIIIHHHHHH', data, 16)

secs = []
for i in range(e_shnum):
    off = e_shoff + i * e_shentsize
    (sh_name, sh_type, sh_flags, sh_addr, sh_offset, sh_size, sh_link,
     sh_info, sh_addralign, sh_entsize) = struct.unpack_from('<IIIIIIIIII', data, off)
    secs.append(dict(name_off=sh_name, type=sh_type, flags=sh_flags, addr=sh_addr,
                     off=sh_offset, size=sh_size, link=sh_link, info=sh_info,
                     entsize=sh_entsize, idx=i))

shstr = secs[e_shstrndx]
def sname(s):
    b = data[shstr['off'] + s['name_off']:]
    return b[:b.index(b'\0')].decode('utf-8', 'replace')
for s in secs:
    s['name'] = sname(s)

def sec(n):
    return [s for s in secs if s['name'] == n][0]

def va2off(va):
    for s in secs:
        if s['addr'] and s['type'] != 8 and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr'])
    return None

def off2secname(off):
    for s in secs:
        if s['type'] != 8 and s['off'] <= off < s['off'] + s['size']:
            return s['name']
    return None

# ---- dynamic symbol table ----
dynsym = sec('.dynsym'); dynstr = sec('.dynstr')
n = dynsym['size'] // 16
dynsyms = []
for i in range(n):
    o = dynsym['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    b = data[dynstr['off'] + st_name:]
    nm = b[:b.index(b'\0')].decode('utf-8', 'replace')
    dynsyms.append(dict(name=nm, value=st_value, size=st_size, info=st_info, shndx=st_shndx, idx=i))

# ---- PLT map via .rel.plt (SHT_REL = 9, SHT_RELA = 4) ----
plt_map = {}
pltsec = sec('.plt')
plt_addr = pltsec['addr']
for s in secs:
    if s['name'] in ('.rel.plt', '.rela.plt'):
        entsz = 8 if s['name'] == '.rel.plt' else 12
        cnt = s['size'] // entsz
        for i in range(cnt):
            o = s['off'] + i * entsz
            r_offset, r_info = struct.unpack_from('<II', data, o)
            sym = r_info >> 8
            if sym < len(dynsyms):
                plt_map[r_offset] = dynsyms[sym]['name']

# ---- static symtab (may be absent in shipped .so) ----
funcs = []
if any(s['name'] == '.symtab' for s in secs):
    symtab = sec('.symtab'); strtab = secs[symtab['link']]
    cnt = symtab['size'] // 16
    for i in range(cnt):
        o = symtab['off'] + i * 16
        st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
        b = data[strtab['off'] + st_name:]
        nm = b[:b.index(b'\0')].decode('utf-8', 'replace')
        if st_value and (st_info & 0xf) == 2:
            funcs.append((st_value, st_size, nm, st_shndx))
funcs.sort()
fvas = [f[0] for f in funcs]
def nearest_func(va):
    i = bisect.bisect_right(fvas, va) - 1
    if i >= 0:
        v, sz, nm, sx = funcs[i]
        if v <= va < v + max(sz, 1):
            return nm, v, sz
    return None, None, None

# ---- locate strings ----
targets = ['spdif_mode', 'spdif_type', 'hdmi_tx_mode', 'hdmi_tx_type', 'HDMI_ARC',
           'SetSpdifOutputMode=PCM', 'SetSpdifOutputMode=AUTO',
           'SetSpdifOutputMode=BYPASS', 'SetSpdifOutputMode=TRANSCODE',
           'SetSpdifOutputType=NONE', 'SetSpdifOutputType=AC3', 'SetSpdifOutputType=DTS',
           'SetHdmiTxOutputMode=AUTO', 'SetHdmiTxOutputMode=TRANSCODE',
           'SetHdmiTxOutputType=AC3P', 'sound_type', 'spdif', 'SPDIF',
           'utils_ApplyDigitalOutputSetting']

str_vas = {}
for t in targets:
    pat = t.encode() + b'\0'
    pos = data.find(pat)
    if pos < 0:
        continue
    # convert file offset -> VA
    va = None
    for s in secs:
        if s['type'] != 8 and s['off'] <= pos < s['off'] + s['size']:
            va = s['addr'] + (pos - s['off']) if s['addr'] else None
            break
    str_vas[t] = (pos, va)

print('=' * 78)
print('AUDIO HAL DIGITAL-OUTPUT RESOLUTION — audio.primary.mt5889.so')
print('=' * 78)
print(f'sections: {len(secs)}  dynsyms: {len(dynsyms)}  plt entries: {len(plt_map)}  funcs: {len(funcs)}')
print()
print('--- target strings ---')
for t in targets:
    if t in str_vas:
        pos, va = str_vas[t]
        print(f'  {t:<34} fileoff=0x{pos:x}  va={("0x%x" % va) if va else "n/a (no sh_addr)"}')
    else:
        print(f'  {t:<34} NOT FOUND')
print()

# ---- xref scan: 4-byte LE value == string VA anywhere in the file ----
text = sec('.text')
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
md.detail = True

def cstring(va):
    o = va2off(va)
    if o is None: return None
    b = data[o:o + 120]
    if b'\0' not in b: return None
    return b[:b.index(b'\0')].decode('utf-8', 'replace')

print('--- xrefs (literal-pool entries pointing at target strings) ---')
xrefs = {}
for t, (pos, va) in str_vas.items():
    if va is None:
        continue
    hits = []
    for cand in (va, va | 1):
        pat = struct.pack('<I', cand)
        start = 0
        while True:
            i = data.find(pat, start)
            if i < 0: break
            start = i + 1
            sn = off2secname(i)
            if sn in ('.text', '.rodata', '.data.rel.ro', '.fini_array', '.init_array'):
                hits.append(i)
    if hits:
        xrefs[t] = hits
        print(f'  {t:<34} -> {len(hits)} pool entries: ' +
              ', '.join(f'0x{h:x}({off2secname(h)})' for h in hits[:8]))
    else:
        print(f'  {t:<34} -> no literal-pool entry found')
print()

# ---- disassemble a function with resolved callees ----
def disasm_func(va, size, label):
    o = va2off(va)
    if o is None:
        print(f'cannot map va 0x{va:x}'); return
    print('=' * 78)
    print(f'{label}  @ va 0x{va:x} size 0x{size:x}')
    print('=' * 78)
    code = data[o:o + size]
    for ins in md.disasm(code, va):
        txt = f'{ins.address & 0xfffffffe:08x}  {ins.mnemonic:<10} {ins.op_str}'
        note = ''
        if ins.mnemonic in ('bl', 'blx'):
            tgt = None
            if ins.op_str.startswith('#'):
                try: tgt = int(ins.op_str[1:], 16)
                except: pass
            elif ins.op_str.startswith('0x'):
                try: tgt = int(ins.op_str, 16)
                except: pass
            if tgt is not None:
                if tgt in plt_map:
                    note = f'  ; PLT -> {plt_map[tgt]}'
                else:
                    nm, fv, fs = nearest_func(tgt)
                    if nm: note = f'  ; -> {nm} (@0x{fv:x})'
        elif ins.mnemonic == 'ldr' and '[pc' in ins.op_str:
            # literal pool: try to show the string
            pass
        elif ins.mnemonic == 'movw' or ins.mnemonic == 'movt':
            pass
        print(txt + note)

# utils_ApplyDigitalOutputSetting
if 'utils_ApplyDigitalOutputSetting' in str_vas:
    pass

# find the demangled symbol
cand = [(v, sz, nm) for v, sz, nm, sx in funcs if 'ApplyDigitalOutputSetting' in nm]
if not cand:
    cand = [(v, sz, nm) for v, sz, nm, sx in funcs if 'DigitalOutput' in nm or 'SpdifOutput' in nm]
print('--- candidate digital-output functions ---')
for v, sz, nm in cand:
    print(f'  0x{v:x} size 0x{sz:x}  {nm}')
print()
for v, sz, nm in cand[:3]:
    disasm_func(v, min(sz, 0x1200), nm)
