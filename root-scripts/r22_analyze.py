#!/usr/bin/env python3
"""R22 offline analysis: parse r22_cap.sh dm.txt captures into a three-way timeline.
Usage:
  r22_analyze.py <capturedir>            # single capture: timeline + transition detection
  r22_analyze.py <ac3real> <dtsreal> <dtsprobe7>   # three-way comparison
Each capturedir must contain dm.txt (and optionally kernel.log, logcat.txt).
"""
import re, sys, os

BLOCK = list(range(0x4f0f, 0x4f19))   # 0x4f0f..0x4f18
IEC   = list(range(0x0900, 0x0911))    # 0x0900..0x0910
DECLO, DECHI = 0x0fe0, 0x10d0

def parse_cap(d):
    path = os.path.join(d, 'dm.txt')
    samples = []
    cur = None
    with open(path) as f:
        for line in f:
            line = line.rstrip()
            m = re.match(r'=== T(\d+)s (\S+) ([\d:]+) ===', line)
            if m:
                if cur: samples.append(cur)
                cur = {'elapsed': int(m.group(1)), 'phase': m.group(2),
                       'wall': m.group(3), 'vals': {}}
                continue
            if line.startswith('-- R'):  # region header, ignore
                continue
            if not line.strip():
                continue
            mm = re.search(r'DM\[0x([0-9a-fA-F]+)\]\s*=\s*0x([0-9a-fA-F]+)', line)
            if mm:
                cur['vals'][int(mm.group(1), 16)] = int(mm.group(2), 16)
    if cur: samples.append(cur)
    return samples

def block_nonzero(s):
    return any(s['vals'].get(a, 0) != 0 for a in BLOCK)

def e3_in_block(s):
    # the Kodi real-DTS-passthrough signature value 0xe30000 in the 0x4f0f-0x4f18 block
    return any(s['vals'].get(a, 0) == 0xe30000 for a in BLOCK)

def iec_active(s):
    return s['vals'].get(0x0900, 0) != 0

def dec_active(s):
    return any(s['vals'].get(a, 0) != 0 for a in range(DECLO, DECHI + 1))

def summarize(name, samples):
    print("="*70)
    print("CAPTURE: %s   (%d samples)" % (name, len(samples)))
    print("="*70)
    print("%-5s %-10s %-8s %-8s %-8s %-8s" % ("T(s)", "phase", "DEC", "IEC61937", "4f0fblk", "e30000"))
    for s in samples:
        print("%-5d %-10s %-8s %-8s %-8s %-8s" % (
            s['elapsed'], s['phase'],
            "ON" if dec_active(s) else "-",
            "ON" if iec_active(s) else "-",
            "ON" if block_nonzero(s) else "-",
            "ON" if e3_in_block(s) else "-"))
    # first event times
    t_dec = next((s['elapsed'] for s in samples if dec_active(s)), None)
    t_iec = next((s['elapsed'] for s in samples if iec_active(s)), None)
    t_4f  = next((s['elapsed'] for s in samples if block_nonzero(s)), None)
    t_e3  = next((s['elapsed'] for s in samples if e3_in_block(s)), None)
    print("\nFIRST EVENT TIMES (relative to capture start):")
    print("  DEC active (decoder running) :", t_dec)
    print("  IEC61937 active (0x0900!=0)  :", t_iec)
    print("  0x4f0f-0x4f18 block nonzero   :", t_4f)
    print("  0x4f0f-0x4f18 == 0xe30000     :", t_e3, "(Kodi real-DTS signature)")
    if t_4f is not None and t_iec is not None:
        rel = t_4f - t_iec
        print("  -> 4f0f block vs IEC61937: %+ds (negative = before IEC61937)" % rel)
    if t_e3 is not None and t_iec is not None:
        print("  -> 0xe30000 vs IEC61937  : %+ds" % (t_e3 - t_iec))
    if t_e3 is not None and t_dec is not None:
        print("  -> 0xe30000 vs DEC start  : %+ds" % (t_e3 - t_dec))
    # show actual block values at first nonzero + steady
    fn = next((s for s in samples if block_nonzero(s)), None)
    if fn:
        print("\n  first nonzero block values (T%d):" % fn['elapsed'])
        for a in BLOCK:
            print("    0x%04x = 0x%06x" % (a, fn['vals'].get(a, 0)))
    print()
    return {'name': name, 't_dec': t_dec, 't_iec': t_iec, 't_4f': t_4f,
            't_e3': t_e3, 'samples': samples}

def threeway(a, b, c):
    A = summarize(a, parse_cap(a))
    B = summarize(b, parse_cap(b))
    C = summarize(c, parse_cap(c))
    print("#"*70)
    print("THREE-WAY TIMELINE (first-event times; None = never)")
    print("#"*70)
    hdr = "%-22s %8s %8s %8s" % ("path", "DEC", "IEC", "4f0f")
    print(hdr)
    for X in (A, B, C):
        print("%-22s %8s %8s %8s" % (
            X['name'],
            str(X['t_dec']), str(X['t_iec']), str(X['t_4f'])))
    # classification hints (focus on the 0xe30000 Kodi-DTS signature)
    print("\nCLASSIFICATION HINTS (0xe30000 = Kodi real-DTS signature):")
    if B['t_e3'] is None:
        print("  DTS real: 0xe30000 NEVER appears -> R22-C (transient/profile-specific; discard block)")
    elif B['t_iec'] is not None and B['t_e3'] < B['t_iec']:
        print("  DTS real: 0xe30000 BEFORE IEC61937 -> R22-A (upstream output-profile config)")
    elif B['t_iec'] is not None and B['t_e3'] > B['t_iec']:
        print("  DTS real: 0xe30000 AFTER IEC61937 -> R22-B (downstream/output state)")
    elif B['t_iec'] is not None and B['t_e3'] == B['t_iec']:
        print("  DTS real: 0xe30000 WITH IEC61937 -> simultaneous w/ output state")
    if A['t_e3'] is None and C['t_e3'] is None and B['t_e3'] is not None:
        print("  0xe30000 is DTS-real-specific (absent in AC3 real and DTS probe7)")
    if C['t_e3'] is None and C['t_4f'] is not None:
        print("  probe7 DTS block=%0x5b (NOT 0xe30000) -> 0xe30000 is Kodi-path-specific" % 0x5b)
    print()

if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) == 1:
        summarize(args[0], parse_cap(args[0]))
    elif len(args) == 3:
        threeway(*args)
    else:
        print(__doc__)
        sys.exit(2)
