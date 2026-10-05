===== kmods/utpa2k.ko HAL_AUDIO_ConfigureAlwaysTranscoder sec_off=0x44465c size=0x3c mode=A =====
0044465c  push      {r4, r5, r6, lr}
00444660  movw      r6, #0  rel→g_AudioVars2
00444664  mov       r5, r0
00444668  movt      r6, #0  rel→g_AudioVars2
0044466c  mov       r4, r1
00444670  ldr       r0, [r6]
00444674  cmp       r0, #0
00444678  bne       #0x44468c
0044467c  bl        #0x44467c  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00444680  ldr       r0, [r6]
00444684  cmp       r0, #0
00444688  beq       #0x444694
0044468c  str       r5, [r0, #0x52c]
00444690  str       r4, [r0, #0x530]
00444694  pop       {r4, r5, r6, pc}
