===== kmods/utpa2k.ko HAL_AUDIO_DTSELoadCode sec_off=0x444010 size=0x54 mode=A =====
00444010  push      {fp, lr}
00444014  movw      r0, #0  rel→g_AudioVars2
00444018  movt      r0, #0  rel→g_AudioVars2
0044401c  ldr       r0, [r0]
00444020  cmp       r0, #0
00444024  beq       #0x444048
00444028  ldr       r0, [r0, #0x4c8]
0044402c  cmp       r0, #4
00444030  poplo     {fp, pc}
00444034  movw      r0, #0  rel→.L.str.2
00444038  movt      r0, #0  rel→.L.str.2
0044403c  bl        #0x44403c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00444040  cmp       r0, #1
00444044  beq       #0x44404c
00444048  pop       {fp, pc}
0044404c  movw      r0, #0  rel→.L.str.60
00444050  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_DTSELoadCode
00444054  movt      r0, #0  rel→.L.str.60
00444058  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_DTSELoadCode
0044405c  pop       {fp, lr}
00444060  b         #0x444060  rel→printk
