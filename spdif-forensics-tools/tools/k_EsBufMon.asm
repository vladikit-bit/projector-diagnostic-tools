===== kmods/mik.ko _MI_AUDIO_EsBufMonTask sec_off=0xb3910 size=0x2d8 mode=A =====
000b3910  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
000b3914  sub       sp, sp, #0xc
000b3918  movw      r6, #0  rel→__stack_chk_guard
000b391c  mov       r4, r0
000b3920  movt      r6, #0  rel→__stack_chk_guard
000b3924  ldr       r0, [r6]
000b3928  str       r0, [sp, #8]
000b392c  mov       r0, r4
000b3930  bl        #0x9d528
000b3934  cmp       r0, #0
000b3938  beq       #0xb3968
000b393c  movw      r0, #0  rel→_u32AudioDbgLevel
000b3940  movt      r0, #0  rel→_u32AudioDbgLevel
000b3944  ldr       r0, [r0]
000b3948  cmp       r0, #0x20
000b394c  bhs       #0xb3b78
000b3950  ldr       r0, [r6]
000b3954  ldr       r1, [sp, #8]
000b3958  subs      r0, r0, r1
000b395c  addeq     sp, sp, #0xc
000b3960  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
000b3964  b         #0xb3bb4
000b3968  ldr       r0, [r4, #0x9f4]
000b396c  cmp       r0, #0
000b3970  beq       #0xb3abc
000b3974  ldrb      r1, [r0, #0xc]
000b3978  cmp       r1, #0
000b397c  bne       #0xb3b24
000b3980  movw      r7, #0  rel→_s32AudioSystemMutex
000b3984  movw      sb, #0  rel→_u32AudioEsBufThresholdMax
000b3988  movw      r8, #0  rel→_u32AudioDbgLevel
000b398c  movw      sl, #0  rel→_u32AudioEsBufThresholdMin
000b3990  add       r5, sp, #4
000b3994  movt      r7, #0  rel→_s32AudioSystemMutex
000b3998  mov       fp, #0
000b399c  movt      sb, #0  rel→_u32AudioEsBufThresholdMax
000b39a0  movt      r8, #0  rel→_u32AudioDbgLevel
000b39a4  movt      sl, #0  rel→_u32AudioEsBufThresholdMin
000b39a8  b         #0xb39c4
000b39ac  mov       r0, #0x64
000b39b0  bl        #0xb39b0  rel→MI_OS_DelayTask; CALL MI_OS_DelayTask
000b39b4  ldr       r0, [r4, #0x9f4]
000b39b8  ldrb      r1, [r0, #0xc]
000b39bc  cmp       r1, #0
000b39c0  bne       #0xb3b24
000b39c4  ldr       r0, [r7]
000b39c8  cmn       r0, #1
000b39cc  beq       #0xb39d8
000b39d0  mvn       r1, #0xff
000b39d4  bl        #0xb39d4  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000b39d8  ldr       r0, [r4, #0xadc]
000b39dc  mov       r1, #0xf
000b39e0  mov       r2, r5
000b39e4  str       fp, [sp, #4]
000b39e8  bl        #0xb39e8  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000b39ec  cmp       r0, #1
000b39f0  bne       #0xb3b04
000b39f4  ldrb      r0, [r4, #0x84a]
000b39f8  cmp       r0, #1
000b39fc  bne       #0xb3a58
000b3a00  ldr       r0, [sb]
000b3a04  ldr       r1, [sp, #4]
000b3a08  cmp       r1, r0
000b3a0c  bls       #0xb3a58
000b3a10  ldr       r0, [r8]
000b3a14  cmp       r0, #0x30
000b3a18  bhs       #0xb3a6c
000b3a1c  mov       r0, r4
000b3a20  mov       r1, #1
000b3a24  mov       r2, #1
000b3a28  bl        #0xa6124
000b3a2c  ldr       r0, [sl]
000b3a30  ldr       r1, [sp, #4]
000b3a34  cmp       r1, r0
000b3a38  bhs       #0xb3a58
000b3a3c  ldr       r0, [r8]
000b3a40  cmp       r0, #0x30
000b3a44  bhs       #0xb3a94
000b3a48  mov       r0, r4
000b3a4c  mov       r1, #1
000b3a50  mov       r2, #0
000b3a54  bl        #0xa6124
000b3a58  ldr       r0, [r7]
000b3a5c  cmn       r0, #1
000b3a60  beq       #0xb39ac
000b3a64  bl        #0xb3a64  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000b3a68  b         #0xb39ac
000b3a6c  bl        #0xb3a6c  rel→current_thread_info; CALL current_thread_info
000b3a70  ldr       r0, [r0, #0xc]
000b3a74  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3a78  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3a7c  movw      r3, #0xd18
000b3a80  ldr       r1, [r0, #0x400]
000b3a84  movw      r0, #0  rel→.L.str.426
000b3a88  movt      r0, #0  rel→.L.str.426
000b3a8c  bl        #0xb3a8c  rel→printk; CALL printk
000b3a90  b         #0xb3a1c
000b3a94  bl        #0xb3a94  rel→current_thread_info; CALL current_thread_info
000b3a98  ldr       r0, [r0, #0xc]
000b3a9c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3aa0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3aa4  movw      r3, #0xd1f
000b3aa8  ldr       r1, [r0, #0x400]
000b3aac  movw      r0, #0  rel→.L.str.427
000b3ab0  movt      r0, #0  rel→.L.str.427
000b3ab4  bl        #0xb3ab4  rel→printk; CALL printk
000b3ab8  b         #0xb3a48
000b3abc  movw      r0, #0  rel→_u32AudioDbgLevel
000b3ac0  movt      r0, #0  rel→_u32AudioDbgLevel
000b3ac4  ldr       r0, [r0]
000b3ac8  cmp       r0, #0x20
000b3acc  blo       #0xb3950
000b3ad0  bl        #0xb3ad0  rel→current_thread_info; CALL current_thread_info
000b3ad4  ldr       r0, [r0, #0xc]
000b3ad8  ldr       r3, [r0, #0x400]
000b3adc  ldr       r0, [r6]
000b3ae0  ldr       r1, [sp, #8]
000b3ae4  subs      r0, r0, r1
000b3ae8  bne       #0xb3bb4
000b3aec  movw      r0, #0  rel→.L.str.424
000b3af0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3af4  movt      r0, #0  rel→.L.str.424
000b3af8  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3afc  movw      r2, #0xd04
000b3b00  b         #0xb3ba8
000b3b04  ldr       r0, [r8]
000b3b08  cmp       r0, #0x20
000b3b0c  bhs       #0xb3bb8
000b3b10  ldr       r0, [r7]
000b3b14  cmn       r0, #1
000b3b18  beq       #0xb3b20
000b3b1c  bl        #0xb3b1c  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000b3b20  ldr       r0, [r4, #0x9f4]
000b3b24  ldr       r0, [r0, #8]
000b3b28  cmp       r0, #1
000b3b2c  blt       #0xb3950
000b3b30  bl        #0xb3b30  rel→MI_OS_ReleaseSemaphore; CALL MI_OS_ReleaseSemaphore
000b3b34  cmp       r0, #0
000b3b38  beq       #0xb3950
000b3b3c  movw      r0, #0  rel→_u32AudioDbgLevel
000b3b40  movt      r0, #0  rel→_u32AudioDbgLevel
000b3b44  ldr       r0, [r0]
000b3b48  cmp       r0, #0x20
000b3b4c  blo       #0xb3950
000b3b50  bl        #0xb3b50  rel→current_thread_info; CALL current_thread_info
000b3b54  ldr       r0, [r0, #0xc]
000b3b58  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3b5c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3b60  movw      r2, #0xd31
000b3b64  ldr       r3, [r0, #0x400]
000b3b68  movw      r0, #0  rel→.L.str.428
000b3b6c  movt      r0, #0  rel→.L.str.428
000b3b70  bl        #0xb3b70  rel→printk; CALL printk
000b3b74  b         #0xb3950
000b3b78  bl        #0xb3b78  rel→current_thread_info; CALL current_thread_info
000b3b7c  ldr       r0, [r0, #0xc]
000b3b80  ldr       r3, [r0, #0x400]
000b3b84  ldr       r0, [r6]
000b3b88  ldr       r1, [sp, #8]
000b3b8c  subs      r0, r0, r1
000b3b90  bne       #0xb3bb4
000b3b94  movw      r0, #0  rel→.L.str.423
000b3b98  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3b9c  movt      r0, #0  rel→.L.str.423
000b3ba0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3ba4  movw      r2, #0xcfe
000b3ba8  add       sp, sp, #0xc
000b3bac  pop       {r4, r5, r6, r7, r8, sb, sl, fp, lr}
000b3bb0  b         #0xb3bb0  rel→printk
000b3bb4  bl        #0xb3bb4  rel→__stack_chk_fail; CALL __stack_chk_fail
000b3bb8  bl        #0xb3bb8  rel→current_thread_info; CALL current_thread_info
000b3bbc  ldr       r0, [r0, #0xc]
000b3bc0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3bc4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_EsBufMonTask
000b3bc8  movw      r2, #0xd0f
000b3bcc  ldr       r3, [r0, #0x400]
000b3bd0  ldr       r0, [r4, #0xadc]
000b3bd4  str       r0, [sp]
000b3bd8  movw      r0, #0  rel→.L.str.425
000b3bdc  movt      r0, #0  rel→.L.str.425
000b3be0  bl        #0xb3be0  rel→printk; CALL printk
000b3be4  b         #0xb3b10
