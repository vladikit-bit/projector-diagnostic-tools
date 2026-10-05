===== kmods/utpa2k.ko HAL_AUDIO_SPDIF_TranscodeMode sec_off=0x445504 size=0x8b8 mode=A =====
00445504  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
00445508  sub       sp, sp, #0x54
0044550c  movw      r4, #0  rel→__stack_chk_guard
00445510  movw      fp, #0  rel→g_AudioVars2
00445514  movt      r4, #0  rel→__stack_chk_guard
00445518  mov       r8, r0
0044551c  ldr       r0, [r4]
00445520  movt      fp, #0  rel→g_AudioVars2
00445524  str       r0, [sp, #0x50]
00445528  mov       r0, #0
0044552c  str       r0, [sp, #0x4c]
00445530  ldr       r0, [fp]
00445534  cmp       r0, #0
00445538  bne       #0x44554c
0044553c  bl        #0x44553c  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445540  ldr       r0, [fp]
00445544  cmp       r0, #0
00445548  beq       #0x445970
0044554c  mov       r0, r8
00445550  bl        #0x445550  rel→HAL_AUDIO_Get_CodeTypeByDecodeID; CALL HAL_AUDIO_Get_CodeTypeByDecodeID
00445554  add       r2, sp, #0x4c
00445558  mov       sb, r0
0044555c  mov       r0, r8
00445560  mov       r1, #0x55
00445564  bl        #0x445564  rel→HAL_MAD_GetAudioInfo2; CALL HAL_MAD_GetAudioInfo2
00445568  ldr       r0, [fp]
0044556c  mov       r1, #4
00445570  cmp       r0, #0
00445574  str       r1, [r0, #0x14]
00445578  str       r1, [r0, #0x18]
0044557c  ldrb      r1, [r0, #0x385]
00445580  ldrb      r6, [r0, #0x3b0]
00445584  ldrb      r7, [r0, #0x3ad]
00445588  ldrb      sl, [r0, #0x395]
0044558c  ldr       r5, [r0, #0x4f0]
00445590  ldr       r4, [r0, #0x4f4]
00445594  str       r1, [sp, #0x44]
00445598  ldrb      r1, [r0, #0x399]
0044559c  str       r1, [sp, #0x40]
004455a0  ldrb      r1, [r0, #0x3a5]
004455a4  str       r1, [sp, #0x48]
004455a8  bne       #0x4455bc
004455ac  bl        #0x4455ac  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
004455b0  ldr       r0, [fp]
004455b4  cmp       r0, #0
004455b8  beq       #0x4458d8
004455bc  mov       r1, #0xff
004455c0  str       r1, [r0, #0x52c]
004455c4  str       r1, [r0, #0x530]
004455c8  movw      r1, #0x2501
004455cc  ldrb      r2, [r0, #0xb]
004455d0  add       r1, r0, r1
004455d4  cmp       r2, #1
004455d8  beq       #0x4455f0
004455dc  ldrb      r2, [r0, #0x4e4]
004455e0  tst       r2, #4
004455e4  ldrbeq    r2, [r1]
004455e8  cmpeq     r2, #0
004455ec  movne     r5, r4
004455f0  cmp       r5, #6
004455f4  bhi       #0x44587c
004455f8  add       r2, pc, #0
004455fc  ldr       pc, [r2, r5, lsl #2]
00445600  subeq     r5, r4, r4, asr #12  rel→
00445604  subeq     r5, r4, r0, lsr r8  rel→
00445608  subeq     r5, r4, ip, lsl r6  rel→
0044560c  subeq     r5, r4, ip, ror r8  rel→
00445610  subeq     r5, r4, ip, ror r8  rel→
00445614  subeq     r5, r4, ip, lsl r6  rel→
00445618  subeq     r5, r4, r0, lsr #17  rel→
0044561c  movw      r4, #0  rel→__stack_chk_guard
00445620  cmp       sb, #0x19
00445624  movt      r4, #0  rel→__stack_chk_guard
00445628  bhi       #0x4459f0
0044562c  movw      r2, #0x400
00445630  mov       r1, #1
00445634  movt      r2, #0x201
00445638  tst       r2, r1, lsl sb
0044563c  bne       #0x4458c4
00445640  b         #0x4459f0
00445644  ldr       r1, [r0, #0x1cc]
00445648  movw      r4, #0  rel→__stack_chk_guard
0044564c  movt      r4, #0  rel→__stack_chk_guard
00445650  cmp       r1, #7
00445654  bhi       #0x445b08
00445658  mov       r2, #1
0044565c  mov       r3, #0x4a
00445660  tst       r3, r2, lsl r1
00445664  bne       #0x4458e0
00445668  mov       r3, #0x91
0044566c  tst       r3, r2, lsl r1
00445670  beq       #0x445ad4
00445674  sub       r0, sb, #2
00445678  cmp       r0, #0x59
0044567c  bhi       #0x445ae8
00445680  add       r1, pc, #0
00445684  ldr       pc, [r1, r0, lsl #2]
00445688  strdeq    r5, r6, [r4], #-0x70  rel→
0044568c  strdeq    r5, r6, [r4], #-0x70  rel→
00445690  strheq    r5, [r4], #-0xbc  rel→
00445694  subeq     r5, r4, r8, ror #21  rel→
00445698  subeq     r5, r4, r8, ror #21  rel→
0044569c  subeq     r5, r4, r8, ror #21  rel→
004456a0  subeq     r5, r4, r8, ror #21  rel→
004456a4  subeq     r5, r4, r8, ror #21  rel→
004456a8  subeq     r5, r4, r8, ror fp  rel→
004456ac  strheq    r5, [r4], #-0xbc  rel→
004456b0  strdeq    r5, r6, [r4], #-0x70  rel→
004456b4  subeq     r5, r4, r8, ror #21  rel→
004456b8  subeq     r5, r4, r8, ror #21  rel→
004456bc  subeq     r5, r4, r8, ror #21  rel→
004456c0  subeq     r5, r4, r8, ror fp  rel→
004456c4  subeq     r5, r4, r8, ror #21  rel→
004456c8  subeq     r5, r4, r8, ror #21  rel→
004456cc  subeq     r5, r4, r8, ror #21  rel→
004456d0  subeq     r5, r4, r8, ror #21  rel→
004456d4  subeq     r5, r4, r8, ror #21  rel→
004456d8  subeq     r5, r4, r8, ror #21  rel→
004456dc  strdeq    r5, r6, [r4], #-0x70  rel→
004456e0  subeq     r5, r4, r8, ror #21  rel→
004456e4  subeq     r5, r4, r8, ror fp  rel→
004456e8  subeq     r5, r4, r8, ror #21  rel→
004456ec  strdeq    r5, r6, [r4], #-0x70  rel→
004456f0  subeq     r5, r4, r8, ror #21  rel→
004456f4  subeq     r5, r4, r8, ror #21  rel→
004456f8  subeq     r5, r4, r8, ror #21  rel→
004456fc  subeq     r5, r4, r8, ror #21  rel→
00445700  subeq     r5, r4, r8, ror #21  rel→
00445704  subeq     r5, r4, r8, ror #21  rel→
00445708  subeq     r5, r4, r8, ror #21  rel→
0044570c  subeq     r5, r4, r8, ror #21  rel→
00445710  subeq     r5, r4, r8, ror #21  rel→
00445714  subeq     r5, r4, r8, ror #21  rel→
00445718  subeq     r5, r4, r8, ror #21  rel→
0044571c  subeq     r5, r4, r8, ror #21  rel→
00445720  subeq     r5, r4, r8, ror #21  rel→
00445724  subeq     r5, r4, r8, ror #21  rel→
00445728  subeq     r5, r4, r8, ror #21  rel→
0044572c  subeq     r5, r4, r8, ror #21  rel→
00445730  subeq     r5, r4, r8, ror #21  rel→
00445734  subeq     r5, r4, r8, ror #21  rel→
00445738  subeq     r5, r4, r8, ror #21  rel→
0044573c  subeq     r5, r4, r8, ror #21  rel→
00445740  strdeq    r5, r6, [r4], #-0x70  rel→
00445744  subeq     r5, r4, r8, ror #21  rel→
00445748  subeq     r5, r4, r8, ror #21  rel→
0044574c  subeq     r5, r4, r8, ror #21  rel→
00445750  subeq     r5, r4, r8, ror #21  rel→
00445754  subeq     r5, r4, r8, ror #21  rel→
00445758  subeq     r5, r4, r8, ror #21  rel→
0044575c  subeq     r5, r4, r8, ror #21  rel→
00445760  subeq     r5, r4, r8, ror #21  rel→
00445764  subeq     r5, r4, r8, ror #21  rel→
00445768  subeq     r5, r4, r8, ror #21  rel→
0044576c  subeq     r5, r4, r8, ror #21  rel→
00445770  subeq     r5, r4, r8, ror #21  rel→
00445774  subeq     r5, r4, r8, ror #21  rel→
00445778  subeq     r5, r4, r8, ror #21  rel→
0044577c  subeq     r5, r4, r8, ror #21  rel→
00445780  subeq     r5, r4, r8, ror #21  rel→
00445784  subeq     r5, r4, r8, ror #21  rel→
00445788  subeq     r5, r4, r8, ror #21  rel→
0044578c  subeq     r5, r4, r8, ror #21  rel→
00445790  subeq     r5, r4, r8, ror #21  rel→
00445794  subeq     r5, r4, r8, ror #21  rel→
00445798  subeq     r5, r4, r8, ror #21  rel→
0044579c  subeq     r5, r4, r8, ror #21  rel→
004457a0  subeq     r5, r4, r8, ror #21  rel→
004457a4  subeq     r5, r4, r8, ror #21  rel→
004457a8  subeq     r5, r4, r8, ror #21  rel→
004457ac  subeq     r5, r4, r8, ror #21  rel→
004457b0  subeq     r5, r4, r8, ror #21  rel→
004457b4  subeq     r5, r4, r8, ror #21  rel→
004457b8  subeq     r5, r4, r8, ror #21  rel→
004457bc  subeq     r5, r4, r8, ror #21  rel→
004457c0  subeq     r5, r4, r8, ror #21  rel→
004457c4  subeq     r5, r4, r8, ror #21  rel→
004457c8  subeq     r5, r4, r8, ror #21  rel→
004457cc  subeq     r5, r4, r8, ror #21  rel→
004457d0  subeq     r5, r4, r8, ror #21  rel→
004457d4  subeq     r5, r4, r8, ror #21  rel→
004457d8  subeq     r5, r4, r8, ror #21  rel→
004457dc  subeq     r5, r4, r8, ror #21  rel→
004457e0  subeq     r5, r4, r8, ror #21  rel→
004457e4  subeq     r5, r4, r8, ror #21  rel→
004457e8  subeq     r5, r4, r8, ror #21  rel→
004457ec  strdeq    r5, r6, [r4], #-0x70  rel→
004457f0  ldr       r0, [sp, #0x48]
004457f4  mov       r7, sl
004457f8  cmp       r0, #1
004457fc  bne       #0x445b50
00445800  ldr       r0, [fp]
00445804  ldrb      r1, [r0, #0x57f]
00445808  cmp       r1, #0
0044580c  beq       #0x445ba4
00445810  ldrb      r1, [r0, #0x4e4]
00445814  tst       r1, #1
00445818  bne       #0x4458f0
0044581c  mov       r1, #0
00445820  str       r1, [r0, #0x14]
00445824  mov       r1, #1
00445828  strb      r1, [r0, #0x573]
0044582c  b         #0x4458f0
00445830  movw      r4, #0  rel→__stack_chk_guard
00445834  cmp       sb, #0x19
00445838  movt      r4, #0  rel→__stack_chk_guard
0044583c  bhi       #0x445854
00445840  movw      r2, #0x400
00445844  mov       r1, #1
00445848  movt      r2, #0x201
0044584c  tst       r2, r1, lsl sb
00445850  bne       #0x4458c4
00445854  ldr       r1, [sp, #0x44]
00445858  cmp       r1, #2
0044585c  beq       #0x4458c4
00445860  ldrb      r1, [r0, #0x57f]
00445864  mov       r7, sl
00445868  cmp       r1, #0
0044586c  beq       #0x445c60
00445870  mov       r1, #1
00445874  strb      r1, [r0, #0x574]
00445878  b         #0x445d84
0044587c  movw      r4, #0  rel→__stack_chk_guard
00445880  mov       r1, #0
00445884  mov       r7, sl
00445888  cmp       r0, #0
0044588c  movt      r4, #0  rel→__stack_chk_guard
00445890  str       r1, [r0, #0x14]
00445894  str       r1, [r0, #0x18]
00445898  bne       #0x44590c
0044589c  b         #0x4458fc
004458a0  movw      r4, #0  rel→__stack_chk_guard
004458a4  cmp       sb, #0x19
004458a8  movt      r4, #0  rel→__stack_chk_guard
004458ac  bhi       #0x445988
004458b0  movw      r3, #0x400
004458b4  mov       r2, #1
004458b8  movt      r3, #0x201
004458bc  tst       r3, r2, lsl sb
004458c0  beq       #0x445988
004458c4  mov       r7, sl
004458c8  mov       r1, #0
004458cc  str       r1, [r0, #0x14]
004458d0  str       r1, [r0, #0x18]
004458d4  b         #0x445918
004458d8  mov       r0, #0
004458dc  b         #0x4455c8
004458e0  mov       r7, sl
004458e4  mov       r1, #0
004458e8  str       r1, [r0, #0x14]
004458ec  str       r1, [r0, #0x18]
004458f0  ldr       r0, [fp]
004458f4  cmp       r0, #0
004458f8  bne       #0x44590c
004458fc  bl        #0x4458fc  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445900  ldr       r0, [fp]
00445904  cmp       r0, #0
00445908  beq       #0x445918
0044590c  mov       r1, #0xff
00445910  str       r1, [r0, #0x52c]
00445914  str       r1, [r0, #0x530]
00445918  movw      sl, #0  rel→HAL_AUDIO_SPDIF_TranscodeMode.u32SysTime
0044591c  movt      sl, #0  rel→HAL_AUDIO_SPDIF_TranscodeMode.u32SysTime
00445920  ldr       r0, [sl]
00445924  cmp       r0, #0
00445928  beq       #0x445968
0044592c  bl        #0x44592c  rel→MsOS_Timer_DiffTimeFromNow; CALL MsOS_Timer_DiffTimeFromNow
00445930  movw      r1, #0x1388
00445934  cmp       r0, r1
00445938  blo       #0x445970
0044593c  ldr       r0, [fp]
00445940  cmp       r0, #0
00445944  beq       #0x445968
00445948  ldr       r0, [r0, #0x4c8]
0044594c  cmp       r0, #4
00445950  blo       #0x445968
00445954  movw      r0, #0  rel→.L.str.2
00445958  movt      r0, #0  rel→.L.str.2
0044595c  bl        #0x44595c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00445960  cmp       r0, #1
00445964  beq       #0x445c78
00445968  bl        #0x445968  rel→MsOS_GetSystemTime; CALL MsOS_GetSystemTime
0044596c  str       r0, [sl]
00445970  ldr       r0, [r4]
00445974  ldr       r1, [sp, #0x50]
00445978  subs      r0, r0, r1
0044597c  addeq     sp, sp, #0x54
00445980  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
00445984  bl        #0x445984  rel→__stack_chk_fail; CALL __stack_chk_fail
00445988  cmp       r7, #1
0044598c  bne       #0x4459f0
00445990  ands      r2, r6, #1
00445994  beq       #0x4459f0
00445998  ldrb      r1, [r1, #1]
0044599c  cmp       r1, #1
004459a0  bne       #0x4459f0
004459a4  ldrb      r1, [r0, #0x57e]
004459a8  cmp       r1, #0
004459ac  beq       #0x445d3c
004459b0  mov       r7, sl
004459b4  cmp       r0, #0
004459b8  bne       #0x4459cc
004459bc  bl        #0x4459bc  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
004459c0  ldr       r0, [fp]
004459c4  cmp       r0, #0
004459c8  beq       #0x445db4
004459cc  mov       r1, #4
004459d0  mov       r2, #1
004459d4  str       r2, [r0, #0x52c]
004459d8  str       r1, [r0, #0x530]
004459dc  mov       r1, #0
004459e0  str       r1, [r0, #0x14]
004459e4  mov       r1, #1
004459e8  strb      r1, [r0, #0x576]
004459ec  b         #0x445918
004459f0  ldr       r1, [sp, #0x48]
004459f4  cmp       r1, #1
004459f8  bne       #0x445a44
004459fc  ldrb      r1, [r0, #0x57f]
00445a00  mov       r7, sl
00445a04  cmp       r1, #0
00445a08  beq       #0x445a94
00445a0c  cmp       r0, #0
00445a10  bne       #0x445a24
00445a14  bl        #0x445a14  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445a18  ldr       r0, [fp]
00445a1c  cmp       r0, #0
00445a20  beq       #0x445d34
00445a24  mov       r1, #1
00445a28  str       r1, [r0, #0x52c]
00445a2c  str       r1, [r0, #0x530]
00445a30  mov       r1, #0
00445a34  str       r1, [r0, #0x14]
00445a38  mov       r1, #1
00445a3c  strb      r1, [r0, #0x573]
00445a40  b         #0x445918
00445a44  ldr       r1, [sp, #0x44]
00445a48  mov       r7, sl
00445a4c  cmp       r1, #2
00445a50  beq       #0x4458c8
00445a54  ldrb      r1, [r0, #0x57f]
00445a58  cmp       r1, #0
00445a5c  beq       #0x445a94
00445a60  cmp       r0, #0
00445a64  bne       #0x445a78
00445a68  bl        #0x445a68  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445a6c  ldr       r0, [fp]
00445a70  cmp       r0, #0
00445a74  beq       #0x445dac
00445a78  mov       r2, #1
00445a7c  mov       r1, #0
00445a80  str       r2, [r0, #0x52c]
00445a84  str       r1, [r0, #0x530]
00445a88  mov       r1, #1
00445a8c  strb      r1, [r0, #0x574]
00445a90  b         #0x445918
00445a94  ldrb      r1, [r0, #0x580]
00445a98  cmp       r1, #0
00445a9c  beq       #0x4458c8
00445aa0  cmp       r0, #0
00445aa4  bne       #0x445ab8
00445aa8  bl        #0x445aa8  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445aac  ldr       r0, [fp]
00445ab0  cmp       r0, #0
00445ab4  beq       #0x445d70
00445ab8  mov       r2, #1
00445abc  mov       r1, #0
00445ac0  str       r2, [r0, #0x52c]
00445ac4  str       r1, [r0, #0x530]
00445ac8  mov       r1, #1
00445acc  strb      r1, [r0, #0x575]
00445ad0  b         #0x445918
00445ad4  cmp       r1, #2
00445ad8  bne       #0x445b08
00445adc  bl        #0x445adc  rel→HAL_AUDIO_HDMI_NonpcmMonitor; CALL HAL_AUDIO_HDMI_NonpcmMonitor
00445ae0  cmp       r0, #0
00445ae4  bne       #0x445674
00445ae8  ldr       r0, [fp]
00445aec  mov       r1, #0
00445af0  mov       r7, sl
00445af4  str       r1, [r0, #0x14]
00445af8  str       r1, [r0, #0x18]
00445afc  cmp       r0, #0
00445b00  bne       #0x44590c
00445b04  b         #0x4458fc
00445b08  cmp       r0, #0
00445b0c  mov       r7, sl
00445b10  ldrne     r0, [r0, #0x4c8]
00445b14  cmpne     r0, #0
00445b18  beq       #0x4458f0
00445b1c  movw      r0, #0  rel→.L.str.11
00445b20  movt      r0, #0  rel→.L.str.11
00445b24  bl        #0x445b24  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00445b28  cmp       r0, #1
00445b2c  bne       #0x4458f0
00445b30  ldr       r0, [fp]
00445b34  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_SPDIF_TranscodeMode
00445b38  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_SPDIF_TranscodeMode
00445b3c  ldr       r2, [r0, #0x1cc]
00445b40  movw      r0, #0  rel→.L.str.61
00445b44  movt      r0, #0  rel→.L.str.61
00445b48  bl        #0x445b48  rel→printk; CALL printk
00445b4c  b         #0x4458f0
00445b50  ldr       r1, [sp, #0x44]
00445b54  ldr       r0, [fp]
00445b58  cmp       r1, #2
00445b5c  beq       #0x4458e4
00445b60  ldrb      r1, [r0, #0x57f]
00445b64  cmp       r1, #0
00445b68  beq       #0x445ba4
00445b6c  mov       r1, #1
00445b70  strb      r1, [r0, #0x574]
00445b74  b         #0x4458f0
00445b78  mov       r0, #0x3d
00445b7c  mov       r1, r8
00445b80  bl        #0x445b80  rel→HAL_DEC_R2_Get_SHM_INFO; CALL HAL_DEC_R2_Get_SHM_INFO
00445b84  mov       r7, sl
00445b88  cmp       r0, #3
00445b8c  bne       #0x445bdc
00445b90  ldr       r0, [fp]
00445b94  mov       r1, #0
00445b98  str       r1, [r0, #0x14]
00445b9c  str       r1, [r0, #0x18]
00445ba0  b         #0x445bfc
00445ba4  ldrb      r1, [r0, #0x580]
00445ba8  cmp       r1, #0
00445bac  beq       #0x4458e4
00445bb0  mov       r1, #1
00445bb4  strb      r1, [r0, #0x575]
00445bb8  b         #0x4458f0
00445bbc  ldr       r0, [fp]
00445bc0  mov       r7, sl
00445bc4  ldrb      r1, [r0, #0x43e]
00445bc8  cmp       r1, #1
00445bcc  ldreq     r1, [sp, #0x48]
00445bd0  cmpeq     r1, #1
00445bd4  bne       #0x4458e4
00445bd8  b         #0x445804
00445bdc  cmp       sb, #0xa
00445be0  cmpeq     r0, #1
00445be4  bne       #0x445bfc
00445be8  mov       r0, #4
00445bec  bl        #0x445bec  rel→HAL_MAD_GetDTSInfo; CALL HAL_MAD_GetDTSInfo
00445bf0  movw      r1, #0  rel→g_u32bDTSCD
00445bf4  movt      r1, #0  rel→g_u32bDTSCD
00445bf8  str       r0, [r1]
00445bfc  ldr       r0, [fp]
00445c00  ldrb      r1, [r0, #0x582]
00445c04  cmp       r1, #1
00445c08  bne       #0x445c50
00445c0c  mov       r1, #1
00445c10  strb      r1, [r0, #0x583]
00445c14  ldr       r1, [sp, #0x40]
00445c18  cmp       r1, #2
00445c1c  beq       #0x4458e4
00445c20  ldrb      r1, [r0, #0x4cd]
00445c24  cmp       r1, #1
00445c28  bne       #0x4458f0
00445c2c  movw      r1, #0  rel→_gMIO_MapBase
00445c30  movw      r2, #0x725
00445c34  movt      r1, #0  rel→_gMIO_MapBase
00445c38  movt      r2, #0xc
00445c3c  ldr       r1, [r1]
00445c40  ldrsb     r1, [r1, r2]
00445c44  cmp       r1, #0
00445c48  bpl       #0x4458e4
00445c4c  b         #0x4458f0
00445c50  ldr       r1, [sp, #0x40]
00445c54  cmp       r1, #2
00445c58  beq       #0x4458e4
00445c5c  b         #0x4458f0
00445c60  ldrb      r1, [r0, #0x580]
00445c64  cmp       r1, #0
00445c68  beq       #0x445d78
00445c6c  mov       r1, #1
00445c70  strb      r1, [r0, #0x575]
00445c74  b         #0x445d84
00445c78  mov       r0, sb
00445c7c  bl        #0x445c7c  rel→_enumToString_CodecType; CALL _enumToString_CodecType
00445c80  str       r0, [sp, #0x3c]
00445c84  ldr       r0, [fp]
00445c88  ldr       r0, [r0, #0x1cc]
00445c8c  bl        #0x445c8c  rel→_enumToString_AudioSource; CALL _enumToString_AudioSource
00445c90  str       r0, [sp, #0x38]
00445c94  ldr       r0, [fp]
00445c98  ldr       r0, [r0, #0x18]
00445c9c  bl        #0x445c9c  rel→_enumToString_SpdifOutputType; CALL _enumToString_SpdifOutputType
00445ca0  mov       sb, r0
00445ca4  ldr       r0, [fp]
00445ca8  ldr       r0, [r0, #0x14]
00445cac  bl        #0x445cac  rel→_enumToString_SpdifOutputType; CALL _enumToString_SpdifOutputType
00445cb0  ldr       r1, [fp]
00445cb4  add       lr, sp, #8
00445cb8  ldr       r5, [sp, #0x4c]
00445cbc  ldrb      r6, [r1, #0x571]
00445cc0  ldrb      r2, [r1, #0x576]
00445cc4  ldrb      r3, [r1, #0x575]
00445cc8  ldrb      ip, [r1, #0x570]
00445ccc  ldrb      r4, [r1, #0x573]
00445cd0  ldrb      r1, [r1, #0x574]
00445cd4  str       r6, [sp, #0x20]
00445cd8  ldr       r6, [sp, #0x48]
00445cdc  str       r6, [sp, #0x28]
00445ce0  ldr       r6, [sp, #0x44]
00445ce4  str       r7, [sp, #0x34]
00445ce8  ldr       r7, [sp, #0x38]
00445cec  str       r6, [sp, #0x2c]
00445cf0  ldr       r6, [sp, #0x40]
00445cf4  str       r5, [sp, #0x24]
00445cf8  str       r6, [sp, #0x30]
00445cfc  stm       sp, {r7, sb}
00445d00  stm       lr, {r0, r2, r4}
00445d04  add       r0, sp, #0x14
00445d08  movw      r4, #0  rel→__stack_chk_guard
00445d0c  ldr       r2, [sp, #0x3c]
00445d10  movt      r4, #0  rel→__stack_chk_guard
00445d14  stm       r0, {r1, r3, ip}
00445d18  movw      r0, #0  rel→.L.str.73
00445d1c  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_SPDIF_TranscodeMode
00445d20  movt      r0, #0  rel→.L.str.73
00445d24  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDIO_SPDIF_TranscodeMode
00445d28  mov       r3, r8
00445d2c  bl        #0x445d2c  rel→printk; CALL printk
00445d30  b         #0x445968
00445d34  mov       r0, #0
00445d38  b         #0x445a30
00445d3c  ldrb      r1, [r0, #0x57f]
00445d40  mov       r7, sl
00445d44  cmp       r1, #0
00445d48  bne       #0x445a0c
00445d4c  ldrb      r1, [r0, #0x580]
00445d50  cmp       r1, #0
00445d54  bne       #0x445aa0
00445d58  mov       r1, #1
00445d5c  cmp       sb, #2
00445d60  strb      r1, [r0, #0x570]
00445d64  movne     r1, #0
00445d68  strne     r1, [r0, #0x14]
00445d6c  b         #0x445918
00445d70  mov       r0, #0
00445d74  b         #0x445ac8
00445d78  mov       r1, #0
00445d7c  str       r1, [r0, #0x14]
00445d80  str       r1, [r0, #0x18]
00445d84  cmp       r0, #0
00445d88  bne       #0x445d9c
00445d8c  bl        #0x445d8c  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
00445d90  ldr       r0, [fp]
00445d94  cmp       r0, #0
00445d98  beq       #0x445918
00445d9c  mov       r2, #1
00445da0  mov       r1, #0
00445da4  str       r2, [r0, #0x52c]
00445da8  b         #0x445914
00445dac  mov       r0, #0
00445db0  b         #0x445a88
00445db4  mov       r0, #0
00445db8  b         #0x4459dc
