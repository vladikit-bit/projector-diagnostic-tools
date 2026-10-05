===== libs/libaudioparser.so dts_parser_read @ 0xc340 size 0x164 =====
0000c340  push      {r4, r5, r6, r7, lr}
0000c342  sub       sp, #0x14
0000c344  ldr       r1, [pc, #0x128]  pool=-0xa249
0000c346  ldr       r2, [pc, #0x12c]  pool=-0x7bd5
0000c348  mov       r4, r0
0000c34a  movs      r0, #2
0000c34c  mov       r5, r3
0000c34e  add       r1, pc
0000c350  add       r2, pc  ; "dts_parser_read"
0000c352  blx       #0xf630
0000c356  cbz       r4, #0xc374
0000c358  ldr       r7, [r4, #0x38]
0000c35a  cbz       r7, #0xc37e
0000c35c  ldr       r0, [r4, #0x14]
0000c35e  ldr       r2, [r7, #0x14]
0000c360  ldr       r1, [r4, #0x48]
0000c362  subs      r0, r2, r0
0000c364  cmp       r0, r1
0000c366  blo       #0xc36e
0000c368  ldr.w     r0, [r4, #0x8c]
0000c36c  cbz       r0, #0xc39a
0000c36e  mov.w     r6, #-1
0000c372  b         #0xc394
0000c374  ldr       r1, [pc, #0x100]  pool=-0x8652
0000c376  ldr       r2, [pc, #0x104]  pool=-0xa40e
0000c378  add       r1, pc  ; "dts_parser"
0000c37a  add       r2, pc
0000c37c  b         #0xc386
0000c37e  ldr       r1, [pc, #0x104]  pool=-0x865c
0000c380  ldr       r2, [pc, #0x104]  pool=-0x969c
0000c382  add       r1, pc
0000c384  add       r2, pc  ; "%s ringbuffer is null"
0000c386  ldr       r3, [pc, #0xf8]  pool=-0x7c0f
0000c388  movs      r0, #6
0000c38a  add       r3, pc
0000c38c  blx       #0xf670
0000c390  mvn       r6, #2
0000c394  mov       r0, r6
0000c396  add       sp, #0x14
0000c398  pop       {r4, r5, r6, r7, pc}
0000c39a  mov       r0, r4
0000c39c  movs      r1, #0
0000c39e  mov       r2, r4
0000c3a0  movs      r3, #0
0000c3a2  blx       #0xf7d0
0000c3a6  mov       r6, r0
0000c3a8  adds      r0, #4
0000c3aa  beq       #0xc3c4
0000c3ac  adds      r0, r6, #1
0000c3ae  beq       #0xc394
0000c3b0  cbnz      r6, #0xc3ca
0000c3b2  ldr.w     r0, [r4, #0x94]
0000c3b6  cbz       r0, #0xc3fc
0000c3b8  ldrd      r0, r1, [r4, #0x58]
0000c3bc  movs      r6, #0
0000c3be  strd      r0, r1, [r5]
0000c3c2  b         #0xc394
0000c3c4  mvn       r6, #3
0000c3c8  b         #0xc394
0000c3ca  movs      r0, #1
0000c3cc  ldr       r5, [r7, #8]
0000c3ce  str       r0, [r4, #0x14]
0000c3d0  movs      r0, #6
0000c3d2  ldr       r1, [pc, #0xc4]  pool=-0x86b0
0000c3d4  ldr       r2, [pc, #0xc4]  pool=-0x9c01
0000c3d6  add       r1, pc
0000c3d8  add       r2, pc
0000c3da  blx       #0xf670
0000c3de  ldrb      r0, [r5, #1]
0000c3e0  ldrb      r1, [r5, #2]
0000c3e2  ldr.w     r2, [r4, #0xb0]
0000c3e6  ldrb      r3, [r5]
0000c3e8  strd      r0, r1, [sp]
0000c3ec  movs      r0, #2
0000c3ee  ldr       r1, [pc, #0xb0]  pool=-0x90a2
0000c3f0  add       r1, pc  ; "f(%d) d=%x %x %x"
0000c3f2  blx       #0xf630
0000c3f6  mvn       r6, #1
0000c3fa  b         #0xc394
0000c3fc  ldr       r2, [r7, #0x14]
0000c3fe  ldr       r3, [r4, #4]
0000c400  cmp       r3, r2
0000c402  bls       #0xc414
0000c404  ldr       r1, [pc, #0x84]  pool=-0xa3f9
0000c406  movs      r0, #2
0000c408  add       r1, pc  ; "level size(0x%x) < frame size(0x%x)"
0000c40a  blx       #0xf630
0000c40e  mov.w     r6, #-1
0000c412  b         #0xc394
0000c414  ldr       r2, [r4]
0000c416  movw      r0, #0x10dc
0000c41a  add       r0, r4
0000c41c  cmp       r2, #0
0000c41e  it        ne
0000c420  strne     r2, [r0]
0000c422  it        eq
0000c424  ldreq     r2, [r0]
0000c426  cmp       r2, #1
0000c428  blt       #0xc442
0000c42a  ldr       r0, [r4, #0xc]
0000c42c  cbz       r0, #0xc456
0000c42e  movw      r1, #0x4240
0000c432  movs      r3, #0
0000c434  movt      r1, #0xf
0000c438  umull     r0, r1, r0, r1
0000c43c  blx       #0xf56c
0000c440  b         #0xc45a
0000c442  ldr       r1, [pc, #0x4c]  pool=-0x8722
0000c444  ldr       r2, [pc, #0x4c]  pool=-0xa99e
0000c446  movs      r0, #5
0000c448  add       r1, pc  ; "dts_parser"
0000c44a  add       r2, pc
0000c44c  blx       #0xf670
0000c450  movs      r0, #0
0000c452  movs      r1, #0
0000c454  b         #0xc45c
0000c456  movs      r0, #0
0000c458  movs      r1, #0
0000c45a  str       r0, [r4, #0x20]
0000c45c  movs      r6, #0
0000c45e  stm.w     sp, {r0, r1, r6}
0000c462  mov       r0, r4
0000c464  mov       r1, r4
0000c466  mov       r2, r5
0000c468  str       r6, [sp, #0xc]
0000c46a  blx       #0xf6e0
0000c46e  b         #0xc394
0000c470  ldrb      r7, [r6, r6]

