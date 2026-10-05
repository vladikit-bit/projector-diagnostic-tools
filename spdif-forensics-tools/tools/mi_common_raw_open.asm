===== libs/audio.primary.mt5889.so _Z18mi_common_raw_openP16mstar_stream_outP12audio_config @ 0x3103c size 0x94 =====
0003103c  push      {r4, r5, r6, lr}
0003103e  sub       sp, #8
00031040  cbz       r0, #0x31068
00031042  ldr.w     r2, [r0, #0x138]
00031046  ldr.w     r6, [r0, #0x170]
0003104a  mov       r5, r0
0003104c  blx       r2
0003104e  cbz       r0, #0x3107e
00031050  str       r0, [sp]
00031052  mov       r4, r0
00031054  movs      r0, #6
00031056  ldr       r1, [pc, #0x60]  pool=0xfffe661f
00031058  ldr       r2, [pc, #0x60]  pool=0xfffe9b7d
0003105a  ldr       r3, [pc, #0x64]  pool=0xfffe460f
0003105c  add       r1, pc
0003105e  add       r2, pc
00031060  add       r3, pc
00031062  blx       #0x3d100
00031066  b         #0x310a4
00031068  ldr       r1, [pc, #0x40]  pool=0xfffe660b
0003106a  ldr       r2, [pc, #0x44]  pool=0xfffe6425
0003106c  ldr       r3, [pc, #0x44]  pool=0xfffe45fb
0003106e  movs      r0, #5
00031070  add       r1, pc
00031072  add       r2, pc
00031074  add       r3, pc
00031076  blx       #0x3d100
0003107a  movs      r4, #3
0003107c  b         #0x310a4
0003107e  movw      r0, #0x3620
00031082  ldr.w     r4, [r5, #0x294]
00031086  ldr       r0, [r6, r0]
00031088  blx       #0x3d470
0003108c  strd      r4, r0, [sp]
00031090  movs      r0, #4
00031092  ldr       r1, [pc, #0x30]  pool=0xfffe65e3
00031094  ldr       r2, [pc, #0x30]  pool=0xfffea8a5
00031096  ldr       r3, [pc, #0x34]  pool=0xfffe45d3
00031098  add       r1, pc
0003109a  add       r2, pc
0003109c  add       r3, pc
0003109e  blx       #0x3d100
000310a2  movs      r4, #0
000310a4  mov       r0, r4
000310a6  add       sp, #8
000310a8  pop       {r4, r5, r6, pc}
000310aa  nop       
000310ac  str       r3, [r1, #0x60]

