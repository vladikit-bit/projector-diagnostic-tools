import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
code = E.d[T['off']:T['off'] + T['size']]
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True

ldrs = []   # (addr, reg, literal_va)
adds = []   # (addr, reg)
for ins in md.disasm(code, T['addr']):
    t = ins.op_str.replace(' ', '')
    if ins.mnemonic == 'ldr' and '[pc,' in t and '#' in t:
        try:
            imm = int(t.split('#')[1].split(']')[0], 16)
        except Exception:
            continue
        litva = ((ins.address + 4) & ~3) + imm
        ldrs.append((ins.address, t.split(',')[0], litva))
    elif ins.mnemonic == 'add' and t.endswith(',pc'):
        adds.append((ins.address, t.split(',')[0]))

print(f"ldr pc-relative: {len(ldrs)}   add rX,pc: {len(adds)}")

# build map reg -> sorted ldr list
from collections import defaultdict
L = defaultdict(list)
for a, r, lv in ldrs:
    L[r].append((a, lv))
for r in L:
    L[r].sort()

WANT = 0x322d5
print(f"\n=== PC-delta literal sites whose computed target == 0x{WANT:06x} (adev_dump Thumb ptr) ===")
hits = []
for A, R in adds:
    for a, lv in L.get(R, []):
        if a <= A <= a + 64:
            off = E.va2off(lv)
            if off is None:
                continue
            W = struct.unpack_from('<I', E.d, off)[0]
            tgt = (W + (A + 4)) & 0xFFFFFFFF
            if tgt == WANT:
                hits.append((a, A, R, lv, W))
for a, A, R, lv, W in hits:
    print(f"  ldr @0x{a:06x} {R}, lit VA 0x{lv:06x} = 0x{W:08x} ; add @0x{A:06x} {R},pc  -> 0x{WANT:06x}")
if not hits:
    print("  none")
