===== kmods/mik.ko _MI_AOUT_MonitorTask sec_off=0x971a8 size=0x14dc mode=A =====
000971a8  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
000971ac  sub       sp, sp, #0xf4
000971b0  movw      sl, #0  rel→__stack_chk_guard
000971b4  movw      fp, #0  rel→_s32AoutMonitorTaskEvent
000971b8  movt      sl, #0  rel→__stack_chk_guard
000971bc  movw      r5, #0  rel→_stAoutMonitorTask
000971c0  ldr       r0, [sl]
000971c4  movt      fp, #0  rel→_s32AoutMonitorTaskEvent
000971c8  str       r0, [sp, #0xf0]
000971cc  mov       r0, #0
000971d0  str       r0, [sp, #0x58]
000971d4  mov       r0, #3
000971d8  str       r0, [sp, #0x50]
000971dc  mov       r0, #0x64
000971e0  str       r0, [sp, #0x54]
000971e4  mvn       r0, #0
000971e8  str       r0, [sp, #0x4c]
000971ec  movt      r5, #0  rel→_stAoutMonitorTask
000971f0  ldr       r0, [fp]
000971f4  str       r0, [sp, #0x48]
000971f8  ldrb      r0, [r5, #0xc]
000971fc  cmp       r0, #0
00097200  bne       #0x985b8
00097204  movw      r7, #0  rel→_bIsAoutInit
00097208  movt      r7, #0  rel→_bIsAoutInit
0009720c  ldrb      r0, [r7]
00097210  cmp       r0, #0
00097214  beq       #0x985b8
00097218  add       r0, sp, #0x60
0009721c  movw      r8, #0  rel→.L.str.1411
00097220  add       r0, r0, #0x30
00097224  add       r6, sp, #0x48
00097228  add       r4, sp, #0x58
0009722c  str       r0, [sp, #0x38]
00097230  movt      r8, #0  rel→.L.str.1411
00097234  mov       r0, #0
00097238  str       r0, [sp, #0x3c]
0009723c  mov       r0, r6
00097240  mov       r1, r4
00097244  bl        #0x97244  rel→MI_OS_WaitEvent; CALL MI_OS_WaitEvent
00097248  cmp       r0, #0
0009724c  bne       #0x9725c
00097250  ldrb      r0, [sp, #0x58]
00097254  tst       r0, #1
00097258  bne       #0x972a0
0009725c  bl        #0x9725c  rel→MDrv_AUDIO_GET_INIT_FLAG; CALL MDrv_AUDIO_GET_INIT_FLAG
00097260  cmp       r0, #0
00097264  bne       #0x972c4
00097268  movw      r0, #0  rel→_u32AoutDbgLevel
0009726c  movt      r0, #0  rel→_u32AoutDbgLevel
00097270  ldr       r0, [r0]
00097274  cmp       r0, #0x50
00097278  blo       #0x972a8
0009727c  bl        #0x9727c  rel→current_thread_info; CALL current_thread_info
00097280  ldr       r0, [r0, #0xc]
00097284  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
00097288  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
0009728c  movw      r3, #0x1f94
00097290  ldr       r1, [r0, #0x400]
00097294  mov       r0, r8
00097298  bl        #0x97298  rel→printk; CALL printk
0009729c  b         #0x972a8
000972a0  mov       r0, #1
000972a4  strb      r0, [r5, #0xc]
000972a8  ldrb      r0, [r5, #0xc]
000972ac  cmp       r0, #0
000972b0  bne       #0x985b8
000972b4  ldrb      r0, [r7]
000972b8  cmp       r0, #0
000972bc  bne       #0x9723c
000972c0  b         #0x985b8
000972c4  movw      r0, #0  rel→_s32AoutSystemMutex
000972c8  movt      r0, #0  rel→_s32AoutSystemMutex
000972cc  ldr       r0, [r0]
000972d0  cmn       r0, #1
000972d4  beq       #0x972e0
000972d8  mvn       r1, #0xff
000972dc  bl        #0x972dc  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000972e0  add       r0, sp, #0x60
000972e4  mov       r1, #0
000972e8  mov       r2, #0x40
000972ec  bl        #0x972ec  rel→memset; CALL memset
000972f0  bl        #0x96d4c
000972f4  mov       r5, r0
000972f8  movw      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsCurrentEArcConnect
000972fc  movt      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsCurrentEArcConnect
00097300  movw      fp, #0  rel→_pastAoutSlot
00097304  strb      r5, [r0]
00097308  movw      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsPreviousEArcConnect
0009730c  movt      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsPreviousEArcConnect
00097310  movt      fp, #0  rel→_pastAoutSlot
00097314  ldrb      r4, [r0]
00097318  cmp       r5, r4
0009731c  bne       #0x9795c
00097320  movw      r0, #0  rel→_u32AoutDbgLevel
00097324  movt      r0, #0  rel→_u32AoutDbgLevel
00097328  ldr       r0, [r0]
0009732c  cmp       r0, #0x50
00097330  bhs       #0x97a08
00097334  movw      r0, #0  rel→_s32AoutSystemMutex
00097338  movt      r0, #0  rel→_s32AoutSystemMutex
0009733c  ldr       r0, [r0]
00097340  cmn       r0, #1
00097344  beq       #0x97368
00097348  bl        #0x97348  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
0009734c  movw      r0, #0  rel→_s32AoutSystemMutex
00097350  movt      r0, #0  rel→_s32AoutSystemMutex
00097354  ldr       r0, [r0]
00097358  cmn       r0, #1
0009735c  beq       #0x97368
00097360  mvn       r1, #0xff
00097364  bl        #0x97364  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
00097368  mov       r4, #0
0009736c  mov       r1, #1
00097370  b         #0x9739c
00097374  mov       r6, r0
00097378  movw      r0, #0  rel→_u32AoutDbgLevel
0009737c  movt      r0, #0  rel→_u32AoutDbgLevel
00097380  mov       r1, #1
00097384  ldr       r0, [r0]
00097388  cmp       r0, #0x20
0009738c  bhs       #0x97580
00097390  add       r4, r4, #1
00097394  cmp       r4, #9
00097398  beq       #0x975b0
0009739c  ldr       r8, [fp, r4, lsl #2]
000973a0  cmp       r8, #0
000973a4  beq       #0x97390
000973a8  mov       r0, #0
000973ac  str       r0, [sp, #0x5c]
000973b0  mov       r0, r8
000973b4  bl        #0x8e100
000973b8  cmp       r0, #0
000973bc  bne       #0x97374
000973c0  movw      r0, #0x8d8
000973c4  add       sl, r8, r0
000973c8  add       sb, r8, #0x54
000973cc  mov       r7, #0
000973d0  mov       r1, #1
000973d4  b         #0x973f0
000973d8  mov       r1, #1
000973dc  add       r7, r7, #1
000973e0  add       sb, sb, #0x40
000973e4  add       sl, sl, #4
000973e8  cmp       r7, #0x20
000973ec  beq       #0x97390
000973f0  ldr       r0, [r8, #0x854]
000973f4  tst       r1, r0, lsr r7
000973f8  ldrne     r0, [sl]
000973fc  cmpne     r0, #0
00097400  beq       #0x973dc
00097404  add       r0, sp, #0x5c
00097408  bl        #0x97408  rel→MI_OS_GetSystemTime; CALL MI_OS_GetSystemTime
0009740c  movw      r0, #0  rel→_u32AoutDbgLevel
00097410  movt      r0, #0  rel→_u32AoutDbgLevel
00097414  ldr       r0, [r0]
00097418  cmp       r0, #0x40
0009741c  bhs       #0x97518
00097420  ldr       r0, [sl, #-0x80]
00097424  ldr       r1, [sl]
00097428  add       r0, r1, r0
0009742c  ldr       r1, [sp, #0x5c]
00097430  cmp       r1, r0
00097434  mov       r1, #1
00097438  blo       #0x973dc
0009743c  add       r5, sp, #0x60
00097440  mov       r0, #0
00097444  str       r0, [sp, #0xd0]
00097448  mov       r1, #0
0009744c  str       r0, [sp, #0xd4]
00097450  mov       r2, #0x40
00097454  str       r0, [sp, #0xd8]
00097458  mov       r0, r5
0009745c  bl        #0x9745c  rel→memset; CALL memset
00097460  movw      r2, #0  rel→.L.str.465
00097464  mov       r0, r5
00097468  mov       r1, #0x40
0009746c  movt      r2, #0  rel→.L.str.465
00097470  mov       r3, sb
00097474  bl        #0x97474  rel→snprintf; CALL snprintf
00097478  mov       r6, r0
0009747c  movw      r0, #0  rel→_s32SnprintfRet
00097480  movt      r0, #0  rel→_s32SnprintfRet
00097484  cmn       r6, #1
00097488  str       r6, [r0]
0009748c  bgt       #0x974a4
00097490  movw      r0, #0  rel→_u32AoutDbgLevel
00097494  movt      r0, #0  rel→_u32AoutDbgLevel
00097498  ldr       r0, [r0]
0009749c  cmp       r0, #0x20
000974a0  bhs       #0x97554
000974a4  mov       r0, #0
000974a8  add       r1, sp, #0xd0
000974ac  str       r0, [sp, #0xd8]
000974b0  strb      r0, [sp, #0xd4]
000974b4  add       r0, sp, #0x60
000974b8  str       r0, [sp, #0xd0]
000974bc  mov       r0, r8
000974c0  bl        #0x827c4
000974c4  cmp       r0, #0
000974c8  beq       #0x973d8
000974cc  mov       r6, r0
000974d0  movw      r0, #0  rel→_u32AoutDbgLevel
000974d4  movt      r0, #0  rel→_u32AoutDbgLevel
000974d8  ldr       r0, [r0]
000974dc  cmp       r0, #0x20
000974e0  blo       #0x973d8
000974e4  bl        #0x974e4  rel→current_thread_info; CALL current_thread_info
000974e8  ldr       r0, [r0, #0xc]
000974ec  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
000974f0  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
000974f4  movw      r2, #0x1ea9
000974f8  ldr       r3, [r0, #0x400]
000974fc  ldr       r0, [sp, #0xd0]
00097500  str       r0, [sp, #4]
00097504  movw      r0, #0  rel→.L.str.1418
00097508  movt      r0, #0  rel→.L.str.1418
0009750c  str       r6, [sp]
00097510  bl        #0x97510  rel→printk; CALL printk
00097514  b         #0x973d8
00097518  bl        #0x97518  rel→current_thread_info; CALL current_thread_info
0009751c  ldr       r0, [r0, #0xc]
00097520  ldr       r2, [sl]
00097524  ldr       r3, [sp, #0x5c]
00097528  ldr       r1, [r0, #0x400]
0009752c  ldr       r0, [sl, #-0x80]
00097530  str       r3, [sp]
00097534  movw      r3, #0x1e9a
00097538  stmib     sp, {r0, r2}
0009753c  movw      r0, #0  rel→.L.str.1417
00097540  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
00097544  movt      r0, #0  rel→.L.str.1417
00097548  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
0009754c  bl        #0x9754c  rel→printk; CALL printk
00097550  b         #0x97420
00097554  bl        #0x97554  rel→current_thread_info; CALL current_thread_info
00097558  ldr       r0, [r0, #0xc]
0009755c  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
00097560  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
00097564  movw      r2, #0x1ea1
00097568  ldr       r3, [r0, #0x400]
0009756c  movw      r0, #0  rel→.L.str.313
00097570  movt      r0, #0  rel→.L.str.313
00097574  str       r6, [sp]
00097578  bl        #0x97578  rel→printk; CALL printk
0009757c  b         #0x974a4
00097580  bl        #0x97580  rel→current_thread_info; CALL current_thread_info
00097584  ldr       r0, [r0, #0xc]
00097588  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
0009758c  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckMuteStatus
00097590  movw      r2, #0x1e8e
00097594  ldr       r3, [r0, #0x400]
00097598  movw      r0, #0  rel→.L.str.1416
0009759c  movt      r0, #0  rel→.L.str.1416
000975a0  str       r6, [sp]
000975a4  bl        #0x975a4  rel→printk; CALL printk
000975a8  mov       r1, #1
000975ac  b         #0x97390
000975b0  movw      r2, #0  rel→_stChannelInputMuteParam
000975b4  movw      r0, #0x884
000975b8  movt      r2, #0  rel→_stChannelInputMuteParam
000975bc  add       r4, r2, r0
000975c0  mov       r7, r2
000975c4  mov       r6, #0
000975c8  movw      r2, #0x904
000975cc  b         #0x975f0
000975d0  ldr       r4, [sp, #0x44]
000975d4  movw      r2, #0x904
000975d8  ldr       r7, [sp, #0x40]
000975dc  add       r6, r6, #1
000975e0  add       r4, r4, r2
000975e4  cmp       r6, #4
000975e8  add       r7, r7, r2
000975ec  beq       #0x97720
000975f0  mov       r0, #0
000975f4  mov       r8, #0
000975f8  str       r0, [sp, #0xd0]
000975fc  movw      r0, #0  rel→_stChannelInputMuteParam
00097600  movt      r0, #0  rel→_stChannelInputMuteParam
00097604  str       r4, [sp, #0x44]
00097608  mla       r0, r6, r2, r0
0009760c  str       r7, [sp, #0x40]
00097610  add       r5, r0, #0x800
00097614  b         #0x97644
00097618  movw      r0, #0  rel→_u32AoutDbgLevel
0009761c  mov       r1, #1
00097620  movt      r0, #0  rel→_u32AoutDbgLevel
00097624  ldr       r0, [r0]
00097628  cmp       r0, #0x40
0009762c  bhs       #0x976b4
00097630  add       r8, r8, #1
00097634  add       r4, r4, #4
00097638  add       r7, r7, #0x40
0009763c  cmp       r8, #0x20
00097640  beq       #0x975d0
00097644  ldr       r0, [r5]
00097648  tst       r1, r0, lsr r8
0009764c  ldrne     r0, [r4]
00097650  cmpne     r0, #0
00097654  beq       #0x97630
00097658  add       r0, sp, #0xd0
0009765c  bl        #0x9765c  rel→MI_OS_GetSystemTime; CALL MI_OS_GetSystemTime
00097660  ldr       sb, [r4, #-0x80]
00097664  ldr       fp, [r4]
00097668  ldr       sl, [sp, #0xd0]
0009766c  add       r0, fp, sb
00097670  cmp       sl, r0
00097674  blo       #0x97618
00097678  mov       r0, #0
0009767c  str       r0, [sp, #0x64]
00097680  str       r0, [sp, #0x68]
00097684  movw      r0, #0  rel→_u32AoutDbgLevel
00097688  movt      r0, #0  rel→_u32AoutDbgLevel
0009768c  str       r7, [sp, #0x60]
00097690  ldr       r0, [r0]
00097694  and       r0, r0, #0xf
00097698  cmp       r0, #5
0009769c  beq       #0x976e4
000976a0  add       r1, sp, #0x60
000976a4  mov       r0, r6
000976a8  bl        #0x8cf88
000976ac  mov       r1, #1
000976b0  b         #0x97630
000976b4  bl        #0x976b4  rel→current_thread_info; CALL current_thread_info
000976b8  ldr       r0, [r0, #0xc]
000976bc  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckInputChannelMuteStatus
000976c0  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckInputChannelMuteStatus
000976c4  movw      r3, #0x1ed4
000976c8  ldr       r1, [r0, #0x400]
000976cc  movw      r0, #0  rel→.L.str.1417
000976d0  movt      r0, #0  rel→.L.str.1417
000976d4  str       sl, [sp]
000976d8  stmib     sp, {sb, fp}
000976dc  bl        #0x976dc  rel→printk; CALL printk
000976e0  b         #0x976ac
000976e4  bl        #0x976e4  rel→current_thread_info; CALL current_thread_info
000976e8  ldr       r0, [r0, #0xc]
000976ec  movw      r2, #0x50c
000976f0  movw      r3, #0x1ece
000976f4  ldr       r1, [r0, #0x400]
000976f8  add       r0, r0, r2
000976fc  stm       sp, {r0, r1, r7, sl}
00097700  movw      r0, #0  rel→.L.str.1420
00097704  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckInputChannelMuteStatus
00097708  movt      r0, #0  rel→.L.str.1420
0009770c  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckInputChannelMuteStatus
00097710  str       sb, [sp, #0x10]
00097714  str       fp, [sp, #0x14]
00097718  bl        #0x97718  rel→printk; CALL printk
0009771c  b         #0x976a0
00097720  ldr       r1, [sp, #0x3c]
00097724  movw      r0, #0x5c29
00097728  movt      r0, #0xc28f
0009772c  movw      r8, #0  rel→.L.str.1411
00097730  add       r6, sp, #0x48
00097734  add       r4, sp, #0x58
00097738  mul       r0, r1, r0
0009773c  movw      r1, #0xb851
00097740  movt      r1, #0x51e
00097744  movt      r8, #0  rel→.L.str.1411
00097748  ror       r0, r0, #1
0009774c  cmp       r0, r1
00097750  bhi       #0x97770
00097754  movw      r0, #0  rel→_u32AoutDbgLevel
00097758  movt      r0, #0  rel→_u32AoutDbgLevel
0009775c  ldr       r0, [r0]
00097760  ands      r0, r0, #1
00097764  beq       #0x97770
00097768  bl        #0x8f5c0
0009776c  bl        #0x98684
00097770  movw      r0, #0  rel→_s32AoutSystemMutex
00097774  movw      sl, #0  rel→__stack_chk_guard
00097778  movt      r0, #0  rel→_s32AoutSystemMutex
0009777c  movw      r5, #0  rel→_stAoutMonitorTask
00097780  ldr       r0, [r0]
00097784  movw      fp, #0  rel→_s32AoutMonitorTaskEvent
00097788  movw      r7, #0  rel→_bIsAoutInit
0009778c  movt      sl, #0  rel→__stack_chk_guard
00097790  cmn       r0, #1
00097794  movt      r5, #0  rel→_stAoutMonitorTask
00097798  movt      fp, #0  rel→_s32AoutMonitorTaskEvent
0009779c  movt      r7, #0  rel→_bIsAoutInit
000977a0  beq       #0x977c4
000977a4  bl        #0x977a4  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000977a8  movw      r0, #0  rel→_s32AoutSystemMutex
000977ac  movt      r0, #0  rel→_s32AoutSystemMutex
000977b0  ldr       r0, [r0]
000977b4  cmn       r0, #1
000977b8  beq       #0x977c4
000977bc  mvn       r1, #0xff
000977c0  bl        #0x977c0  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000977c4  movw      r0, #0  rel→_bAllInsReleased
000977c8  movt      r0, #0  rel→_bAllInsReleased
000977cc  ldrb      r0, [r0]
000977d0  cmp       r0, #1
000977d4  bne       #0x977dc
000977d8  bl        #0x977d8  rel→MApi_Audio_SPDIF_Monitor; CALL MApi_Audio_SPDIF_Monitor
000977dc  movw      r0, #0  rel→_s32AoutSystemMutex
000977e0  movt      r0, #0  rel→_s32AoutSystemMutex
000977e4  ldr       r0, [r0]
000977e8  cmn       r0, #1
000977ec  beq       #0x977f4
000977f0  bl        #0x977f0  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000977f4  ldr       r0, [sp, #0x3c]
000977f8  tst       r0, #3
000977fc  bne       #0x97d98
00097800  movw      r0, #0  rel→_s32AoutSystemMutex
00097804  movt      r0, #0  rel→_s32AoutSystemMutex
00097808  ldr       r0, [r0]
0009780c  cmn       r0, #1
00097810  beq       #0x9781c
00097814  mvn       r1, #0xff
00097818  bl        #0x97818  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
0009781c  movw      r0, #0  rel→_bEdidAutoSetup
00097820  movt      r0, #0  rel→_bEdidAutoSetup
00097824  ldrb      r0, [r0]
00097828  cmp       r0, #0
0009782c  bne       #0x97c54
00097830  movw      r0, #0  rel→_bHdmiInfoEnable
00097834  movt      r0, #0  rel→_bHdmiInfoEnable
00097838  ldrb      r0, [r0]
0009783c  cmp       r0, #1
00097840  bne       #0x97c54
00097844  mov       r0, #0
00097848  mov       r1, #0
0009784c  strb      r0, [sp, #0xd0]
00097850  mov       r2, #0
00097854  str       r0, [sp, #0x60]
00097858  mov       r3, #0
0009785c  str       r0, [sp]
00097860  movw      r0, #0  rel→.L.str.561
00097864  movt      r0, #0  rel→.L.str.561
00097868  bl        #0x97868  rel→find_symbol; CALL find_symbol
0009786c  cmp       r0, #0
00097870  beq       #0x97c44
00097874  ldr       r2, [r0]
00097878  movw      r0, #0  rel→_MApi_HDMITx_GetDataBlockLengthFromEDID
0009787c  movt      r0, #0  rel→_MApi_HDMITx_GetDataBlockLengthFromEDID
00097880  mov       r1, #1
00097884  str       r2, [r0]
00097888  add       r0, sp, #0xd0
0009788c  blx       r2
00097890  cmp       r0, #0
00097894  beq       #0x97c44
00097898  ldrb      r0, [sp, #0xd0]
0009789c  cmp       r0, #0
000978a0  beq       #0x97acc
000978a4  bl        #0x978a4  rel→vmalloc; CALL vmalloc
000978a8  cmp       r0, #0
000978ac  beq       #0x97b08
000978b0  ldrb      r2, [sp, #0xd0]
000978b4  mov       r1, #0
000978b8  mov       r6, r0
000978bc  bl        #0x978bc  rel→memset; CALL memset
000978c0  mov       r0, #0
000978c4  mov       r1, #0
000978c8  str       r0, [sp]
000978cc  movw      r0, #0  rel→.L.str.563
000978d0  movt      r0, #0  rel→.L.str.563
000978d4  mov       r2, #0
000978d8  mov       r3, #0
000978dc  bl        #0x978dc  rel→find_symbol; CALL find_symbol
000978e0  movw      r4, #0xaaab
000978e4  cmp       r0, #0
000978e8  movt      r4, #0xaaaa
000978ec  beq       #0x9790c
000978f0  ldr       r2, [r0]
000978f4  movw      r0, #0  rel→_MApi_HDMITx_GetRxAudioFormatFromEDID
000978f8  ldrb      r1, [sp, #0xd0]
000978fc  movt      r0, #0  rel→_MApi_HDMITx_GetRxAudioFormatFromEDID
00097900  str       r2, [r0]
00097904  mov       r0, r6
00097908  blx       r2
0009790c  ldrb      r0, [sp, #0xd0]
00097910  cmp       r0, #0
00097914  beq       #0x97b10
00097918  mov       r1, #0
0009791c  mov       r8, #0
00097920  mov       ip, #1
00097924  b         #0x97934
00097928  add       r1, r1, #1
0009792c  cmp       r0, r1
00097930  beq       #0x97b14
00097934  uxtb      r2, r1
00097938  movw      r3, #0x5555
0009793c  mul       r2, r2, r4
00097940  movt      r3, #0x5555
00097944  cmp       r2, r3
00097948  bhi       #0x97928
0009794c  ldrb      r2, [r6, r1]
00097950  ubfx      r2, r2, #3, #4
00097954  orr       r8, r8, ip, lsl r2
00097958  b         #0x97928
0009795c  bl        #0x9795c  rel→current_thread_info; CALL current_thread_info
00097960  mov       r8, r0
00097964  ldr       r0, [r0, #0xc]
00097968  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
0009796c  movw      r3, #0x1eea
00097970  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00097974  ldr       r1, [r0, #0x400]
00097978  movw      r0, #0  rel→.L.str.1415
0009797c  movt      r0, #0  rel→.L.str.1415
00097980  str       r5, [sp]
00097984  bl        #0x97984  rel→printk; CALL printk
00097988  movw      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsCurrentEArcConnect
0009798c  movw      r1, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsPreviousEArcConnect
00097990  movt      r0, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsCurrentEArcConnect
00097994  movt      r1, #0  rel→_MI_AOUT_CheckEArcConnectStatus.bIsPreviousEArcConnect
00097998  ldrb      r0, [r0]
0009799c  strb      r0, [r1]
000979a0  cmp       r0, #1
000979a4  bne       #0x97a38
000979a8  movw      r2, #0  rel→.L.str.1387
000979ac  add       r0, sp, #0x60
000979b0  mov       r1, #0x40
000979b4  movt      r2, #0  rel→.L.str.1387
000979b8  mov       r3, #0
000979bc  bl        #0x979bc  rel→snprintf; CALL snprintf
000979c0  movw      r1, #0  rel→_s32SnprintfRet
000979c4  cmn       r0, #1
000979c8  movt      r1, #0  rel→_s32SnprintfRet
000979cc  str       r0, [r1]
000979d0  bgt       #0x979e8
000979d4  movw      r1, #0  rel→_u32AoutDbgLevel
000979d8  movt      r1, #0  rel→_u32AoutDbgLevel
000979dc  ldr       r1, [r1]
000979e0  cmp       r1, #0x20
000979e4  bhs       #0x98040
000979e8  add       r4, sp, #0x60
000979ec  mov       r0, r4
000979f0  bl        #0x979f0  rel→strlen; CALL strlen
000979f4  mov       r1, r0
000979f8  mov       r0, r4
000979fc  bl        #0x979fc  rel→MApi_AUDIO_SYSTEM_Control; CALL MApi_AUDIO_SYSTEM_Control
00097a00  mov       r0, #1
00097a04  b         #0x97ac4
00097a08  bl        #0x97a08  rel→current_thread_info; CALL current_thread_info
00097a0c  ldr       r0, [r0, #0xc]
00097a10  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00097a14  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00097a18  movw      r3, #0x1ee6
00097a1c  ldr       r1, [r0, #0x400]
00097a20  movw      r0, #0  rel→.L.str.1414
00097a24  movt      r0, #0  rel→.L.str.1414
00097a28  str       r5, [sp]
00097a2c  str       r4, [sp, #4]
00097a30  bl        #0x97a30  rel→printk; CALL printk
00097a34  b         #0x97334
00097a38  movw      r0, #0  rel→_stAoutMuteStatus
00097a3c  movw      r2, #0  rel→.L.str.1387
00097a40  movt      r0, #0  rel→_stAoutMuteStatus
00097a44  movt      r2, #0  rel→.L.str.1387
00097a48  ldrh      r0, [r0]
00097a4c  lsr       r1, r0, #7
00097a50  orr       r1, r1, r0, lsr #9
00097a54  orr       r0, r1, r0, lsr #10
00097a58  mov       r1, #0x40
00097a5c  and       r3, r0, #1
00097a60  add       r0, sp, #0x60
00097a64  bl        #0x97a64  rel→snprintf; CALL snprintf
00097a68  movw      r1, #0  rel→_s32SnprintfRet
00097a6c  cmn       r0, #1
00097a70  movt      r1, #0  rel→_s32SnprintfRet
00097a74  str       r0, [r1]
00097a78  bgt       #0x97a90
00097a7c  movw      r1, #0  rel→_u32AoutDbgLevel
00097a80  movt      r1, #0  rel→_u32AoutDbgLevel
00097a84  ldr       r1, [r1]
00097a88  cmp       r1, #0x20
00097a8c  bhs       #0x98068
00097a90  add       r4, sp, #0x60
00097a94  mov       r0, r4
00097a98  bl        #0x97a98  rel→strlen; CALL strlen
00097a9c  mov       r1, r0
00097aa0  mov       r0, r4
00097aa4  bl        #0x97aa4  rel→MApi_AUDIO_SYSTEM_Control; CALL MApi_AUDIO_SYSTEM_Control
00097aa8  movw      r0, #0  rel→_stAoutMuteStatus
00097aac  movt      r0, #0  rel→_stAoutMuteStatus
00097ab0  ldrh      r0, [r0]
00097ab4  lsr       r1, r0, #4
00097ab8  orr       r1, r1, r0, lsr #9
00097abc  orr       r0, r1, r0, lsr #10
00097ac0  and       r0, r0, #1
00097ac4  bl        #0x9701c
00097ac8  b         #0x97334
00097acc  movw      r0, #0  rel→_u32AoutDbgLevel
00097ad0  movt      r0, #0  rel→_u32AoutDbgLevel
00097ad4  ldr       r0, [r0]
00097ad8  cmp       r0, #0x20
00097adc  blo       #0x97c44
00097ae0  bl        #0x97ae0  rel→current_thread_info; CALL current_thread_info
00097ae4  ldr       r0, [r0, #0xc]
00097ae8  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00097aec  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00097af0  movw      r2, #0x1de5
00097af4  ldr       r3, [r0, #0x400]
00097af8  movw      r0, #0  rel→.L.str.1424
00097afc  movt      r0, #0  rel→.L.str.1424
00097b00  bl        #0x97b00  rel→printk; CALL printk
00097b04  b         #0x97c44
00097b08  mov       r8, #0
00097b0c  b         #0x97b1c
00097b10  mov       r8, #0
00097b14  mov       r0, r6
00097b18  bl        #0x97b18  rel→vfree; CALL vfree
00097b1c  movw      r0, #0  rel→_u32CurEdidSupportList
00097b20  mov       r2, #1
00097b24  movt      r0, #0  rel→_u32CurEdidSupportList
00097b28  ldr       r0, [r0]
00097b2c  cmp       r0, r8
00097b30  beq       #0x97be8
00097b34  movw      r1, #0  rel→_u32AoutDbgLevel
00097b38  movt      r1, #0  rel→_u32AoutDbgLevel
00097b3c  ldr       r1, [r1]
00097b40  cmp       r1, #0x3f
00097b44  bhi       #0x9847c
00097b48  eor       r4, r0, r8
00097b4c  mov       r6, #1
00097b50  b         #0x97b60
00097b54  add       r6, r6, #1
00097b58  cmp       r6, #0xf
00097b5c  beq       #0x97bdc
00097b60  tst       r4, r2, lsl r6
00097b64  beq       #0x97b54
00097b68  movw      r1, #0  rel→_u32CurEdidSupportList
00097b6c  lsl       r0, r2, r6
00097b70  movt      r1, #0  rel→_u32CurEdidSupportList
00097b74  ldr       r1, [r1]
00097b78  and       r0, r1, r0
00097b7c  clz       r0, r0
00097b80  lsr       r1, r0, #5
00097b84  mov       r0, r6
00097b88  bl        #0x98760
00097b8c  mov       r2, #1
00097b90  cmp       r0, #0
00097b94  beq       #0x97b54
00097b98  mov       sb, r0
00097b9c  movw      r0, #0  rel→_u32AoutDbgLevel
00097ba0  movt      r0, #0  rel→_u32AoutDbgLevel
00097ba4  ldr       r0, [r0]
00097ba8  cmp       r0, #0x20
00097bac  blo       #0x97c44
00097bb0  bl        #0x97bb0  rel→current_thread_info; CALL current_thread_info
00097bb4  ldr       r0, [r0, #0xc]
00097bb8  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00097bbc  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00097bc0  movw      r2, #0x1e17
00097bc4  ldr       r3, [r0, #0x400]
00097bc8  movw      r0, #0  rel→.L.str.1427
00097bcc  movt      r0, #0  rel→.L.str.1427
00097bd0  str       sb, [sp]
00097bd4  bl        #0x97bd4  rel→printk; CALL printk
00097bd8  b         #0x97c44
00097bdc  movw      r0, #0  rel→_u32CurEdidSupportList
00097be0  movt      r0, #0  rel→_u32CurEdidSupportList
00097be4  str       r8, [r0]
00097be8  movw      r0, #0  rel→_bHdmiTxMonitorEnable
00097bec  movt      r0, #0  rel→_bHdmiTxMonitorEnable
00097bf0  ldrb      r0, [r0]
00097bf4  cmp       r0, #0
00097bf8  beq       #0x97c44
00097bfc  add       r1, sp, #0x60
00097c00  mov       r0, #0
00097c04  bl        #0x97c04  rel→mi_audio_GetCodecType; CALL mi_audio_GetCodecType
00097c08  movw      r0, #0  rel→_MI_AOUT_HdmiInfoMonitor.u32CurAudioCodecType.0
00097c0c  ldr       r1, [sp, #0x60]
00097c10  movt      r0, #0  rel→_MI_AOUT_HdmiInfoMonitor.u32CurAudioCodecType.0
00097c14  ldr       r0, [r0]
00097c18  cmp       r0, r1
00097c1c  beq       #0x97c44
00097c20  movw      r0, #0  rel→_eCurHdmiAudioType
00097c24  movt      r0, #0  rel→_eCurHdmiAudioType
00097c28  str       r1, [r0]
00097c2c  mov       r0, r8
00097c30  bl        #0x989cc
00097c34  movw      r1, #0  rel→_MI_AOUT_HdmiInfoMonitor.u32CurAudioCodecType.0
00097c38  ldr       r0, [sp, #0x60]
00097c3c  movt      r1, #0  rel→_MI_AOUT_HdmiInfoMonitor.u32CurAudioCodecType.0
00097c40  str       r0, [r1]
00097c44  movw      r8, #0  rel→.L.str.1411
00097c48  add       r6, sp, #0x48
00097c4c  add       r4, sp, #0x58
00097c50  movt      r8, #0  rel→.L.str.1411
00097c54  movw      r0, #0  rel→_bAiAqPreParsed
00097c58  movt      r0, #0  rel→_bAiAqPreParsed
00097c5c  ldrb      r0, [r0]
00097c60  cmp       r0, #0
00097c64  bne       #0x97d80
00097c68  mov       r0, #0x41
00097c6c  mov       r1, #0
00097c70  bl        #0x97c70  rel→MApi_SND_GetParam1; CALL MApi_SND_GetParam1
00097c74  uxtb      r0, r0
00097c78  cmp       r0, #1
00097c7c  bne       #0x97d80
00097c80  movw      r8, #0  rel→kmalloc_caches
00097c84  movw      sb, #0xc0
00097c88  movt      r8, #0  rel→kmalloc_caches
00097c8c  movt      sb, #0x60
00097c90  ldr       r0, [r8, #0x20]
00097c94  mov       r1, sb
00097c98  mov       r2, #0x100
00097c9c  bl        #0x97c9c  rel→kmem_cache_alloc_trace; CALL kmem_cache_alloc_trace
00097ca0  mov       r2, r0
00097ca4  ldr       r0, [r8, #0x20]
00097ca8  mov       r1, sb
00097cac  mov       sb, r2
00097cb0  mov       r2, #0x100
00097cb4  bl        #0x97cb4  rel→kmem_cache_alloc_trace; CALL kmem_cache_alloc_trace
00097cb8  mov       r8, r0
00097cbc  movw      r0, #0x1350
00097cc0  bl        #0x97cc0  rel→vmalloc; CALL vmalloc
00097cc4  cmp       sb, #0
00097cc8  str       r0, [sp, #0x44]
00097ccc  cmpne     r8, #0
00097cd0  str       r8, [sp, #0x40]
00097cd4  bne       #0x97d14
00097cd8  movw      r0, #0  rel→_u32AoutDbgLevel
00097cdc  movt      r0, #0  rel→_u32AoutDbgLevel
00097ce0  ldr       r0, [r0]
00097ce4  cmp       r0, #0x20
00097ce8  blo       #0x97d60
00097cec  bl        #0x97cec  rel→current_thread_info; CALL current_thread_info
00097cf0  ldr       r0, [r0, #0xc]
00097cf4  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
00097cf8  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
00097cfc  movw      r2, #0x1f35
00097d00  ldr       r3, [r0, #0x400]
00097d04  movw      r0, #0  rel→.L.str.1458
00097d08  movt      r0, #0  rel→.L.str.1458
00097d0c  bl        #0x97d0c  rel→printk; CALL printk
00097d10  b         #0x97d60
00097d14  ldr       r0, [sp, #0x44]
00097d18  cmp       r0, #0
00097d1c  beq       #0x97cd8
00097d20  mov       r0, sb
00097d24  mov       r1, #0
00097d28  mov       r2, #0x100
00097d2c  bl        #0x97d2c  rel→memset; CALL memset
00097d30  movw      r1, #0  rel→.L.str.1459
00097d34  mov       r0, sb
00097d38  movt      r1, #0  rel→.L.str.1459
00097d3c  bl        #0x76c9c
00097d40  cmp       r0, #0
00097d44  beq       #0x98090
00097d48  mov       r8, r0
00097d4c  movw      r0, #0  rel→_u32AoutDbgLevel
00097d50  movt      r0, #0  rel→_u32AoutDbgLevel
00097d54  ldr       r0, [r0]
00097d58  cmp       r0, #0x20
00097d5c  bhs       #0x98400
00097d60  mov       r0, sb
00097d64  bl        #0x97d64  rel→kfree; CALL kfree
00097d68  ldr       r0, [sp, #0x40]
00097d6c  bl        #0x97d6c  rel→kfree; CALL kfree
00097d70  ldr       r0, [sp, #0x44]
00097d74  bl        #0x97d74  rel→vfree; CALL vfree
00097d78  movw      r8, #0  rel→.L.str.1411
00097d7c  movt      r8, #0  rel→.L.str.1411
00097d80  movw      r0, #0  rel→_s32AoutSystemMutex
00097d84  movt      r0, #0  rel→_s32AoutSystemMutex
00097d88  ldr       r0, [r0]
00097d8c  cmn       r0, #1
00097d90  beq       #0x97d98
00097d94  bl        #0x97d94  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
00097d98  ldr       r1, [sp, #0x3c]
00097d9c  movw      r0, #0xcccd
00097da0  movt      r0, #0xcccc
00097da4  mul       r0, r1, r0
00097da8  movw      r1, #0x3333
00097dac  movt      r1, #0x3333
00097db0  cmp       r0, r1
00097db4  bhi       #0x97e78
00097db8  movw      r0, #0  rel→_s32AoutSystemMutex
00097dbc  movt      r0, #0  rel→_s32AoutSystemMutex
00097dc0  ldr       r0, [r0]
00097dc4  cmn       r0, #1
00097dc8  beq       #0x97dd4
00097dcc  mvn       r1, #0xff
00097dd0  bl        #0x97dd0  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
00097dd4  add       r0, sp, #0x60
00097dd8  mov       r1, #0
00097ddc  mov       r2, #0x40
00097de0  bl        #0x97de0  rel→memset; CALL memset
00097de4  movw      r0, #0  rel→_u32AoutDbgLevel
00097de8  movt      r0, #0  rel→_u32AoutDbgLevel
00097dec  ldr       r0, [r0]
00097df0  cmp       r0, #0x50
00097df4  bhs       #0x97e94
00097df8  movw      r0, #0  rel→_bIsSpdifMuteInBypass
00097dfc  movt      r0, #0  rel→_bIsSpdifMuteInBypass
00097e00  ldrb      sb, [r0]
00097e04  movw      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreSpdifMuteInBypass
00097e08  movt      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreSpdifMuteInBypass
00097e0c  ldrb      r0, [r0]
00097e10  cmp       r0, sb
00097e14  beq       #0x97e2c
00097e18  movw      r0, #0  rel→_stAoutSndParam
00097e1c  movt      r0, #0  rel→_stAoutSndParam
00097e20  ldr       r0, [r0, #0x6c]
00097e24  cmp       r0, #3
00097e28  beq       #0x97ef0
00097e2c  movw      r0, #0  rel→_bIsArcMuteInBypass
00097e30  movt      r0, #0  rel→_bIsArcMuteInBypass
00097e34  ldrb      sb, [r0]
00097e38  movw      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreArcMuteInBypass
00097e3c  movt      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreArcMuteInBypass
00097e40  ldrb      r0, [r0]
00097e44  cmp       r0, sb
00097e48  beq       #0x97e60
00097e4c  movw      r0, #0  rel→_stAoutSndParam
00097e50  movt      r0, #0  rel→_stAoutSndParam
00097e54  ldr       r0, [r0, #0xbc]
00097e58  cmp       r0, #3
00097e5c  beq       #0x97f98
00097e60  movw      r0, #0  rel→_s32AoutSystemMutex
00097e64  movt      r0, #0  rel→_s32AoutSystemMutex
00097e68  ldr       r0, [r0]
00097e6c  cmn       r0, #1
00097e70  beq       #0x97e78
00097e74  bl        #0x97e74  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
00097e78  ldr       r0, [sp, #0x3c]
00097e7c  mvn       r1, #0
00097e80  add       r0, r0, #1
00097e84  subs      r1, r0, r1
00097e88  movne     r1, r0
00097e8c  str       r1, [sp, #0x3c]
00097e90  b         #0x972a8
00097e94  bl        #0x97e94  rel→current_thread_info; CALL current_thread_info
00097e98  ldr       r0, [r0, #0xc]
00097e9c  ldr       r1, [r0, #0x400]
00097ea0  movw      r0, #0  rel→_bIsSpdifMuteInBypass
00097ea4  movt      r0, #0  rel→_bIsSpdifMuteInBypass
00097ea8  ldrb      ip, [r0]
00097eac  movw      r0, #0  rel→_stAoutSndParam
00097eb0  movt      r0, #0  rel→_stAoutSndParam
00097eb4  ldr       r2, [r0, #0x6c]
00097eb8  ldr       r3, [r0, #0xbc]
00097ebc  movw      r0, #0  rel→_bIsArcMuteInBypass
00097ec0  movt      r0, #0  rel→_bIsArcMuteInBypass
00097ec4  stm       sp, {r2, ip}
00097ec8  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097ecc  ldrb      r0, [r0]
00097ed0  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097ed4  str       r0, [sp, #0xc]
00097ed8  movw      r0, #0  rel→.L.str.1465
00097edc  str       r3, [sp, #8]
00097ee0  movt      r0, #0  rel→.L.str.1465
00097ee4  movw      r3, #0x1c81
00097ee8  bl        #0x97ee8  rel→printk; CALL printk
00097eec  b         #0x97df8
00097ef0  bl        #0x97ef0  rel→current_thread_info; CALL current_thread_info
00097ef4  mov       r8, r0
00097ef8  ldr       r0, [r0, #0xc]
00097efc  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097f00  movw      r3, #0x1c87
00097f04  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097f08  ldr       r1, [r0, #0x400]
00097f0c  movw      r0, #0  rel→.L.str.1466
00097f10  movt      r0, #0  rel→.L.str.1466
00097f14  str       sb, [sp]
00097f18  bl        #0x97f18  rel→printk; CALL printk
00097f1c  movw      r0, #0  rel→_bIsSpdifMuteInBypass
00097f20  movw      r2, #0  rel→.L.str.1383
00097f24  movt      r0, #0  rel→_bIsSpdifMuteInBypass
00097f28  mov       r1, #0x40
00097f2c  ldrb      r3, [r0]
00097f30  movw      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreSpdifMuteInBypass
00097f34  movt      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreSpdifMuteInBypass
00097f38  movt      r2, #0  rel→.L.str.1383
00097f3c  strb      r3, [r0]
00097f40  add       r0, sp, #0x60
00097f44  bl        #0x97f44  rel→snprintf; CALL snprintf
00097f48  movw      r1, #0  rel→_s32SnprintfRet
00097f4c  cmn       r0, #1
00097f50  movt      r1, #0  rel→_s32SnprintfRet
00097f54  str       r0, [r1]
00097f58  bgt       #0x97f70
00097f5c  movw      r1, #0  rel→_u32AoutDbgLevel
00097f60  movt      r1, #0  rel→_u32AoutDbgLevel
00097f64  ldr       r1, [r1]
00097f68  cmp       r1, #0x20
00097f6c  bhs       #0x9842c
00097f70  add       r4, sp, #0x60
00097f74  mov       r0, r4
00097f78  bl        #0x97f78  rel→strlen; CALL strlen
00097f7c  mov       r1, r0
00097f80  mov       r0, r4
00097f84  bl        #0x97f84  rel→MApi_AUDIO_SYSTEM_Control; CALL MApi_AUDIO_SYSTEM_Control
00097f88  movw      r8, #0  rel→.L.str.1411
00097f8c  add       r4, sp, #0x58
00097f90  movt      r8, #0  rel→.L.str.1411
00097f94  b         #0x97e2c
00097f98  bl        #0x97f98  rel→current_thread_info; CALL current_thread_info
00097f9c  mov       r8, r0
00097fa0  ldr       r0, [r0, #0xc]
00097fa4  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097fa8  movw      r3, #0x1c91
00097fac  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00097fb0  ldr       r1, [r0, #0x400]
00097fb4  movw      r0, #0  rel→.L.str.1467
00097fb8  movt      r0, #0  rel→.L.str.1467
00097fbc  str       sb, [sp]
00097fc0  bl        #0x97fc0  rel→printk; CALL printk
00097fc4  movw      r0, #0  rel→_bIsArcMuteInBypass
00097fc8  movw      r2, #0  rel→.L.str.1387
00097fcc  movt      r0, #0  rel→_bIsArcMuteInBypass
00097fd0  mov       r1, #0x40
00097fd4  ldrb      r3, [r0]
00097fd8  movw      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreArcMuteInBypass
00097fdc  movt      r0, #0  rel→_MI_AOUT_SetMuteInBypassMode.bIsPreArcMuteInBypass
00097fe0  movt      r2, #0  rel→.L.str.1387
00097fe4  strb      r3, [r0]
00097fe8  add       r0, sp, #0x60
00097fec  bl        #0x97fec  rel→snprintf; CALL snprintf
00097ff0  movw      r1, #0  rel→_s32SnprintfRet
00097ff4  cmn       r0, #1
00097ff8  movt      r1, #0  rel→_s32SnprintfRet
00097ffc  str       r0, [r1]
00098000  bgt       #0x98018
00098004  movw      r1, #0  rel→_u32AoutDbgLevel
00098008  movt      r1, #0  rel→_u32AoutDbgLevel
0009800c  ldr       r1, [r1]
00098010  cmp       r1, #0x20
00098014  bhs       #0x98454
00098018  add       r4, sp, #0x60
0009801c  mov       r0, r4
00098020  bl        #0x98020  rel→strlen; CALL strlen
00098024  mov       r1, r0
00098028  mov       r0, r4
0009802c  bl        #0x9802c  rel→MApi_AUDIO_SYSTEM_Control; CALL MApi_AUDIO_SYSTEM_Control
00098030  movw      r8, #0  rel→.L.str.1411
00098034  add       r4, sp, #0x58
00098038  movt      r8, #0  rel→.L.str.1411
0009803c  b         #0x97e60
00098040  ldr       r1, [r8, #0xc]
00098044  movw      r2, #0x1ef0
00098048  ldr       r3, [r1, #0x400]
0009804c  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00098050  str       r0, [sp]
00098054  movw      r0, #0  rel→.L.str.313
00098058  movt      r0, #0  rel→.L.str.313
0009805c  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00098060  bl        #0x98060  rel→printk; CALL printk
00098064  b         #0x979e8
00098068  ldr       r1, [r8, #0xc]
0009806c  movw      r2, #0x1efc
00098070  ldr       r3, [r1, #0x400]
00098074  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00098078  str       r0, [sp]
0009807c  movw      r0, #0  rel→.L.str.313
00098080  movt      r0, #0  rel→.L.str.313
00098084  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_CheckEArcConnectStatus
00098088  bl        #0x98088  rel→printk; CALL printk
0009808c  b         #0x97a90
00098090  str       sb, [sp, #0x34]
00098094  bl        #0x98094  rel→current_thread_info; CALL current_thread_info
00098098  str       r0, [sp, #0x20]
0009809c  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000980a0  ldr       r0, [r0, #0xc]
000980a4  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000980a8  movw      r3, #0x1f43
000980ac  ldr       r1, [r0, #0x400]
000980b0  ldr       r0, [sp, #0x40]
000980b4  str       r0, [sp]
000980b8  movw      r0, #0  rel→.L.str.447
000980bc  movt      r0, #0  rel→.L.str.447
000980c0  bl        #0x980c0  rel→printk; CALL printk
000980c4  ldr       r1, [sp, #0x44]
000980c8  movw      r0, #0x10be
000980cc  movw      r6, #0  rel→_MI_AOUT_AiAqLoadGeqParams.bAiAqGeqFirstLoad
000980d0  mov       sb, #0
000980d4  add       r0, r1, r0
000980d8  str       r0, [sp, #0x2c]
000980dc  movw      r0, #0x10bc
000980e0  movt      r6, #0  rel→_MI_AOUT_AiAqLoadGeqParams.bAiAqGeqFirstLoad
000980e4  add       r0, r1, r0
000980e8  str       r0, [sp, #0x24]
000980ec  movw      r0, #0x4c4
000980f0  add       r0, r1, r0
000980f4  str       r0, [sp, #0x30]
000980f8  b         #0x98178
000980fc  ldr       r0, [sp, #0x2c]
00098100  movw      r4, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098104  movt      r4, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098108  ldr       ip, [r0]
0009810c  ldr       r1, [r0, #4]
00098110  ldrh      r3, [r0, #8]
00098114  movw      r0, #0  rel→_MI_AOUT_AiAqLoadGeqParams.eErrCode
00098118  strb      r2, [r4, #4]
0009811c  mov       r4, #1
00098120  movt      r0, #0  rel→_MI_AOUT_AiAqLoadGeqParams.eErrCode
00098124  add       r2, r2, r2, lsl #1
00098128  strb      r4, [r0]
0009812c  movw      r0, #0  rel→_astAiAqGeqParams
00098130  movt      r0, #0  rel→_astAiAqGeqParams
00098134  add       r2, r0, r2, lsl #2
00098138  strh      r3, [r2, #0xfa]
0009813c  str       r1, [r2, #0xf6]
00098140  str       ip, [r2, #0xf2]
00098144  ldr       r0, [sp, #0x24]
00098148  ldr       r3, [r0]
0009814c  ldmib     r0, {r1, r2}
00098150  ldr       r0, [sp, #0x38]
00098154  str       r3, [r0]
00098158  stmib     r0, {r1, r2}
0009815c  mov       r1, #4
00098160  bl        #0x7108c
00098164  movw      r6, #0  rel→_MI_AOUT_AiAqLoadGeqParams.bAiAqGeqFirstLoad
00098168  sub       sb, sb, #1
0009816c  cmn       sb, #5
00098170  movt      r6, #0  rel→_MI_AOUT_AiAqLoadGeqParams.bAiAqGeqFirstLoad
00098174  beq       #0x98564
00098178  ldr       r4, [sp, #0x40]
0009817c  mov       r1, #0
00098180  mov       r2, #0x100
00098184  mov       r0, r4
00098188  bl        #0x98188  rel→memset; CALL memset
0009818c  movw      r0, #0  rel→_aszAiAqFileName
00098190  ldr       r3, [sp, #0x34]
00098194  movt      r0, #0  rel→_aszAiAqFileName
00098198  movw      r2, #0  rel→.L.str.446
0009819c  ldr       r0, [r0, -sb, lsl #2]
000981a0  mov       r1, #0x100
000981a4  movt      r2, #0  rel→.L.str.446
000981a8  str       r0, [sp]
000981ac  mov       r0, r4
000981b0  bl        #0x981b0  rel→snprintf; CALL snprintf
000981b4  movw      r1, #0  rel→_s32SnprintfRet
000981b8  cmn       r0, #1
000981bc  movt      r1, #0  rel→_s32SnprintfRet
000981c0  str       r0, [r1]
000981c4  bgt       #0x981dc
000981c8  movw      r1, #0  rel→_u32AoutDbgLevel
000981cc  movt      r1, #0  rel→_u32AoutDbgLevel
000981d0  ldr       r1, [r1]
000981d4  cmp       r1, #0x20
000981d8  bhs       #0x983d4
000981dc  ldr       r0, [sp, #0x40]
000981e0  bl        #0x981e0  rel→iniparser_load; CALL iniparser_load
000981e4  cmp       r0, #0
000981e8  beq       #0x984d0
000981ec  ldr       r4, [sp, #0x44]
000981f0  mov       r8, r0
000981f4  mov       r1, #0
000981f8  movw      r2, #0x1350
000981fc  mov       r0, r4
00098200  bl        #0x98200  rel→memset; CALL memset
00098204  mov       r0, r8
00098208  mov       r1, r4
0009820c  mov       r2, #4
00098210  str       r8, [sp, #0x28]
00098214  bl        #0x7720c
00098218  cmp       r0, #0
0009821c  bne       #0x98518
00098220  ldr       r0, [sp, #0x30]
00098224  mov       r1, #4
00098228  bl        #0x92930
0009822c  cmp       r0, #0
00098230  bne       #0x98274
00098234  ldr       r4, [sp, #0x44]
00098238  add       ip, sp, #0xd0
0009823c  ldr       r0, [r4, #0x4c4]
00098240  ldr       r1, [r4, #0x4c8]
00098244  ldr       r2, [r4, #0x4cc]
00098248  ldr       r3, [r4, #0x4d0]
0009824c  stm       ip, {r0, r1, r2, r3}
00098250  mov       r1, #4
00098254  ldr       r0, [r4, #0x4d4]
00098258  str       r0, [sp, #0xe0]
0009825c  ldr       r0, [r4, #0x4d8]
00098260  str       r0, [sp, #0xe4]
00098264  ldr       r0, [r4, #0x4dc]
00098268  str       r0, [sp, #0xe8]
0009826c  add       r0, sp, #0xd0
00098270  bl        #0x92b3c
00098274  movw      r0, #0  rel→_stAiAqParam
00098278  ldrb      r1, [r6]
0009827c  movt      r0, #0  rel→_stAiAqParam
00098280  ldrh      r0, [r0]
00098284  cmp       r1, #1
00098288  bne       #0x9829c
0009828c  movw      r1, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098290  movt      r1, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098294  ldrb      r1, [r1, #4]
00098298  b         #0x98358
0009829c  ldr       r3, [sp, #0x2c]
000982a0  movw      r4, #0  rel→_astAiAqGeqHistoricParams
000982a4  movt      r4, #0  rel→_astAiAqGeqHistoricParams
000982a8  ldrh      r1, [r3, #8]
000982ac  strh      r1, [r4, #0xfa]
000982b0  ldr       r1, [r3]
000982b4  ldr       r2, [r3, #4]
000982b8  str       r2, [r4, #0xf6]
000982bc  movw      r2, #0x106
000982c0  str       r1, [r4, #0xf2]
000982c4  ldrh      r1, [r3, #8]
000982c8  strh      r1, [r4, r2]
000982cc  ldr       r1, [r3]
000982d0  ldr       r2, [r3, #4]
000982d4  str       r2, [r4, #0x102]
000982d8  movw      r2, #0x112
000982dc  str       r1, [r4, #0xfe]
000982e0  ldrh      r1, [r3, #8]
000982e4  strh      r1, [r4, r2]
000982e8  ldr       r1, [r3]
000982ec  ldr       r2, [r3, #4]
000982f0  str       r2, [r4, #0x10e]
000982f4  movw      r2, #0x11e
000982f8  str       r1, [r4, #0x10a]
000982fc  ldrh      r1, [r3, #8]
00098300  strh      r1, [r4, r2]
00098304  ldr       r1, [r3]
00098308  ldr       r2, [r3, #4]
0009830c  str       r2, [r4, #0x11a]
00098310  movw      r2, #0x12a
00098314  str       r1, [r4, #0x116]
00098318  ldrh      r1, [r3, #8]
0009831c  strh      r1, [r4, r2]
00098320  movw      r2, #0x505
00098324  ldr       ip, [r3]
00098328  movt      r2, #0x505
0009832c  ldr       r1, [r3, #4]
00098330  movw      r3, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098334  movt      r3, #0  rel→_MI_AOUT_AiAqLoadGeqParams.u8PrevAiAqGeqProbMaxIdx
00098338  str       r1, [r4, #0x126]
0009833c  mov       r1, #5
00098340  str       r2, [r3]
00098344  str       r2, [r3, #4]
00098348  mov       r2, #1
0009834c  strb      r1, [r3, #8]
00098350  str       ip, [r4, #0x122]
00098354  strb      r2, [r6]
00098358  movw      r4, #0  rel→_stAiAqParam
0009835c  mov       r2, #0
00098360  movt      r4, #0  rel→_stAiAqParam
00098364  ldrh      r3, [r4, #2]
00098368  cmp       r3, r0
0009836c  movlo     r3, r0
00098370  ldrh      r0, [r4, #4]
00098374  movwhs    r2, #1
00098378  cmp       r0, r3
0009837c  movhs     r3, r0
00098380  ldrh      r0, [r4, #6]
00098384  movhs     r2, #2
00098388  cmp       r0, r3
0009838c  movhs     r3, r0
00098390  ldrh      r0, [r4, #8]
00098394  movhs     r2, #3
00098398  mov       r4, #4
0009839c  cmp       r0, r3
000983a0  movhs     r3, r0
000983a4  movhs     r2, r4
000983a8  movw      r0, #0x3e9
000983ac  cmp       r3, r0
000983b0  bne       #0x983bc
000983b4  cmp       r2, r1
000983b8  bne       #0x980fc
000983bc  movw      r0, #0  rel→_MI_AOUT_AiAqLoadGeqParams.eErrCode
000983c0  movt      r0, #0  rel→_MI_AOUT_AiAqLoadGeqParams.eErrCode
000983c4  ldrb      r0, [r0]
000983c8  cmp       r0, #1
000983cc  beq       #0x98144
000983d0  b         #0x98164
000983d4  ldr       r1, [sp, #0x20]
000983d8  movw      r2, #0x1f48
000983dc  ldr       r1, [r1, #0xc]
000983e0  ldr       r3, [r1, #0x400]
000983e4  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000983e8  str       r0, [sp]
000983ec  movw      r0, #0  rel→.L.str.313
000983f0  movt      r0, #0  rel→.L.str.313
000983f4  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000983f8  bl        #0x983f8  rel→printk; CALL printk
000983fc  b         #0x981dc
00098400  bl        #0x98400  rel→current_thread_info; CALL current_thread_info
00098404  ldr       r0, [r0, #0xc]
00098408  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
0009840c  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
00098410  movw      r2, #0x1f3f
00098414  ldr       r3, [r0, #0x400]
00098418  movw      r0, #0  rel→.L.str.445
0009841c  movt      r0, #0  rel→.L.str.445
00098420  str       r8, [sp]
00098424  bl        #0x98424  rel→printk; CALL printk
00098428  b         #0x97d60
0009842c  ldr       r1, [r8, #0xc]
00098430  movw      r2, #0x1c8a
00098434  ldr       r3, [r1, #0x400]
00098438  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
0009843c  str       r0, [sp]
00098440  movw      r0, #0  rel→.L.str.313
00098444  movt      r0, #0  rel→.L.str.313
00098448  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
0009844c  bl        #0x9844c  rel→printk; CALL printk
00098450  b         #0x97f70
00098454  ldr       r1, [r8, #0xc]
00098458  movw      r2, #0x1c94
0009845c  ldr       r3, [r1, #0x400]
00098460  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00098464  str       r0, [sp]
00098468  movw      r0, #0  rel→.L.str.313
0009846c  movt      r0, #0  rel→.L.str.313
00098470  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_SetMuteInBypassMode
00098474  bl        #0x98474  rel→printk; CALL printk
00098478  b         #0x98018
0009847c  bl        #0x9847c  rel→current_thread_info; CALL current_thread_info
00098480  mov       r6, r0
00098484  ldr       r0, [r0, #0xc]
00098488  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
0009848c  mov       r3, #0x1e00
00098490  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00098494  ldr       r1, [r0, #0x400]
00098498  movw      r0, #0  rel→.L.str.1425
0009849c  movt      r0, #0  rel→.L.str.1425
000984a0  bl        #0x984a0  rel→printk; CALL printk
000984a4  movw      r0, #0  rel→_u32CurEdidSupportList
000984a8  movt      r0, #0  rel→_u32CurEdidSupportList
000984ac  ldr       r0, [r0]
000984b0  eor       r4, r0, r8
000984b4  movw      r0, #0  rel→_u32AoutDbgLevel
000984b8  movt      r0, #0  rel→_u32AoutDbgLevel
000984bc  ldr       r0, [r0]
000984c0  cmp       r0, #0x40
000984c4  bhs       #0x9858c
000984c8  mov       r2, #1
000984cc  b         #0x97b4c
000984d0  movw      r0, #0  rel→_u32AoutDbgLevel
000984d4  ldr       sb, [sp, #0x34]
000984d8  movt      r0, #0  rel→_u32AoutDbgLevel
000984dc  add       r6, sp, #0x48
000984e0  ldr       r0, [r0]
000984e4  add       r4, sp, #0x58
000984e8  cmp       r0, #0x20
000984ec  blo       #0x97d60
000984f0  ldr       r0, [sp, #0x20]
000984f4  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000984f8  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
000984fc  movw      r2, #0x1f4d
00098500  ldr       r0, [r0, #0xc]
00098504  ldr       r3, [r0, #0x400]
00098508  movw      r0, #0  rel→.L.str.1460
0009850c  movt      r0, #0  rel→.L.str.1460
00098510  bl        #0x98510  rel→printk; CALL printk
00098514  b         #0x97d60
00098518  movw      r1, #0  rel→_u32AoutDbgLevel
0009851c  ldr       sb, [sp, #0x34]
00098520  movt      r1, #0  rel→_u32AoutDbgLevel
00098524  add       r6, sp, #0x48
00098528  ldr       r1, [r1]
0009852c  add       r4, sp, #0x58
00098530  cmp       r1, #0x20
00098534  blo       #0x98580
00098538  ldr       r1, [sp, #0x20]
0009853c  movw      r2, #0x1f56
00098540  ldr       r1, [r1, #0xc]
00098544  ldr       r3, [r1, #0x400]
00098548  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
0009854c  str       r0, [sp]
00098550  movw      r0, #0  rel→.L.str.449
00098554  movt      r0, #0  rel→.L.str.449
00098558  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_AiAqPreparsing
0009855c  bl        #0x9855c  rel→printk; CALL printk
00098560  b         #0x98580
00098564  ldr       sb, [sp, #0x34]
00098568  movw      r1, #0  rel→_bAiAqPreParsed
0009856c  add       r6, sp, #0x48
00098570  add       r4, sp, #0x58
00098574  mov       r0, #1
00098578  movt      r1, #0  rel→_bAiAqPreParsed
0009857c  strb      r0, [r1]
00098580  ldr       r0, [sp, #0x28]
00098584  bl        #0x98584  rel→iniparser_freedict; CALL iniparser_freedict
00098588  b         #0x97d60
0009858c  ldr       r0, [r6, #0xc]
00098590  movw      r2, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00098594  movt      r2, #0  rel→.L__FUNCTION__._MI_AOUT_HdmiInfoMonitor
00098598  movw      r3, #0x1e05
0009859c  ldr       r1, [r0, #0x400]
000985a0  movw      r0, #0  rel→.L.str.1426
000985a4  movt      r0, #0  rel→.L.str.1426
000985a8  str       r8, [sp]
000985ac  str       r8, [sp, #4]
000985b0  bl        #0x985b0  rel→printk; CALL printk
000985b4  b         #0x984c8
000985b8  ldr       r0, [fp]
000985bc  mvn       r1, #0
000985c0  bl        #0x985c0  rel→MI_OS_ClearEvent; CALL MI_OS_ClearEvent
000985c4  cmp       r0, #0
000985c8  beq       #0x985e4
000985cc  mov       r4, r0
000985d0  movw      r0, #0  rel→_u32AoutDbgLevel
000985d4  movt      r0, #0  rel→_u32AoutDbgLevel
000985d8  ldr       r0, [r0]
000985dc  cmp       r0, #0x20
000985e0  bhs       #0x98628
000985e4  ldr       r0, [r5, #8]
000985e8  cmp       r0, #1
000985ec  blt       #0x98610
000985f0  bl        #0x985f0  rel→MI_OS_ReleaseSemaphore; CALL MI_OS_ReleaseSemaphore
000985f4  cmp       r0, #0
000985f8  beq       #0x98610
000985fc  movw      r0, #0  rel→_u32AoutDbgLevel
00098600  movt      r0, #0  rel→_u32AoutDbgLevel
00098604  ldr       r0, [r0]
00098608  cmp       r0, #0x20
0009860c  bhs       #0x9865c
00098610  ldr       r0, [sl]
00098614  ldr       r1, [sp, #0xf0]
00098618  subs      r0, r0, r1
0009861c  addeq     sp, sp, #0xf4
00098620  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
00098624  bl        #0x98624  rel→__stack_chk_fail; CALL __stack_chk_fail
00098628  bl        #0x98628  rel→current_thread_info; CALL current_thread_info
0009862c  ldr       r0, [r0, #0xc]
00098630  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
00098634  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
00098638  movw      r2, #0x1fcc
0009863c  ldr       r3, [r0, #0x400]
00098640  ldr       r0, [fp]
00098644  str       r0, [sp, #4]
00098648  movw      r0, #0  rel→.L.str.1412
0009864c  movt      r0, #0  rel→.L.str.1412
00098650  str       r4, [sp]
00098654  bl        #0x98654  rel→printk; CALL printk
00098658  b         #0x985e4
0009865c  bl        #0x9865c  rel→current_thread_info; CALL current_thread_info
00098660  ldr       r0, [r0, #0xc]
00098664  movw      r1, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
00098668  movt      r1, #0  rel→.L__FUNCTION__._MI_AOUT_MonitorTask
0009866c  movw      r2, #0x1fd3
00098670  ldr       r3, [r0, #0x400]
00098674  movw      r0, #0  rel→.L.str.1413
00098678  movt      r0, #0  rel→.L.str.1413
0009867c  bl        #0x9867c  rel→printk; CALL printk
00098680  b         #0x98610
