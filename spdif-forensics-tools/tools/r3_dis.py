import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
start, end = int(sys.argv[1], 16), int(sys.argv[2], 16)
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True
md.disasm(E.d[T['off'] + start - T['addr']: T['off'] + end - T['addr']], start | 1)
off = T['off'] + start - T['addr']
n = end - start
for ins in md.disasm(E.d[off:off+n], start | 1):
    extra = ""
    if ins.mnemonic == 'ldr' and '[pc' in ins.op_str:
        try:
            imm = int(ins.op_str.split('#')[1].split(']')[0], 16)
            lv = ((ins.address + 4) & ~3) + imm
            o = E.va2off(lv)
            if o:
                w = struct.unpack_from('<I', E.d, o)[0]
                extra = f"   ; lit 0x{w:08x}"
                if 0x1000 < w < 0x60000:
                    s = E.d[E.va2off(w):]
                    s = s[:s.find(b'\0')]
                    if 0 < len(s) < 80:
                        extra += f"  '{s.decode('latin1')}'"
        except Exception:
            pass
    print(f"0x{ins.address & ~1:06x}: {ins.mnemonic:8s} {ins.op_str}{extra}")
