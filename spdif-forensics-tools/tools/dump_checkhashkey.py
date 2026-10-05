import struct, sys, bisect
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
FIELDS = [(0x43d, 'F43d'), (0x43e, 'F43e'), (0x440, 'F440'), (0x444, 'F444'),
          (0x4d0, 'F4d0'), (0x4d4, 'F4d4'), (0x4d8, 'F4d8'), (0x57e, 'F57e'),
          (0x57f, 'F57f'), (0x580, 'F580'), (0x581, 'F581'), (0x582, 'F582'),
          (0x503, 'F503'), (0x4c8, 'dbg')]

def dump(name, base, size, out):
    out.write(f"===== {name} @ {base:#x} size {size:#x} ARM (relocs applied) =====\n")
    pend = None
    for ins in md.disasm(bytes(data[base:base + size]), base):
        notes = []
        r = relmap.get(ins.address)
        if r:
            notes.append(r)
        if ins.mnemonic in ('bl', 'blx') and ins.op_str.startswith('#'):
            t = int(ins.op_str.lstrip('#'), 0)
            if t in syms2:
                notes.append("CALL " + syms2[t])
        if ins.mnemonic == 'ldr' and '[pc' in ins.op_str:
            try:
                imm = int(ins.op_str.split('#')[1].rstrip(']'), 0)
                pool = ((ins.address + 8) & ~3) + imm
                rr = relmap.get(pool)
                if rr:
                    notes.append(f"pool@{pool:#x} {rr}")
            except Exception:
                pass
        if ins.mnemonic == 'mov' and ins.op_str.startswith('r0, #'):
            pend = (ins.address, int(ins.op_str.split('#')[1], 0))
        if ins.mnemonic == 'bl' and pend and ins.address == pend[0] + 4 \
                and any('MDrv_AUTH_IPCheck' in n for n in notes):
            notes.append(f"IPID={pend[1]:#x}")
            pend = None
        for off, nm in FIELDS:
            if f', #{off:#x}]' in ins.op_str:
                notes.append(f"<<{nm}>>")
                break
        out.write(f"{ins.address:#08x}  {ins.mnemonic:<7} {ins.op_str}" +
                  ("   ; " + " ".join(notes) if notes else "") + "\n")

if __name__ == '__main__':
    out = open(sys.argv[1] if len(sys.argv) > 1 else 'tools/ut_checkhashkey_full.asm', 'w')
    dump('MDrv_AUDIO_CheckHashkey', 0x423494, 0x16fc, out)
    out.close()
    print('done')
