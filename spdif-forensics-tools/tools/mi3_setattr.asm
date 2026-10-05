===== libs/libmi3.so MI_AUDIO_SetAttr @ 0x636b4 size 0x1d8 =====
000636b4  push.w    {r4, r5, r6, r7, r8, lr}
000636b8  sub       sp, #0x80
000636ba  mov       r4, r2
000636bc  ldr       r2, [pc, #0x18c]  pool=0x4ee4e
000636be  add       r2, pc
000636c0  ldr       r5, [r2]
000636c2  ldr       r2, [r5]
000636c4  str       r2, [sp, #0x7c]
000636c6  ldr       r6, [pc, #0x188]  pool=0x53250
000636c8  add       r6, pc
000636ca  ldr       r2, [r6]
000636cc  cmp.w     r2, #-1
000636d0  ble       #0x63744
000636d2  add       r7, sp, #0x10
000636d4  vmov.i32  q8, #0
000636d8  add.w     r2, r7, #8
000636dc  vst1.64   {d16, d17}, [r2]
000636e0  movs      r2, #0
000636e2  strd      r2, r2, [sp, #0x28]
000636e6  strd      r0, r1, [sp, #0x10]
000636ea  strd      r4, r2, [sp, #0x20]
000636ee  cmp.w     r1, #0x500
000636f2  ldr       r0, [pc, #0x16c]  pool=0x5321c
000636f4  add       r0, pc
000636f6  mov       r8, r0
000636f8  beq       #0x63762
000636fa  cmp.w     r1, #0x4000
000636fe  bne.w     #0x63812
00063702  add       r0, sp, #0x30
00063704  movs      r1, #0x44
00063706  blx       #0xaf560
0006370a  ldrb      r0, [r4, #4]
0006370c  strb.w    r0, [sp, #0x70]
00063710  ldr       r0, [r4, #8]
00063712  str       r0, [sp, #0x74]
00063714  ldr       r0, [r4]
00063716  cmp       r0, #0
00063718  beq       #0x637c4
0006371a  blx       #0xaf6e0
0006371e  cmp       r0, #0x3e
00063720  bhi       #0x637e0
00063722  ldr       r0, [r4]
00063724  blx       #0xaf6e0
00063728  mov       r2, r0
0006372a  cmp       r0, #0
0006372c  bne       #0x637e2
0006372e  ldrb.w    r0, [r8]
00063732  cmp       r0, #0x20
00063734  blo       #0x637dc
00063736  ldr       r0, [pc, #0x130]  pool=-0x228db
00063738  ldr       r1, [pc, #0x130]  pool=-0x2e8fc
0006373a  movw      r2, #0x25e
0006373e  add       r0, pc
00063740  add       r1, pc  ; "MI_AUDIO_SetAttr"
00063742  b         #0x637d8
00063744  ldr       r0, [pc, #0x10c]  pool=0x531ca
00063746  add       r0, pc  ; "�� "
00063748  ldrb      r0, [r0]
0006374a  cmp       r0, #0x20
0006374c  blo       #0x6375e
0006374e  ldr       r0, [pc, #0x108]  pool=-0x37f54
00063750  ldr       r1, [pc, #0x108]  pool=-0x2e914
00063752  movw      r2, #0x246
00063756  add       r0, pc
00063758  add       r1, pc  ; "MI_AUDIO_SetAttr"
0006375a  blx       #0xaf300
0006375e  movs      r4, #4
00063760  b         #0x63836
00063762  mov       r0, r8
00063764  ldrb.w    r0, [r8]
00063768  cmp       r0, #0x20
0006376a  blo       #0x6377e
0006376c  ldr       r3, [r4]
0006376e  ldr       r0, [pc, #0x108]  pool=-0x3bab3
00063770  ldr       r1, [pc, #0x108]  pool=-0x2e934
00063772  movw      r2, #0x26d
00063776  add       r0, pc
00063778  add       r1, pc  ; "MI_AUDIO_SetAttr"
0006377a  blx       #0xaf300
0006377e  ldr       r0, [r4]
00063780  cmp       r0, #2
00063782  str       r0, [sp, #0x18]
00063784  bne       #0x63812
00063786  mov       r0, r8
00063788  adds      r7, #0x10
0006378a  ldrb.w    r0, [r8]
0006378e  cmp       r0, #0x20
00063790  blo       #0x637ac
00063792  ldrd      r0, r1, [r4, #0x10]
00063796  movw      r2, #0x271
0006379a  movs      r3, #2
0006379c  strd      r0, r1, [sp]
000637a0  ldr       r0, [pc, #0xdc]  pool=-0x2fb9b
000637a2  ldr       r1, [pc, #0xe0]  pool=-0x2e962
000637a4  add       r0, pc
000637a6  add       r1, pc
000637a8  blx       #0xaf300
000637ac  ldrd      r0, r1, [r4, #0x10]
000637b0  strd      r0, r1, [sp, #8]
000637b4  add       r0, sp, #8
000637b6  vld1.32   {d16}, [r0:0x40]
000637ba  vmovl.u32 q8, d16
000637be  vst1.64   {d16, d17}, [r7]
000637c2  b         #0x63812
000637c4  ldrb.w    r0, [r8]
000637c8  cmp       r0, #0x20
000637ca  blo       #0x637dc
000637cc  ldr       r0, [pc, #0xa0]  pool=-0x26a6d
000637ce  ldr       r1, [pc, #0xa4]  pool=-0x2e992
000637d0  mov.w     r2, #0x264
000637d4  add       r0, pc
000637d6  add       r1, pc
000637d8  blx       #0xaf300
000637dc  movs      r4, #8
000637de  b         #0x63836
000637e0  movs      r2, #0x3f
000637e2  ldr       r1, [r4]
000637e4  add       r4, sp, #0x30
000637e6  movs      r3, #0x40
000637e8  mov       r0, r4
000637ea  blx       #0xafbd0
000637ee  mov       r0, r8
000637f0  movs      r7, #0
000637f2  ldrb.w    r0, [r8]
000637f6  strb.w    r7, [sp, #0x6f]
000637fa  cmp       r0, #0x3f
000637fc  bls       #0x6380e
000637fe  ldr       r3, [sp, #0x74]
00063800  ldrb.w    r2, [sp, #0x70]
00063804  ldr       r0, [pc, #0x5c]  pool=-0x441bd
00063806  add       r1, sp, #0x30
00063808  add       r0, pc
0006380a  blx       #0xaf300
0006380e  strd      r4, r7, [sp, #0x20]
00063812  ldr       r0, [r6]
00063814  movw      r1, #0x1014
00063818  add       r2, sp, #0x10
0006381a  movt      r1, #0xc020
0006381e  blx       #0xaffe0
00063822  mov       r4, r0
00063824  ldrb.w    r0, [r8]
00063828  cmp       r0, #0x40
0006382a  blo       #0x63836
0006382c  ldr       r0, [pc, #0x58]  pool=-0x42771
0006382e  mov       r1, r4
00063830  add       r0, pc
00063832  blx       #0xaf300
00063836  ldr       r0, [r5]
00063838  ldr       r1, [sp, #0x7c]
0006383a  subs      r0, r0, r1
0006383c  bne       #0x63846
0006383e  mov       r0, r4
00063840  add       sp, #0x80
00063842  pop.w     {r4, r5, r6, r7, r8, pc}
00063846  blx       #0xaf550
0006384a  nop       
0006384c  cdp       p0, #4, c0, c14, c4, #0
00063850  adds      r2, #0x50
00063852  movs      r5, r0
00063854  adds      r1, #0xca
00063856  movs      r5, r0
00063858  strh      r4, [r5, #4]

