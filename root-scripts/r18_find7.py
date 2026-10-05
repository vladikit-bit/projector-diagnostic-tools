#!/usr/bin/env python3
"""R18g: register-value propagation reference scanner.
Track each register's 32-bit value through movhi (set upper) and ori (OR low).
Flag any instruction where rD or rA holds a known target string VA. This catches
base-register + split-offset references that a naive movhi+ori pair scan misses.
Static only. Disassembles context around each producer use.
"""
import struct

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"

TARGETS = {
    0x0280f07c: b"r2_decoder_houseKeeping",
    0x0280ea2d: b"decType change",
    0x02813ac5: b"dts m6 hook ok",
    0x02813ad5: b"dts m6 init ok",
    0x02813ae4: b"dts_licensee",
    0x02813af5: b"lbr_licensee",
    0x02813b06: b"xll_licensee",
    0x02813b17: b"transcoder_licensee",
    0x02814c80: b"CPU MS12V2 ddp init ok",
    0x02814c98: b"CPU MS12V2 ddp hook ok",
    0x02814c8b: b"ddp init ok",
}
TOL = 8
def match_target(val):
    for base, lit in TARGETS.items():
        if base <= val <= base + len(lit) + TOL:
            return (base, lit)
    return None

b = open(BIN, 'rb').read()
N = len(b)

insns = []
for off in range(0, N - 4, 4):
    v = struct.unpack_from('>I', b, off)[0]
    op = v >> 26; rD = (v >> 21) & 0x1f; rA = (v >> 16) & 0x1f; imm = v & 0xffff
    insns.append((off, op, rD, rA, imm))
idx = {off: i for i, (off, *_ ) in enumerate(insns)}

OPS = {0x30: 'movhi', 0x3f: 'ori', 0x3b: 'ld/st', 0x39: 'call'}

reg = {}   # r -> 32-bit value or None (unknown)
events = []  # (off, va, lit, role)
for off, op, rD, rA, imm in insns:
    if op == 0x30:
        reg[rD] = (imm << 16) & 0xffffffff
    elif op == 0x3f:
        base = reg.get(rA, 0) if rA in reg and reg.get(rA) is not None else 0
        # if rA unknown but rD==rA and rD known, still OR
        if rA not in reg or reg.get(rA) is None:
            base = reg.get(rD, 0) if (rD in reg and reg.get(rD) is not None) else 0
        reg[rD] = (base | imm) & 0xffffffff
    else:
        reg[rD] = None   # unknown / clobbered
    # flag uses
    for rr in (rD, rA):
        val = reg.get(rr)
        if val is not None:
            mt = match_target(val)
            if mt is not None:
                events.append((off, val, mt[1], 'r%d' % rr, op))

print("=== R18g PRODUCER EVENTS (register-value propagation) ===")
seen = set()
producers = {}
for (off, va, lit, role, op) in events:
    nm = OPS.get(op, 'op%02x' % op)
    key = (off, va)
    if key in seen:
        continue
    seen.add(key)
    print("  0x%06x  %-22r  %s via %s  VA 0x%08x" % (off, lit, nm, role, va))
    producers[off] = (lit, va, nm)

def disasm_around(center, half=40):
    ci = idx.get(center)
    if ci is None:
        return
    lo = max(0, ci - half); hi = min(len(insns), ci + half)
    print("\n--- disasm around 0x%06x (%s) ---" % (center, producers.get(center, ('?', 0))[0]))
    for i in range(lo, hi):
        off, op, rD, rA, imm = insns[i]
        nm = OPS.get(op, 'op%02x' % op)
        mark = ' <<<' if off == center else ''
        print("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"
              % (off, struct.unpack_from('>I', b, off)[0], nm, rD, rA, imm, mark))

for off in producers:
    disasm_around(off)
