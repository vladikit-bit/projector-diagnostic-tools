import struct, re, os, sys
from elftools.elf.elffile import ELFFile

KO = 'kmods/utpa2k.ko'
elf = ELFFile(open(KO, 'rb'))
secs = list(elf.iter_sections())
symtab = elf.get_section_by_name('.symtab')

imgs = {}
for sym in symtab.iter_symbols():
    if sym.name in ('mst_codec_r2', 'mst_codec_r2_MS12V22',
                    'mst_snd_r2', 'mst_snd_r2_MS12V22'):
        shndx = sym['st_shndx']
        sec = secs[shndx]
        fo = sec['sh_offset'] + sym['st_value']
        imgs[sym.name] = (fo, sym['st_size'], sec.name, sym['st_value'])
        print(f"{sym.name:26s} st_value {sym['st_value']:#010x} size {sym['st_size']:#010x} "
              f"sec {sec.name} sec_off {sec['sh_offset']:#x} -> file {fo:#010x}")

blob = open(KO, 'rb').read()
os.makedirs('r2img', exist_ok=True)
for nm, (fo, sz, secn, sv) in imgs.items():
    open(f'r2img/{nm}.bin', 'wb').write(blob[fo:fo+sz])
    print(f"wrote r2img/{nm}.bin ({sz:#x} bytes)")

def strings(data, minlen=6):
    return set(m.group().decode('ascii') for m in re.finditer(rb'[ -~]{%d,}' % minlen, data))

sets = {}
for nm in imgs:
    d = open(f'r2img/{nm}.bin', 'rb').read()
    sets[nm] = strings(d)
    print(f"{nm}: {len(sets[nm])} strings")

pairs = [('mst_codec_r2', 'mst_codec_r2_MS12V22'),
         ('mst_snd_r2', 'mst_snd_r2_MS12V22')]
for a, b in pairs:
    only_a = sets[a] - sets[b]
    only_b = sets[b] - sets[a]
    print(f"\n==== {a} ONLY ({len(only_a)}) vs {b} ONLY ({len(only_b)}) ====")
    def dump(s, title):
        print(f"---- {title} ({len(s)}) ----")
        for x in sorted(s):
            print("   ", x[:110])
    dump(only_a, f"ONLY in {a}")
    dump(only_b, f"ONLY in {b}")
