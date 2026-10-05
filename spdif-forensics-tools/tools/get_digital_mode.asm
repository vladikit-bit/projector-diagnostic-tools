===== libs/audio.primary.mt5889.so _Z29utils_get_digital_output_modej @ 0x27fbc size 0x1c =====
00027fbc  cmp       r0, #3
00027fbe  bhi       #0x27fca
00027fc0  ldr       r1, [pc, #0xc]  pool=0x17afa; ; "k.system.s.m.support"
00027fc2  add       r1, pc
00027fc4  ldr.w     r0, [r1, r0, lsl #2]
00027fc8  bx        lr
00027fca  ldr       r0, [pc, #8]  pool=-0x9ad1
00027fcc  add       r0, pc  ; "un-know"
00027fce  bx        lr
00027fd0  ldrb      r2, [r7, #0xb]
00027fd2  movs      r1, r0
00027fd4  str       r7, [r5, #0x50]

