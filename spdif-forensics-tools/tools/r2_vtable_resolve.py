#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Resolve adev_open's audio_hw_device_t vtable.
Pattern used by this compiler:  ldr rX,[pc,#imm] ; add rX, pc  ->  target = lit + Align(addr_add+4,4)
Also handles: strd (pair stores) and stm.w (multi stores) and the `mov lr/ip/fp` detour.
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
    secs.append(dict(name_off=f[0], addr=f[3], off=f[4], size=f[5]))
sh = secs[e_shstrndx]['off']
def rds(o):
    b = data[o:]; return b[:b.index(b'\0')].decode('latin1')
for s in secs: s['name'] = rds(sh + s['name_off'])
SEC = {s['name']: s for s in secs}
dynstr = SEC['.dynstr']['off']; ds = SEC['.dynsym']
dynsyms = []
for i in range(ds['size'] // 16):
    o = ds['off'] + i * 16
    st_name, st_value, st_size, st_info, st_other, st_shndx = struct.unpack_from('<IIIBBH', data, o)
    dynsyms.append((rds(dynstr + st_name), st_value, st_size, st_shndx))
SYM = {n: v for n, v, s, x in dynsyms}

def va2off(va):
    for s in secs:
        if s['addr'] and s['size'] and s['addr'] <= va < s['addr'] + s['size']:
            return s['off'] + (va - s['addr'])
    return None

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True
A4 = lambda x: x & ~3

OPEN = SYM.get('_ZN7android25jinju_adev_open_output_streamE...', None)
# adev_open entry from HMI
hmi = SYM['HMI']
hva = struct.unpack_from('<I', data, va2off(hmi) + 0x14)[0]
open_fn = struct.unpack_from('<I', data, va2off(hva))[0]
print("adev_open = 0x%x" % open_fn)

ooff = va2off(open_fn & ~1)
code = data[ooff:ooff + 0x4000]
ins_list = []
for ins in md.disasm(code, (ooff + 0x1000) | 1):
    ins_list.append(ins)
    if ins.mnemonic == 'bx' and ins.op_str == 'lr': break
    if ins.mnemonic == 'pop' and 'pc}' in ins.op_str: break

def lit_at(pc_va, imm):
    a = va2off(A4(pc_va + 4) + imm)
    return struct.unpack_from('<I', data, a)[0] if a is not None else None

# pass 1: record `ldr rX,[pc,#imm]` -> literal value (store pending until we see `add rX,pc`)
pending = {}
resolved_val = {}   # reg -> value at a given point (we track by address)
regval = {}         # addr -> (reg,value)
for idx, ins in enumerate(ins_list):
    if ins.mnemonic in ('ldr', 'ldr.w') and '[pc' in ins.op_str and '#' in ins.op_str:
        reg = ins.op_str.split(',')[0].strip()
        try:
            imm = int(ins.op_str.split('#')[1].rstrip(']').strip(), 0)
        except ValueError:
            continue
        if reg in ('r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'sb', 'fp', 'ip', 'lr'):
            pending[reg] = (ins.address, lit_at(ins.address, imm))
    if ins.mnemonic == 'add' and ins.op_str.endswith(', pc'):
        reg = ins.op_str.split(',')[0].strip()
        if reg in pending and pending[reg][1] is not None:
            val = pending[reg][1] + A4(ins.address + 4)
            resolved_val.setdefault(ins.address, {})[reg] = val
            pending.pop(reg, None)

# pass 2: linear scan tracking register values (incl. mov ip/lr/fp)
regstate = {}
store_log = []
for ins in ins_list:
    if ins.address in resolved_val:
        for r, v in resolved_val[ins.address].items():
            regstate[r] = v
    if ins.mnemonic == 'mov' and ',' in ins.op_str:
        a, b = [x.strip() for x in ins.op_str.split(',')]
        if b in regstate and a in ('ip', 'lr', 'fp', 'r12', 'r11', 'r10'):
            regstate[a] = regstate[b]
    if ins.mnemonic == 'add.w' and ins.op_str.startswith('r0, r4, #0x70'):
        regstate['_base70'] = True
    if ins.mnemonic in ('str', 'str.w') and '[' in ins.op_str:
        ops = ins.op_str.split(',', 1)
        src = ops[0].strip()
        mem = ops[1].strip()
        if mem.startswith('[') and mem.endswith(']') and '#' in mem:
            inner = mem[1:-1]; reg, imm = inner.split('#')
            immv = int(imm.strip(), 0)
            if reg.strip().rstrip(',') == 'r4' and immv >= 0x40:
                store_log.append((immv, src, regstate.get(src), ins.address))
    if ins.mnemonic == 'strd':
        # strd rA, rB, [r4,#imm]
        ops = ins.op_str.split(',', 2)
        src1 = ops[0].strip(); src2 = ops[1].strip()
        mem = ops[2].strip()
        if mem.startswith('[') and mem.endswith(']') and '#' in mem:
            inner = mem[1:-1]; reg, imm = inner.split('#')
            immv = int(imm.strip(), 0)
            if reg.strip().rstrip(',') == 'r4' and immv >= 0x40:
                store_log.append((immv, src1, regstate.get(src1), ins.address))
                store_log.append((immv + 4, src2, regstate.get(src2), ins.address))
    if ins.mnemonic.startswith('stm'):
        # stm.w r0, {r3, fp, lr}   where r0 = r4+0x70
        head, regs = ins.op_str.split(',', 1)
        regs = regs.strip().lstrip('{').rstrip('}')
        rl = [x.strip() for x in regs.split(',')]
        if head.strip() == 'r0' and regstate.get('_base70'):
            for i, r in enumerate(rl):
                store_log.append((0x70 + 4 * i, r, regstate.get(r), ins.address))

ADEV = {0x40:'get_supported_devices',0x44:'init_check',0x48:'set_voice_volume',
        0x4c:'set_master_volume',0x50:'get_master_volume',0x54:'set_mode',
        0x58:'set_mic_mute',0x5c:'get_mic_mute',0x60:'get_parameters',
        0x64:'set_parameters',0x68:'get_input_buffer_size',0x6c:'open_output_stream',
        0x70:'close_output_stream',0x74:'open_input_stream',0x78:'close_input_stream',
        0x7c:'dump',0x80:'set_master_mute',0x84:'get_master_mute',
        0x88:'create_audio_patch',0x8c:'release_audio_patch',0x90:'get_audio_port',
        0x94:'set_audio_port_config',0x98:'<unknown_0x98>'}

print("\n=== AUDIO_HW_DEVICE VTABLE ===  (store_log entries=%d)" % len(store_log))
vt = {}
for off, src, val, addr in sorted(store_log, key=lambda t: (t[0], t[1], str(t[2]), t[3])):
    nm = ADEV.get(off, '?0x%x' % off)
    if off in vt: continue
    vt[off] = val
    anchor = ''
    if val is not None and (val & ~1) == (SYM.get('jinju_adev_close_input_stream', 0) & ~1):
        anchor = '   <<< ANCHOR OK (jinju_adev_close_input_stream)'
    if val is None:
        print("  +0x%02x %-24s = <unresolved> (src %s @0x%x)" % (off, nm, src, addr))
    else:
        print("  +0x%02x %-24s = 0x%08x (thumb=%s)%s" % (off, nm, val, bool(val & 1), anchor))

json.dump({'%02x' % k: v for k, v in vt.items()},
          open(r'C:\firmware_temp\spdif_audio_investigation\tools\r2_adev_vtable.json', 'w'), indent=1)
