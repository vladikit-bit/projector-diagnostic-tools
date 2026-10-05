===== libs/libmi3.so MI_AOUT_SetDigitalMode @ 0x6049c size 0x124 =====
0006049c  push.w    {r4, r5, r6, r7, r8, lr}
000604a0  sub       sp, #0x58
000604a2  mov       r6, r0
000604a4  ldr       r0, [pc, #0xf0]  pool=0x52060
000604a6  mov       r5, sp
000604a8  mov       r4, r1
000604aa  movs      r1, #0x50
000604ac  add       r0, pc
000604ae  ldr.w     r8, [r0]
000604b2  ldr.w     r0, [r8]
000604b6  str       r0, [sp, #0x54]
000604b8  mov       r0, r5
000604ba  blx       #0xaf560
000604be  ldr       r7, [pc, #0xdc]  pool=0x5644c
000604c0  add       r7, pc  ; "���� "
000604c2  ldr       r0, [r7]
000604c4  cmp.w     r0, #-1
000604c8  ble       #0x60514
000604ca  cbz       r4, #0x60532
000604cc  vmov.i32  q8, #0
000604d0  add.w     r0, r5, #0x40
000604d4  str       r6, [sp]
000604d6  add.w     ip, sp, #4
000604da  vst1.64   {d16, d17}, [r0]
000604de  add.w     r0, r5, #0x30
000604e2  vst1.64   {d16, d17}, [r0]
000604e6  add.w     r0, r5, #0x20
000604ea  adds      r5, #0x10
000604ec  vst1.64   {d16, d17}, [r0]
000604f0  vst1.64   {d16, d17}, [r5]
000604f4  ldr       r0, [r4, #0xc]
000604f6  ldm.w     r4, {r1, r2, r3}
000604fa  stm.w     ip, {r1, r2, r3}
000604fe  cbz       r0, #0x6055c
00060500  blx       #0xaf6e0
00060504  cmp       r0, #0x3e
00060506  bhi       #0x60550
00060508  ldr       r0, [r4, #0xc]
0006050a  blx       #0xaf6e0
0006050e  mov       r2, r0
00060510  cbnz      r0, #0x60552
00060512  b         #0x6055c
00060514  ldr       r0, [pc, #0x88]  pool=0x563f2
00060516  add       r0, pc  ; "�� "
00060518  ldr       r0, [r0]
0006051a  cmp       r0, #0x20
0006051c  blo       #0x6052e
0006051e  ldr       r0, [pc, #0x84]  pool=-0x34d24
00060520  ldr       r1, [pc, #0x84]  pool=-0x2e02a
00060522  movw      r2, #0x19b
00060526  add       r0, pc
00060528  add       r1, pc  ; "MI_AOUT_SetDigitalMode"
0006052a  blx       #0xaf300
0006052e  movs      r4, #4
00060530  b         #0x60582
00060532  ldr       r0, [pc, #0x78]  pool=0x563d4
00060534  add       r0, pc
00060536  ldr       r0, [r0]
00060538  cmp       r0, #0x20
0006053a  blo       #0x6054c
0006053c  ldr       r0, [pc, #0x70]  pool=-0x39dbb
0006053e  ldr       r1, [pc, #0x74]  pool=-0x2e048
00060540  mov.w     r2, #0x19c
00060544  add       r0, pc
00060546  add       r1, pc
00060548  blx       #0xaf300
0006054c  movs      r4, #8
0006054e  b         #0x60582
00060550  movs      r2, #0x3f
00060552  ldr       r1, [r4, #0xc]
00060554  mov       r0, r5
00060556  movs      r3, #0x40
00060558  blx       #0xafbd0
0006055c  ldr       r0, [r7]
0006055e  movw      r1, #0x1111
00060562  mov       r2, sp
00060564  movt      r1, #0xc050
00060568  blx       #0xaffe0
0006056c  mov       r4, r0
0006056e  ldr       r0, [pc, #0x48]  pool=0x56398
00060570  add       r0, pc
00060572  ldr       r0, [r0]
00060574  cmp       r0, #0x40
00060576  blo       #0x60582
00060578  ldr       r0, [pc, #0x40]  pool=-0x33827
0006057a  mov       r1, r4
0006057c  add       r0, pc
0006057e  blx       #0xaf300
00060582  ldr.w     r0, [r8]
00060586  ldr       r1, [sp, #0x54]
00060588  subs      r0, r0, r1
0006058a  bne       #0x60594
0006058c  mov       r0, r4
0006058e  add       sp, #0x58
00060590  pop.w     {r4, r5, r6, r7, r8, pc}
00060594  blx       #0xaf550
00060598  movs      r0, #0x60
0006059a  movs      r5, r0
0006059c  str       r4, [r1, #0x44]
0006059e  movs      r5, r0
000605a0  str       r2, [r6, #0x3c]
000605a2  movs      r5, r0
000605a4  uxtb      r4, r3

