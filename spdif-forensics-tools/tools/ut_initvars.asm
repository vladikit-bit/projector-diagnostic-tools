===== kmods/utpa2k.ko HAL_AUDIO_InitialVars sec_off=0x441080 size=0x12c mode=A =====
00441080  push      {r4, r5, fp, lr}
00441084  movw      r5, #0  rel→g_AudioVars2
00441088  movt      r5, #0  rel→g_AudioVars2
0044108c  ldr       r0, [r5]
00441090  cmp       r0, #0
00441094  beq       #0x4410e8
00441098  ldrb      r1, [r0, #8]
0044109c  cmp       r1, #0
004410a0  bne       #0x441184
004410a4  movw      r1, #0  rel→g_bInitShmFlag
004410a8  movt      r1, #0  rel→g_bInitShmFlag
004410ac  ldrb      r1, [r1]
004410b0  cmp       r1, #0
004410b4  bne       #0x441128
004410b8  ldr       r0, [r0, #0x4c8]
004410bc  cmp       r0, #3
004410c0  blo       #0x4410fc
004410c4  movw      r0, #0  rel→.L.str.6
004410c8  movt      r0, #0  rel→.L.str.6
004410cc  bl        #0x4410cc  rel→UtopiaLogSystem; CALL UtopiaLogSystem
004410d0  cmp       r0, #1
004410d4  bne       #0x4410fc
004410d8  movw      r0, #0  rel→.L.str.9
004410dc  movt      r0, #0  rel→.L.str.9
004410e0  bl        #0x4410e0  rel→printk; CALL printk
004410e4  b         #0x4410fc
004410e8  movw      r0, #0  rel→g_bInitShmFlag
004410ec  movt      r0, #0  rel→g_bInitShmFlag
004410f0  ldrb      r0, [r0]
004410f4  cmp       r0, #0
004410f8  bne       #0x441128
004410fc  movw      r0, #0  rel→g_bInitShmFlag
00441100  movw      r4, #0  rel→g_audioShared
00441104  movt      r0, #0  rel→g_bInitShmFlag
00441108  mov       r1, #1
0044110c  movt      r4, #0  rel→g_audioShared
00441110  strb      r1, [r0]
00441114  mov       r0, r4
00441118  bl        #0x441118  rel→HAL_AUDIO_ResetDefaultVars; CALL HAL_AUDIO_ResetDefaultVars
0044111c  ldr       r0, [r4, #0xc0]
00441120  add       r0, r0, #1
00441124  str       r0, [r4, #0xc0]
00441128  movw      r0, #0  rel→gDigitalOutChannelStatusFuncPtr
0044112c  movw      r1, #0  rel→HAL_AUDIO_DigitalOut_SetChannelStatus
00441130  movt      r0, #0  rel→gDigitalOutChannelStatusFuncPtr
00441134  movt      r1, #0  rel→HAL_AUDIO_DigitalOut_SetChannelStatus
00441138  str       r1, [r0]
0044113c  movw      r0, #0  rel→gOpenDecodeSystemFuncPtr
00441140  movw      r1, #0  rel→HAL_AUDIO_OpenDecodeSystem
00441144  movt      r0, #0  rel→gOpenDecodeSystemFuncPtr
00441148  movt      r1, #0  rel→HAL_AUDIO_OpenDecodeSystem
0044114c  str       r1, [r0]
00441150  movw      r0, #0  rel→pFuncPtr_Setsystem
00441154  movw      r1, #0  rel→HAL_AUDIO_SetDecodeSystem
00441158  movt      r0, #0  rel→pFuncPtr_Setsystem
0044115c  movt      r1, #0  rel→HAL_AUDIO_SetDecodeSystem
00441160  str       r1, [r0]
00441164  movw      r0, #0  rel→gGetDDRInfoFuncPtr
00441168  movw      r1, #0  rel→HAL_AUDIO_GetDDRInfo
0044116c  movt      r0, #0  rel→gGetDDRInfoFuncPtr
00441170  movt      r1, #0  rel→HAL_AUDIO_GetDDRInfo
00441174  str       r1, [r0]
00441178  movw      r0, #0  rel→g_audioShared
0044117c  movt      r0, #0  rel→g_audioShared
00441180  str       r0, [r5]
00441184  bl        #0x441184  rel→HAL_ADVSOUND_GET_INIT_FLAG; CALL HAL_ADVSOUND_GET_INIT_FLAG
00441188  cmp       r0, #0
0044118c  bne       #0x44119c
00441190  bl        #0x441190  rel→HAL_ADVSOUND_AllocateVars; CALL HAL_ADVSOUND_AllocateVars
00441194  cmp       r0, #0
00441198  beq       #0x4411a4
0044119c  mov       r0, #1
004411a0  pop       {r4, r5, fp, pc}
004411a4  mov       r0, #0
004411a8  pop       {r4, r5, fp, pc}
