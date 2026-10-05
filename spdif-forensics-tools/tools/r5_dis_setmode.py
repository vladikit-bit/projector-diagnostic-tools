#!/usr/bin/env python3
"""R5 Phase C: full disassembly of mik.ko::_MI_AOUT_SetHdmiAutoMode.
Highlights capability-bit tests (tst #imm), r5/r6 assignments, branches,
and any print / MApi_AUDIO_SPDIF_SetMode calls. Runs on the ACTIVE module."""
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection
from capstone import *

PATH = r'C:/firmware_temp/spdif_audio_investigation/libs/mik_dts_hdmienable.ko'
FUNC_VA = 0x989cc
MAXLEN = 0x1400

# CEA-861 SAD format code -> bit position (established in earlier phase)
BITS = {0x4: 'AC3 (SAD 0x02)', 0x80: 'DTS core (SAD 0x07)',
        0x400: 'E-AC3/DD+ (SAD 0x0A)', 0x800: 'DTS-HD (SAD 0x0B)',
        0x1000: 'MLP/TrueHD (SAD 0x0C)'}


def load(path):
    f = open(path, 'rb'); e = ELFFile(f)
    secs = list(e.iter_sections()); syms = []; strs = {}
    for s in secs:
        if isinstance(s, SymbolTableSection):
            for sym in s.iter_symbols():
                if sym['st_value']:
                    strs[sym['st_value']] = sym.name
                if sym['st_info']['type'] == 'STT_FUNC' and sym['st_value']:
                    syms.append((sym['st_value'], sym['st_size'], sym.name))
    syms.sort()
    return f, secs, syms, strs


def va2off(secs, va):
    for s in secs:
        if s['sh_type'] == 'SHT_PROGBITS' and s['sh_addr'] <= va < s['sh_addr'] + s['sh_size']:
            return s['sh_offset'] + (va - s['sh_addr'])
    return None


def main():
    f, secs, syms, strs = load(PATH)
    # report symbols bracketing the function
    print('=== symbols around 0x%x ===' % FUNC_VA)
    for a, sz, n in syms:
        if FUNC_VA - 0x2000 <= a <= FUNC_VA + 0x800:
            print('  0x%08x size=0x%-6x %s%s' % (a, sz, n, '   <== TARGET' if a == FUNC_VA else ''))

    off = va2off(secs, FUNC_VA)
    f.seek(off); data = f.read(MAXLEN)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM); md.skipdata = True

    # collect labels = branch targets inside window
    insns = list(md.disasm(data, FUNC_VA))
    targets = set()
    for i in insns:
        if i.mnemonic in ('b', 'bx', 'bl', 'blx', 'beq', 'bne', 'blo', 'bhi',
                          'bcs', 'bcc', 'bmi', 'bpl', 'bvs', 'bvc', 'bls', 'bge', 'blt', 'bgt', 'ble'):
            for op in i.operands:
                if op.type == 2:  # ARM_OP_IMM
                    if FUNC_VA <= op.imm < FUNC_VA + MAXLEN:
                        targets.add(op.imm)

    print()
    print('=' * 90)
    print('mik.ko::_MI_AOUT_SetHdmiAutoMode  (ACTIVE module %s)' % PATH.split('/')[-1])
    print('VA 0x%x .. ~0x%x   (%d instructions)' % (FUNC_VA, FUNC_VA + MAXLEN, len(insns)))
    print('=' * 90)
    prev = None
    for i in insns:
        lbl = 'L%08x:' % i.address if i.address in targets else ''
        note = ''
        m = i.mnemonic
        # capability bit tests
        if m == 'tst':
            for op in i.operands:
                if op.type == 2 and op.imm in BITS:
                    note = '   <<< CAP BIT 0x%x = %s' % (op.imm, BITS[op.imm])
                elif op.type == 2:
                    note = '   ; tst mask 0x%x' % op.imm
        # r5/r6 writes
        if m == 'mov' and i.op_str.startswith(('r5,', 'r6,', 'r4,')):
            note += '   <<< %s' % i.op_str
        if m in ('movw', 'movt'):
            note = ''
        if m.startswith('bl'):
            note += '   [CALL]'
        if lbl:
            print()
            print('%s' % lbl)
        print('  0x%08x: %-8s %-9s %-30s%s' %
              (i.address, i.bytes.hex(), m, i.op_str, note))
        # stop at a likely function end (pop {..pc} / bx lr after N instrs)
        if m in ('bx',) and i.op_str == 'lr' and i.address > FUNC_VA + 0x20:
            pass
    print()
    print('=== branch-target labels seen: %d ===' % len(targets))


main()
