===== libs/libmi3.so MI_AUDIO_Start @ 0x629ac size 0xc4 =====
000629ac  push      {r4, r5, r7, lr}
000629ae  sub       sp, #0x10
000629b0  ldr       r2, [pc, #0x94]  pool=0x4fb5a
000629b2  add       r2, pc
000629b4  ldr       r5, [r2]
000629b6  ldr       r2, [r5]
000629b8  str       r2, [sp, #0xc]
000629ba  movs      r2, #0
000629bc  strd      r2, r2, [sp]
000629c0  ldr       r2, [pc, #0x88]  pool=0x53f56
000629c2  add       r2, pc
000629c4  ldr       r3, [r2]
000629c6  cmp.w     r3, #-1
000629ca  ble       #0x629fc
000629cc  cbz       r1, #0x62a1a
000629ce  str       r0, [sp]
000629d0  ldr       r0, [r1]
000629d2  movw      r1, #0x1005
000629d6  mov       r2, sp
000629d8  movt      r1, #0xc008
000629dc  str       r0, [sp, #4]
000629de  mov       r0, r3
000629e0  blx       #0xaffe0
000629e4  mov       r4, r0
000629e6  ldr       r0, [pc, #0x80]  pool=0x53f28
000629e8  add       r0, pc
000629ea  ldrb      r0, [r0]
000629ec  cmp       r0, #0x40
000629ee  blo       #0x62a36
000629f0  ldr       r0, [pc, #0x78]  pool=-0x27096
000629f2  mov       r1, r4
000629f4  add       r0, pc
000629f6  blx       #0xaf300
000629fa  b         #0x62a36
000629fc  ldr       r0, [pc, #0x50]  pool=0x53f12
000629fe  add       r0, pc  ; "�� "
00062a00  ldrb      r0, [r0]
00062a02  cmp       r0, #0x20
00062a04  blo       #0x62a16
00062a06  ldr       r0, [pc, #0x4c]  pool=-0x3720c
00062a08  ldr       r1, [pc, #0x4c]  pool=-0x29987
00062a0a  movw      r2, #0x133
00062a0e  add       r0, pc
00062a10  add       r1, pc  ; "MI_AUDIO_Start"
00062a12  blx       #0xaf300
00062a16  movs      r4, #4
00062a18  b         #0x62a36
00062a1a  ldr       r0, [pc, #0x40]  pool=0x53ef4
00062a1c  add       r0, pc
00062a1e  ldrb      r0, [r0]
00062a20  cmp       r0, #0x20
00062a22  blo       #0x62a34
00062a24  ldr       r0, [pc, #0x38]  pool=-0x476d3
00062a26  ldr       r1, [pc, #0x3c]  pool=-0x299a5
00062a28  mov.w     r2, #0x134
00062a2c  add       r0, pc
00062a2e  add       r1, pc
00062a30  blx       #0xaf300
00062a34  movs      r4, #8
00062a36  ldr       r0, [r5]
00062a38  ldr       r1, [sp, #0xc]
00062a3a  subs      r0, r0, r1
00062a3c  bne       #0x62a44
00062a3e  mov       r0, r4
00062a40  add       sp, #0x10
00062a42  pop       {r4, r5, r7, pc}
00062a44  blx       #0xaf550
00062a48  smmla     r0, sl, r4, r0
00062a4c  subs      r7, #0x56
00062a4e  movs      r5, r0
00062a50  subs      r7, #0x12
00062a52  movs      r5, r0
00062a54  ldrh      r4, [r6, #0x2e]

