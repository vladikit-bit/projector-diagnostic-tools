#!/usr/bin/env python3
"""R19: per-anchor decoder-type value-flow differential.
For each known 0x81/0x4 materialization, disassemble a wide window, mark every use of the
anchor register, follow the value FORWARD until the register is redefined (consumer chain),
and track the base register BACKWARD. Unknown ops (opXX) are NOT assumed to preserve/move
registers -> chain stops, classified UNRESOLVED. Static only.
"""
import struct, os
os.makedirs("C:/firmware_temp/r19_out", exist_ok=True)
BIN="C:/firmware_temp/spdif_audio_investigation/r8_out/mst_codec_r2_MS12V22.bin"
b=open(BIN,'rb').read();N=len(b)
OPS={0x30:'movhi',0x3f:'ori',0x3b:'ld/st',0x39:'call'}

ANCHORS=[
 (0x1208a0,"0x81",None),
 (0x166f30,"0x4",None),
 (0x166fa0,"0x4",None),
 (0x1674a8,"0x4",None),
 (0x19c148,"0x4",None),
]

def disasm_line(off):
    v=struct.unpack_from('>I',b,off)[0]
    op=v>>26;rD=(v>>21)&0x1f;rA=(v>>16)&0x1f;imm=v&0xffff
    nm=OPS.get(op,'op%02x'%op)
    return off,v,op,rD,rA,imm,nm

def consumer_chain(anchor, reg, maxfwd=800):
    """Follow `reg` forward from anchor+1 until reg is redefined by any op (value destroyed).
    List every instruction that USES reg (rA==reg) before that, plus the redefining insn."""
    chain=[]
    off=anchor+4
    while off+4<=N and len(chain)<maxfwd:
        o2,v,op,rD,rA,imm,nm=disasm_line(off)
        if rD==reg and op not in (0x3f,):  # any write to reg destroys the constant (ori re-ORs, but only imm==0 keeps; treat all writes as end)
            # if it's ori rD==reg, rA==reg, imm==0 -> identity, keep going
            if op==0x3f and rA==reg and imm==0:
                off+=4; continue
            chain.append((o2,v,op,rD,rA,imm,nm,'REDEF(end)'))
            break
        if rA==reg or rD==reg:
            role='USE' if rA==reg else 'DEF'
            chain.append((o2,v,op,rD,rA,imm,nm,role))
        off+=4
    return chain

def base_backward(anchor, basereg, maxback=400):
    """Track `basereg` backward: what last defined it before anchor."""
    res=[]
    off=anchor-4
    while off>=0 and len(res)<maxback:
        o2,v,op,rD,rA,imm,nm=disasm_line(off)
        if rD==basereg:
            res.append((o2,v,op,rD,rA,imm,nm,'LAST-DEF'))
            break
        off-=4
    return res

def window(anchor, half=200):
    lines=[]
    for off in range(anchor-half*4, anchor+half*4, 4):
        if off<0 or off+4>N: continue
        o2,v,op,rD,rA,imm,nm=disasm_line(off)
        mark=' <<<' if off==anchor else ''
        lines.append("  %06x  %08x  %-6s r%-2d,r%-2d,0x%04x%s"%(off,v,nm,rD,rA,imm,mark))
    return lines

out=[]
for (anchor,val,_) in ANCHORS:
    o0,v,op,rD,rA,imm,nm=disasm_line(anchor)
    out.append("\n########## ANCHOR %s @ 0x%06x : %s r%d, r%d, 0x%04x ##########"
               %(val,anchor,nm,rD,rA,imm))
    out.append("anchor dest reg = r%d ; base reg = r%d"%(rD,rA))
    # backward base
    bw=base_backward(anchor, rA)
    out.append("\n-- base reg r%d last defined before anchor --"%rA)
    for x in bw:
        out.append("  %06x %08x %s r%d,r%d,0x%04x %s"%(x[0],x[1],x[2],x[3],x[4],x[5],x[6]))
    if not bw: out.append("  (no def found within 400 insns)")
    # forward consumer chain
    ch=consumer_chain(anchor, rD)
    out.append("\n-- FORWARD consumer chain (r%d) until redefined --"%rD)
    for x in ch:
        out.append("  %06x %08x %-6s r%d,r%d,0x%04x  %s"%(x[0],x[1],x[2],x[3],x[4],x[5],x[6]))
    if not ch: out.append("  (no use before redefinition within window)")
    # wide window
    out.append("\n-- wide window (marked <<< = anchor) --")
    out.extend(window(anchor,200))

txt="\n".join(out)
open("C:/firmware_temp/r19_out/trace.txt","w").write(txt)
print(txt)
