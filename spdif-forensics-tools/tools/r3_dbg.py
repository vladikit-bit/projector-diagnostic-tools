import sys
sys.path.insert(0, '.')
from elfx import ELF
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
from capstone.arm import ARM_OP_IMM

E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
code = E.d[T['off']:T['off'] + T['size']]
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True

n = 0; bl = 0
seen = {}
for ins in md.disasm(code, T['addr']):
    n += 1
    if ins.mnemonic in ('bl','blx','b','b.w','bx'):
        bl += 1
        for op in ins.operands:
            if op.type == ARM_OP_IMM:
                seen.setdefault(op.imm & 0xFFFFFFFF, []).append(ins.address)
print("instructions:", n, " branches:", bl, " distinct targets:", len(seen))
print("0x328d0 in targets?", 0x328d0 in seen, seen.get(0x328d0))
print("0x328d1 in targets?", 0x328d1 in seen, seen.get(0x328d1))
print("0x322d4 in targets?", 0x322d4 in seen, seen.get(0x322d4))
print("0x322d5 in targets?", 0x322d5 in seen, seen.get(0x322d5))
