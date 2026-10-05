===== kmods/utpa2k.ko UtopiaLogSystem sec_off=0x2d54 size=0x80 mode=A =====
00002d54  push      {r4, r5, r6, r7, fp, lr}
00002d58  mov       r5, r0
00002d5c  movw      r0, #0  rel→MuteLogSys
00002d60  movt      r0, #0  rel→MuteLogSys
00002d64  mov       r4, #0
00002d68  ldrb      r0, [r0]
00002d6c  cmp       r0, #0
00002d70  beq       #0x2d7c
00002d74  mov       r0, r4
00002d78  pop       {r4, r5, r6, r7, fp, pc}
00002d7c  movw      r0, #0  rel→bIsULogTagEnable
00002d80  movt      r0, #0  rel→bIsULogTagEnable
00002d84  ldrb      r0, [r0]
00002d88  cmp       r0, #1
00002d8c  beq       #0x2d9c
00002d90  mov       r4, #1
00002d94  mov       r0, r4
00002d98  pop       {r4, r5, r6, r7, fp, pc}
00002d9c  movw      r6, #0  rel→utagHead
00002da0  movt      r6, #0  rel→utagHead
00002da4  ldr       r7, [r6]
00002da8  cmp       r7, r6
00002dac  beq       #0x2d74
00002db0  add       r1, r7, #8
00002db4  mov       r0, r5
00002db8  bl        #0x2db8  rel→strstr; CALL strstr
00002dbc  cmp       r0, #0
00002dc0  bne       #0x2d90
00002dc4  ldr       r7, [r7]
00002dc8  cmp       r7, r6
00002dcc  bne       #0x2db0
00002dd0  b         #0x2d74
