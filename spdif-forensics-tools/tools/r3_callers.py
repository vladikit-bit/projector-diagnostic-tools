import sys, struct
sys.path.insert(0, '.')
from elfx import ELF
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
from capstone.arm import ARM_OP_IMM, ARM_INS_BL, ARM_INS_BLX, ARM_INS_B

E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
code = E.d[T['off']:T['off'] + T['size']]

md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
md.detail = True
md.skipdata = True

targets = {0x0322d4: "dump-dispatcher", 0x0328d0: "mi_getCodecType"}
# Thumb targets carry bit0 set
wanted = set()
for t in targets:
    wanted.add(t); wanted.add(t | 1)

hits = {t: [] for t in targets}
for ins in md.disasm(code, T['addr']):
    if ins.id not in (ARM_INS_BL, ARM_INS_BLX, ARM_INS_B):
        continue
    if ins.cc != 0 and ins.cc != 14:
        continue
    for op in ins.operands:
        if op.type == ARM_OP_IMM:
            tgt = op.imm & 0xFFFFFFFF
            if tgt in wanted:
                base = tgt & ~1
                kind = {ARM_INS_BL: 'bl', ARM_INS_BLX: 'blx', ARM_INS_B: 'b'}[ins.id]
                hits[base].append((ins.address, kind, tgt, ins.mnemonic + ' ' + ins.op_str))

for t, name in targets.items():
    print(f"\n=== callers / branches to 0x{t:06x}  ({name}) ===")
    if not hits[t]:
        print("  (none found by direct branch)")
    for a, k, tgt, txt in sorted(hits[t]):
        print(f"  @0x{a:06x}  {k:3s} -> 0x{tgt:06x}   {txt}")
