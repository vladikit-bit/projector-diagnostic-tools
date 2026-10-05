===== libs/libmi3.so MI_AUDIO_GetAttr @ 0x635c0 size 0xf4 =====
000635c0  push.w    {r4, r5, r6, r7, r8, sb, sl, lr}
000635c4  sub       sp, #0x130
000635c6  mov       sl, r0
000635c8  ldr       r0, [pc, #0xcc]  pool=0x4ef42
000635ca  add       r0, pc
000635cc  ldr       r5, [r0]
000635ce  ldr       r0, [r5]
000635d0  str       r0, [sp, #0x12c]
000635d2  ldr       r0, [pc, #0xc8]  pool=0x53344
000635d4  add       r0, pc
000635d6  ldr       r7, [r0]
000635d8  cmp.w     r7, #-1
000635dc  ble       #0x6365c
000635de  add.w     sb, sp, #0x18
000635e2  mov       r6, r1
000635e4  mov.w     r1, #0x110
000635e8  mov       r8, r3
000635ea  mov       r4, r2
000635ec  mov       r0, sb
000635ee  blx       #0xaf560
000635f2  vmov.32   d16[0], r4
000635f6  mov       r0, sp
000635f8  vmov.32   d16[1], r8
000635fc  adds      r0, #8
000635fe  vmovl.u32 q8, d16
00063602  cmp.w     r6, #0x500
00063606  vst1.64   {d16, d17}, [r0]
0006360a  strd      sl, r6, [sp]
0006360e  bne       #0x6361e
00063610  mov       r0, sb
00063612  movs      r1, #0x88
00063614  blx       #0xaf560
00063618  movs      r0, #0
0006361a  strd      sb, r0, [sp, #0x10]
0006361e  movw      r1, #0x1013
00063622  mov       r2, sp
00063624  mov       r0, r7
00063626  movt      r1, #0xc018
0006362a  blx       #0xaffe0
0006362e  mov       r7, r0
00063630  ldr       r0, [pc, #0x78]  pool=0x532de
00063632  add       r0, pc  ; "�� "
00063634  ldrb      r0, [r0]
00063636  cmp       r0, #0x40
00063638  blo       #0x63644
0006363a  ldr       r0, [pc, #0x74]  pool=-0x43eab
0006363c  mov       r1, r7
0006363e  add       r0, pc
00063640  blx       #0xaf300
00063644  cmp.w     r6, #0x500
00063648  it        eq
0006364a  cmpeq     r7, #0
0006364c  bne       #0x63682
0006364e  add       r1, sp, #0x18
00063650  mov       r0, r8
00063652  cmp.w     sl, #0
00063656  beq       #0x6367a
00063658  movs      r2, #0x88
0006365a  b         #0x6367e
0006365c  ldr       r0, [pc, #0x40]  pool=0x532b2
0006365e  add       r0, pc  ; "�� "
00063660  ldrb      r0, [r0]
00063662  cmp       r0, #0x20
00063664  blo       #0x63676
00063666  ldr       r0, [pc, #0x3c]  pool=-0x37e6c
00063668  ldr       r1, [pc, #0x3c]  pool=-0x2bb65
0006366a  movw      r2, #0x226
0006366e  add       r0, pc
00063670  add       r1, pc  ; "MI_AUDIO_GetAttr"
00063672  blx       #0xaf300
00063676  movs      r7, #4
00063678  b         #0x63682
0006367a  mov.w     r2, #0x110
0006367e  blx       #0xaf620
00063682  ldr       r0, [r5]
00063684  ldr       r1, [sp, #0x12c]
00063686  subs      r0, r0, r1
00063688  bne       #0x63692
0006368a  mov       r0, r7
0006368c  add       sp, #0x130
0006368e  pop.w     {r4, r5, r6, r7, r8, sb, sl, pc}
00063692  blx       #0xaf550
00063696  nop       
00063698  vhadd.s8  d16, d2, d4
0006369c  adds      r3, #0x44
0006369e  movs      r5, r0
000636a0  adds      r2, #0xb2
000636a2  movs      r5, r0
000636a4  strh      r4, [r2, #0xc]
000636a6  vsri.64   d20, d11, #4

