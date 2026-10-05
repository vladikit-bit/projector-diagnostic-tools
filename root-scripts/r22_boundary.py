#!/usr/bin/env python3
"""R22 boundary diff: find the audio-path transaction present in REAL Kodi DTS passthrough
but ABSENT in probe7 (which drives the MI decoder directly and bypasses AudioTrack/HAL).

Usage: r22_boundary.py <real_dir> <probe7_dir>
  real_dir / probe7_dir each contain logcat.txt and/or kernel.log (and optionally kernfull.txt).

Strategy:
  - Match only BOUNDARY-layer lines (AudioTrack/AudioFlinger/HAL/MI_AUDIO/spdif/passthrough/offload...).
  - Preserve original order so the open transaction sequence is visible.
  - Set-diff to find lines/types UNIQUE to real Kodi DTS (the R22-D target).
  - Categorize unique-real lines by subsystem (Android AudioTrack, HAL, MI_AUDIO kernel, spdif).
  - Bonus: extract the real-DTS kernel open transaction from kernfull.txt (MI_AUDIO_Start/Write/Open, SetMode).
"""
import sys, os, re

# boundary-layer match: the userspace->kernel path, not generic decoder chatter
BOUNDARY_RE = re.compile(
    r'(AudioTrack|AudioFlinger|audio_hw|HAL_AUDIO|utpa2k|spdif|SPDIF|'
    r'passthrough|PassThrough|pass[- ]?through|SetMode|SetOutputType|'
    r'offload|NonPCM|nonpcm|MI_AO|MI_AI|MI_AUDIO|'
    r'IEC61937|burst|Packer|encoder|createTrack|getOutput|setParameters|'
    r'AudioPolicyManager|AudioSystem|openOutput|startOutput)',
    re.IGNORECASE)

# categorize a boundary line into a subsystem
def categorize(line):
    l = line.lower()
    if 'audiotrack' in l or 'audioflinger' in l or 'audiopolicymanager' in l or 'audiosystem' in l or 'createtrack' in l or 'getoutput' in l or 'openoutput' in l or 'startoutput' in l:
        return 'ANDROID-AUDIO'
    if 'audio_hw' in l or 'hal_audio' in l or 'utpa2k' in l or 'setparameters' in l or 'setmode' in l or 'setoutputtype' in l or 'passthrough' in l or 'offload' in l or 'nonpcm' in l:
        return 'AUDIO-HAL'
    if 'mi_audio' in l or 'mi_ao' in l or 'mi_ai' in l:
        return 'MI_AUDIO-KERNEL'
    if 'spdif' in l or 'iec61937' in l or 'burst' in l or 'packer' in l or 'encoder' in l:
        return 'SPDIF-OUT'
    return 'OTHER'

LOGCAT_TS = re.compile(r'^\d\d-\d\d \d\d:\d\d:\d\d\.\d+\s+[VDIWEF]/')
# this device emits: "MM-DD HH:MM:SS.mmm  D/Tag(PID): message"
LOGCAT_TAGMSG = re.compile(r'^\d\d-\d\d \d\d:\d\d:\d\d\.\d+\s+[VDIWEF]/([A-Za-z0-9_]+)\(\s*\d+\):\s*(.*)$')

def load_logcat(path):
    """Return list of (tag, message) for boundary-relevant logcat lines, in order."""
    if not os.path.exists(path):
        return []
    out = []
    with open(path, errors='ignore') as f:
        for line in f:
            line = line.rstrip('\n')
            m = LOGCAT_TAGMSG.match(line)
            if not m:
                continue
            tag, msg = m.group(1), m.group(2)
            if BOUNDARY_RE.search(tag + ' ' + msg):
                out.append((tag, msg.strip()))
    return out

def load_kernel(path):
    """Return list of (ts, message) for boundary-relevant kernel lines, in order.
    Kernel lines look like: [12345.678] TAG: message  or  <6> TAG: message"""
    if not os.path.exists(path):
        return []
    out = []
    with open(path, errors='ignore') as f:
        for line in f:
            line = line.rstrip('\n')
            if BOUNDARY_RE.search(line):
                out.append(line.strip())
    return out

def main():
    real_dir, probe7_dir = sys.argv[1], sys.argv[2]
    # ---------- logcat symmetric diff (both runs have logcat.txt) ----------
    rl = load_logcat(os.path.join(real_dir, 'logcat.txt'))
    pl = load_logcat(os.path.join(probe7_dir, 'logcat.txt'))
    rl_set = set((t, m) for t, m in rl)
    pl_set = set((t, m) for t, m in pl)
    only_real = [(t, m) for (t, m) in rl if (t, m) not in pl_set]
    only_probe = [(t, m) for (t, m) in pl if (t, m) not in rl_set]

    print("=" * 78)
    print("BOUNDARY DIFF: logcat.txt   REAL Kodi DTS vs probe7")
    print("=" * 78)
    print("REAL Kodi DTS boundary lines total : %d" % len(rl))
    print("probe7        boundary lines total : %d" % len(pl))
    print("UNIQUE to REAL Kodi DTS (type+msg) : %d" % len(only_real))
    print("UNIQUE to probe7           (type+msg) : %d" % len(only_probe))
    print()
    # categorize unique-real
    cats = {}
    for t, m in only_real:
        cats.setdefault(categorize(m), 0)
        cats[categorize(m)] += 1
    print("UNIQUE-to-REAL by subsystem:")
    for c, n in sorted(cats.items(), key=lambda x: -x[1]):
        print("   %-16s %d" % (c, n))
    print()
    print("--- REAL Kodi DTS boundary lines IN ORDER (first 80; shows open transaction) ---")
    seen = set()
    shown = 0
    for t, m in rl:
        key = (t, m)
        if key in seen:
            continue
        seen.add(key)
        if key in pl_set:
            continue  # not unique to real
        print("   [%s] %s" % (t, m[:150]))
        shown += 1
        if shown >= 80:
            break
    print()

    # ---------- bonus: real-DTS kernel open transaction from kernfull.txt ----------
    kf = os.path.join(real_dir, 'kernfull.txt')
    if os.path.exists(kf):
        kl = load_kernel(kf)
        print("=" * 78)
        print("REAL Kodi DTS KERNEL OPEN TRANSACTION (kernfull.txt) -- %d boundary lines" % len(kl))
        print("=" * 78)
        for l in kl[:60]:
            print("   " + l[:170])
        print()
    else:
        print("(no kernfull.txt in real_dir; kernel open transaction not captured in this run)")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print(__doc__); sys.exit(2)
    main()
