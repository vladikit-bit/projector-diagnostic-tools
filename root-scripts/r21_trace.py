#!/usr/bin/env python3
# R21 static trace: AEON disasm around 0xe30000 materialization / 0x4f17-0x4f1a destination sites
# in mst_snd_r2_MS12V22.bin. Static-first, read-only, no brute-force, unknown ops stay opXX.
import struct, os, sys

BIN = "C:/firmware_temp/spdif_audio_investigation/r8_out/mst_snd_r2_MS12V22.bin"
OUT = "C:/firmware_temp/r21_out/static_trace.txt"
os.makedirs(os.path.dirname(OUT), exist_ok=True)

data = open(BIN, "rb").read()
N = len(data)

def be32(off):
    return struct.unpack(">I", data[off:off+4])[0]

# ---- AEON decode (validated R8/R12/R18/R19/R20) ----
# word = |op(6)|rD(5)|rA(5)|imm16(16)|, big-endian.
KNOWN = {
    0x39: "call",
    0x30: "movhi",
    0x32: "li",     # load / OR-immediate (boot stub "li r25,0xa000" = op 0x32, rA=0)
    0x3f: "ori",
    0x3b: "mem",    # ld/st (mode ambiguous without further ISA knowledge)
}

def decode(off):
    w = be32(off)
    op = (w >> 26) & 0x3F
    rD = (w >> 21) & 0x1F
    rA = (w >> 16) & 0x1F
    immu = w & 0xFFFF
    imms = immu - 0x10000 if (immu & 0x8000) else immu
    return op, rD, rA, imms, immu, w

def dis(off):
    op, rD, rA, imms, immu, w = decode(off)
    name = KNOWN.get(op, "op%02X" % op)
    if op == 0x30:                      # movhi: rD = imm<<16
        return "%08x  %-5s r%d, 0x%x   (rA=%d)" % (w, name, rD, immu, rA)
    if op == 0x32:                      # li / OR-immediate
        if rA == 0:
            return "%08x  %-5s r%d, 0x%x" % (w, name, rD, immu)
        return "%08x  %-5s r%d, r%d, 0x%x  (OR-imm)" % (w, name, rD, rA, immu)
    if op == 0x3f:                      # ori: rD = rA | imm
        return "%08x  %-5s r%d, r%d, 0x%x" % (w, name, rD, rA, immu)
    if op == 0x3b:                      # mem: [rA + imms]
        return "%08x  %-5s r%d, [r%d + 0x%x]  (mem)" % (w, name, rD, rA, imms)
    if op == 0x39:                      # call
        return "%08x  %-5s (r%d + 0x%x)" % (w, name, rA, imms)
    return "%08x  %-5s r%d, r%d, 0x%x" % (w, name, rD, rA, immu)

def window(center, half=40, mark=None, label=""):
    lines = []
    if label:
        lines.append("=== %s (center 0x%x) ===" % (label, center))
    lo = max(0, center - half*4)
    hi = min(N-4, center + half*4)
    lo -= lo % 4
    off = lo
    while off <= hi:
        s = dis(off)
        tag = ""
        if mark and off in mark:
            tag = "   <== " + mark[off]
        lines.append("0x%05x: %s%s" % (off, s, tag))
        off += 4
    return lines

# ---- trace a register forward from `start` until redefined or unknown op ----
def trace_fwd(start, reg):
    out = []
    off = start
    while off + 4 <= N:
        op, rD, rA, imms, immu, w = decode(off)
        if op in (0x30, 0x32, 0x3f):     # known writers of rD
            if rD == reg:
                out.append(("0x%x" % off, dis(off),
                            "REDEF" if off != start else "start"))
                break
            # op reads rA (and rD for ori) - note usage
            if rA == reg or (op in (0x3f, 0x32) and rD == reg):
                out.append(("0x%x" % off, dis(off), "use"))
        elif op == 0x3b:                 # mem: rD=load target, rA=base; could be store(value in rD)
            if rD == reg or rA == reg:
                out.append(("0x%x" % off, dis(off), "mem-use"))
        elif op == 0x39:                 # call may clobber/use
            if rD == reg or rA == reg:
                out.append(("0x%x" % off, dis(off), "call-use"))
        else:
            if rD == reg or rA == reg:
                out.append(("0x%x" % off, dis(off), "UNKNOWN-op"))
                break
        off += 4
        if off - start > 240:  # cap 60 instrs
            break
    return out

lines = []
def L(s): lines.append(s)

L("="*78)
L("R21 static_trace.txt — AEON writer trace of DTS-specific 0xe30000 state in SND DM 0x4f17/0x4f18")
L("binary: %s  size=0x%x (%d)" % (BIN, N, N))
L("ISA: big-endian |op(6)|rD(5)|rA(5)|imm16(16)|; known 0x32 li, 0x30 movhi, 0x3f ori, 0x3b mem, 0x39 call")
L("="*78)

# ---- (1) locate 4-byte literals ----
L("")
L("----------------------------------------------------------------------")
L("(1) 4-byte BE literal scan for 0x00e30000 / 0x00e3e300 / 0x0000e300")
L("----------------------------------------------------------------------")
target_lits = {
    b"\x00\xe3\x00\x00": "0x00e30000",
    b"\x00\xe3\xe3\x00": "0x00e3e300",
    b"\x00\x00\xe3\x00": "0x0000e300",
}
for lit, name in target_lits.items():
    hits = []
    o = data.find(lit)
    while o != -1:
        hits.append(o)
        o = data.find(lit, o+1)
    L("  literal %s (%s): %d hits @ %s" % (name, lit.hex(), len(hits),
                                           ", ".join("0x%x" % h for h in hits[:12])))

# ---- (2) ori immediate census for the destination + value sub-fields ----
L("")
L("----------------------------------------------------------------------")
L("(2) ori immediate census: 0xe300, 0x4f17, 0x4f18, 0x4f19, 0x4f1a")
L("----------------------------------------------------------------------")
ori_targets = {0xe300: "0xe300", 0x4f17: "0x4f17", 0x4f18: "0x4f18",
               0x4f19: "0x4f19", 0x4f1a: "0x4f1a"}
for t, name in ori_targets.items():
    hits = []
    off = 0
    while off + 4 <= N:
        op, rD, rA, imms, immu, w = decode(off)
        if op == 0x3f and immu == t:
            hits.append((off, rD, rA))
        off += 4
    L("  ori imm %s : %d sites" % (name, len(hits)))
    for off, rD, rA in hits:
        L("     0x%05x: ori r%d, r%d, 0x%x" % (off, rD, rA, t))

# ---- (3) windows around the four 0xe300 ori sites (value formation) ----
L("")
L("----------------------------------------------------------------------")
L("(3) WINDOWS @ the four ori 0xe300 sites (value formation 0xe3e300?)")
L("----------------------------------------------------------------------")
e300_sites = [0x0aaa1c, 0x102ae8, 0x171970, 0x199f44]
for s in e300_sites:
    L("")
    for ln in window(s, 36, {s: "ori 0xe300"}, "ori 0xe300 site 0x%x" % s):
        L(ln)
    # trace the value register (rD of the ori) forward & backward
    op, rD, rA, imms, immu, w = decode(s)
    L("  -> rD=r%d formed here (= r%d | 0xe300). Backward def of r%d:" % (rD, rA, rD))
    bo = s - 4
    while bo >= 0:
        bop, brD, brA, bimms, bimmu, bw = decode(bo)
        if bop in (0x30, 0x32, 0x3f) and brD == rD:
            L("      0x%05x: %s   <== last def (r%d)" % (bo, dis(bo), rD))
            break
        bo -= 4
    L("  -> forward use of r%d (until redef / unknown op):" % rD)
    for addr, d, kind in trace_fwd(s, rD):
        L("      0x%s: %s   [%s]" % (addr, d, kind))

# ---- (4) windows around the literal 0x00e30000 + nearby stores ----
L("")
L("----------------------------------------------------------------------")
L("(4) WINDOW @ literal 0x00e30000 (0x154e57) — who loads it?")
L("----------------------------------------------------------------------")
lit_off = data.find(b"\x00\xe3\x00\x00")
L("  literal at 0x%x" % lit_off)
for ln in window(lit_off, 48, {lit_off: "0x00e30000"}, "literal 0x00e30000"):
    L(ln)

# ---- (5) windows around the destination ori sites (0x4f17/0x4f18) ----
L("")
L("----------------------------------------------------------------------")
L("(5) WINDOWS @ ori 0x4f17 / 0x4f18 destination sites")
L("----------------------------------------------------------------------")
dest_sites = {
    0x0b98a4: "ori 0x4f17", 0x0c5800: "ori 0x4f17",
    0x08ea24: "ori 0x4f18(no-op r0,r0)", 0x1085d8: "ori 0x4f18",
    0x0ff230: "ori 0x4f1a", 0x0ff374: "ori 0x4f1a",
}
for s, nm in dest_sites.items():
    L("")
    for ln in window(s, 36, {s: nm}, "%s @ 0x%x" % (nm, s)):
        L(ln)
    op, rD, rA, imms, immu, w = decode(s)
    if rD == 0 and rA == 0:
        L("  (no-op: r0 = r0 | imm)")
        continue
    L("  -> address reg r%d = r%d | 0x%x. Backward def of r%d:" % (rD, rA, immu, rA))
    bo = s - 4
    while bo >= 0:
        bop, brD, brA, bimms, bimmu, bw = decode(bo)
        if bop in (0x30, 0x32, 0x3f) and brD == rA:
            L("      0x%05x: %s   <== last def of base r%d" % (bo, dis(bo), rA))
            break
        bo -= 4
    L("  -> forward use of r%d (address reg) until redef / unknown op:" % rD)
    for addr, d, kind in trace_fwd(s, rD):
        L("      0x%s: %s   [%s]" % (addr, d, kind))

# ---- (6) mem-op census in a band around the destination sites (find stores) ----
L("")
L("----------------------------------------------------------------------")
L("(6) mem (0x3b) ops in +/-64-instr bands around destination ori sites")
L("----------------------------------------------------------------------")
for s, nm in dest_sites.items():
    if rD0 := True:
        op, rD, rA, imms, immu, w = decode(s)
        if rD == 0 and rA == 0:
            continue
    L("  -- band +/-64i around %s @ 0x%x --" % (nm, s))
    lo = max(0, s - 256); hi = min(N-4, s + 256)
    lo -= lo % 4; off = lo
    while off <= hi:
        op, rD, rA, imms, immu, w = decode(off)
        if op == 0x3b:
            mark = "  <== dest-site" if off == s else ""
            L("      0x%05x: %s%s" % (off, dis(off), mark))
        off += 4

open(OUT, "w").write("\n".join(lines))
print("\n".join(lines))
print("\n[written %s]" % OUT)
