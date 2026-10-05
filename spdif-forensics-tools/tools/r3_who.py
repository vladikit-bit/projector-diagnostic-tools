import sys
sys.path.insert(0, '.')
from elfx import ELF
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB
from capstone.arm import ARM_OP_IMM
E = ELF(r"C:/firmware_temp/spdif_audio_investigation/libs/audio.primary.mt5889.so")
T = E.SEC['.text']
code = E.d[T['off']:T['off'] + T['size']]
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB); md.detail = True; md.skipdata = True

want = {int(x,16) for x in sys.argv[1:]}
want |= {v|1 for v in want}
res = {w: [] for w in want}
for ins in md.disasm(code, T['addr']):
    if ins.mnemonic not in ('bl','blx','b','b.w'):
        continue
    for op in ins.operands:
        if op.type == ARM_OP_IMM:
            t = op.imm & 0xFFFFFFFF
            if t in res:
                res[t].append((ins.address, ins.mnemonic))
for w in sorted(res):
    print(f"=== branches to 0x{w & ~1:06x} ===")
    if not res[w]:
        print("   (none)")
    for a, m in res[w]:
        print(f"   @0x{a:06x}  {m}")
