===== kmods/mik.ko MI_AUDIO_Start sec_off=0xa437c size=0xb5c mode=A =====
000a437c  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
000a4380  sub       sp, sp, #0x94
000a4384  movw      fp, #0  rel→__stack_chk_guard
000a4388  movw      r6, #0  rel→_u32AudioDbgLevel
000a438c  movt      fp, #0  rel→__stack_chk_guard
000a4390  mov       r4, r0
000a4394  ldr       r0, [fp]
000a4398  movt      r6, #0  rel→_u32AudioDbgLevel
000a439c  str       r0, [sp, #0x90]
000a43a0  mov       r0, #0
000a43a4  str       r0, [sp, #0x20]
000a43a8  mov       r5, r1
000a43ac  ldr       r0, [r6]
000a43b0  cmp       r0, #0xf0
000a43b4  bhs       #0xa4418
000a43b8  tst       r4, #0x100
000a43bc  bne       #0xa4438
000a43c0  cmp       r5, #0
000a43c4  bne       #0xa4464
000a43c8  ldr       r0, [r6]
000a43cc  mov       r7, #8
000a43d0  cmp       r0, #0x20
000a43d4  blo       #0xa4448
000a43d8  movw      r0, #0  rel→.L.str.7
000a43dc  movw      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a43e0  movt      r0, #0  rel→.L.str.7
000a43e4  movt      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a43e8  movw      r2, #0x2450
000a43ec  bl        #0xa43ec  rel→printk; CALL printk
000a43f0  ldr       r0, [r6]
000a43f4  cmp       r0, #0x20
000a43f8  blo       #0xa4448
000a43fc  movw      r0, #0  rel→.L.str.89
000a4400  movw      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4404  movt      r0, #0  rel→.L.str.89
000a4408  movt      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a440c  movw      r2, #0x2450
000a4410  bl        #0xa4410  rel→printk; CALL printk
000a4414  b         #0xa4448
000a4418  movw      r0, #0  rel→.L.str.20
000a441c  movw      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4420  movt      r0, #0  rel→.L.str.20
000a4424  movt      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4428  movw      r2, #0x2448
000a442c  bl        #0xa442c  rel→printk; CALL printk
000a4430  tst       r4, #0x100
000a4434  beq       #0xa43c0
000a4438  ldr       r0, [r6]
000a443c  mov       r7, #7
000a4440  cmp       r0, #0x20
000a4444  bhs       #0xa4524
000a4448  ldr       r0, [fp]
000a444c  ldr       r1, [sp, #0x90]
000a4450  subs      r0, r0, r1
000a4454  moveq     r0, r7
000a4458  addeq     sp, sp, #0x94
000a445c  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
000a4460  bl        #0xa4460  rel→__stack_chk_fail; CALL __stack_chk_fail
000a4464  movw      sl, #0  rel→_s32AudioSystemMutex
000a4468  movt      sl, #0  rel→_s32AudioSystemMutex
000a446c  ldr       r0, [sl]
000a4470  cmn       r0, #1
000a4474  beq       #0xa4480
000a4478  mvn       r1, #0xff
000a447c  bl        #0xa447c  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000a4480  mov       r0, #0
000a4484  add       r1, sp, #0x20
000a4488  str       r0, [sp, #0x20]
000a448c  mov       r0, r4
000a4490  bl        #0xb2d24
000a4494  cmp       r0, #0
000a4498  bne       #0xa4550
000a449c  ldr       sb, [sp, #0x20]
000a44a0  ldr       r8, [r5]
000a44a4  mov       r0, sb
000a44a8  bl        #0x9d528
000a44ac  cmp       r0, #0
000a44b0  bne       #0xa4590
000a44b4  mov       r0, #0xff
000a44b8  mov       r1, #0
000a44bc  str       r0, [sp, #0x24]
000a44c0  add       r0, sp, #0x28
000a44c4  mov       r2, #0x34
000a44c8  bl        #0xa44c8  rel→memset; CALL memset
000a44cc  cmp       sb, #0
000a44d0  bne       #0xa45c8
000a44d4  ldr       r0, [r6]
000a44d8  mov       r7, #8
000a44dc  cmp       r0, #0x20
000a44e0  blo       #0xa4e34
000a44e4  movw      r0, #0  rel→.L.str.7
000a44e8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a44ec  movt      r0, #0  rel→.L.str.7
000a44f0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a44f4  movw      r2, #0x14db
000a44f8  bl        #0xa44f8  rel→printk; CALL printk
000a44fc  ldr       r0, [r6]
000a4500  cmp       r0, #0x20
000a4504  blo       #0xa4e34
000a4508  movw      r0, #0  rel→.L.str.8
000a450c  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4510  movt      r0, #0  rel→.L.str.8
000a4514  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4518  movw      r2, #0x14db
000a451c  bl        #0xa451c  rel→printk; CALL printk
000a4520  b         #0xa4e34
000a4524  bl        #0xa4524  rel→current_thread_info; CALL current_thread_info
000a4528  ldr       r0, [r0, #0xc]
000a452c  movw      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4530  movt      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4534  movw      r2, #0x244c
000a4538  ldr       r3, [r0, #0x400]
000a453c  movw      r0, #0  rel→.L.str.81
000a4540  movt      r0, #0  rel→.L.str.81
000a4544  str       r4, [sp]
000a4548  bl        #0xa4548  rel→printk; CALL printk
000a454c  b         #0xa4448
000a4550  mov       r7, r0
000a4554  ldr       r0, [r6]
000a4558  cmp       r0, #0x20
000a455c  blo       #0xa4e34
000a4560  bl        #0xa4560  rel→current_thread_info; CALL current_thread_info
000a4564  ldr       r0, [r0, #0xc]
000a4568  movw      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a456c  movt      r1, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4570  movw      r2, #0x2457
000a4574  ldr       r3, [r0, #0x400]
000a4578  movw      r0, #0  rel→.L.str.90
000a457c  movt      r0, #0  rel→.L.str.90
000a4580  str       r7, [sp]
000a4584  str       r4, [sp, #4]
000a4588  bl        #0xa4588  rel→printk; CALL printk
000a458c  b         #0xa4e34
000a4590  mov       r7, r0
000a4594  ldr       r0, [r6]
000a4598  cmp       r0, #0x20
000a459c  blo       #0xa4e34
000a45a0  bl        #0xa45a0  rel→current_thread_info; CALL current_thread_info
000a45a4  ldr       r0, [r0, #0xc]
000a45a8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Start
000a45ac  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Start
000a45b0  movw      r2, #0x1d56
000a45b4  ldr       r3, [r0, #0x400]
000a45b8  movw      r0, #0  rel→.L.str
000a45bc  movt      r0, #0  rel→.L.str
000a45c0  bl        #0xa45c0  rel→printk; CALL printk
000a45c4  b         #0xa4e34
000a45c8  cmp       r8, #0
000a45cc  bne       #0xa4610
000a45d0  ldr       r0, [r6]
000a45d4  mov       r7, #8
000a45d8  cmp       r0, #0x20
000a45dc  blo       #0xa4e34
000a45e0  bl        #0xa45e0  rel→current_thread_info; CALL current_thread_info
000a45e4  ldr       r0, [r0, #0xc]
000a45e8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a45ec  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a45f0  movw      r2, #0x14e1
000a45f4  ldr       r3, [r0, #0x400]
000a45f8  mov       r0, #0
000a45fc  str       r0, [sp]
000a4600  movw      r0, #0  rel→.L.str.402
000a4604  movt      r0, #0  rel→.L.str.402
000a4608  bl        #0xa4608  rel→printk; CALL printk
000a460c  b         #0xa4e34
000a4610  add       r0, sp, #0x28
000a4614  bl        #0xa4614  rel→mi_hwcaps_GetAudioCaps; CALL mi_hwcaps_GetAudioCaps
000a4618  cmp       r0, #0
000a461c  bne       #0xa46c8
000a4620  ldr       r0, [r6]
000a4624  ldr       r7, [sb, #0xb18]
000a4628  cmp       r0, #0x40
000a462c  blo       #0xa4660
000a4630  bl        #0xa4630  rel→current_thread_info; CALL current_thread_info
000a4634  ldr       r0, [r0, #0xc]
000a4638  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a463c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4640  movw      r3, #0x14ef
000a4644  ldr       r1, [r0, #0x400]
000a4648  ldr       r0, [sb, #0xadc]
000a464c  str       r0, [sp, #4]
000a4650  movw      r0, #0  rel→.L.str.404
000a4654  movt      r0, #0  rel→.L.str.404
000a4658  str       r7, [sp]
000a465c  bl        #0xa465c  rel→printk; CALL printk
000a4660  cmp       r7, #1
000a4664  bhi       #0xa4700
000a4668  add       r1, sp, #0x24
000a466c  mov       r0, r8
000a4670  str       r8, [sb, #0x958]
000a4674  bl        #0xa33e0
000a4678  mov       r1, r7
000a467c  movw      r7, #0  rel→_aeCurAudioDecoderType
000a4680  movt      r7, #0  rel→_aeCurAudioDecoderType
000a4684  str       r1, [sp, #0x1c]
000a4688  ldr       r0, [r7, r1, lsl #2]
000a468c  cmp       r0, r8
000a4690  beq       #0xa4860
000a4694  str       r8, [r7, r1, lsl #2]
000a4698  ldr       r0, [sb, #0x948]
000a469c  cmp       r0, #4
000a46a0  bne       #0xa4738
000a46a4  bl        #0xa46a4  rel→current_thread_info; CALL current_thread_info
000a46a8  ldr       r0, [r0, #0xc]
000a46ac  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a46b0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a46b4  movw      r3, #0x150d
000a46b8  ldr       r1, [r0, #0x400]
000a46bc  movw      r0, #0  rel→.L.str.405
000a46c0  movt      r0, #0  rel→.L.str.405
000a46c4  b         #0xa47d8
000a46c8  ldr       r0, [r6]
000a46cc  mov       r7, #3
000a46d0  cmp       r0, #0x20
000a46d4  blo       #0xa4e34
000a46d8  bl        #0xa46d8  rel→current_thread_info; CALL current_thread_info
000a46dc  ldr       r0, [r0, #0xc]
000a46e0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a46e4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a46e8  movw      r2, #0x14e7
000a46ec  ldr       r3, [r0, #0x400]
000a46f0  movw      r0, #0  rel→.L.str.403
000a46f4  movt      r0, #0  rel→.L.str.403
000a46f8  bl        #0xa46f8  rel→printk; CALL printk
000a46fc  b         #0xa4e34
000a4700  ldr       r0, [r6]
000a4704  mov       r7, #3
000a4708  cmp       r0, #0x20
000a470c  blo       #0xa4e34
000a4710  bl        #0xa4710  rel→current_thread_info; CALL current_thread_info
000a4714  ldr       r0, [r0, #0xc]
000a4718  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a471c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4720  movw      r2, #0x15a2
000a4724  ldr       r3, [r0, #0x400]
000a4728  movw      r0, #0  rel→.L.str.412
000a472c  movt      r0, #0  rel→.L.str.412
000a4730  bl        #0xa4730  rel→printk; CALL printk
000a4734  b         #0xa4e34
000a4738  add       r8, sp, #0x60
000a473c  ldr       r0, [sp, #0x24]
000a4740  str       r0, [sp, #0x18]
000a4744  mov       r1, #0
000a4748  mov       r0, r8
000a474c  mov       r2, #0x28
000a4750  bl        #0xa4750  rel→memset; CALL memset
000a4754  ldr       r0, [sb, #0xadc]
000a4758  mov       r1, r8
000a475c  bl        #0xa475c  rel→MApi_AUDIO_GetDecodeSystem; CALL MApi_AUDIO_GetDecodeSystem
000a4760  cmp       r0, #1
000a4764  beq       #0xa47a0
000a4768  ldr       r0, [r6]
000a476c  cmp       r0, #0x20
000a4770  blo       #0xa47a0
000a4774  bl        #0xa4774  rel→current_thread_info; CALL current_thread_info
000a4778  ldr       r0, [r0, #0xc]
000a477c  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a4780  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a4784  movw      r2, #0x46e
000a4788  ldr       r3, [r0, #0x400]
000a478c  ldr       r0, [sb, #0xadc]
000a4790  str       r0, [sp]
000a4794  movw      r0, #0  rel→.L.str.413
000a4798  movt      r0, #0  rel→.L.str.413
000a479c  bl        #0xa479c  rel→printk; CALL printk
000a47a0  ldr       r0, [sb, #0xb18]
000a47a4  cmp       r0, #2
000a47a8  blo       #0xa47e0
000a47ac  ldr       r0, [r6]
000a47b0  cmp       r0, #0x20
000a47b4  blo       #0xa485c
000a47b8  bl        #0xa47b8  rel→current_thread_info; CALL current_thread_info
000a47bc  ldr       r0, [r0, #0xc]
000a47c0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a47c4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a47c8  movw      r2, #0x473
000a47cc  ldr       r3, [r0, #0x400]
000a47d0  movw      r0, #0  rel→.L.str.414
000a47d4  movt      r0, #0  rel→.L.str.414
000a47d8  bl        #0xa47d8  rel→printk; CALL printk
000a47dc  b         #0xa485c
000a47e0  ldr       r1, [sp, #0x18]
000a47e4  str       r1, [sp, #0x70]
000a47e8  movw      r1, #0  rel→_aeAdecStcSource
000a47ec  movt      r1, #0  rel→_aeAdecStcSource
000a47f0  ldr       r8, [sb, #0xae0]
000a47f4  ldr       r0, [r1, r0, lsl #2]
000a47f8  str       r8, [sp, #0x6c]
000a47fc  str       r0, [sp, #0x14]
000a4800  str       r0, [sp, #0x74]
000a4804  ldr       r0, [r6]
000a4808  cmp       r0, #0x40
000a480c  blo       #0xa4850
000a4810  bl        #0xa4810  rel→current_thread_info; CALL current_thread_info
000a4814  ldr       r0, [r0, #0xc]
000a4818  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a481c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_SetAudioSystem
000a4820  movw      r3, #0x47b
000a4824  ldr       r1, [r0, #0x400]
000a4828  ldr       r0, [sb, #0xadc]
000a482c  str       r0, [sp]
000a4830  ldr       r0, [sp, #0x18]
000a4834  str       r0, [sp, #4]
000a4838  ldr       r0, [sp, #0x14]
000a483c  str       r0, [sp, #8]
000a4840  movw      r0, #0  rel→.L.str.415
000a4844  movt      r0, #0  rel→.L.str.415
000a4848  str       r8, [sp, #0xc]
000a484c  bl        #0xa484c  rel→printk; CALL printk
000a4850  ldr       r0, [sb, #0xadc]
000a4854  add       r1, sp, #0x60
000a4858  bl        #0xa4858  rel→MApi_AUDIO_SetDecodeSystem; CALL MApi_AUDIO_SetDecodeSystem
000a485c  ldr       r1, [sp, #0x1c]
000a4860  ldr       r0, [r7, r1, lsl #2]
000a4864  ldr       r1, [sb, #0xa2c]
000a4868  cmp       r0, r1
000a486c  beq       #0xa488c
000a4870  add       r0, sb, #0xa30
000a4874  mov       r1, #0
000a4878  mov       r2, #0x84
000a487c  bl        #0xa487c  rel→memset; CALL memset
000a4880  ldr       r0, [sb, #0xb18]
000a4884  ldr       r0, [r7, r0, lsl #2]
000a4888  str       r0, [sb, #0xa2c]
000a488c  bl        #0xb17c4
000a4890  ldr       r0, [sb, #0x948]
000a4894  ldr       r7, [sp, #0x1c]
000a4898  cmp       r0, #3
000a489c  bhi       #0xa4a8c
000a48a0  add       r1, pc, #0
000a48a4  ldr       pc, [r1, r0, lsl #2]
000a48a8  strheq    r4, [sl], -r8  rel→
000a48ac  andeq     r4, sl, r0, lsr sb  rel→
000a48b0  andeq     r4, sl, ip, asr #18  rel→
000a48b4  strheq    r4, [sl], -r8  rel→
000a48b8  ldr       r7, [sb, #0x950]
000a48bc  mov       r1, #3
000a48c0  ldr       r0, [sb, #0xadc]
000a48c4  cmp       r7, #1
000a48c8  movweq    r1, #4
000a48cc  bl        #0xa48cc  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a48d0  cmp       r7, #1
000a48d4  ldr       r0, [sb, #0xadc]
000a48d8  movwne    r7, #7
000a48dc  mov       r1, r7
000a48e0  ldr       r7, [sp, #0x1c]
000a48e4  bl        #0xa48e4  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a48e8  ldrb      r0, [sp, #0x2a]
000a48ec  cmp       r0, #1
000a48f0  bne       #0xa4a8c
000a48f4  mov       r0, #0x4e
000a48f8  mov       r1, #0
000a48fc  mov       r2, #0
000a4900  bl        #0xa4900  rel→MApi_AUDIO_SetCommAudioInfo; CALL MApi_AUDIO_SetCommAudioInfo
000a4904  cmp       r0, #1
000a4908  beq       #0xa4a8c
000a490c  ldr       r0, [r6]
000a4910  cmp       r0, #0x20
000a4914  blo       #0xa4a8c
000a4918  bl        #0xa4918  rel→current_thread_info; CALL current_thread_info
000a491c  ldr       r0, [r0, #0xc]
000a4920  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4924  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4928  movw      r2, #0x156c
000a492c  b         #0xa4a5c
000a4930  ldr       r0, [sb, #0x954]
000a4934  cmp       r0, #1
000a4938  bne       #0xa49f8
000a493c  bl        #0xb17c4
000a4940  mov       r7, #1
000a4944  mov       r1, #4
000a4948  b         #0xa4a00
000a494c  ldr       r0, [sb, #0xadc]
000a4950  mov       r1, #3
000a4954  bl        #0xa4954  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4958  ldr       r0, [sb, #0xadc]
000a495c  mov       r1, #7
000a4960  bl        #0xa4960  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4964  ldrb      r0, [sp, #0x2a]
000a4968  cmp       r0, #1
000a496c  bne       #0xa4a8c
000a4970  mov       r0, #0x4e
000a4974  mov       r1, #1
000a4978  mov       r2, #0
000a497c  bl        #0xa497c  rel→MApi_AUDIO_SetCommAudioInfo; CALL MApi_AUDIO_SetCommAudioInfo
000a4980  cmp       r0, #1
000a4984  beq       #0xa4a8c
000a4988  ldr       r0, [r6]
000a498c  cmp       r0, #0x20
000a4990  blo       #0xa4a8c
000a4994  bl        #0xa4994  rel→current_thread_info; CALL current_thread_info
000a4998  ldr       r0, [r0, #0xc]
000a499c  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a49a0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a49a4  movw      r2, #0x1547
000a49a8  ldr       r3, [r0, #0x400]
000a49ac  movw      r0, #0  rel→.L.str.407
000a49b0  movt      r0, #0  rel→.L.str.407
000a49b4  b         #0xa4a68
000a49b8  ldr       r1, [sb, #0x94c]
000a49bc  ldr       r0, [sb, #0xadc]
000a49c0  cmp       r1, #1
000a49c4  bne       #0xa4a70
000a49c8  mov       r1, #8
000a49cc  mov       r2, #8
000a49d0  bl        #0xa49d0  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a49d4  ldr       r0, [sb, #0xadc]
000a49d8  mov       r1, #0x15
000a49dc  mov       r2, #3
000a49e0  bl        #0xa49e0  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a49e4  ldr       r2, [sb, #0x938]
000a49e8  mov       r1, #0xf
000a49ec  ldr       r0, [sb, #0xadc]
000a49f0  bl        #0xa49f0  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a49f4  b         #0xa4a8c
000a49f8  mov       r7, #7
000a49fc  mov       r1, #3
000a4a00  ldr       r0, [sb, #0xadc]
000a4a04  bl        #0xa4a04  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4a08  ldr       r0, [sb, #0xadc]
000a4a0c  mov       r1, r7
000a4a10  bl        #0xa4a10  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4a14  ldrb      r0, [sp, #0x2a]
000a4a18  ldr       r7, [sp, #0x1c]
000a4a1c  cmp       r0, #1
000a4a20  bne       #0xa4a8c
000a4a24  mov       r0, #0x4e
000a4a28  mov       r1, #0
000a4a2c  mov       r2, #0
000a4a30  bl        #0xa4a30  rel→MApi_AUDIO_SetCommAudioInfo; CALL MApi_AUDIO_SetCommAudioInfo
000a4a34  cmp       r0, #1
000a4a38  beq       #0xa4a8c
000a4a3c  ldr       r0, [r6]
000a4a40  cmp       r0, #0x20
000a4a44  blo       #0xa4a8c
000a4a48  bl        #0xa4a48  rel→current_thread_info; CALL current_thread_info
000a4a4c  ldr       r0, [r0, #0xc]
000a4a50  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4a54  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4a58  movw      r2, #0x1539
000a4a5c  ldr       r3, [r0, #0x400]
000a4a60  movw      r0, #0  rel→.L.str.406
000a4a64  movt      r0, #0  rel→.L.str.406
000a4a68  bl        #0xa4a68  rel→printk; CALL printk
000a4a6c  b         #0xa4a8c
000a4a70  bl        #0xa4a70  rel→MApi_AUDIO_MM2_initAesInfo; CALL MApi_AUDIO_MM2_initAesInfo
000a4a74  ldr       r0, [sb, #0xadc]
000a4a78  mov       r1, #3
000a4a7c  bl        #0xa4a7c  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4a80  ldr       r0, [sb, #0xadc]
000a4a84  mov       r1, #0xc
000a4a88  bl        #0xa4a88  rel→MApi_AUDIO_SetDecodeCmd; CALL MApi_AUDIO_SetDecodeCmd
000a4a8c  ldrb      r0, [sb, #0x84a]
000a4a90  cmp       r0, #1
000a4a94  bne       #0xa4d08
000a4a98  ldr       r0, [sp, #0x50]
000a4a9c  cmp       r0, #0
000a4aa0  beq       #0xa4d08
000a4aa4  movw      r1, #0xcccd
000a4aa8  movt      r1, #0xcccc
000a4aac  umull     r2, r3, r0, r1
000a4ab0  add       r0, r0, r0, lsl #3
000a4ab4  umull     r0, r1, r0, r1
000a4ab8  lsr       r2, r3, #3
000a4abc  movw      r3, #0  rel→_u32AudioEsBufThresholdMin
000a4ac0  movt      r3, #0  rel→_u32AudioEsBufThresholdMin
000a4ac4  str       r2, [r3]
000a4ac8  lsr       r0, r1, #3
000a4acc  movw      r1, #0  rel→_u32AudioEsBufThresholdMax
000a4ad0  movt      r1, #0  rel→_u32AudioEsBufThresholdMax
000a4ad4  str       r0, [r1]
000a4ad8  bl        #0xa4ad8  rel→current_thread_info; CALL current_thread_info
000a4adc  mov       r8, r0
000a4ae0  ldr       r0, [r0, #0xc]
000a4ae4  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4ae8  movw      r3, #0x1576
000a4aec  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4af0  ldr       r1, [r0, #0x400]
000a4af4  movw      r0, #0  rel→.L.str.408
000a4af8  movt      r0, #0  rel→.L.str.408
000a4afc  bl        #0xa4afc  rel→printk; CALL printk
000a4b00  movw      r0, #0  rel→.L__const._MI_AUDIO_CreateMonitor.stCreateSemParams
000a4b04  str       sb, [sp, #0x64]
000a4b08  movt      r0, #0  rel→.L__const._MI_AUDIO_CreateMonitor.stCreateSemParams
000a4b0c  ldrd      r0, r1, [r0]
000a4b10  str       r0, [sp, #0x88]
000a4b14  movw      r0, #0  rel→.L.str.417
000a4b18  movt      r0, #0  rel→.L.str.417
000a4b1c  str       r1, [sp, #0x8c]
000a4b20  str       r0, [sp, #0x78]
000a4b24  mov       r0, #0x1000
000a4b28  str       r0, [sp, #0x74]
000a4b2c  mov       r0, #0
000a4b30  str       r0, [sp, #0x70]
000a4b34  mov       r0, #1
000a4b38  strb      r0, [sp, #0x6c]
000a4b3c  mov       r0, #4
000a4b40  str       r0, [sp, #0x68]
000a4b44  movw      r0, #0  rel→_MI_AUDIO_EsBufMonTask
000a4b48  movt      r0, #0  rel→_MI_AUDIO_EsBufMonTask
000a4b4c  str       r0, [sp, #0x60]
000a4b50  ldr       r0, [sb, #0x9f4]
000a4b54  cmp       r0, #0
000a4b58  bne       #0xa4bb8
000a4b5c  movw      r0, #0  rel→kmalloc_caches
000a4b60  movw      r1, #0xc0
000a4b64  movt      r0, #0  rel→kmalloc_caches
000a4b68  movt      r1, #0x60
000a4b6c  ldr       r0, [r0, #0x18]
000a4b70  mov       r2, #0x10
000a4b74  bl        #0xa4b74  rel→kmem_cache_alloc_trace; CALL kmem_cache_alloc_trace
000a4b78  cmp       r0, #0
000a4b7c  bne       #0xa4be8
000a4b80  ldr       r0, [r6]
000a4b84  cmp       r0, #0x20
000a4b88  blo       #0xa4d04
000a4b8c  ldr       r0, [r8, #0xc]
000a4b90  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4b94  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4b98  movw      r2, #0xd4f
000a4b9c  ldr       r3, [r0, #0x400]
000a4ba0  mov       r0, #0x10
000a4ba4  str       r0, [sp]
000a4ba8  movw      r0, #0  rel→.L.str.419
000a4bac  movt      r0, #0  rel→.L.str.419
000a4bb0  bl        #0xa4bb0  rel→printk; CALL printk
000a4bb4  b         #0xa4d04
000a4bb8  ldr       r0, [r6]
000a4bbc  cmp       r0, #0x20
000a4bc0  blo       #0xa4d04
000a4bc4  ldr       r0, [r8, #0xc]
000a4bc8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4bcc  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4bd0  movw      r2, #0xd48
000a4bd4  ldr       r3, [r0, #0x400]
000a4bd8  movw      r0, #0  rel→.L.str.418
000a4bdc  movt      r0, #0  rel→.L.str.418
000a4be0  bl        #0xa4be0  rel→printk; CALL printk
000a4be4  b         #0xa4d04
000a4be8  mov       r7, r0
000a4bec  mov       r0, #0
000a4bf0  str       r0, [r7]
000a4bf4  str       r0, [r7, #4]
000a4bf8  str       r0, [r7, #8]
000a4bfc  str       r0, [r7, #0xc]
000a4c00  mov       r0, #0x1000
000a4c04  bl        #0xa4c04  rel→vmalloc; CALL vmalloc
000a4c08  cmp       r0, #0
000a4c0c  str       r0, [r7, #4]
000a4c10  bne       #0xa4c48
000a4c14  ldr       r0, [r6]
000a4c18  cmp       r0, #0x20
000a4c1c  blo       #0xa4cfc
000a4c20  ldr       r0, [r8, #0xc]
000a4c24  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4c28  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4c2c  movw      r2, #0xd5a
000a4c30  ldr       r3, [r0, #0x400]
000a4c34  mov       r0, #0x1000
000a4c38  str       r0, [sp]
000a4c3c  movw      r0, #0  rel→.L.str.420
000a4c40  movt      r0, #0  rel→.L.str.420
000a4c44  b         #0xa4ce0
000a4c48  mov       r1, #0
000a4c4c  mov       r2, #0x1000
000a4c50  bl        #0xa4c50  rel→memset; CALL memset
000a4c54  ldr       r0, [r7, #4]
000a4c58  mov       r1, r7
000a4c5c  str       r0, [sp, #0x70]
000a4c60  add       r0, sp, #0x60
000a4c64  bl        #0xa4c64  rel→MI_OS_CreateTask; CALL MI_OS_CreateTask
000a4c68  cmp       r0, #0
000a4c6c  bne       #0xa4cb8
000a4c70  add       r1, r7, #8
000a4c74  add       r0, sp, #0x88
000a4c78  bl        #0xa4c78  rel→MI_OS_CreateSemaphore; CALL MI_OS_CreateSemaphore
000a4c7c  cmp       r0, #0
000a4c80  beq       #0xa4cb0
000a4c84  ldr       r0, [r6]
000a4c88  cmp       r0, #0x20
000a4c8c  blo       #0xa4cb0
000a4c90  ldr       r0, [r8, #0xc]
000a4c94  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4c98  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4c9c  movw      r2, #0xd6b
000a4ca0  ldr       r3, [r0, #0x400]
000a4ca4  movw      r0, #0  rel→.L.str.422
000a4ca8  movt      r0, #0  rel→.L.str.422
000a4cac  bl        #0xa4cac  rel→printk; CALL printk
000a4cb0  str       r7, [sb, #0x9f4]
000a4cb4  b         #0xa4d04
000a4cb8  ldr       r0, [r6]
000a4cbc  cmp       r0, #0x20
000a4cc0  blo       #0xa4ce4
000a4cc4  ldr       r0, [r8, #0xc]
000a4cc8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4ccc  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_CreateEsBufMonTask
000a4cd0  movw      r2, #0xd64
000a4cd4  ldr       r3, [r0, #0x400]
000a4cd8  movw      r0, #0  rel→.L.str.421
000a4cdc  movt      r0, #0  rel→.L.str.421
000a4ce0  bl        #0xa4ce0  rel→printk; CALL printk
000a4ce4  ldr       r0, [r7, #4]
000a4ce8  cmp       r0, #0
000a4cec  beq       #0xa4cfc
000a4cf0  bl        #0xa4cf0  rel→vfree; CALL vfree
000a4cf4  mov       r0, #0
000a4cf8  str       r0, [r7, #4]
000a4cfc  mov       r0, r7
000a4d00  bl        #0xa4d00  rel→kfree; CALL kfree
000a4d04  ldr       r7, [sp, #0x1c]
000a4d08  ldr       r0, [sb, #0x948]
000a4d0c  cmp       r0, #1
000a4d10  bhi       #0xa4d34
000a4d14  add       r0, sb, r7, lsl #2
000a4d18  ldr       r0, [r0, #0x960]
000a4d1c  cmp       r0, #0
000a4d20  bne       #0xa4d34
000a4d24  mov       r0, sb
000a4d28  mov       r1, #1
000a4d2c  mov       r2, #0
000a4d30  bl        #0xa6124
000a4d34  ldrb      r0, [sb, #0x846]
000a4d38  cmp       r0, #0
000a4d3c  beq       #0xa4d50
000a4d40  mov       r0, sb
000a4d44  bl        #0xa6938
000a4d48  cmp       r0, #0
000a4d4c  bne       #0xa4db4
000a4d50  ldr       r0, [sb, #0xadc]
000a4d54  cmp       r0, #2
000a4d58  beq       #0xa4dec
000a4d5c  cmp       r0, #0
000a4d60  bne       #0xa4e04
000a4d64  mov       r0, #0x7c
000a4d68  mov       r1, #1
000a4d6c  mov       r2, #0
000a4d70  bl        #0xa4d70  rel→MApi_AUDIO_SetCommAudioInfo; CALL MApi_AUDIO_SetCommAudioInfo
000a4d74  cmp       r0, #1
000a4d78  beq       #0xa4e04
000a4d7c  ldr       r0, [r6]
000a4d80  mov       r7, #3
000a4d84  cmp       r0, #0x20
000a4d88  blo       #0xa4e34
000a4d8c  bl        #0xa4d8c  rel→current_thread_info; CALL current_thread_info
000a4d90  ldr       r0, [r0, #0xc]
000a4d94  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4d98  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4d9c  movw      r2, #0x1590
000a4da0  ldr       r3, [r0, #0x400]
000a4da4  movw      r0, #0  rel→.L.str.410
000a4da8  movt      r0, #0  rel→.L.str.410
000a4dac  bl        #0xa4dac  rel→printk; CALL printk
000a4db0  b         #0xa4e34
000a4db4  ldr       r0, [r6]
000a4db8  mov       r7, #3
000a4dbc  cmp       r0, #0x20
000a4dc0  blo       #0xa4e34
000a4dc4  bl        #0xa4dc4  rel→current_thread_info; CALL current_thread_info
000a4dc8  ldr       r0, [r0, #0xc]
000a4dcc  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4dd0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4dd4  movw      r2, #0x1587
000a4dd8  ldr       r3, [r0, #0x400]
000a4ddc  movw      r0, #0  rel→.L.str.409
000a4de0  movt      r0, #0  rel→.L.str.409
000a4de4  bl        #0xa4de4  rel→printk; CALL printk
000a4de8  b         #0xa4e34
000a4dec  mov       r0, #0xac
000a4df0  mov       r1, #1
000a4df4  mov       r2, #0
000a4df8  bl        #0xa4df8  rel→MApi_AUDIO_SetCommAudioInfo; CALL MApi_AUDIO_SetCommAudioInfo
000a4dfc  cmp       r0, #1
000a4e00  bne       #0xa4ea0
000a4e04  ldr       r1, [sp, #0x1c]
000a4e08  movw      r0, #0  rel→_au32PreErrFrameCnt
000a4e0c  mov       r7, #0
000a4e10  movt      r0, #0  rel→_au32PreErrFrameCnt
000a4e14  str       r7, [r0, r1, lsl #2]
000a4e18  movw      r0, #0  rel→_au32PreDecStatus
000a4e1c  movt      r0, #0  rel→_au32PreDecStatus
000a4e20  str       r7, [r0, r1, lsl #2]
000a4e24  movw      r0, #0x848
000a4e28  mov       r1, #1
000a4e2c  strh      r1, [sb, r0]
000a4e30  str       r7, [sb, #0x928]
000a4e34  bl        #0xa4e34  rel→current_thread_info; CALL current_thread_info
000a4e38  ldr       r0, [r0, #0xc]
000a4e3c  cmp       r7, #0
000a4e40  ldr       r1, [r0, #0x400]
000a4e44  bne       #0xa4e70
000a4e48  ldr       r0, [r5]
000a4e4c  mov       r2, #0
000a4e50  movw      r3, #0x245f
000a4e54  stm       sp, {r0, r4}
000a4e58  movw      r0, #0  rel→.L.str.91
000a4e5c  movt      r0, #0  rel→.L.str.91
000a4e60  str       r2, [sp, #8]
000a4e64  movw      r2, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4e68  movt      r2, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4e6c  b         #0xa4e88
000a4e70  movw      r0, #0  rel→.L.str.80
000a4e74  movw      r2, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4e78  movt      r0, #0  rel→.L.str.80
000a4e7c  movt      r2, #0  rel→.L__FUNCTION__.MI_AUDIO_Start
000a4e80  movw      r3, #0x2463
000a4e84  str       r7, [sp]
000a4e88  bl        #0xa4e88  rel→printk; CALL printk
000a4e8c  ldr       r0, [sl]
000a4e90  cmn       r0, #1
000a4e94  beq       #0xa4448
000a4e98  bl        #0xa4e98  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000a4e9c  b         #0xa4448
000a4ea0  ldr       r0, [r6]
000a4ea4  mov       r7, #3
000a4ea8  cmp       r0, #0x20
000a4eac  blo       #0xa4e34
000a4eb0  bl        #0xa4eb0  rel→current_thread_info; CALL current_thread_info
000a4eb4  ldr       r0, [r0, #0xc]
000a4eb8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4ebc  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_Internal_Start
000a4ec0  movw      r2, #0x1598
000a4ec4  ldr       r3, [r0, #0x400]
000a4ec8  movw      r0, #0  rel→.L.str.411
000a4ecc  movt      r0, #0  rel→.L.str.411
000a4ed0  bl        #0xa4ed0  rel→printk; CALL printk
000a4ed4  b         #0xa4e34
