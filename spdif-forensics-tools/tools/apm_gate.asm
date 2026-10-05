00032d4c  movw      r1, #0x6c6
00032d50  b         #0x32dc2
00032d52  ldr       r5, [pc, #0x10c]
00032d54  add.w     r0, sp, #0x420
00032d58  mov.w     r1, #0x100
00032d5c  mov.w     r2, #0x100
00032d60  mov.w     r6, #0x100
00032d64  add       r5, pc
00032d66  mov       r3, r5
00032d68  bl        #0x25150
00032d6c  cmp.w     r0, #0x100
00032d70  blo       #0x32ddc
00032d72  movw      r1, #0x6c7
00032d76  b         #0x32dc2
00032d78  ldr       r5, [pc, #0xe8]
00032d7a  add.w     r0, sp, #0x420
00032d7e  mov.w     r1, #0x100
00032d82  mov.w     r2, #0x100
00032d86  mov.w     r6, #0x100
00032d8a  add       r5, pc
00032d8c  mov       r3, r5
00032d8e  bl        #0x25150
00032d92  cmp.w     r0, #0x100
00032d96  blo       #0x32ddc
00032d98  mov.w     r1, #0x6c8
00032d9c  b         #0x32dc2
00032d9e  ldr       r5, [pc, #0xc8]
00032da0  add.w     r0, sp, #0x420
00032da4  mov.w     r1, #0x100
00032da8  mov.w     r2, #0x100
00032dac  mov.w     r6, #0x100
00032db0  add       r5, pc
00032db2  mov       r3, r5
00032db4  bl        #0x25150
00032db8  cmp.w     r0, #0x100
00032dbc  blo       #0x32ddc
00032dbe  movw      r1, #0x6c9
00032dc2  strd      r1, r5, [sp]
00032dc6  strd      r0, r6, [sp, #8]
00032dca  movs      r0, #5
00032dcc  ldr       r1, [pc, #0x9c]
00032dce  ldr       r2, [pc, #0xa0]
00032dd0  ldr       r3, [pc, #0xa0]
00032dd2  add       r1, pc
00032dd4  add       r2, pc
00032dd6  add       r3, pc
00032dd8  blx       #0x3d100
00032ddc  add       r5, sp, #0x1c
00032dde  add.w     r1, sp, #0x420
00032de2  mov       r0, r5
00032de4  blx       #0x3d5c0
00032de8  ldr       r6, [sp, #0x1c]
00032dea  mov       r0, r5
00032dec  blx       #0x3d5d0
00032df0  mov       r2, r0
00032df2  mov       r0, r4
00032df4  mov       r1, r6
00032df6  mov.w     r3, #-1
00032dfa  blx       #0x3d5e0
00032dfe  mov       r0, r5
00032e00  blx       #0x3d620
00032e04  ldr.w     r0, [r8]
00032e08  ldr.w     r1, [sp, #0x524]
00032e0c  subs      r0, r0, r1
00032e0e  bne       #0x32e18
00032e10  add.w     sp, sp, #0x528
00032e14  pop.w     {r4, r5, r6, r7, r8, pc}
00032e18  blx       #0x3d210
00032e1c  ldrh      r1, [r6, #0x10]
00032e1e  vsri.32   q9, q11, #2
00032e24  strb      r5, [r1, #0x15]
00032e28  adds      r7, #0x85
00032e2c  strh      r1, [r1, r4]
00032e30  cmp       fp, r4
00032e32  vshr.u64  q11, q14, #2
00032e38  movs      r6, #0xc8
00032e3c  str       r0, [r0, #0x64]
00032e3e  vtbx.8    d19, {d14, d15, d16, d17}, d7
00032e44  strh      r5, [r1, #0x1e]
00032e48  ldrb      r4, [r4, #0x1f]
00032e4c  movs      r5, #0xd5
00032e50  adds      r5, #0xc6
00032e54  ldrb      r1, [r0, #0x1d]
00032e58  strh      r1, [r3, #0x16]
00032e5a  vtbl.8    d21, {d30, d31, fpinst2}, d18
00032e5e  vcvt.f16.u16 q12, q13, #2
00032e64  subs      r6, #0x5e
00032e68  muls      r7, r2, r7