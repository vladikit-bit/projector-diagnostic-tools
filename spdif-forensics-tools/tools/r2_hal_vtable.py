#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
R2 Obj 1-3: HMI -> hw_module_methods_t.open -> adev_open -> audio_hw_device_t vtable.
Sanity anchor: jinju_adev_close_input_stream @0x3a3a5 must land on close_input_stream.
"""
import struct, json
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

SO = r'C:\firmware_temp\spdif_audio_investigation\libs\audio.primary.mt5889.so'
data = open(SO, 'rb').read()

e_shoff, = struct.unpack_from('<I', data, 0x20)
e_shentsize, e_shnum, e_shstrndx = struct.unpack_from('<HHH', data, 0x2e)
secs = []
for i in range(e_shnum):
    o = e_shoff + i * e_shentsize
    f = struct.unpack_from('<10I', data, o)
    secs.append(dict(i=i, name_off=f[0], type=f[1], flags=f[2], addr=f[3], off=f[4],
                     size=f[5], link=f[6], info=f[7], align=f[8], entsize=f[9]))
shstr_off = secs[e_shstrndx]['off']
def rdstr(off):
    b = data[off:]
    return b[:b.index(b'\0')].decode('latin1')
for s in secs:
    s['name'] = rdstr(shstr_off + s['name_off'])
SEC = {s['name']: s for s in secs}

dynstr_off = SEC['.dynstr']['off']
dynsyms = []
ds = SEC['.dynsym']
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    dynsyms.append(dict(name=rdstr(dynstr_off + st_name), value=st_value, size=st_size, shndx=st_shndx))
symval = {d['name']: d['value'] for d in dynsyms}
symsize = {d['name']: d['size'] for d in dynsyms}

plt_map = {}
for rn in ('.rel.plt', '.rela.plt'):
    s = SEC.get(rn)
    if not s: continue
    for i in range(s['size'] // 12):
        o = s['off'] + i * 12
        r_offset, r_info = struct.unpack_from('<II', data, o)
        idx = r_info >> 8
        if idx < len(dynsyms):
            plt_map[r_offset] = dynsyms[idx]['name']

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr']), s['name']
    return None, None

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True

# ---------------- HMI ----------------
print("=== HMI (hw_module_t @0x41934) ===")
hmi = symval['HMI']
hoff, hsn = va2off(hmi)
tag, = struct.unpack_from('<I', data, hoff)
mav, hav = struct.unpack_from('<HH', data, hoff + 4)
idp, namep, authp, methp, dsop = struct.unpack_from('<5I', data, hoff + 8)
def rdstrva(va):
    o, _ = va2off(va)
    return rdstr(o) if o is not None else '?'
print("  tag=0x%08x  module_api_version=0x%04x  hal_api_version=0x%04x" % (tag, mav, hav))
print("  id=%r name=%r author=%r" % (rdstrva(idp), rdstrva(namep), rdstrva(authp)))
print("  methods=0x%08x dso=0x%08x" % (methp, dsop))
moff, _ = va2off(methp)
open_fn, = struct.unpack_from('<I', data, moff)
print("  methods->open = 0x%08x" % open_fn)

# ---------------- audio_hw_device_t vtable offsets (Android 11 audio.h) ----------------
ADEV = [
    (0x00, 'common.tag'), (0x04, 'common.version'), (0x08, 'common.module'),
    (0x0c, 'common.reserved[0]'), (0x38, 'common.close'),
    (0x40, 'get_supported_devices'), (0x44, 'init_check'), (0x48, 'set_voice_volume'),
    (0x4c, 'set_master_volume'), (0x50, 'get_master_volume'), (0x54, 'set_mode'),
    (0x58, 'set_mic_mute'), (0x5c, 'get_mic_mute'), (0x60, 'get_parameters'),
    (0x64, 'set_parameters'), (0x68, 'get_input_buffer_size'), (0x6c, 'open_output_stream'),
    (0x70, 'close_output_stream'), (0x74, 'open_input_stream'), (0x78, 'close_input_stream'),
    (0x7c, 'dump'), (0x80, 'set_master_mute'), (0x84, 'get_master_mute'),
    (0x88, 'create_audio_patch'), (0x8c, 'release_audio_patch'),
    (0x90, 'get_audio_port'), (0x94, 'set_audio_port_config'),
]
FIELD = {o: n for o, n in ADEV}
NAME2OFF = {n: o for o, n in ADEV}

# ---------------- disassemble open ----------------
ooff, osn = va2off(open_fn & ~1)
print("\n=== adev_open @0x%08x (off=0x%x) ===" % (open_fn, ooff))
start = (ooff + 0x1000) | 1   # VA space = fileoff + 0x1000 for .text, thumb bit set
code = data[ooff:ooff + 0x4000]
out = []
for ins in md.disasm(code, start):
    out.append(ins)
    if ins.mnemonic == 'bx' and ins.op_str == 'lr':
        break
    if ins.mnemonic == 'pop' and 'pc}' in ins.op_str:
        break
print("  %d instructions" % len(out))

# Build: literal-pool resolver
def ldr_lit_value(ins):
    """If ins is a Thumb-2 PC-relative LDR, return the loaded word."""
    a = ins.address & ~1
    b = data[a:a + 4]
    if len(b) < 4:
        return None
    if (b[0] & 0xf0) == 0xf0 and b[1] in (0xdf, 0x5f):
        imm12 = ((b[0] & 0x0f) << 8) | b[3]
        base = ((ins.address + 4) & ~3) if False else ((a + 4) & ~3)
        if b[1] == 0xdf:
            tgt = base + imm12
        else:
            tgt = base - imm12
        if 0 <= tgt < len(data) - 4:
            return struct.unpack_from('<I', data, tgt)[0]
    return None

stores = []
for ins in out:
    if ins.mnemonic in ('str', 'str.w'):
        ops = ins.op_str.split(',', 1)
        if len(ops) != 2:
            continue
        mem = ops[1].strip()
        if mem.startswith('[') and mem.endswith(']') and '#' in mem:
            inner = mem[1:-1]
            reg, imm = inner.split('#')
            try:
                immv = int(imm.strip(), 0)
            except ValueError:
                continue
            if immv in FIELD and immv >= 0x40:
                stores.append((immv, FIELD[immv], ins, ops[0].strip()))

# backward: find value loaded into the stored register
def resolve_reg(addr, reg, limit=200):
    idx = None
    for i, ins in enumerate(out):
        if ins.address >= addr:
            idx = i
            break
    if idx is None:
        idx = len(out)
    # prefer literal pool load
    for i in range(idx - 1, max(0, idx - limit), -1):
        ins = out[i]
        o = ins.op_str
        if ins.mnemonic in ('ldr', 'ldr.w') and (o.startswith(reg + ',') or o.startswith(reg + ' ,')):
            v = ldr_lit_value(ins)
            if v is not None:
                return v, ins.address
        if ins.mnemonic == 'mov' and o.startswith(reg + ','):
            return None, ins.address
        if ins.mnemonic.startswith('bl') or ins.mnemonic == 'blx':
            pass
    return None, None

print("\n=== ADEV VTABLE (resolved) ===")
vt = {}
for immv, name, ins, reg in sorted(stores, key=lambda x: x[0]):
    val, src = resolve_reg(ins.address, reg)
    vt[name] = val
    mark = ''
    if val is not None and val & ~1 == 0x3a3a5 & ~1:
        mark = '   <<< ANCHOR jinju_adev_close_input_stream'
    if val is None:
        print("  0x%02x %-24s = <unresolved> (stored %s at 0x%x)" % (immv, name, reg, ins.address))
    else:
        print("  0x%02x %-24s = 0x%08x%s" % (immv, name, val, mark))

with open(r'C:\firmware_temp\spdif_audio_investigation\tools\r2_adev_open.asm', 'w') as f:
    for ins in out:
        extra = ''
        for immv, name, si, reg in stores:
            if si.address == ins.address:
                extra = '   ; <=== adev.%s (+0x%02x) = %s' % (name, immv, reg)
        if ins.address & ~1 in plt_map:
            extra += '   ; PLT->%s' % plt_map[ins.address & ~1]
        f.write("0x%06x: %-10s %s%s\n" % (ins.address & ~1, ins.mnemonic, ins.op_str, extra))

json.dump({k: (v if v else 0) for k, v in vt.items()},
          open(r'C:\firmware_temp\spdif_audio_investigation\tools\r2_adev_vtable.json', 'w'), indent=1)
print("\n  wrote tools/r2_adev_open.asm and tools/r2_adev_vtable.json")
