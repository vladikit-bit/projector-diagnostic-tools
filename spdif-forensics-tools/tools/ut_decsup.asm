===== kmods/utpa2k.ko MDrv_AUDIO_Get_Decoder_Support sec_off=0x41f72c size=0x9a0 mode=A =====
0041f72c  push      {r4, r5, r6, lr}
0041f730  sub       sp, sp, #8
0041f734  movw      r6, #0  rel→__stack_chk_guard
0041f738  mov       r5, r0
0041f73c  movt      r6, #0  rel→__stack_chk_guard
0041f740  cmp       r5, #0
0041f744  ldr       r0, [r6]
0041f748  str       r0, [sp, #4]
0041f74c  mvn       r0, #0
0041f750  str       r0, [sp]
0041f754  beq       #0x41f8d8
0041f758  mov       r2, sp
0041f75c  mov       r0, #0
0041f760  mov       r1, #3
0041f764  bl        #0x41f764  rel→HAL_MAD_GetAudioInfo2; CALL HAL_MAD_GetAudioInfo2
0041f768  movw      r1, #0  rel→.L.str.8
0041f76c  mov       r0, r5
0041f770  movt      r1, #0  rel→.L.str.8
0041f774  mov       r2, #3
0041f778  bl        #0x41f778  rel→strncmp; CALL strncmp
0041f77c  cmp       r0, #0
0041f780  beq       #0x41f928
0041f784  movw      r1, #0  rel→.L.str.25
0041f788  mov       r0, r5
0041f78c  movt      r1, #0  rel→.L.str.25
0041f790  mov       r2, #3
0041f794  bl        #0x41f794  rel→strncmp; CALL strncmp
0041f798  cmp       r0, #0
0041f79c  beq       #0x41f988
0041f7a0  movw      r1, #0  rel→.L.str.10
0041f7a4  mov       r0, r5
0041f7a8  movt      r1, #0  rel→.L.str.10
0041f7ac  mov       r2, #3
0041f7b0  bl        #0x41f7b0  rel→strncmp; CALL strncmp
0041f7b4  cmp       r0, #0
0041f7b8  beq       #0x41f9f4
0041f7bc  movw      r1, #0  rel→.L.str.1265
0041f7c0  mov       r0, r5
0041f7c4  movt      r1, #0  rel→.L.str.1265
0041f7c8  mov       r2, #5
0041f7cc  bl        #0x41f7cc  rel→strncmp; CALL strncmp
0041f7d0  cmp       r0, #0
0041f7d4  beq       #0x41fab4
0041f7d8  movw      r1, #0  rel→.L.str.15
0041f7dc  mov       r0, r5
0041f7e0  movt      r1, #0  rel→.L.str.15
0041f7e4  mov       r2, #3
0041f7e8  bl        #0x41f7e8  rel→strncmp; CALL strncmp
0041f7ec  cmp       r0, #0
0041f7f0  beq       #0x41fb20
0041f7f4  movw      r1, #0  rel→.L.str.12
0041f7f8  mov       r0, r5
0041f7fc  movt      r1, #0  rel→.L.str.12
0041f800  mov       r2, #3
0041f804  bl        #0x41f804  rel→strncmp; CALL strncmp
0041f808  cmp       r0, #0
0041f80c  beq       #0x41fc34
0041f810  movw      r1, #0  rel→.L.str.24
0041f814  mov       r0, r5
0041f818  movt      r1, #0  rel→.L.str.24
0041f81c  mov       r2, #3
0041f820  bl        #0x41f820  rel→strncmp; CALL strncmp
0041f824  cmp       r0, #0
0041f828  beq       #0x41fc94
0041f82c  movw      r1, #0  rel→.L.str.1274
0041f830  mov       r0, r5
0041f834  movt      r1, #0  rel→.L.str.1274
0041f838  mov       r2, #4
0041f83c  bl        #0x41f83c  rel→strncmp; CALL strncmp
0041f840  cmp       r0, #0
0041f844  beq       #0x41fdbc
0041f848  movw      r1, #0  rel→.L.str.1228
0041f84c  mov       r0, r5
0041f850  movt      r1, #0  rel→.L.str.1228
0041f854  mov       r2, #3
0041f858  bl        #0x41f858  rel→strncmp; CALL strncmp
0041f85c  cmp       r0, #0
0041f860  beq       #0x41fe88
0041f864  movw      r1, #0  rel→.L.str.1279
0041f868  mov       r0, r5
0041f86c  movt      r1, #0  rel→.L.str.1279
0041f870  mov       r2, #6
0041f874  bl        #0x41f874  rel→strncmp; CALL strncmp
0041f878  cmp       r0, #0
0041f87c  beq       #0x41fef4
0041f880  movw      r0, #0  rel→g_AudioVars2
0041f884  mov       r4, #0
0041f888  movt      r0, #0  rel→g_AudioVars2
0041f88c  ldr       r0, [r0]
0041f890  cmp       r0, #0
0041f894  beq       #0x420094
0041f898  ldr       r0, [r0, #0x4c8]
0041f89c  cmp       r0, #2
0041f8a0  blo       #0x420094
0041f8a4  movw      r0, #0  rel→.L.str.1282
0041f8a8  movt      r0, #0  rel→.L.str.1282
0041f8ac  bl        #0x41f8ac  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041f8b0  cmp       r0, #1
0041f8b4  bne       #0x420094
0041f8b8  movw      r0, #0  rel→.L.str.1283
0041f8bc  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f8c0  movt      r0, #0  rel→.L.str.1283
0041f8c4  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f8c8  movw      r2, #0x21fb
0041f8cc  mov       r3, r5
0041f8d0  bl        #0x41f8d0  rel→printk; CALL printk
0041f8d4  b         #0x420094
0041f8d8  movw      r0, #0  rel→g_AudioVars2
0041f8dc  mov       r4, #0
0041f8e0  movt      r0, #0  rel→g_AudioVars2
0041f8e4  ldr       r0, [r0]
0041f8e8  cmp       r0, #0
0041f8ec  ldrne     r0, [r0, #0x4c8]
0041f8f0  cmpne     r0, #0
0041f8f4  beq       #0x420094
0041f8f8  movw      r0, #0  rel→.L.str
0041f8fc  movt      r0, #0  rel→.L.str
0041f900  bl        #0x41f900  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041f904  cmp       r0, #1
0041f908  bne       #0x420094
0041f90c  movw      r0, #0  rel→.L.str.1258
0041f910  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f914  movt      r0, #0  rel→.L.str.1258
0041f918  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f91c  movw      r2, #0x217b
0041f920  bl        #0x41f920  rel→printk; CALL printk
0041f924  b         #0x420094
0041f928  bl        #0x41f928  rel→MDrv_AUDIO_Get_AC3_License; CALL MDrv_AUDIO_Get_AC3_License
0041f92c  cmp       r0, #0
0041f930  beq       #0x41fa54
0041f934  movw      r0, #0  rel→g_AudioVars2
0041f938  mov       r4, #0
0041f93c  movt      r0, #0  rel→g_AudioVars2
0041f940  ldr       r0, [r0]
0041f944  cmp       r0, #0
0041f948  beq       #0x420094
0041f94c  ldr       r0, [r0, #0x4c8]
0041f950  cmp       r0, #4
0041f954  blo       #0x420094
0041f958  movw      r0, #0  rel→.L.str.38
0041f95c  movt      r0, #0  rel→.L.str.38
0041f960  bl        #0x41f960  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041f964  cmp       r0, #1
0041f968  bne       #0x420094
0041f96c  movw      r0, #0  rel→.L.str.1260
0041f970  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f974  movt      r0, #0  rel→.L.str.1260
0041f978  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f97c  movw      r2, #0x218a
0041f980  bl        #0x41f980  rel→printk; CALL printk
0041f984  b         #0x420094
0041f988  bl        #0x41f988  rel→MDrv_AUDIO_Get_AC4_License; CALL MDrv_AUDIO_Get_AC4_License
0041f98c  cmp       r0, #0
0041f990  bne       #0x41f9a0
0041f994  ldrb      r0, [sp, #3]
0041f998  tst       r0, #2
0041f99c  bne       #0x41fbe0
0041f9a0  movw      r0, #0  rel→g_AudioVars2
0041f9a4  mov       r4, #0
0041f9a8  movt      r0, #0  rel→g_AudioVars2
0041f9ac  ldr       r0, [r0]
0041f9b0  cmp       r0, #0
0041f9b4  beq       #0x420094
0041f9b8  ldr       r0, [r0, #0x4c8]
0041f9bc  cmp       r0, #4
0041f9c0  blo       #0x420094
0041f9c4  movw      r0, #0  rel→.L.str.38
0041f9c8  movt      r0, #0  rel→.L.str.38
0041f9cc  bl        #0x41f9cc  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041f9d0  cmp       r0, #1
0041f9d4  bne       #0x420094
0041f9d8  movw      r0, #0  rel→.L.str.1262
0041f9dc  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f9e0  movt      r0, #0  rel→.L.str.1262
0041f9e4  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041f9e8  movw      r2, #0x2196
0041f9ec  bl        #0x41f9ec  rel→printk; CALL printk
0041f9f0  b         #0x420094
0041f9f4  bl        #0x41f9f4  rel→MDrv_AUDIO_Get_AAC_License; CALL MDrv_AUDIO_Get_AAC_License
0041f9f8  cmp       r0, #0
0041f9fc  beq       #0x41fb80
0041fa00  movw      r0, #0  rel→g_AudioVars2
0041fa04  mov       r4, #0
0041fa08  movt      r0, #0  rel→g_AudioVars2
0041fa0c  ldr       r0, [r0]
0041fa10  cmp       r0, #0
0041fa14  beq       #0x420094
0041fa18  ldr       r0, [r0, #0x4c8]
0041fa1c  cmp       r0, #4
0041fa20  blo       #0x420094
0041fa24  movw      r0, #0  rel→.L.str.38
0041fa28  movt      r0, #0  rel→.L.str.38
0041fa2c  bl        #0x41fa2c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fa30  cmp       r0, #1
0041fa34  bne       #0x420094
0041fa38  movw      r0, #0  rel→.L.str.1264
0041fa3c  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fa40  movt      r0, #0  rel→.L.str.1264
0041fa44  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fa48  movw      r2, #0x21a2
0041fa4c  bl        #0x41fa4c  rel→printk; CALL printk
0041fa50  b         #0x420094
0041fa54  ldrb      r0, [sp]
0041fa58  tst       r0, #0x30
0041fa5c  beq       #0x41f934
0041fa60  movw      r0, #0  rel→g_AudioVars2
0041fa64  mov       r4, #1
0041fa68  movt      r0, #0  rel→g_AudioVars2
0041fa6c  ldr       r0, [r0]
0041fa70  cmp       r0, #0
0041fa74  beq       #0x420094
0041fa78  ldr       r0, [r0, #0x4c8]
0041fa7c  cmp       r0, #4
0041fa80  blo       #0x420094
0041fa84  movw      r0, #0  rel→.L.str.38
0041fa88  movt      r0, #0  rel→.L.str.38
0041fa8c  bl        #0x41fa8c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fa90  cmp       r0, #1
0041fa94  bne       #0x420094
0041fa98  movw      r0, #0  rel→.L.str.1259
0041fa9c  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041faa0  movt      r0, #0  rel→.L.str.1259
0041faa4  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041faa8  movw      r2, #0x2185
0041faac  bl        #0x41faac  rel→printk; CALL printk
0041fab0  b         #0x420094
0041fab4  bl        #0x41fab4  rel→MDrv_AUDIO_Get_MPEGH_License; CALL MDrv_AUDIO_Get_MPEGH_License
0041fab8  cmp       r0, #0
0041fabc  bne       #0x41facc
0041fac0  ldrb      r0, [sp, #3]
0041fac4  tst       r0, #4
0041fac8  bne       #0x41fd68
0041facc  movw      r0, #0  rel→g_AudioVars2
0041fad0  mov       r4, #0
0041fad4  movt      r0, #0  rel→g_AudioVars2
0041fad8  ldr       r0, [r0]
0041fadc  cmp       r0, #0
0041fae0  beq       #0x420094
0041fae4  ldr       r0, [r0, #0x4c8]
0041fae8  cmp       r0, #4
0041faec  blo       #0x420094
0041faf0  movw      r0, #0  rel→.L.str.38
0041faf4  movt      r0, #0  rel→.L.str.38
0041faf8  bl        #0x41faf8  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fafc  cmp       r0, #1
0041fb00  bne       #0x420094
0041fb04  movw      r0, #0  rel→.L.str.1267
0041fb08  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fb0c  movt      r0, #0  rel→.L.str.1267
0041fb10  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fb14  movw      r2, #0x21ae
0041fb18  bl        #0x41fb18  rel→printk; CALL printk
0041fb1c  b         #0x420094
0041fb20  bl        #0x41fb20  rel→MDrv_AUDIO_Get_DTS_License; CALL MDrv_AUDIO_Get_DTS_License
0041fb24  cmp       r0, #0
0041fb28  beq       #0x41fd00
0041fb2c  movw      r0, #0  rel→g_AudioVars2
0041fb30  mov       r4, #0
0041fb34  movt      r0, #0  rel→g_AudioVars2
0041fb38  ldr       r0, [r0]
0041fb3c  cmp       r0, #0
0041fb40  beq       #0x420094
0041fb44  ldr       r0, [r0, #0x4c8]
0041fb48  cmp       r0, #4
0041fb4c  blo       #0x420094
0041fb50  movw      r0, #0  rel→.L.str.38
0041fb54  movt      r0, #0  rel→.L.str.38
0041fb58  bl        #0x41fb58  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fb5c  cmp       r0, #1
0041fb60  bne       #0x420094
0041fb64  movw      r0, #0  rel→.L.str.1269
0041fb68  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fb6c  movt      r0, #0  rel→.L.str.1269
0041fb70  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fb74  movw      r2, #0x21ba
0041fb78  bl        #0x41fb78  rel→printk; CALL printk
0041fb7c  b         #0x420094
0041fb80  ldrh      r0, [sp]
0041fb84  tst       r0, #0x3c0
0041fb88  beq       #0x41fa00
0041fb8c  movw      r0, #0  rel→g_AudioVars2
0041fb90  mov       r4, #1
0041fb94  movt      r0, #0  rel→g_AudioVars2
0041fb98  ldr       r0, [r0]
0041fb9c  cmp       r0, #0
0041fba0  beq       #0x420094
0041fba4  ldr       r0, [r0, #0x4c8]
0041fba8  cmp       r0, #4
0041fbac  blo       #0x420094
0041fbb0  movw      r0, #0  rel→.L.str.38
0041fbb4  movt      r0, #0  rel→.L.str.38
0041fbb8  bl        #0x41fbb8  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fbbc  cmp       r0, #1
0041fbc0  bne       #0x420094
0041fbc4  movw      r0, #0  rel→.L.str.1263
0041fbc8  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fbcc  movt      r0, #0  rel→.L.str.1263
0041fbd0  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fbd4  movw      r2, #0x219d
0041fbd8  bl        #0x41fbd8  rel→printk; CALL printk
0041fbdc  b         #0x420094
0041fbe0  movw      r0, #0  rel→g_AudioVars2
0041fbe4  mov       r4, #1
0041fbe8  movt      r0, #0  rel→g_AudioVars2
0041fbec  ldr       r0, [r0]
0041fbf0  cmp       r0, #0
0041fbf4  beq       #0x420094
0041fbf8  ldr       r0, [r0, #0x4c8]
0041fbfc  cmp       r0, #4
0041fc00  blo       #0x420094
0041fc04  movw      r0, #0  rel→.L.str.38
0041fc08  movt      r0, #0  rel→.L.str.38
0041fc0c  bl        #0x41fc0c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fc10  cmp       r0, #1
0041fc14  bne       #0x420094
0041fc18  movw      r0, #0  rel→.L.str.1261
0041fc1c  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fc20  movt      r0, #0  rel→.L.str.1261
0041fc24  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fc28  movw      r2, #0x2191
0041fc2c  bl        #0x41fc2c  rel→printk; CALL printk
0041fc30  b         #0x420094
0041fc34  bl        #0x41fc34  rel→MDrv_AUDIO_Get_WMA_License; CALL MDrv_AUDIO_Get_WMA_License
0041fc38  cmp       r0, #0
0041fc3c  beq       #0x41fe28
0041fc40  movw      r0, #0  rel→g_AudioVars2
0041fc44  mov       r4, #0
0041fc48  movt      r0, #0  rel→g_AudioVars2
0041fc4c  ldr       r0, [r0]
0041fc50  cmp       r0, #0
0041fc54  beq       #0x420094
0041fc58  ldr       r0, [r0, #0x4c8]
0041fc5c  cmp       r0, #4
0041fc60  blo       #0x420094
0041fc64  movw      r0, #0  rel→.L.str.38
0041fc68  movt      r0, #0  rel→.L.str.38
0041fc6c  bl        #0x41fc6c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fc70  cmp       r0, #1
0041fc74  bne       #0x420094
0041fc78  movw      r0, #0  rel→.L.str.1271
0041fc7c  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fc80  movt      r0, #0  rel→.L.str.1271
0041fc84  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fc88  movw      r2, #0x21c6
0041fc8c  bl        #0x41fc8c  rel→printk; CALL printk
0041fc90  b         #0x420094
0041fc94  bl        #0x41fc94  rel→MDrv_AUDIO_Get_DRA_License; CALL MDrv_AUDIO_Get_DRA_License
0041fc98  cmp       r0, #0
0041fc9c  bne       #0x41fcac
0041fca0  ldrb      r0, [sp, #2]
0041fca4  tst       r0, #0x10
0041fca8  bne       #0x41ff60
0041fcac  movw      r0, #0  rel→g_AudioVars2
0041fcb0  mov       r4, #0
0041fcb4  movt      r0, #0  rel→g_AudioVars2
0041fcb8  ldr       r0, [r0]
0041fcbc  cmp       r0, #0
0041fcc0  beq       #0x420094
0041fcc4  ldr       r0, [r0, #0x4c8]
0041fcc8  cmp       r0, #4
0041fccc  blo       #0x420094
0041fcd0  movw      r0, #0  rel→.L.str.38
0041fcd4  movt      r0, #0  rel→.L.str.38
0041fcd8  bl        #0x41fcd8  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fcdc  cmp       r0, #1
0041fce0  bne       #0x420094
0041fce4  movw      r0, #0  rel→.L.str.1273
0041fce8  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fcec  movt      r0, #0  rel→.L.str.1273
0041fcf0  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fcf4  movw      r2, #0x21d2
0041fcf8  bl        #0x41fcf8  rel→printk; CALL printk
0041fcfc  b         #0x420094
0041fd00  ldr       r1, [sp]
0041fd04  movw      r0, #0x2000
0041fd08  movt      r0, #0x1a0
0041fd0c  tst       r1, r0
0041fd10  beq       #0x41fb2c
0041fd14  movw      r0, #0  rel→g_AudioVars2
0041fd18  mov       r4, #1
0041fd1c  movt      r0, #0  rel→g_AudioVars2
0041fd20  ldr       r0, [r0]
0041fd24  cmp       r0, #0
0041fd28  beq       #0x420094
0041fd2c  ldr       r0, [r0, #0x4c8]
0041fd30  cmp       r0, #4
0041fd34  blo       #0x420094
0041fd38  movw      r0, #0  rel→.L.str.38
0041fd3c  movt      r0, #0  rel→.L.str.38
0041fd40  bl        #0x41fd40  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fd44  cmp       r0, #1
0041fd48  bne       #0x420094
0041fd4c  movw      r0, #0  rel→.L.str.1268
0041fd50  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fd54  movt      r0, #0  rel→.L.str.1268
0041fd58  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fd5c  movw      r2, #0x21b5
0041fd60  bl        #0x41fd60  rel→printk; CALL printk
0041fd64  b         #0x420094
0041fd68  movw      r0, #0  rel→g_AudioVars2
0041fd6c  mov       r4, #1
0041fd70  movt      r0, #0  rel→g_AudioVars2
0041fd74  ldr       r0, [r0]
0041fd78  cmp       r0, #0
0041fd7c  beq       #0x420094
0041fd80  ldr       r0, [r0, #0x4c8]
0041fd84  cmp       r0, #4
0041fd88  blo       #0x420094
0041fd8c  movw      r0, #0  rel→.L.str.38
0041fd90  movt      r0, #0  rel→.L.str.38
0041fd94  bl        #0x41fd94  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fd98  cmp       r0, #1
0041fd9c  bne       #0x420094
0041fda0  movw      r0, #0  rel→.L.str.1266
0041fda4  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fda8  movt      r0, #0  rel→.L.str.1266
0041fdac  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fdb0  movw      r2, #0x21a9
0041fdb4  bl        #0x41fdb4  rel→printk; CALL printk
0041fdb8  b         #0x420094
0041fdbc  bl        #0x41fdbc  rel→MDrv_AUDIO_Get_COOK_License; CALL MDrv_AUDIO_Get_COOK_License
0041fdc0  cmp       r0, #0
0041fdc4  bne       #0x41fdd4
0041fdc8  ldrb      r0, [sp, #1]
0041fdcc  tst       r0, #0x10
0041fdd0  bne       #0x41ffb4
0041fdd4  movw      r0, #0  rel→g_AudioVars2
0041fdd8  mov       r4, #0
0041fddc  movt      r0, #0  rel→g_AudioVars2
0041fde0  ldr       r0, [r0]
0041fde4  cmp       r0, #0
0041fde8  beq       #0x420094
0041fdec  ldr       r0, [r0, #0x4c8]
0041fdf0  cmp       r0, #4
0041fdf4  blo       #0x420094
0041fdf8  movw      r0, #0  rel→.L.str.38
0041fdfc  movt      r0, #0  rel→.L.str.38
0041fe00  bl        #0x41fe00  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fe04  cmp       r0, #1
0041fe08  bne       #0x420094
0041fe0c  movw      r0, #0  rel→.L.str.1276
0041fe10  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fe14  movt      r0, #0  rel→.L.str.1276
0041fe18  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fe1c  movw      r2, #0x21de
0041fe20  bl        #0x41fe20  rel→printk; CALL printk
0041fe24  b         #0x420094
0041fe28  ldrb      r0, [sp, #1]
0041fe2c  tst       r0, #0xc
0041fe30  beq       #0x41fc40
0041fe34  movw      r0, #0  rel→g_AudioVars2
0041fe38  mov       r4, #1
0041fe3c  movt      r0, #0  rel→g_AudioVars2
0041fe40  ldr       r0, [r0]
0041fe44  cmp       r0, #0
0041fe48  beq       #0x420094
0041fe4c  ldr       r0, [r0, #0x4c8]
0041fe50  cmp       r0, #4
0041fe54  blo       #0x420094
0041fe58  movw      r0, #0  rel→.L.str.38
0041fe5c  movt      r0, #0  rel→.L.str.38
0041fe60  bl        #0x41fe60  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fe64  cmp       r0, #1
0041fe68  bne       #0x420094
0041fe6c  movw      r0, #0  rel→.L.str.1270
0041fe70  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fe74  movt      r0, #0  rel→.L.str.1270
0041fe78  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fe7c  movw      r2, #0x21c1
0041fe80  bl        #0x41fe80  rel→printk; CALL printk
0041fe84  b         #0x420094
0041fe88  bl        #0x41fe88  rel→MDrv_AUDIO_Get_MAT_License; CALL MDrv_AUDIO_Get_MAT_License
0041fe8c  cmp       r0, #0
0041fe90  bne       #0x41fea0
0041fe94  ldrb      r0, [sp, #3]
0041fe98  tst       r0, #0x20
0041fe9c  bne       #0x420008
0041fea0  movw      r0, #0  rel→g_AudioVars2
0041fea4  mov       r4, #0
0041fea8  movt      r0, #0  rel→g_AudioVars2
0041feac  ldr       r0, [r0]
0041feb0  cmp       r0, #0
0041feb4  beq       #0x420094
0041feb8  ldr       r0, [r0, #0x4c8]
0041febc  cmp       r0, #4
0041fec0  blo       #0x420094
0041fec4  movw      r0, #0  rel→.L.str.38
0041fec8  movt      r0, #0  rel→.L.str.38
0041fecc  bl        #0x41fecc  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041fed0  cmp       r0, #1
0041fed4  bne       #0x420094
0041fed8  movw      r0, #0  rel→.L.str.1278
0041fedc  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fee0  movt      r0, #0  rel→.L.str.1278
0041fee4  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fee8  movw      r2, #0x21ea
0041feec  bl        #0x41feec  rel→printk; CALL printk
0041fef0  b         #0x420094
0041fef4  bl        #0x41fef4  rel→MDrv_AUDIO_Get_MAT_License; CALL MDrv_AUDIO_Get_MAT_License
0041fef8  cmp       r0, #0
0041fefc  bne       #0x41ff0c
0041ff00  ldrb      r0, [sp, #3]
0041ff04  tst       r0, #0x20
0041ff08  bne       #0x42005c
0041ff0c  movw      r0, #0  rel→g_AudioVars2
0041ff10  mov       r4, #0
0041ff14  movt      r0, #0  rel→g_AudioVars2
0041ff18  ldr       r0, [r0]
0041ff1c  cmp       r0, #0
0041ff20  beq       #0x420094
0041ff24  ldr       r0, [r0, #0x4c8]
0041ff28  cmp       r0, #4
0041ff2c  blo       #0x420094
0041ff30  movw      r0, #0  rel→.L.str.38
0041ff34  movt      r0, #0  rel→.L.str.38
0041ff38  bl        #0x41ff38  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041ff3c  cmp       r0, #1
0041ff40  bne       #0x420094
0041ff44  movw      r0, #0  rel→.L.str.1281
0041ff48  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041ff4c  movt      r0, #0  rel→.L.str.1281
0041ff50  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041ff54  movw      r2, #0x21f6
0041ff58  bl        #0x41ff58  rel→printk; CALL printk
0041ff5c  b         #0x420094
0041ff60  movw      r0, #0  rel→g_AudioVars2
0041ff64  mov       r4, #1
0041ff68  movt      r0, #0  rel→g_AudioVars2
0041ff6c  ldr       r0, [r0]
0041ff70  cmp       r0, #0
0041ff74  beq       #0x420094
0041ff78  ldr       r0, [r0, #0x4c8]
0041ff7c  cmp       r0, #4
0041ff80  blo       #0x420094
0041ff84  movw      r0, #0  rel→.L.str.38
0041ff88  movt      r0, #0  rel→.L.str.38
0041ff8c  bl        #0x41ff8c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041ff90  cmp       r0, #1
0041ff94  bne       #0x420094
0041ff98  movw      r0, #0  rel→.L.str.1272
0041ff9c  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041ffa0  movt      r0, #0  rel→.L.str.1272
0041ffa4  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041ffa8  movw      r2, #0x21cd
0041ffac  bl        #0x41ffac  rel→printk; CALL printk
0041ffb0  b         #0x420094
0041ffb4  movw      r0, #0  rel→g_AudioVars2
0041ffb8  mov       r4, #1
0041ffbc  movt      r0, #0  rel→g_AudioVars2
0041ffc0  ldr       r0, [r0]
0041ffc4  cmp       r0, #0
0041ffc8  beq       #0x420094
0041ffcc  ldr       r0, [r0, #0x4c8]
0041ffd0  cmp       r0, #4
0041ffd4  blo       #0x420094
0041ffd8  movw      r0, #0  rel→.L.str.38
0041ffdc  movt      r0, #0  rel→.L.str.38
0041ffe0  bl        #0x41ffe0  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0041ffe4  cmp       r0, #1
0041ffe8  bne       #0x420094
0041ffec  movw      r0, #0  rel→.L.str.1275
0041fff0  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fff4  movt      r0, #0  rel→.L.str.1275
0041fff8  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
0041fffc  movw      r2, #0x21d9
00420000  bl        #0x420000  rel→printk; CALL printk
00420004  b         #0x420094
00420008  movw      r0, #0  rel→g_AudioVars2
0042000c  mov       r4, #1
00420010  movt      r0, #0  rel→g_AudioVars2
00420014  ldr       r0, [r0]
00420018  cmp       r0, #0
0042001c  beq       #0x420094
00420020  ldr       r0, [r0, #0x4c8]
00420024  cmp       r0, #4
00420028  blo       #0x420094
0042002c  movw      r0, #0  rel→.L.str.38
00420030  movt      r0, #0  rel→.L.str.38
00420034  bl        #0x420034  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00420038  cmp       r0, #1
0042003c  bne       #0x420094
00420040  movw      r0, #0  rel→.L.str.1277
00420044  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
00420048  movt      r0, #0  rel→.L.str.1277
0042004c  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
00420050  movw      r2, #0x21e5
00420054  bl        #0x420054  rel→printk; CALL printk
00420058  b         #0x420094
0042005c  movw      r0, #0  rel→g_AudioVars2
00420060  mov       r4, #1
00420064  movt      r0, #0  rel→g_AudioVars2
00420068  ldr       r0, [r0]
0042006c  cmp       r0, #0
00420070  beq       #0x420094
00420074  ldr       r0, [r0, #0x4c8]
00420078  cmp       r0, #4
0042007c  blo       #0x420094
00420080  movw      r0, #0  rel→.L.str.38
00420084  movt      r0, #0  rel→.L.str.38
00420088  bl        #0x420088  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0042008c  cmp       r0, #1
00420090  beq       #0x4200b0
00420094  ldr       r0, [r6]
00420098  ldr       r1, [sp, #4]
0042009c  subs      r0, r0, r1
004200a0  moveq     r0, r4
004200a4  addeq     sp, sp, #8
004200a8  popeq     {r4, r5, r6, pc}
004200ac  bl        #0x4200ac  rel→__stack_chk_fail; CALL __stack_chk_fail
004200b0  movw      r0, #0  rel→.L.str.1280
004200b4  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
004200b8  movt      r0, #0  rel→.L.str.1280
004200bc  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_Decoder_Support
004200c0  movw      r2, #0x21f1
004200c4  bl        #0x4200c4  rel→printk; CALL printk
004200c8  b         #0x420094
