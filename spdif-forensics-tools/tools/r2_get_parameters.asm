;; ==== disasm @0x02072c  (func 0x02072c..0x021bf0 <static>) size=0x14c0 ====
0x02072c: push.w    {r4, r5, r6, r7, r8, sb, sl, fp, lr}
0x020730: subw      sp, sp, #0x43c
0x020734: mov       r5, r0
0x020736: ldr       r0, [pc, #0x38c]  ; lit=0x0001fa46
0x020738: mov       r4, r1
0x02073a: mov.w     r1, #0x400
0x02073e: add       r0, pc
0x020740: ldr.w     sb, [r0]
0x020744: ldr.w     r0, [sb]
0x020748: str.w     r0, [sp, #0x438]
0x02074c: add       r0, sp, #0x38
0x02074e: blx       #0x3d280  ; -> 0x03d280 
0x020752: movs      r0, #0
0x020754: mov       r3, r4
0x020756: str       r0, [sp, #0x24]
0x020758: movs      r0, #3
0x02075a: ldr       r1, [pc, #0x36c]  ; lit=0xffff6f51
0x02075c: ldr       r6, [pc, #0x36c]  ; lit=0xffffdb8e
0x02075e: add       r6, pc
0x020760: add       r1, pc
0x020762: mov       r2, r6
0x020764: blx       #0x3d1a0  ; -> 0x03d1a0 
0x020768: cbz       r5, #0x207db
0x02076a: mov       r0, r4
0x02076c: blx       #0x3d290  ; -> 0x03d290 
0x020770: cbz       r0, #0x207e3
0x020772: ldr       r1, [pc, #0x35c]  ; lit=0xffff8650
0x020774: add       r2, sp, #0x38
0x020776: mov.w     r3, #0x400
0x02077a: mov       r8, r0
0x02077c: add       r1, pc
0x02077e: blx       #0x3d2a0  ; -> 0x03d2a0 
0x020782: cmp       r0, #0
0x020784: bmi       #0x207fd
0x020786: movs      r6, #0
0x020788: strb.w    r6, [sp, #0x2c]
0x02078c: str       r6, [sp, #0x28]
0x02078e: str       r6, [sp, #0x18]
0x020790: add       r0, sp, #0x38
0x020792: ldr       r1, [pc, #0x340]  ; lit=0xffffd5cc
0x020794: add       r1, pc
0x020796: blx       #0x3d2b0  ; -> 0x03d2b0 
0x02079a: cmp       r0, #0
0x02079c: beq       #0x20851
0x02079e: add       r4, sp, #0x28
0x0207a0: ldr       r6, [pc, #0x334]  ; lit=0xffffd5bc
0x0207a2: movs      r7, #0
0x0207a4: add       r6, pc
0x0207a6: blx       #0x3d2c0  ; -> 0x03d2c0 
0x0207aa: strb      r0, [r4, r7]
0x0207ac: movs      r0, #0
0x0207ae: mov       r1, r6
0x0207b0: blx       #0x3d2b0  ; -> 0x03d2b0 
0x0207b4: cbz       r0, #0x207bf
0x0207b6: adds      r1, r7, #1
0x0207b8: cmp       r7, #4
0x0207ba: mov       r7, r1
0x0207bc: blo       #0x207a7  ; -> 0x0207a7 
0x0207be: ldrb.w    r1, [sp, #0x29]
0x0207c2: ldrb.w    r0, [sp, #0x28]
0x0207c6: ldrb.w    r2, [sp, #0x2a]
0x0207ca: ldrb.w    r3, [sp, #0x2b]
0x0207ce: cmp       r1, #0
0x0207d0: it        ne
0x0207d2: movne     r1, #1
0x0207d4: ldrb.w    r6, [sp, #0x2c]
0x0207d8: b         #0x20859  ; -> 0x020859 
0x0207da: mvn       r5, #0x15
0x0207de: b.w       #0x21a55
0x0207e2: ldr       r1, [pc, #0x2f8]  ; lit=0xffff6e91
0x0207e4: ldr       r2, [pc, #0x2f8]  ; lit=0xffff85cc
0x0207e6: ldr       r3, [pc, #0x2fc]  ; lit=0xffffdafe
0x0207e8: movs      r0, #6
0x0207ea: add       r1, pc
0x0207ec: add       r2, pc
0x0207ee: add       r3, pc
0x0207f0: blx       #0x3d100  ; -> 0x03d100 
0x0207f4: mvn       r5, #0xb
0x0207f8: b.w       #0x21a55
0x0207fc: ldr       r1, [pc, #0x2e8]  ; lit=0xffff5b77
0x0207fe: add       r2, sp, #0x38
0x020800: mov       r0, r8
0x020802: mov.w     r3, #0x400
0x020806: movw      r7, #0x361c
0x02080a: add       r1, pc
0x02080c: blx       #0x3d2a0  ; -> 0x03d2a0 
0x020810: cmp       r0, #0
0x020812: bmi       #0x208c3
0x020814: add       r0, sp, #0x38
0x020816: ldr       r1, [pc, #0x2d4]  ; lit=0xffffad8f
0x020818: movs      r2, #8
0x02081a: add       r1, pc
0x02081c: blx       #0x3d2d0  ; -> 0x03d2d0 
0x020820: cmp       r0, #0
0x020822: beq       #0x208a9
0x020824: add       r0, sp, #0x38
0x020826: ldr       r1, [pc, #0x2c8]  ; lit=0xffff98e6
0x020828: movs      r2, #7
0x02082a: add       r1, pc
0x02082c: blx       #0x3d2d0  ; -> 0x03d2d0 
0x020830: cmp       r0, #0
0x020832: bne       #0x208c3
0x020834: movw      r0, #0x3594
0x020838: movs      r1, #0
0x02083a: movs      r2, #3
0x02083c: add       r0, r5
0x02083e: ldr.w     r3, [r0, r1, lsl #2]
0x020842: cbz       r3, #0x20849
0x020844: str.w     r2, [r3, #0x204]
0x020848: adds      r1, #1
0x02084a: cmp       r1, #4
0x02084c: bne       #0x2083f
0x02084e: b         #0x208c3  ; -> 0x0208c3 
0x020850: movs      r3, #0
0x020852: movs      r2, #0
0x020854: movs      r1, #0
0x020856: movs      r0, #0
0x020858: add.w     r7, r0, r0, lsl #2
0x02085c: movw      r4, #0x3630
0x020860: str       r0, [sp, #0x18]
0x020862: movw      r0, #0x3584
0x020866: add       r7, r5
0x020868: strb      r6, [r7, r4]
0x02086a: movw      r6, #0x362e
0x02086e: strb      r3, [r7, r6]
0x020870: movw      r3, #0x362d
0x020874: strb      r2, [r7, r3]
0x020876: ldr       r3, [r5, r0]
0x020878: movw      r2, #0x362c
0x02087c: strb      r1, [r7, r2]
0x02087e: cbz       r3, #0x2088d
0x020880: add       r2, sp, #0x18
0x020882: mov       r0, r5
0x020884: movs      r1, #0
0x020886: blx       r3
0x020888: b.w       #0x21a4d
0x02088c: movw      r0, #0x92b
0x020890: str       r0, [sp]
0x020892: ldr       r1, [pc, #0x260]  ; lit=0xffff6de5
0x020894: ldr       r2, [pc, #0x260]  ; lit=0xffff547b
0x020896: add       r1, pc
0x020898: add       r2, pc
0x02089a: ldr       r3, [pc, #0x260]  ; lit=0xffffda4e
0x02089c: movs      r0, #5
0x02089e: add       r3, pc
0x0208a0: blx       #0x3d100  ; -> 0x03d100 
0x0208a4: b.w       #0x21a4d
0x0208a8: movw      r0, #0x3594
0x0208ac: movs      r1, #0
0x0208ae: movs      r2, #2
0x0208b0: add       r0, r5
0x0208b2: ldr.w     r3, [r0, r1, lsl #2]
0x0208b6: cbz       r3, #0x208bd
0x0208b8: str.w     r2, [r3, #0x204]
0x0208bc: adds      r1, #1
0x0208be: cmp       r1, #4
0x0208c0: bne       #0x208b3
0x0208c2: ldr       r1, [pc, #0x23c]  ; lit=0xffffc57e
0x0208c4: add       r2, sp, #0x38
0x0208c6: mov       r0, r8
0x0208c8: mov.w     r3, #0x400
0x0208cc: add.w     sl, r5, r7
0x0208d0: add       r1, pc
0x0208d2: blx       #0x3d2a0  ; -> 0x03d2a0 
0x0208d6: cmp       r0, #0
0x0208d8: bmi       #0x2092d
0x0208da: add       r0, sp, #0x38
0x0208dc: ldr       r1, [pc, #0x224]  ; lit=0xffffacc9
0x0208de: movs      r2, #8
0x0208e0: add       r1, pc
0x0208e2: blx       #0x3d2d0  ; -> 0x03d2d0 
0x0208e6: cbz       r0, #0x20913
0x0208e8: add       r0, sp, #0x38
0x0208ea: ldr       r1, [pc, #0x21c]  ; lit=0xffff9822
0x0208ec: movs      r2, #7
0x0208ee: add       r1, pc
0x0208f0: blx       #0x3d2d0  ; -> 0x03d2d0 
0x0208f4: cbnz      r0, #0x2092d
0x0208f6: movw      r0, #0x35a4
0x0208fa: movs      r1, #0
0x0208fc: movs      r2, #3
0x0208fe: add       r0, r5
0x020900: ldr.w     r3, [r0, r1, lsl #2]
0x020904: cbz       r3, #0x2090b
0x020906: str.w     r2, [r3, #0x180]
0x02090a: adds      r1, #1
0x02090c: cmp       r1, #4
0x02090e: bne       #0x20901
0x020910: b         #0x2092d  ; -> 0x02092d 
0x020912: movw      r0, #0x35a4
0x020916: movs      r1, #0
0x020918: movs      r2, #2
0x02091a: add       r0, r5
0x02091c: ldr.w     r3, [r0, r1, lsl #2]
0x020920: cbz       r3, #0x20927
0x020922: str.w     r2, [r3, #0x180]
0x020926: adds      r1, #1
0x020928: cmp       r1, #4
0x02092a: bne       #0x2091d
0x02092c: ldr       r1, [pc, #0x1dc]  ; lit=0xffffca65
0x02092e: add       r2, sp, #0x38
0x020930: mov       r0, r8
0x020932: mov.w     r3, #0x400
0x020936: add       r1, pc
0x020938: blx       #0x3d2a0  ; -> 0x03d2a0 
0x02093c: cmp       r0, #0
0x02093e: bmi       #0x2096b
0x020940: add       r0, sp, #0x38
0x020942: blx       #0x3d2e0  ; -> 0x03d2e0 
0x020946: mov       r6, r0
0x020948: cmp.w     r0, #0x800
0x02094c: blt       #0x209a1  ; -> 0x0209a1 
0x02094e: beq.w     #0x20a5f
0x020952: cmp.w     r6, #0x40000
0x020956: beq.w     #0x20a67
0x02095a: cmp.w     r6, #0x80000
0x02095e: bne.w     #0x20a77
0x020962: ldr       r1, [pc, #0x1ac]  ; lit=0xffff8e86
0x020964: add       r1, pc
0x020966: b.w       #0x21a43
0x02096a: ldr       r1, [pc, #0x1a8]  ; lit=0xffffca2f
0x02096c: add       r2, sp, #0x38
0x02096e: mov       r0, r8
0x020970: mov.w     r3, #0x400
0x020974: add       r1, pc
0x020976: blx       #0x3d2a0  ; -> 0x03d2a0 
0x02097a: cmp       r0, #0
0x02097c: bmi       #0x209b1
0x02097e: add       r0, sp, #0x38
0x020980: blx       #0x3d2e0  ; -> 0x03d2e0 
0x020984: mov       r3, r0
0x020986: cmp.w     r0, #0x40000
0x02098a: bge       #0x20a4b
0x02098c: cmp       r3, #2
0x02098e: beq.w     #0x20bfb
0x020992: cmp       r3, #8
0x020994: bne.w     #0x20b83
0x020998: ldr       r1, [pc, #0x17c]  ; lit=0xffff9e7e
0x02099a: add       r1, pc
0x02099c: b.w       #0x21a43
0x0209a0: cmp       r6, #2
0x0209a2: beq       #0x20a6f
0x0209a4: cmp       r6, #8
0x0209a6: bne       #0x20a77
0x0209a8: ldr       r1, [pc, #0x170]  ; lit=0xffff538d
0x0209aa: add       r1, pc
0x0209ac: b.w       #0x21a43
0x0209b0: ldr       r1, [pc, #0x16c]  ; lit=0xffff6365
0x0209b2: add       r2, sp, #0x38
0x0209b4: mov       r0, r8
0x0209b6: mov.w     r3, #0x400
0x0209ba: add       r1, pc
0x0209bc: blx       #0x3d2a0  ; -> 0x03d2a0 
0x0209c0: cmp       r0, #0
0x0209c2: bmi       #0x209f9
0x0209c4: add       r0, sp, #0x38
0x0209c6: blx       #0x3d2e0  ; -> 0x03d2e0 
0x0209ca: cmp       r0, #1
0x0209cc: bhi.w     #0x218dd
0x0209d0: movs      r2, #1
0x0209d2: movw      r1, #0x35e4
0x0209d6: strb      r2, [r5, r1]
0x0209d8: movw      r1, #0x35d4
0x0209dc: cmp       r0, #0
0x0209de: strb      r2, [r5, r1]
0x0209e0: movw      r1, #0x35c4
0x0209e4: strb      r2, [r5, r1]
0x0209e6: it        ne
0x0209e8: movne     r0, #1
0x0209ea: strb.w    r0, [r5, #0x170]
0x0209ee: movw      r0, #0x3688
0x0209f2: add       r0, r5
0x0209f4: blx       #0x3d2f0  ; -> 0x03d2f0 
0x0209f8: ldr       r1, [pc, #0x128]  ; lit=0xffff6cb6
0x0209fa: add       r2, sp, #0x38
0x0209fc: mov       r0, r8
0x0209fe: mov.w     r3, #0x400
0x020a02: add       r1, pc
0x020a04: blx       #0x3d2a0  ; -> 0x03d2a0 
0x020a08: movw      r4, #0x6370
0x020a0c: cmp       r0, #0
0x020a0e: movt      r4, #0x6d
0x020a12: bmi.w     #0x20d13
0x020a16: ldr       r0, [sp, #0x38]
0x020a18: cmp       r0, r4
0x020a1a: beq.w     #0x20c8b
0x020a1e: add       r0, sp, #0x38
0x020a20: ldr       r1, [pc, #0x104]  ; lit=0xffff7b16
0x020a22: movs      r2, #7
0x020a24: add       r1, pc
0x020a26: blx       #0x3d2d0  ; -> 0x03d2d0 
0x020a2a: cmp       r0, #0
0x020a2c: beq.w     #0x20cdb
0x020a30: add       r0, sp, #0x38
0x020a32: ldr       r1, [pc, #0xf8]  ; lit=0xffffc98e
0x020a34: movs      r2, #0xa
0x020a36: add       r1, pc
0x020a38: blx       #0x3d2d0  ; -> 0x03d2d0 
0x020a3c: mov.w     fp, #1
0x020a40: cmp       r0, #0
0x020a42: it        eq
0x020a44: moveq.w   fp, #3
0x020a48: b         #0x20cdf  ; -> 0x020cdf 
0x020a4a: beq.w     #0x20c03
0x020a4e: cmp.w     r3, #0x80000
0x020a52: bne.w     #0x20b83
0x020a56: ldr       r1, [pc, #0xd8]  ; lit=0xffff62b2
0x020a58: add       r1, pc
0x020a5a: b.w       #0x21a43
0x020a5e: ldr       r1, [pc, #0xd4]  ; lit=0xffffb979
0x020a60: add       r1, pc
0x020a62: b.w       #0x21a43
0x020a66: ldr       r1, [pc, #0xd0]  ; lit=0xffffcd68
0x020a68: add       r1, pc
0x020a6a: b.w       #0x21a43
0x020a6e: ldr       r1, [pc, #0xcc]  ; lit=0xffff749a
0x020a70: add       r1, pc
0x020a72: b.w       #0x21a43
0x020a76: cmp       r6, #0
0x020a78: bmi       #0x20b51
0x020a7a: ands      r0, r6, #0x380
0x020a7e: beq       #0x20b51
0x020a80: ldr.w     r0, [sl, #0xac]
0x020a84: mov       r3, r6
0x020a86: str       r0, [sp]
0x020a88: movs      r0, #3
0x020a8a: ldr       r1, [pc, #0xb4]  ; lit=0xffffcd57
0x020a8c: ldr       r2, [pc, #0xb4]  ; lit=0xffffd85c
0x020a8e: add       r1, pc
0x020a90: add       r2, pc
0x020a92: blx       #0x3d1a0  ; -> 0x03d1a0 
0x020a96: ldrb.w    r0, [sl, #0xa8]
0x020a9a: cmp       r0, #0
0x020a9c: beq.w     #0x20c91
0x020aa0: ldr.w     r3, [sl, #0xac]
0x020aa4: adds      r0, r3, #1
0x020aa6: str       r0, [sp]
0x020aa8: movs      r0, #3
0x020aaa: ldr       r1, [pc, #0x9c]  ; lit=0xffff4828
0x020aac: ldr       r2, [pc, #0x9c]  ; lit=0xffffd83c
0x020aae: add       r1, pc
0x020ab0: add       r2, pc
0x020ab2: blx       #0x3d1a0  ; -> 0x03d1a0 
0x020ab6: ldr.w     r0, [sl, #0xac]
0x020aba: adds      r0, #1
0x020abc: str.w     r0, [sl, #0xac]
0x020ac0: b.w       #0x21a4d
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
