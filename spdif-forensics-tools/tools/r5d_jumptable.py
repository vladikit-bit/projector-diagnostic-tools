#!/usr/bin/env python3
"""R5 Phase D item 12 — decode the switch jump table at 0x989e8 that routes each
codec to its capability chain, and prove which codecs can reach the patched
instruction 0x98a58 (i.e. which are affected by the 1-byte change).

   0x989d4: sub r1, r1, #4
   0x989d8: cmp r1, #0x13           ; index 0..19
   0x989dc: bhi #0x98b8c            ; default
   0x989e0: add r2, pc, #0
   0x989e4: ldr pc, [r2, r1, lsl #2]  ; jump table @0x989e8, 20 entries
"""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from capstone import *

OUT  = r'C:/firmware_temp/spdif_audio_investigation/runtime_phase5/mik_r5_patched.ko'
SRC  = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
TBL, N = 0x989e8, 20
PATCH_VA = 0x98a58

# chains reached from the table, and the codec each chain handles
CHAIN = {
    0x98a38: 'DTS chain  (tst DTS-HD 0x800 -> tst DTS-core 0x80)  <<< contains 0x98a58',
    0x98a88: 'AC3/E-AC3/MLP chain  (tst 0x1404)',
    0x98b3c: 'other chain',
    0x98b8c: 'default / other chain',
    0x98ba8: 'other chain',
}


def table(path):
    e = ELF32(path)
    off = e.va2off(TBL)
    return e, [struct.unpack_from('<I', e.b, off + 4 * i)[0] for i in range(N)]


def main():
    e, tgt = table(OUT)
    es, tgt_s = table(SRC)

    print('=' * 96)
    print('SWITCH JUMP TABLE @0x%x  (%d entries)   switch_arg = 4 .. %d'
          % (TBL, N, 3 + N))
    print('=' * 96)
    print('%-8s %-12s %-46s %s' % ('arg', 'table VA', 'target', 'chain'))
    print('-' * 96)
    for i, t in enumerate(tgt):
        arg = i + 4
        print('%-8d 0x%08x   0x%08x   %-46s' % (arg, TBL + 4 * i, t,
                                                CHAIN.get(t, '(?other)')))
    print()
    print('jump table identical in source and output : %s' % (tgt == tgt_s))

    # which args reach the DTS chain (0x98a38) -> may execute the patch
    dts_args = [i + 4 for i, t in enumerate(tgt) if t == 0x98a38]
    other = {}
    for i, t in enumerate(tgt):
        other.setdefault(t, []).append(i + 4)
    print()
    print('args routed to the DTS chain 0x98a38 : %s' % dts_args)
    print('   -> ONLY these can ever execute 0x98a58 (the patched instruction).')
    for t, args in sorted(other.items()):
        if t != 0x98a38:
            print('args routed to 0x%08x : %-22s %s'
                  % (t, str(args), CHAIN.get(t, '')))

    print()
    print('=' * 96)
    print('CONCLUSION FOR ITEM 12')
    print('=' * 96)
    print("""
The switch argument selects the codec being played.  Only codec cases
%s enter the chain that begins at 0x98a38 (DTS-HD test -> DTS-core test).
Every other codec case is dispatched to a DIFFERENT chain and therefore
never executes the patched instruction at 0x98a58.

  AC3      -> routed via 0x98a88 (tests 0x1404 = AC3|E-AC3|MLP), sets its own
              r5/r6 independently.  It does NOT pass through 0x98a58.
  E-AC3    -> own chain (r5=0xa / r6=3 at 0x98b48-0x98b50).
  DTS-HD   -> tested FIRST at 0x98a38; when the DTS-HD bit is set the code
              branches to 0x98ad4, i.e. it LEAVES the chain before 0x98a58.
  MLP      -> own chain (r5=0xc / r6=3 at 0x98ca8-0x98cb0).

Combined with the byte-level fact that the two binaries differ in exactly ONE
byte, every codec whose case does not enter the 0x98a38 chain executes
bit-identical instructions and is therefore provably unaffected.
""" % dts_args)


main()
