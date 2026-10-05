===== libs/libmi3.so MI_AOUT_GetHandle @ 0x60d24 size 0x128 =====
00060d24  push      {r4, r5, r6, lr}
00060d26  sub       sp, #0x10
00060d28  mov       r5, r1
00060d2a  ldr       r1, [pc, #0xe0]  pool=0x517e0
00060d2c  add       r1, pc
00060d2e  ldr       r6, [r1]
00060d30  ldr       r1, [r6]
00060d32  str       r1, [sp, #0xc]
00060d34  movs      r1, #0
00060d36  strd      r1, r1, [sp]
00060d3a  ldr       r1, [pc, #0xd4]  pool=0x55bd0
00060d3c  add       r1, pc  ; "���� "
00060d3e  ldr       r3, [r1]
00060d40  cmp.w     r3, #-1
00060d44  ble       #0x60d86
00060d46  cbz       r0, #0x60da4
00060d48  cbz       r5, #0x60dbc
00060d4a  ldr       r0, [r0]
00060d4c  movs      r1, #0
00060d4e  mov       r2, sp
00060d50  str       r1, [sp, #4]
00060d52  movw      r1, #0x1116
00060d56  movt      r1, #0xc008
00060d5a  str       r0, [sp]
00060d5c  mov       r0, r3
00060d5e  blx       #0xaffe0
00060d62  cmp       r0, #0
00060d64  beq       #0x60de6
00060d66  mov       r4, r0
00060d68  ldr       r0, [pc, #0xcc]  pool=0x55b9e
00060d6a  add       r0, pc  ; "�� "
00060d6c  ldr       r0, [r0]
00060d6e  cmp       r0, #0x20
00060d70  blo       #0x60dd8
00060d72  ldr       r0, [pc, #0xc8]  pool=-0x49c19
00060d74  ldr       r1, [pc, #0xc8]  pool=-0x3a5be
00060d76  mov.w     r2, #0x27c
00060d7a  mov       r3, r4
00060d7c  add       r0, pc
00060d7e  add       r1, pc
00060d80  blx       #0xaf300
00060d84  b         #0x60dd8
00060d86  ldr       r0, [pc, #0x8c]  pool=0x55b80
00060d88  add       r0, pc
00060d8a  ldr       r0, [r0]
00060d8c  cmp       r0, #0x20
00060d8e  blo       #0x60da0
00060d90  ldr       r0, [pc, #0x84]  pool=-0x35596
00060d92  ldr       r1, [pc, #0x88]  pool=-0x3a5da
00060d94  movw      r2, #0x273
00060d98  add       r0, pc
00060d9a  add       r1, pc
00060d9c  blx       #0xaf300
00060da0  movs      r4, #4
00060da2  b         #0x60dd8
00060da4  ldr       r0, [pc, #0x78]  pool=0x55b62
00060da6  add       r0, pc  ; "�� "
00060da8  ldr       r0, [r0]
00060daa  cmp       r0, #0x20
00060dac  blo       #0x60dd6
00060dae  ldr       r0, [pc, #0x74]  pool=-0x22b3c
00060db0  ldr       r1, [pc, #0x74]  pool=-0x3a5f8
00060db2  mov.w     r2, #0x274
00060db6  add       r0, pc
00060db8  add       r1, pc  ; "MI_AOUT_GetHandle"
00060dba  b         #0x60dd2
00060dbc  ldr       r0, [pc, #0x6c]  pool=0x55b4a
00060dbe  add       r0, pc  ; "�� "
00060dc0  ldr       r0, [r0]
00060dc2  cmp       r0, #0x20
00060dc4  blo       #0x60dd6
00060dc6  ldr       r0, [pc, #0x68]  pool=-0x2e948
00060dc8  ldr       r1, [pc, #0x68]  pool=-0x3a610
00060dca  movw      r2, #0x275
00060dce  add       r0, pc
00060dd0  add       r1, pc  ; "MI_AOUT_GetHandle"
00060dd2  blx       #0xaf300
00060dd6  movs      r4, #8
00060dd8  ldr       r0, [r6]
00060dda  ldr       r1, [sp, #0xc]
00060ddc  subs      r0, r0, r1
00060dde  bne       #0x60e06
00060de0  mov       r0, r4
00060de2  add       sp, #0x10
00060de4  pop       {r4, r5, r6, pc}
00060de6  ldr       r0, [sp, #4]
00060de8  str       r0, [r5]
00060dea  ldr       r0, [pc, #0x58]  pool=0x55b1c
00060dec  add       r0, pc
00060dee  ldr       r0, [r0]
00060df0  cmp       r0, #0x40
00060df2  blo       #0x60e02
00060df4  ldr       r0, [pc, #0x50]  pool=-0x3003f
00060df6  movs      r1, #0
00060df8  movs      r4, #0
00060dfa  add       r0, pc
00060dfc  blx       #0xaf300
00060e00  b         #0x60dd8
00060e02  movs      r4, #0
00060e04  b         #0x60dd8
00060e06  blx       #0xaf550
00060e0a  nop       
00060e0c  asrs      r0, r4, #0x1f
00060e0e  movs      r5, r0
00060e10  ldrh      r0, [r2, r7]
00060e12  movs      r5, r0
00060e14  ldrh      r0, [r0, r6]
00060e16  movs      r5, r0
00060e18  add       r2, sp, #0x1a8
00060e1a  vtbl.8    d21, {d12, d13, d14}, d22
00060e1e  vtbx.8    d21, {d12, d13, d14, d15}, d18
00060e22  movs      r5, r0
00060e24  bmi       #0x60db0
00060e26  vtbl.8    d21, {d13, d14, d15}, d8
00060e2a  vtbx.8    d21, {d12, d13, d14, d15}, d10
00060e2e  movs      r5, r0
00060e30  asrs      r0, r7, #0x1a

