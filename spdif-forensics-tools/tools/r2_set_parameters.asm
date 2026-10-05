;; ==== disasm @0x021bf0  (func 0x021bf0..0x022cd8 <static>) size=0x10e4 ====
0x021bf0: push.w    {r4, r5, r6, r7, r8, sb, sl, fp, lr}
0x021bf4: subw      sp, sp, #0x82c
0x021bf8: mov       fp, r0
0x021bfa: ldr       r0, [pc, #0x31c]  ; lit=0x0001e582 'stream wrapper, dev 0x%x'
0x021bfc: mov       r4, r1
0x021bfe: mov.w     r1, #0x400
0x021c02: add       r0, pc
0x021c04: ldr.w     r8, [r0]
0x021c08: ldr.w     r0, [r8]
0x021c0c: str.w     r0, [sp, #0x828]
0x021c10: add.w     r0, sp, #0x428
0x021c14: blx       #0x3d280  ; -> 0x03d280 
0x021c18: ldr       r1, [pc, #0x300]  ; lit=0xffff8c63
0x021c1a: ldr       r2, [pc, #0x304]  ; lit=0xffff80f0
0x021c1c: movs      r0, #3
0x021c1e: mov       r3, r4
0x021c20: add       r1, pc
0x021c22: add       r2, pc
0x021c24: blx       #0x3d1a0  ; -> 0x03d1a0 
0x021c28: mov       r0, r4
0x021c2a: blx       #0x3d290  ; -> 0x03d290 
0x021c2e: mov       r6, r0
0x021c30: blx       #0x3d3d0  ; -> 0x03d3d0 
0x021c34: mov       r7, r0
0x021c36: cmp       r6, #0
0x021c38: beq.w     #0x21da5
0x021c3c: cmp       r7, #0
0x021c3e: beq.w     #0x21da5
0x021c42: ldr       r1, [pc, #0x2e0]  ; lit=0xffff7c02
0x021c44: add.w     r2, sp, #0x428
0x021c48: mov       r0, r6
0x021c4a: mov.w     r3, #0x400
0x021c4e: movw      r4, #0x3590
0x021c52: add       r1, pc
0x021c54: blx       #0x3d2a0  ; -> 0x03d2a0 
0x021c58: mov.w     sl, #0
0x021c5c: cmp       r0, #0
0x021c5e: bmi       #0x21c91
0x021c60: ldr       r0, [pc, #0x2c4]  ; lit=0xffff9457
0x021c62: strb.w    sl, [sp, #0x428]
0x021c66: ldrb.w    r1, [fp, #0x16f]
0x021c6a: ldr       r2, [pc, #0x2c0]  ; lit=0xffff6d03
0x021c6c: add       r0, pc
0x021c6e: cmp       r1, #0
0x021c70: add       r2, pc
0x021c72: it        ne
0x021c74: movne     r2, r0
0x021c76: ldr       r1, [pc, #0x2b8]  ; lit=0xffff7bda
0x021c78: mov       r0, r7
0x021c7a: add       r1, pc
0x021c7c: blx       #0x3d3e0  ; -> 0x03d3e0 
0x021c80: mov       r0, r7
0x021c82: blx       #0x3d3f0  ; -> 0x03d3f0 
0x021c86: mov       r1, r0
0x021c88: movs      r0, #0
0x021c8a: bl        #0x251ad  ; -> 0x0251ad 
0x021c8e: mov       sl, r0
0x021c90: add.w     r0, fp, r4
0x021c94: add.w     r2, sp, #0x428
0x021c98: mov.w     r3, #0x400
0x021c9c: str       r0, [sp, #0x24]
0x021c9e: mov       r0, r6
0x021ca0: ldr       r1, [pc, #0x290]  ; lit=0xffffa7ac
0x021ca2: add       r1, pc
0x021ca4: blx       #0x3d2a0  ; -> 0x03d2a0 
0x021ca8: cmp       r0, #0
0x021caa: bmi.w     #0x21e0d
0x021cae: add       r0, sp, #0x18
0x021cb0: movs      r2, #3
0x021cb2: mov.w     r3, #0x400
0x021cb6: stm.w     r0, {r6, r7, r8}
0x021cba: movs      r0, #0
0x021cbc: add.w     r6, sp, #0x428
0x021cc0: strb.w    r0, [sp, #0x428]
0x021cc4: mov       r0, r6
0x021cc6: ldr       r1, [pc, #0x270]  ; lit=0xffff93f7
0x021cc8: add       r1, pc
0x021cca: blx       #0x3d400  ; -> 0x03d400 
0x021cce: movw      r0, #0x362c
0x021cd2: str.w     fp, [sp, #0x14]
0x021cd6: mov.w     r8, #0
0x021cda: add       fp, r0
0x021cdc: add       r0, sp, #0x28
0x021cde: ldr       r4, [pc, #0x25c]  ; lit=0xffff6c93
0x021ce0: adds      r5, r0, #6
0x021ce2: add       r4, pc
0x021ce4: add.w     r0, r8, r8, lsl #2
0x021ce8: ldrb.w    r0, [fp, r0]
0x021cec: cmp       r0, #0
0x021cee: beq       #0x21d99
0x021cf0: mov       r0, r8
0x021cf2: blx       #0x3d410  ; -> 0x03d410 
0x021cf6: blx       #0x3d420  ; -> 0x03d420 
0x021cfa: mov       sb, r0
0x021cfc: mov       r0, r6
0x021cfe: mov.w     r1, #0x400
0x021d02: blx       #0x3d430  ; -> 0x03d430 
0x021d06: add       r0, sb
0x021d08: adds      r0, #1
0x021d0a: cmp.w     r0, #0x400
0x021d0e: bhs       #0x21dbf
0x021d10: mov       r0, r6
0x021d12: mov       r1, r4
0x021d14: movs      r2, #1
0x021d16: mov.w     r3, #0x400
0x021d1a: blx       #0x3d400  ; -> 0x03d400 
0x021d1e: mov       r0, r8
0x021d20: blx       #0x3d410  ; -> 0x03d410 
0x021d24: mov       r7, r0
0x021d26: mov       r0, r8
0x021d28: blx       #0x3d410  ; -> 0x03d410 
0x021d2c: blx       #0x3d420  ; -> 0x03d420 
0x021d30: mov       r2, r0
0x021d32: mov       r0, r6
0x021d34: mov       r1, r7
0x021d36: mov.w     r3, #0x400
0x021d3a: blx       #0x3d400  ; -> 0x03d400 
0x021d3e: cmp.w     r8, #0xa
0x021d42: bne       #0x21d99
0x021d44: ldrb.w    r0, [fp, #0x36]
0x021d48: lsls      r0, r0, #0x1f
0x021d4a: beq       #0x21d99
0x021d4c: mov       r0, r5
0x021d4e: movw      r1, #0x3fa
0x021d52: blx       #0x3d440  ; -> 0x03d440 
0x021d56: movw      r0, #0x736f
0x021d5a: mov.w     r1, #0x400
0x021d5e: strh.w    r0, [sp, #0x2c]
0x021d62: movw      r0, #0x613b
0x021d66: movt      r0, #0x6d74
0x021d6a: str       r0, [sp, #0x28]
0x021d6c: add       r0, sp, #0x28
0x021d6e: blx       #0x3d430  ; -> 0x03d430 
0x021d72: mov       r7, r0
0x021d74: mov       r0, r6
0x021d76: mov.w     r1, #0x400
0x021d7a: blx       #0x3d430  ; -> 0x03d430 
0x021d7e: add       r0, r7
0x021d80: movs      r1, #0
0x021d82: cmp.w     r1, r0, lsr #10
0x021d86: bne       #0x21dbf
0x021d88: ldr       r1, [pc, #0x1b4]  ; lit=0xffffab8d
0x021d8a: mov       r0, r6
0x021d8c: movs      r2, #6
0x021d8e: mov.w     r3, #0x400
0x021d92: add       r1, pc
0x021d94: blx       #0x3d400  ; -> 0x03d400 
0x021d98: add.w     r8, r8, #1
0x021d9c: cmp.w     r8, #0xf
0x021da0: bne       #0x21ce5
0x021da2: b         #0x21dd3  ; -> 0x021dd3 
0x021da4: ldr       r1, [pc, #0x19c]  ; lit=0xffff58cf
0x021da6: ldr       r2, [pc, #0x1a0]  ; lit=0xffff7032
0x021da8: ldr       r3, [pc, #0x1a0]  ; lit=0xffff7f62
0x021daa: movs      r0, #6
0x021dac: add       r1, pc
0x021dae: add       r2, pc
0x021db0: add       r3, pc
0x021db2: blx       #0x3d100  ; -> 0x03d100 
0x021db6: mov.w     sl, #0
0x021dba: b.w       #0x22bf7
0x021dbe: str       r6, [sp]
0x021dc0: movs      r0, #5
0x021dc2: ldr       r1, [pc, #0x18c]  ; lit=0xffff58b3
0x021dc4: ldr       r2, [pc, #0x18c]  ; lit=0xffff6777
0x021dc6: ldr       r3, [pc, #0x190]  ; lit=0xffff7f46
0x021dc8: add       r1, pc
0x021dca: add       r2, pc
0x021dcc: add       r3, pc
0x021dce: blx       #0x3d100  ; -> 0x03d100 
0x021dd2: ldr       r1, [pc, #0x188]  ; lit=0xffff6b95
0x021dd4: add.w     r4, sp, #0x428
0x021dd8: movs      r2, #1
0x021dda: mov.w     r3, #0x400
0x021dde: mov       r0, r4
0x021de0: add       r1, pc
0x021de2: blx       #0x3d400  ; -> 0x03d400 
0x021de6: ldr       r1, [pc, #0x178]  ; lit=0xffffa662
0x021de8: ldr       r7, [sp, #0x1c]
0x021dea: mov       r2, r4
0x021dec: add       r1, pc
0x021dee: mov       r0, r7
0x021df0: blx       #0x3d3e0  ; -> 0x03d3e0 
0x021df4: mov       r0, r7
0x021df6: blx       #0x3d3f0  ; -> 0x03d3f0 
0x021dfa: mov       r1, r0
0x021dfc: mov       r0, sl
0x021dfe: bl        #0x251ad  ; -> 0x0251ad 
0x021e02: ldr.w     r8, [sp, #0x20]
0x021e06: ldrd      fp, r6, [sp, #0x14]
0x021e0a: mov       sl, r0
0x021e0c: ldr       r1, [pc, #0x154]  ; lit=0xffff92ad
0x021e0e: add.w     r2, sp, #0x428
0x021e12: mov       r0, r6
0x021e14: mov.w     r3, #0x400
0x021e18: add       r1, pc
0x021e1a: blx       #0x3d2a0  ; -> 0x03d2a0 
0x021e1e: cmp       r0, #0
0x021e20: bmi       #0x21ecd
0x021e22: ldr       r0, [sp, #0x24]
0x021e24: movs      r1, #0
0x021e26: strb.w    r1, [sp, #0x428]
0x021e2a: ldr       r0, [r0]
0x021e2c: cmp       r0, #0
0x021e2e: beq       #0x21eaf
0x021e30: ldr       r2, [r0, #0x58]
0x021e32: str       r1, [sp, #0x28]
0x021e34: add       r1, sp, #0x28
0x021e36: blx       r2
0x021e38: ldr       r0, [sp, #0x28]
0x021e3a: movw      r1, #0xab01
0x021e3e: subs      r1, r0, r1
0x021e40: cmp       r1, #1
0x021e42: bhi       #0x21e9b
0x021e44: str       r0, [sp]
0x021e46: add.w     r4, sp, #0x428
0x021e4a: mov.w     r1, #0x400
0x021e4e: mov.w     r2, #0x400
0x021e52: mov.w     sb, #0x400
0x021e56: ldr       r5, [pc, #0x110]  ; lit=0xffff2ddd
0x021e58: mov       r0, r4
0x021e5a: add       r5, pc
0x021e5c: mov       r3, r5
0x021e5e: bl        #0x25151  ; -> 0x025151 
0x021e62: cmp.w     r0, #0x400
0x021e66: blo       #0x21e87  ; -> 0x021e87 
0x021e68: movw      r1, #0xc05
0x021e6c: strd      r1, r5, [sp]
0x021e70: strd      r0, sb, [sp, #8]
0x021e74: movs      r0, #5
0x021e76: ldr       r1, [pc, #0xf4]  ; lit=0xffff57ff
0x021e78: ldr       r2, [pc, #0xf4]  ; lit=0xffff749b
0x021e7a: ldr       r3, [pc, #0xf8]  ; lit=0xffff7e92
0x021e7c: add       r1, pc
0x021e7e: add       r2, pc
0x021e80: add       r3, pc
0x021e82: blx       #0x3d100  ; -> 0x03d100 
0x021e86: str       r4, [sp]
0x021e88: ldr       r3, [sp, #0x28]
0x021e8a: movs      r0, #2
0x021e8c: ldr       r1, [pc, #0xe8]  ; lit=0xffffa5cd
0x021e8e: ldr       r2, [pc, #0xec]  ; lit=0xffff7e80
0x021e90: add       r1, pc
0x021e92: add       r2, pc
0x021e94: blx       #0x3d1a0  ; -> 0x03d1a0 
0x021e98: b         #0x21eaf  ; -> 0x021eaf 
0x021e9a: str       r0, [sp]
0x021e9c: movs      r0, #6
0x021e9e: ldr       r1, [pc, #0xe0]  ; lit=0xffff57d7
0x021ea0: ldr       r2, [pc, #0xe0]  ; lit=0xffff2d94
0x021ea2: ldr       r3, [pc, #0xe4]  ; lit=0xffff7e6a
0x021ea4: add       r1, pc
0x021ea6: add       r2, pc
0x021ea8: add       r3, pc
0x021eaa: blx       #0x3d100  ; -> 0x03d100 
0x021eae: ldr       r1, [pc, #0xdc]  ; lit=0xffff920f
0x021eb0: add.w     r2, sp, #0x428
0x021eb4: mov       r0, r7
0x021eb6: add       r1, pc
0x021eb8: blx       #0x3d3e0  ; -> 0x03d3e0 
0x021ebc: mov       r0, r7
0x021ebe: blx       #0x3d3f0  ; -> 0x03d3f0 
0x021ec2: mov       r1, r0
0x021ec4: mov       r0, sl
0x021ec6: bl        #0x251ad  ; -> 0x0251ad 
0x021eca: mov       sl, r0
0x021ecc: ldr       r1, [pc, #0xc0]  ; lit=0xffff3ea2
0x021ece: add.w     r2, sp, #0x428
0x021ed2: mov       r0, r6
0x021ed4: mov.w     r3, #0x400
0x021ed8: add       r1, pc
0x021eda: blx       #0x3d2a0  ; -> 0x03d2a0 
0x021ede: cmp       r0, #0
0x021ee0: bmi.w     #0x22003
0x021ee4: movs      r0, #0
0x021ee6: strb.w    r0, [sp, #0x428]
0x021eea: ldr       r0, [sp, #0x24]
0x021eec: ldr       r0, [r0]
0x021eee: cmp       r0, #0
0x021ef0: beq       #0x21f99
0x021ef2: ldr       r4, [pc, #0xa0]  ; lit=0xffff7490
0x021ef4: add.w     r0, sp, #0x428
0x021ef8: mov.w     r1, #0x400
0x021efc: mov.w     r2, #0x400
0x021f00: mov.w     r5, #0x400
0x021f04: add       r4, pc
0x021f06: mov       r3, r4
0x021f08: bl        #0x25151  ; -> 0x025151 
0x021f0c: cmp.w     r0, #0x400
0x021f10: blo       #0x21fe5  ; -> 0x021fe5 
0x021f12: movw      r1, #0xc19
0x021f16: b         #0x21fcb  ; -> 0x021fcb 
0x021f18: b         #0x21a21  ; -> 0x021a21 
0x021f1a: movs      r1, r0
0x021f1c: ldrh      r3, [r4, #0x22]
0x021f1e: vshr.u64  q12, q8, #1
0x021f22: vdup.8    d23, d2[7]
Traceback (most recent call last):
  File "C:\firmware_temp\spdif_audio_investigation\tools\r2_funcs.py", line 138, in <module>
    dis(va, size)
    ~~~^^^^^^^^^^
  File "C:\firmware_temp\spdif_audio_investigation\tools\r2_funcs.py", line 90, in dis
    t = ins.operands
        ^^^^^^^^^^^^
  File "C:\Users\k0994\.workbuddy-ai\binaries\python\envs\default\Lib\site-packages\capstone\__init__.py", line 792, in __getattr__
    raise CsError(CS_ERR_SKIPDATA)
capstone.CsError: Information irrelevant for 'data' instruction in SKIPDATA mode (CS_ERR_SKIPDATA)
