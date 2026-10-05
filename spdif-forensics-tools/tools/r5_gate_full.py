#!/usr/bin/env python3
"""R5 Phase C: full static trace of the EDID-capability -> SPDIF-mode selector
in the ACTIVE mik.ko (mik_dts_hdmienable). Confirms:
  - which capability bit is tested per codec
  - the r5/r6 (compressed-mode) decision
  - that r6 flows into MApi_AUDIO_SPDIF_SetMode / HAL path
Annotated with branch labels and resolved call targets."""
import sys, os, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32
from relocs import Relocs
from capstone import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
# region spanning the unlabeled gap between _MI_AOUT_MonitorTask end and _MI_AOUT_AmpInit
VA0, VA1 = 0x98684, 0x9a7dc

BITS = {0x4: 'AC3(0x02)', 0x80: 'DTS-core(0x07)', 0x400: 'E-AC3(0x0A)',
        0x800: 'DTS-HD(0x0B)', 0x1000: 'MLP(0x0C)', 0x1404: 'AC3|E-AC3|MLP'}


def main():
    e = ELF32(PATH); r = Relocs(e)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.detail = True; md.skipdata = True
    off = e.va2off(VA0)
    data = e.b[off:off + (VA1 - VA0)]
    insns = list(md.disasm(data, VA0))

    # collect intra-region branch targets
    targets = set()
    for i in insns:
        if i.mnemonic in ('b', 'bl', 'bx', 'blx', 'beq', 'bne', 'blo', 'bhi',
                          'bcs', 'bcc', 'bge', 'blt', 'bgt', 'ble',
                          'bpl', 'bmi', 'bvs', 'bvc', 'bhs', 'blo'):
            for op in i.operands:
                if op.type == 2 and VA0 <= op.imm < VA1:
                    targets.add(op.imm)

    print('=== mik.ko EDID-gate selector  VA 0x%x .. 0x%x ===' % (VA0, VA1))
    print('=== (ACTIVE module = mik_dts_hdmienable) ===')
    print('bits: AC3=0x4  DTS-core=0x80  DTS-HD=0x800  E-AC3=0x400  MLP=0x1000')
    print('=' * 100)
    for i in insns:
        lbl = 'L%08x:' % i.address if i.address in targets else ''
        note = ''
        m = i.mnemonic
        if m == 'tst':
            for op in i.operands:
                if op.type == 2 and op.imm in BITS:
                    note = '   <<< CAP BIT 0x%x = %s' % (op.imm, BITS[op.imm])
        if m == 'mov' and i.op_str.strip().startswith(('r5', 'r6', 'r4')):
            note += '   <<< %s' % i.op_str.strip()
        if (m == 'movw' or m == 'movt') and 'r5,' in i.op_str or 'r6,' in i.op_str:
            note += '   <<< %s' % i.op_str
        if m.startswith('bl'):
            tgt = r.call_target(i.address)
            note += '   [-> %s]' % (tgt if tgt else '?')
        if lbl:
            print()
            print(lbl)
        print('  0x%08x: %-8s %-9s %-30s%s' %
              (i.address, i.bytes.hex(), m, i.op_str, note))


main()
