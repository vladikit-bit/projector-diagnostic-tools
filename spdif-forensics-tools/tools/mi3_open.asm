===== libs/libmi3.so MI_AUDIO_Open @ 0x62694 size 0x1ec =====
00062694  push.w    {r4, r5, r6, r7, r8, lr}
00062698  sub       sp, #0x58
0006269a  mov       r5, r0
0006269c  ldr       r0, [pc, #0x184]  pool=0x4fe6a
0006269e  mov       r4, r1
000626a0  movs      r1, #0x4c
000626a2  add       r0, pc
000626a4  ldr       r7, [r0]
000626a6  ldr       r0, [r7]
000626a8  str       r0, [sp, #0x54]
000626aa  add       r0, sp, #8
000626ac  blx       #0xaf560
000626b0  ldr       r6, [pc, #0x174]  pool=0x54266
000626b2  add       r6, pc
000626b4  ldr       r0, [r6]
000626b6  cmp.w     r0, #-1
000626ba  ble       #0x626ec
000626bc  cbz       r5, #0x6270a
000626be  cbz       r4, #0x62722
000626c0  add.w     r8, sp, #8
000626c4  movs      r1, #0x44
000626c6  mov       r0, r8
000626c8  blx       #0xaf560
000626cc  ldm.w     r5, {r0, r1, r2}
000626d0  strd      r1, r2, [sp, #0x4c]
000626d4  cmp       r0, #0
000626d6  beq       #0x6275c
000626d8  blx       #0xaf6e0
000626dc  cmp       r0, #0x3e
000626de  bhi       #0x6274e
000626e0  ldr       r0, [r5]
000626e2  blx       #0xaf6e0
000626e6  mov       r2, r0
000626e8  cbnz      r0, #0x62750
000626ea  b         #0x6275c
000626ec  ldr       r0, [pc, #0x13c]  pool=0x54222
000626ee  add       r0, pc  ; "�� "
000626f0  ldrb      r0, [r0]
000626f2  cmp       r0, #0x20
000626f4  blo       #0x62706
000626f6  ldr       r0, [pc, #0x138]  pool=-0x36efc
000626f8  ldr       r1, [pc, #0x138]  pool=-0x381c6
000626fa  mov.w     r2, #0x102
000626fe  add       r0, pc
00062700  add       r1, pc  ; "MI_AUDIO_Open"
00062702  blx       #0xaf300
00062706  movs      r5, #4
00062708  b         #0x6273e
0006270a  ldr       r0, [pc, #0x12c]  pool=0x54204
0006270c  add       r0, pc
0006270e  ldrb      r0, [r0]
00062710  cmp       r0, #0x20
00062712  blo       #0x6273c
00062714  ldr       r0, [pc, #0x124]  pool=-0x4b711
00062716  ldr       r1, [pc, #0x128]  pool=-0x381e4
00062718  movw      r2, #0x103
0006271c  add       r0, pc
0006271e  add       r1, pc
00062720  b         #0x62738
00062722  ldr       r0, [pc, #0x120]  pool=0x541ec
00062724  add       r0, pc
00062726  ldrb      r0, [r0]
00062728  cmp       r0, #0x20
0006272a  blo       #0x6273c
0006272c  ldr       r0, [pc, #0x118]  pool=-0x2ac77
0006272e  ldr       r1, [pc, #0x11c]  pool=-0x381fc
00062730  mov.w     r2, #0x104
00062734  add       r0, pc
00062736  add       r1, pc
00062738  blx       #0xaf300
0006273c  movs      r5, #8
0006273e  ldr       r0, [r7]
00062740  ldr       r1, [sp, #0x54]
00062742  subs      r0, r0, r1
00062744  bne       #0x62820
00062746  mov       r0, r5
00062748  add       sp, #0x58
0006274a  pop.w     {r4, r5, r6, r7, r8, pc}
0006274e  movs      r2, #0x3f
00062750  ldr       r1, [r5]
00062752  add.w     r0, r8, #4
00062756  movs      r3, #0x40
00062758  blx       #0xafbd0
0006275c  ldr       r0, [r6]
0006275e  movw      r1, #0x1003
00062762  add       r2, sp, #8
00062764  movt      r1, #0xc04c
00062768  blx       #0xaffe0
0006276c  ldr       r6, [pc, #0xe0]  pool=0x541a0
0006276e  mov       r5, r0
00062770  add       r6, pc
00062772  ldrb      r0, [r6]
00062774  cbz       r5, #0x6278e
00062776  cmp       r0, #0x20
00062778  blo       #0x6273e
0006277a  ldr       r0, [pc, #0xd8]  pool=-0x43081
0006277c  ldr       r1, [pc, #0xd8]  pool=-0x3824a
0006277e  movw      r2, #0x117
00062782  add       r0, pc
00062784  add       r1, pc  ; "MI_AUDIO_Open"
00062786  mov       r3, r5
00062788  blx       #0xaf300
0006278c  b         #0x6273e
0006278e  cmp       r0, #0x40
00062790  blo       #0x627ae
00062792  ldr       r0, [pc, #0xc8]  pool=-0x22e4e
00062794  movs      r1, #0
00062796  add       r0, pc
00062798  blx       #0xaf300
0006279c  ldrb      r0, [r6]
0006279e  cmp       r0, #0x40
000627a0  blo       #0x627ae
000627a2  ldr       r1, [sp, #8]
000627a4  ldr       r0, [pc, #0xb8]  pool=-0x2aed9
000627a6  add       r0, pc
000627a8  blx       #0xaf300
000627ac  ldrb      r0, [r6]
000627ae  ldr       r1, [sp, #8]
000627b0  cmp       r0, #0x40
000627b2  str       r1, [r4]
000627b4  str       r1, [sp, #4]
000627b6  ldr       r4, [pc, #0xac]  pool=0x5c5b4
000627b8  add       r4, pc
000627ba  blo       #0x627ea
000627bc  blx       #0xaf760
000627c0  mov       r1, r0
000627c2  ldr       r0, [pc, #0xa4]  pool=-0x3eb50
000627c4  add       r0, pc
000627c6  blx       #0xaf300
000627ca  ldrb      r0, [r6]
000627cc  cmp       r0, #0x40
000627ce  blo       #0x627ea
000627d0  ldr       r1, [r4]
000627d2  ldr       r0, [pc, #0x98]  pool=-0x32f2a
000627d4  add       r0, pc
000627d6  blx       #0xaf300
000627da  ldrb      r0, [r6]
000627dc  cmp       r0, #0x40
000627de  blo       #0x627ea
000627e0  ldr       r1, [sp, #8]
000627e2  ldr       r0, [pc, #0x8c]  pool=-0x2add9
000627e4  add       r0, pc
000627e6  blx       #0xaf300
000627ea  ldr       r0, [r4]
000627ec  add       r1, sp, #4
000627ee  blx       #0xb0050
000627f2  cbz       r0, #0x62808
000627f4  mov       r5, r0
000627f6  cmp       r0, #1
000627f8  bne       #0x6280c
000627fa  ldrb      r0, [r6]
000627fc  cmp       r0, #0x40
000627fe  blo       #0x62808
00062800  ldr       r0, [pc, #0x70]  pool=-0x32e58
00062802  add       r0, pc
00062804  blx       #0xaf600
00062808  movs      r5, #0
0006280a  b         #0x6273e
0006280c  ldrb      r0, [r6]
0006280e  cmp       r0, #0x20
00062810  blo       #0x6273e
00062812  ldr       r0, [pc, #0x64]  pool=-0x48955
00062814  ldr       r1, [pc, #0x64]  pool=-0x382e2
00062816  movw      r2, #0x11f
0006281a  add       r0, pc
0006281c  add       r1, pc  ; "MI_AUDIO_Open"
0006281e  b         #0x62786
00062820  blx       #0xaf550
00062824  cdp2      p0, #6, c0, c10, c4, #0
00062828  rsbs      r6, r4, #0
0006282a  movs      r5, r0
0006282c  tst       r2, r4
0006282e  movs      r5, r0
00062830  str       r1, [sp, #0x10]
00062832  vcvt.f32.u32 d23, d26, #4

