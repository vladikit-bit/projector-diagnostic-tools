#!/usr/bin/env python3
"""R5 Phase D — minimal experimental patch: BUILD + FULL VERIFICATION.

Single intended change (from the CURRENTLY DEPLOYED mik_dts_hdmienable.ko):
    VA 0x98a58 / file offset 0x9b54c
    OLD: 00 60 a0 e3   mov r6, #0
    NEW: 01 60 a0 e3   mov r6, #1
Forces the compressed-output branch (r4=2 -> MApi_AUDIO_SPDIF_SetMode(2))
when the DTS-core EDID capability bit (0x80) is absent.

NOTHING is deployed. Device untouched.
"""
import os, sys, hashlib, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from forensic_elf import ELF32

BASE = r'C:/firmware_temp/spdif_audio_investigation'
SRC  = BASE + r'/libs/mik_dts_hdmienable.ko'          # = currently deployed mik.ko
PRIS = BASE + r'/kmods/mik.ko'                        # pristine factory module
OUT  = BASE + r'/runtime_phase5/mik_r5_patched.ko'    # experimental output
UTPA = BASE + r'/libs/utpa2k_expB.ko'                 # Exp-B (reference, read-only)
UTPA_ONDEV_MD5 = '4c5e6fbb'                           # on-device Exp-B prefix (R4/R5)

OFF     = 0x9b54c
OLD_B4  = bytes.fromhex('0060a0e3')
NEW_B4  = bytes.fromhex('0160a0e3')
VA      = 0x98a58
MONITOR_OFF = 0x9a334          # existing hdmienable MonitorTask patch (bne -> nop)


def h(b):
    return hashlib.md5(b).hexdigest(), hashlib.sha256(b).hexdigest()


def sec(title):
    print('\n' + '=' * 78)
    print(title)
    print('=' * 78)


def main():
    src  = open(SRC,  'rb').read()
    pris = open(PRIS, 'rb').read()

    src_md5, src_sha = h(src)

    sec('1. SOURCE (base = currently deployed mik_dts_hdmienable)')
    print('file      : %s' % os.path.basename(SRC))
    print('path      : %s' % SRC)
    print('size      : %d bytes (0x%x)' % (len(src), len(src)))
    print('MD5       : %s' % src_md5)
    print('SHA-256   : %s' % src_sha)

    # ---- build -------------------------------------------------------------
    if len(src) != len(pris):
        sys.exit('FATAL: source and pristine differ in size')
    out = bytearray(src)

    sec('3-6. PATCH SITE')
    print('file offset : 0x%x' % OFF)
    print('VA          : 0x%x' % VA)
    print('OLD bytes   : %s  (%s)' % (src[OFF:OFF+4].hex(), OLD_B4.hex()))
    print('NEW bytes   : %s  (%s)' % (NEW_B4.hex(), NEW_B4.hex()))

    assert src[OFF:OFF+4] == OLD_B4, \
        'FATAL: expected OLD instruction %s at 0x%x, found %s' % (
            OLD_B4.hex(), OFF, src[OFF:OFF+4].hex())
    out[OFF] = 0x01                       # single byte: 00 -> 01

    out = bytes(out)
    open(OUT, 'wb').write(out)
    out_md5, out_sha = h(out)

    sec('2. OUTPUT (experimental)')
    print('file      : %s' % os.path.basename(OUT))
    print('path      : %s' % OUT)
    print('size      : %d bytes (0x%x)' % (len(out), len(out)))
    print('MD5       : %s' % out_md5)
    print('SHA-256   : %s' % out_sha)

    # ---- 6/7 byte diff -----------------------------------------------------
    sec('6+7. COMPLETE BINARY DIFF — source vs output')
    diffs = [(i, src[i], out[i]) for i in range(len(src)) if src[i] != out[i]]
    print('Total differing bytes : %d' % len(diffs))
    if len(diffs) <= 32:
        print()
        print('%-12s %-6s %-6s %-10s %s' %
              ('offset', 'old', 'new', 'bit', 'byte-in-instr'))
        print('-' * 62)
        for off, o, n in diffs:
            # locate the 4-byte instruction containing this byte
            instr_off = (off // 4) * 4
            idx = off - instr_off
            print('0x%08x  0x%02x   0x%02x    bit%2d      byte %d of %s -> %s' % (
                off, o, n, n ^ o, idx,
                src[instr_off:instr_off+4].hex(), out[instr_off:instr_off+4].hex()))
    else:
        print('!! MORE THAN 32 DIFFERING BYTES - INVESTIGATE')
        for off, o, n in diffs[:64]:
            print('  0x%08x: %02x -> %02x' % (off, o, n))

    assert len(diffs) == 1, 'FATAL: patch changed %d bytes, expected 1' % len(diffs)
    assert out[OFF:OFF+4] == NEW_B4, 'FATAL: new instruction mismatch'
    print('\nRESULT: exactly ONE byte changed (0x9b54c: 0x00 -> 0x01).')

    # ---- 8 MonitorTask patch preserved ------------------------------------
    sec('8. EXISTING hdmienable MonitorTask PATCH AT 0x9a334 — PRESERVED?')
    print('%-22s %-14s %s' % ('variant', 'bytes@0x9a334', 'instruction'))
    print('-' * 62)
    for name, blob in (('pristine kmods/mik.ko', pris),
                       ('base (deployed)', src),
                       ('output (patched)', out)):
        b4 = blob[MONITOR_OFF:MONITOR_OFF+4]
        print('%-22s %-14s %s' % (name, b4.hex(), describe_monitor(b4)))
    ok8 = (out[MONITOR_OFF:MONITOR_OFF+4] == src[MONITOR_OFF:MONITOR_OFF+4]
           and out[MONITOR_OFF:MONITOR_OFF+4] != pris[MONITOR_OFF:MONITOR_OFF+4])
    print()
    print('output == base at 0x9a334      : %s' %
          (out[MONITOR_OFF:MONITOR_OFF+4] == src[MONITOR_OFF:MONITOR_OFF+4]))
    print('output != pristine at 0x9a334  : %s' %
          (out[MONITOR_OFF:MONITOR_OFF+4] != pris[MONITOR_OFF:MONITOR_OFF+4]))
    print('=> MonitorTask patch PRESERVED : %s' % ok8)
    assert ok8, 'FATAL: MonitorTask patch not preserved'

    # ---- 9 pre-existing changes preserved ---------------------------------
    sec('9. ALL PRE-EXISTING (pristine -> deployed) DELTAS PRESERVED?')
    pre = [(i, pris[i], src[i]) for i in range(len(pris)) if pris[i] != src[i]]
    print('pristine -> deployed base : %d differing byte(s)' % len(pre))
    for off, o, n in pre:
        print('   0x%08x: %02x -> %02x' % (off, o, n))
    lost = [off for off, o, n in pre if out[off] != n]
    print()
    print('deltas lost in output     : %d' % len(lost))
    for off in lost:
        print('   LOST at 0x%08x' % off)
    print('=> all pre-existing deltas intact : %s' % (not lost))
    assert not lost, 'FATAL: lost pre-existing delta(s)'

    # superset check: pristine->output diffs must equal pre + the one new byte
    allout = [(i, pris[i], out[i]) for i in range(len(pris)) if pris[i] != out[i]]
    expected = set(off for off, o, n in pre) | {OFF}
    got = set(off for off, o, n in allout)
    print('pristine -> output total diffs     : %d' % len(allout))
    print('expected (pre-existing + 1 new)    : %d' % len(expected))
    print('sets identical                     : %s' % (expected == got))
    assert expected == got, 'FATAL: output is not a clean superset'
    print('=> output = deployed base + exactly the 1 intended new byte.')

    # ---- 9b Exp-B untouched ----------------------------------------------
    sec('9b. Exp-B (utpa2k.ko) UNTOUCHED')
    print('This patch touches ONLY mik.ko. Exp-B lives in utpa2k.ko and is a')
    print('DIFFERENT module; no byte of it is read or written by this script.')
    for p in (UTPA, BASE + '/libs/utpa2k.ko', BASE + '/kmods/utpa2k.ko'):
        if os.path.exists(p):
            m, s = h(open(p, 'rb').read())
            tag = '  <<< Exp-B' if m.startswith(UTPA_ONDEV_MD5) else ''
            print('  %-42s md5 %s%s' % (os.path.basename(p), m, tag))
    print('  on-device utpa2k.ko (R5 verified) md5 %s...  [UNCHANGED - not touched]'
          % UTPA_ONDEV_MD5)

    # ---- 10 ELF / module sanity ------------------------------------------
    sec('10. ELF / MODULE SANITY — output binary')
    sanity(SRC, src, OUT, out)

    print('\n\n' + '#' * 78)
    print('PATCH BUILD + BYTE-LEVEL VERIFICATION: PASS')
    print('  source md5 : %s' % src_md5)
    print('  output md5 : %s' % out_md5)
    print('  changed    : 1 byte  (0x9b54c: 00 -> 01)')
    print('NOT DEPLOYED. Device untouched.')
    print('#' * 78)


def describe_monitor(b4):
    if b4.hex() == '0000a0e1':
        return 'nop (mov r0,r0)  [PATCHED]'
    return '(branch/other)  [pristine]'


def sanity(spath, src, opath, out):
    ok = True
    def chk(label, cond, detail=''):
        nonlocal ok
        ok = ok and cond
        print('  [%s] %-42s %s' % ('OK ' if cond else 'FAIL', label, detail))

    for name, b in (('source', src), ('output', out)):
        print('\n-- %s --' % name)
        chk('magic \\x7fELF', b[:4] == b'\x7fELF', b[:4].hex())
        chk('EI_CLASS = ELFCLASS32', b[4] == 1, str(b[4]))
        chk('EI_DATA  = ELFDATA2LSB', b[5] == 1, str(b[5]))
        chk('EI_VERSION = 1', b[6] == 1, str(b[6]))
        e_type, e_machine = struct.unpack_from('<HH', b, 0x10)
        chk('e_type = ET_REL (1) = relocatable .ko', e_type == 1, str(e_type))
        chk('e_machine = EM_ARM (40)', e_machine == 40, str(e_machine))
        e_shoff, = struct.unpack_from('<I', b, 0x20)
        e_shentsize, = struct.unpack_from('<H', b, 0x2e)
        e_shnum, = struct.unpack_from('<H', b, 0x30)
        e_shstrndx, = struct.unpack_from('<H', b, 0x32)
        chk('e_shoff sane (< filesize)', 0 < e_shoff < len(b), hex(e_shoff))
        chk('e_shnum > 0', e_shnum > 0, str(e_shnum))
        chk('e_shentsize = 40', e_shentsize == 40, str(e_shentsize))
        chk('e_shstrndx < e_shnum', e_shstrndx < e_shnum, str(e_shstrndx))
        # every section must fit inside the file (non-NOBITS)
        bad = []
        for i in range(e_shnum):
            o = e_shoff + i * e_shentsize
            (nm, typ, flags, addr, off, size, link, info, al, en) = \
                struct.unpack_from('<10I', b, o)
            if typ != 8 and off + size > len(b):      # 8 = SHT_NOBITS
                bad.append((i, off, size))
        chk('all non-NOBITS sections in-bounds', not bad, str(bad[:3]))
        chk('file size unchanged', len(b) == len(src), '%d' % len(b))

        # ELF32 object via the project parser (proves sections parse)
        e = ELF32(spath if name == 'source' else opath)
        t = e.sec('.text')
        chk('.text present', t is not None,
            'addr=0x%x size=0x%x off=0x%x' % (t['addr'], t['size'], t['off']))
        # patch VA must live inside .text
        chk('patch VA 0x%x inside .text' % VA,
            t['addr'] <= VA < t['addr'] + t['size'],
            'delta +0x%x' % (VA - t['addr']))
        chk('patch file offset inside .text',
            t['off'] <= OFF < t['off'] + t['size'],
            'delta +0x%x' % (OFF - t['off']))
        chk('VA<->offset mapping consistent (unlinked .ko: addr=0)',
            e.va2off(VA) == OFF,
            'va2off(0x%x)=0x%x' % (VA, e.va2off(VA)))
        # modinfo / vermagic intact
        mi = e.sec('.modinfo')
        chk('.modinfo present (module metadata intact)', mi is not None,
            'size=0x%x' % (mi['size'] if mi else 0))
        if mi is not None:
            blob = e.b[mi['off']:mi['off'] + mi['size']]
            chk('.modinfo contains "vermagic="', b'vermagic=' in blob)
            chk('.modinfo blob byte-identical to source',
                blob == src[mi['off']:mi['off'] + mi['size']])
        # relocation sections intact (kernel must still link the module)
        for sn in ('.rel.text', '.rel.data', '.rel.rodata',
                   '.rel__mcount_loc', '.rel.gnu.linkonce.this_module'):
            s = e.sec(sn)
            if s is not None:
                blob = e.b[s['off']:s['off'] + s['size']]
                chk('.%s intact' % sn.lstrip('.'),
                    blob == src[s['off']:s['off'] + s['size']],
                    'size=0x%x' % s['size'])

    print('\n  OVERALL ELF/MODULE SANITY: %s' % ('PASS' if ok else 'FAIL'))
    return ok


main()
