===== libs/libaudioparser.so dts_parser_write @ 0xc2b4 size 0x8c =====
0000c2b4  push.w    {r4, r5, r6, r7, r8, lr}
0000c2b8  sub       sp, #8
0000c2ba  cbz       r0, #0xc302
0000c2bc  mov       r6, r0
0000c2be  ldr       r0, [r0, #0x38]
0000c2c0  cbz       r0, #0xc30c
0000c2c2  mov       r5, r1
0000c2c4  ldr.w     r1, [r6, #0x8c]
0000c2c8  ldrd      r7, r8, [sp, #0x20]
0000c2cc  mov       r4, r2
0000c2ce  cbz       r1, #0xc2e8
0000c2d0  ldr       r1, [r6, #0x48]
0000c2d2  ldr       r0, [r0, #0x14]
0000c2d4  cmp       r0, r1
0000c2d6  bls       #0xc2e8
0000c2d8  mov       r0, r6
0000c2da  blx       #0xf860
0000c2de  cmp       r0, #0
0000c2e0  bmi       #0xc2e8
0000c2e2  movs      r0, #0
0000c2e4  str.w     r0, [r6, #0x8c]
0000c2e8  strd      r7, r8, [sp]
0000c2ec  movs      r0, #2
0000c2ee  mov       r2, r5
0000c2f0  mov       r3, r4
0000c2f2  ldr       r1, [pc, #0x48]  pool=-0x7baa
0000c2f4  add       r1, pc  ; "ptr(%p) size(0x%x) pts(%lld)"
0000c2f6  blx       #0xf630
0000c2fa  movs      r0, #0
0000c2fc  add       sp, #8
0000c2fe  pop.w     {r4, r5, r6, r7, r8, pc}
0000c302  ldr       r1, [pc, #0x24]  pool=-0x85e0
0000c304  ldr       r2, [pc, #0x24]  pool=-0xa39c
0000c306  add       r1, pc
0000c308  add       r2, pc  ; "%s parser is null"
0000c30a  b         #0xc314
0000c30c  ldr       r1, [pc, #0x24]  pool=-0x85ea
0000c30e  ldr       r2, [pc, #0x28]  pool=-0x962a
0000c310  add       r1, pc  ; "dts_parser"
0000c312  add       r2, pc
0000c314  ldr       r3, [pc, #0x18]  pool=-0x96a4
0000c316  movs      r0, #6
0000c318  add       r3, pc  ; "dts_parser_write"
0000c31a  blx       #0xf670
0000c31e  mvn       r0, #2
0000c322  add       sp, #8
0000c324  pop.w     {r4, r5, r6, r7, r8, pc}
0000c328  ldrb      r0, [r4, #8]

