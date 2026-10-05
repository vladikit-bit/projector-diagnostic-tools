import struct, sys
from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM

KO = 'kmods/utpa2k.ko'
elf = ELFFile(open(KO, 'rb'))
secs = list(elf.iter_sections())
text_idx = [i for i, s in enumerate(secs) if s.name == '.text'][0]
data = bytearray(secs[text_idx].data())
symtab = elf.get_section_by_name('.symtab')
syms2 = {}
for s in symtab.iter_symbols():
    if s.name and s['st_value'] and s['st_info']['type'] == 'STT_FUNC':
        syms2.setdefault(s['st_value'], s.name)
relmap = {}
for s in secs:
    if s.header['sh_type'] in ('SHT_REL',) and s.header['sh_info'] == text_idx:
        for r in s.iter_relocations():
            nm = symtab.get_symbol(r['r_info_sym']).name
            off = r['r_offset']
            if off + 4 > len(data):
                continue
            if nm:
                val = symtab.get_symbol(r['r_info_sym'])['st_value']
                if r['r_info_type'] in (28, 10, 29):
                    w = struct.unpack_from('<I', data, off)[0]
                    imm = w & 0xffffff
                    if imm & 0x800000:
                        imm -= 0x1000000
                    tgt = val + (imm << 2)
                    disp = ((tgt - (off + 8)) >> 2) & 0xffffff
                    struct.pack_into('<I', data, off, (w & 0xff000000) | disp)
                    relmap[off] = "CALL " + nm
                elif r['r_info_type'] == 2:
                    struct.pack_into('<I', data, off, val)
                    relmap[off] = f"={val:#x} {nm}"

md = Cs(CS_ARCH_ARM, CS_MODE_ARM)

def dis(name, base, size, out):
    out.write(f"\n===== {name} @ {base:#x} size {size:#x} =====\n")
    for ins in md.disasm(bytes(data[base:base + size]), base):
        notes = []
        r = relmap.get(ins.address)
        if r:
            notes.append(r)
        if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#'):
            t = int(ins.op_str.lstrip('#'), 0)
            if t in syms2:
                notes.append("CALL " + syms2[t])
        out.write(f"{ins.address:#08x}  {ins.mnemonic:<7} {ins.op_str}" +
                  ("   ; " + " ".join(notes) if notes else "") + "\n")

names = sys.argv[2:] if len(sys.argv) > 2 else [
    'MDrv_AUDIO_Get_AAC_License', 'MDrv_AUDIO_Get_AC3_License',
    'MDrv_AUDIO_Get_AC4_License', 'MDrv_AUDIO_Get_MAT_License',
    'MDrv_AUDIO_Get_DTS_License', 'MDrv_AUDIO_Get_WMA_License',
    'MDrv_AUDIO_Get_DRA_License', 'HAL_AUDIO_CheckHashkeyDone',
    'MDrv_AUDIO_Get_License', 'MDrv_AUDIO_Get_Decoder_Support',
]
out = open(sys.argv[1], 'w')
for nm in names:
    for sym in symtab.iter_symbols():
        if sym.name == nm and sym['st_info']['type'] == 'STT_FUNC':
            dis(nm, sym['st_value'], max(sym['st_size'], 0x40), out)
            break
    else:
        out.write(f"\n===== {nm}: NOT FOUND =====\n")
out.close()
print('done')
