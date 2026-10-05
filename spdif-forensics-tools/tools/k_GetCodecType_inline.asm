000b3be8  push      {r4, r5, r6, r7, r8, sb, fp, lr}
000b3bec  sub       sp, sp, #0x10
000b3bf0  movw      r8, #0  rel→__stack_chk_guard
000b3bf4  movw      r7, #0  rel→_u32AudioDbgLevel
000b3bf8  movt      r8, #0  rel→__stack_chk_guard
000b3bfc  mov       r4, r0
000b3c00  ldr       r0, [r8]
000b3c04  cmp       r4, #0
000b3c08  movt      r7, #0  rel→_u32AudioDbgLevel
000b3c0c  str       r0, [sp, #0xc]
000b3c10  beq       #0xb3c80
000b3c14  mov       r5, r1
000b3c18  cmp       r1, #0
000b3c1c  beq       #0xb3d24
000b3c20  ldr       r0, [r7]
000b3c24  ldr       r6, [r4, #0x958]
000b3c28  cmp       r0, #0x50
000b3c2c  bhs       #0xb3e6c
000b3c30  ldr       r0, [r4, #0x948]
000b3c34  cmp       r0, #4
000b3c38  bne       #0xb3cd0
000b3c3c  mov       r0, #0
000b3c40  add       r2, sp, #8
000b3c44  str       r0, [sp, #8]
000b3c48  mov       r1, #7
000b3c4c  ldr       r0, [r4, #0xadc]
000b3c50  bl        #0xb3c50  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000b3c54  cmp       r0, #1
000b3c58  bne       #0xb3da8
000b3c5c  ldr       sb, [sp, #8]
000b3c60  cmp       sb, #1
000b3c64  bhi       #0xb3cd0
000b3c68  ldr       r0, [r7]
000b3c6c  cmp       r0, #0x40
000b3c70  bhs       #0xb3f30
000b3c74  mov       r0, #0xd
000b3c78  str       r0, [r5]
000b3c7c  b         #0xb3e4c
000b3c80  ldr       r0, [r7]
000b3c84  mov       r5, #8
000b3c88  cmp       r0, #0x20
000b3c8c  blo       #0xb3e50
000b3c90  movw      r0, #0  rel→.L.str.7
000b3c94  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3c98  movt      r0, #0  rel→.L.str.7
000b3c9c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3ca0  movw      r2, #0x861
000b3ca4  bl        #0xb3ca4  rel→printk; CALL printk
000b3ca8  ldr       r0, [r7]
000b3cac  cmp       r0, #0x20
000b3cb0  blo       #0xb3e50
000b3cb4  movw      r0, #0  rel→.L.str.8
000b3cb8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3cbc  movt      r0, #0  rel→.L.str.8
000b3cc0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3cc4  movw      r2, #0x861
000b3cc8  bl        #0xb3cc8  rel→printk; CALL printk
000b3ccc  b         #0xb3e50
000b3cd0  sub       r0, r6, #9
000b3cd4  cmp       r0, #3
000b3cd8  blo       #0xb3d74
000b3cdc  cmp       r6, #0x17
000b3ce0  beq       #0xb3d74
000b3ce4  cmp       r6, #0
000b3ce8  bne       #0xb3dfc
000b3cec  ldr       r0, [r7]
000b3cf0  mov       r5, #3
000b3cf4  cmp       r0, #0x20
000b3cf8  blo       #0xb3e50
000b3cfc  bl        #0xb3cfc  rel→current_thread_info; CALL current_thread_info
000b3d00  ldr       r0, [r0, #0xc]
000b3d04  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d08  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d0c  movw      r2, #0x87c
000b3d10  ldr       r3, [r0, #0x400]
000b3d14  movw      r0, #0  rel→.L.str.539
000b3d18  movt      r0, #0  rel→.L.str.539
000b3d1c  bl        #0xb3d1c  rel→printk; CALL printk
000b3d20  b         #0xb3e50
000b3d24  ldr       r0, [r7]
000b3d28  mov       r5, #8
000b3d2c  cmp       r0, #0x20
000b3d30  blo       #0xb3e50
000b3d34  movw      r0, #0  rel→.L.str.7
000b3d38  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d3c  movt      r0, #0  rel→.L.str.7
000b3d40  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d44  movw      r2, #0x862
000b3d48  bl        #0xb3d48  rel→printk; CALL printk
000b3d4c  ldr       r0, [r7]
000b3d50  cmp       r0, #0x20
000b3d54  blo       #0xb3e50
000b3d58  movw      r0, #0  rel→.L.str.535
000b3d5c  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d60  movt      r0, #0  rel→.L.str.535
000b3d64  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3d68  movw      r2, #0x862
000b3d6c  bl        #0xb3d6c  rel→printk; CALL printk
000b3d70  b         #0xb3e50
000b3d74  ldr       r0, [r4, #0xadc]
000b3d78  add       r2, sp, #8
000b3d7c  mov       r1, #0x30
000b3d80  bl        #0xb3d80  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000b3d84  cmp       r0, #0
000b3d88  beq       #0xb3de8
000b3d8c  ldr       r0, [sp, #8]
000b3d90  cmp       r0, #3
000b3d94  bhi       #0xb3e38
000b3d98  movw      r1, #0  rel→.Lswitch.table._MI_AUDIO_GetCodecType
000b3d9c  movt      r1, #0  rel→.Lswitch.table._MI_AUDIO_GetCodecType
000b3da0  ldr       r6, [r1, r0, lsl #2]
000b3da4  b         #0xb3e38
000b3da8  ldr       r0, [r7]
000b3dac  mov       r5, #3
000b3db0  cmp       r0, #0x20
000b3db4  blo       #0xb3e50
000b3db8  bl        #0xb3db8  rel→current_thread_info; CALL current_thread_info
000b3dbc  ldr       r0, [r0, #0xc]
000b3dc0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3dc4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3dc8  movw      r2, #0x86d
000b3dcc  ldr       r3, [r0, #0x400]
000b3dd0  ldr       r0, [r4, #0xadc]
000b3dd4  str       r0, [sp]
000b3dd8  movw      r0, #0  rel→.L.str.537
000b3ddc  movt      r0, #0  rel→.L.str.537
000b3de0  bl        #0xb3de0  rel→printk; CALL printk
000b3de4  b         #0xb3e50
000b3de8  ldr       r0, [r7]
000b3dec  cmp       r0, #0x20
000b3df0  bhs       #0xb3f00
000b3df4  mov       r5, #3
000b3df8  b         #0xb3e50
000b3dfc  orr       r0, r6, #1
000b3e00  cmp       r0, #5
000b3e04  bne       #0xb3e38
000b3e08  ldr       r0, [r4, #0xadc]
000b3e0c  add       r2, sp, #8
000b3e10  mov       r1, #0x30
000b3e14  bl        #0xb3e14  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000b3e18  cmp       r0, #0
000b3e1c  beq       #0xb3ec4
000b3e20  ldr       r0, [sp, #8]
000b3e24  cmp       r0, #2
000b3e28  bhi       #0xb3e38
000b3e2c  movw      r1, #0  rel→.Lswitch.table._MI_AUDIO_GetCodecType.735
000b3e30  movt      r1, #0  rel→.Lswitch.table._MI_AUDIO_GetCodecType.735
000b3e34  b         #0xb3da0
000b3e38  ldr       r0, [r7]
000b3e3c  cmp       r0, #0x50
000b3e40  bhs       #0xb3e98
000b3e44  str       r6, [r5]
000b3e48  str       r6, [r4, #0x958]
000b3e4c  mov       r5, #0
000b3e50  ldr       r0, [r8]
000b3e54  ldr       r1, [sp, #0xc]
000b3e58  subs      r0, r0, r1
000b3e5c  moveq     r0, r5
000b3e60  addeq     sp, sp, #0x10
000b3e64  popeq     {r4, r5, r6, r7, r8, sb, fp, pc}
000b3e68  bl        #0xb3e68  rel→__stack_chk_fail; CALL __stack_chk_fail
000b3e6c  bl        #0xb3e6c  rel→current_thread_info; CALL current_thread_info
000b3e70  ldr       r0, [r0, #0xc]
000b3e74  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3e78  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3e7c  movw      r3, #0x865
000b3e80  ldr       r1, [r0, #0x400]
000b3e84  movw      r0, #0  rel→.L.str.536
000b3e88  movt      r0, #0  rel→.L.str.536
000b3e8c  str       r6, [sp]
000b3e90  bl        #0xb3e90  rel→printk; CALL printk
000b3e94  b         #0xb3c30
000b3e98  bl        #0xb3e98  rel→current_thread_info; CALL current_thread_info
000b3e9c  ldr       r0, [r0, #0xc]
000b3ea0  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3ea4  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3ea8  movw      r3, #0x8b9
000b3eac  ldr       r1, [r0, #0x400]
000b3eb0  movw      r0, #0  rel→.L.str.542
000b3eb4  movt      r0, #0  rel→.L.str.542
000b3eb8  str       r6, [sp]
000b3ebc  bl        #0xb3ebc  rel→printk; CALL printk
000b3ec0  b         #0xb3e44
000b3ec4  ldr       r0, [r7]
000b3ec8  cmp       r0, #0x20
000b3ecc  blo       #0xb3df4
000b3ed0  bl        #0xb3ed0  rel→current_thread_info; CALL current_thread_info
000b3ed4  ldr       r0, [r0, #0xc]
000b3ed8  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3edc  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3ee0  movw      r2, #0x8a7
000b3ee4  ldr       r3, [r0, #0x400]
000b3ee8  ldr       r0, [r4, #0xadc]
000b3eec  str       r0, [sp]
000b3ef0  movw      r0, #0  rel→.L.str.541
000b3ef4  movt      r0, #0  rel→.L.str.541
000b3ef8  bl        #0xb3ef8  rel→printk; CALL printk
000b3efc  b         #0xb3df4
000b3f00  bl        #0xb3f00  rel→current_thread_info; CALL current_thread_info
000b3f04  ldr       r0, [r0, #0xc]
000b3f08  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3f0c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3f10  movw      r2, #0x889
000b3f14  ldr       r3, [r0, #0x400]
000b3f18  ldr       r0, [r4, #0xadc]
000b3f1c  str       r0, [sp]
000b3f20  movw      r0, #0  rel→.L.str.540
000b3f24  movt      r0, #0  rel→.L.str.540
000b3f28  bl        #0xb3f28  rel→printk; CALL printk
000b3f2c  b         #0xb3df4
000b3f30  bl        #0xb3f30  rel→current_thread_info; CALL current_thread_info
000b3f34  ldr       r0, [r0, #0xc]
000b3f38  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3f3c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_GetCodecType
000b3f40  movw      r3, #0x873
000b3f44  ldr       r1, [r0, #0x400]
000b3f48  movw      r0, #0  rel→.L.str.538
000b3f4c  movt      r0, #0  rel→.L.str.538
000b3f50  str       sb, [sp]
000b3f54  bl        #0xb3f54  rel→printk; CALL printk
000b3f58  b         #0xb3c74
000b3f5c  push      {r4, r5, r6, r7, r8, sb, sl, lr}
000b3f60  sub       sp, sp, #8
000b3f64  mov       r4, r1
000b3f68  mov       r5, r0
000b3f6c  cmp       r1, #0
000b3f70  mov       r6, r1
000b3f74  beq       #0xb3f84
000b3f78  cmp       r4, #1
000b3f7c  bne       #0xb4050
000b3f80  mov       r6, #1
000b3f84  and       r0, r5, #0xfe
000b3f88  cmp       r0, #2
000b3f8c  bne       #0xb40c0
000b3f90  movw      sl, #0  rel→_u32AudioDbgLevel
000b3f94  movw      r8, #0  rel→.L.str.692
000b3f98  movw      sb, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b3f9c  mov       r7, #0
000b3fa0  movt      sl, #0  rel→_u32AudioDbgLevel
000b3fa4  movt      r8, #0  rel→.L.str.692
000b3fa8  movt      sb, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b3fac  b         #0xb3fd0
000b3fb0  ldr       r3, [r0, #0x400]
000b3fb4  mov       r0, r8
000b3fb8  str       r7, [sp]
000b3fbc  str       r4, [sp, #4]
000b3fc0  bl        #0xb3fc0  rel→printk; CALL printk
000b3fc4  add       r7, r7, #1
000b3fc8  cmp       r7, #5
000b3fcc  beq       #0xb4104
000b3fd0  cmp       r5, #3
000b3fd4  beq       #0xb4018
000b3fd8  cmp       r5, #2
000b3fdc  bne       #0xb3fc4
000b3fe0  mov       r0, r7
000b3fe4  mov       r1, #0x20
000b3fe8  mov       r2, r6
000b3fec  bl        #0xb3fec  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b3ff0  cmp       r0, #1
000b3ff4  beq       #0xb3fc4
000b3ff8  ldr       r0, [sl]
000b3ffc  cmp       r0, #0x20
000b4000  blo       #0xb3fc4
000b4004  bl        #0xb4004  rel→current_thread_info; CALL current_thread_info
000b4008  ldr       r0, [r0, #0xc]
000b400c  mov       r1, sb
000b4010  movw      r2, #0x16bd
000b4014  b         #0xb3fb0
000b4018  mov       r0, r7
000b401c  mov       r1, #0x81
000b4020  mov       r2, r6
000b4024  bl        #0xb4024  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b4028  cmp       r0, #1
000b402c  beq       #0xb3fc4
000b4030  ldr       r0, [sl]
000b4034  cmp       r0, #0x20
000b4038  blo       #0xb3fc4
000b403c  bl        #0xb403c  rel→current_thread_info; CALL current_thread_info
000b4040  ldr       r0, [r0, #0xc]
000b4044  mov       r1, sb
000b4048  movw      r2, #0x16c5
000b404c  b         #0xb3fb0
000b4050  movw      r6, #0  rel→_u32AudioDbgLevel
000b4054  movt      r6, #0  rel→_u32AudioDbgLevel
000b4058  ldr       r0, [r6]
000b405c  cmp       r0, #0x20
000b4060  blo       #0xb415c
000b4064  bl        #0xb4064  rel→current_thread_info; CALL current_thread_info
000b4068  mov       r5, r0
000b406c  ldr       r0, [r0, #0xc]
000b4070  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_MiDrcMapUtopiaDrc
000b4074  movw      r2, #0x528
000b4078  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_MiDrcMapUtopiaDrc
000b407c  ldr       r3, [r0, #0x400]
000b4080  movw      r0, #0  rel→.L.str.510
000b4084  movt      r0, #0  rel→.L.str.510
000b4088  str       r4, [sp]
000b408c  bl        #0xb408c  rel→printk; CALL printk
000b4090  ldr       r0, [r6]
000b4094  cmp       r0, #0x20
000b4098  blo       #0xb415c
000b409c  ldr       r0, [r5, #0xc]
000b40a0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b40a4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b40a8  movw      r2, #0x16ad
000b40ac  ldr       r3, [r0, #0x400]
000b40b0  movw      r0, #0  rel→.L.str.690
000b40b4  movt      r0, #0  rel→.L.str.690
000b40b8  str       r4, [sp]
000b40bc  b         #0xb40f8
000b40c0  movw      r0, #0  rel→_u32AudioDbgLevel
000b40c4  movt      r0, #0  rel→_u32AudioDbgLevel
000b40c8  ldr       r0, [r0]
000b40cc  cmp       r0, #0x20
000b40d0  blo       #0xb415c
000b40d4  bl        #0xb40d4  rel→current_thread_info; CALL current_thread_info
000b40d8  ldr       r0, [r0, #0xc]
000b40dc  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b40e0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcMode
000b40e4  movw      r2, #0x16b3
000b40e8  ldr       r3, [r0, #0x400]
000b40ec  movw      r0, #0  rel→.L.str.691
000b40f0  str       r5, [sp]
000b40f4  movt      r0, #0  rel→.L.str.691
000b40f8  bl        #0xb40f8  rel→printk; CALL printk
000b40fc  add       sp, sp, #8
000b4100  pop       {r4, r5, r6, r7, r8, sb, sl, pc}
000b4104  movw      r1, #0  rel→_stAc3pCodecData
000b4108  add       r0, r5, r5, lsl #1
000b410c  movt      r1, #0  rel→_stAc3pCodecData
000b4110  str       r4, [r1, r0, lsl #3]
000b4114  movw      r0, #0  rel→_pastAudSlot
000b4118  movt      r0, #0  rel→_pastAudSlot
000b411c  ldr       r1, [r0]
000b4120  cmp       r1, #0
000b4124  beq       #0xb4138
000b4128  ldr       r2, [r1, #0xa2c]
000b412c  bic       r2, r2, #1
000b4130  cmp       r2, #4
000b4134  streq     r4, [r1, #0xa3c]
000b4138  ldr       r0, [r0, #4]
000b413c  cmp       r0, #0
000b4140  beq       #0xb415c
000b4144  ldr       r1, [r0, #0xa2c]
000b4148  bic       r1, r1, #1
000b414c  cmp       r1, #4
000b4150  streq     r4, [r0, #0xa3c]
000b4154  add       sp, sp, #8
000b4158  pop       {r4, r5, r6, r7, r8, sb, sl, pc}
000b415c  add       sp, sp, #8
000b4160  pop       {r4, r5, r6, r7, r8, sb, sl, pc}
000b4164  push      {r4, r5, r6, lr}
000b4168  sub       sp, sp, #8
000b416c  mov       r6, r0
000b4170  and       r0, r0, #0xfe
000b4174  cmp       r0, #2
000b4178  bne       #0xb41f0
000b417c  mov       r5, r2
000b4180  mov       r4, r1
000b4184  cmp       r6, #3
000b4188  beq       #0xb420c
000b418c  cmp       r6, #2
000b4190  bne       #0xb423c
000b4194  mov       r0, #0
000b4198  mov       r1, #0x23
000b419c  mov       r2, r4
000b41a0  bl        #0xb41a0  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b41a4  cmp       r0, #1
000b41a8  bne       #0xb42a4
000b41ac  mov       r0, #0
000b41b0  mov       r1, #0x22
000b41b4  mov       r2, r5
000b41b8  bl        #0xb41b8  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b41bc  cmp       r0, #1
000b41c0  beq       #0xb423c
000b41c4  movw      r0, #0  rel→_u32AudioDbgLevel
000b41c8  movt      r0, #0  rel→_u32AudioDbgLevel
000b41cc  ldr       r0, [r0]
000b41d0  cmp       r0, #0x20
000b41d4  blo       #0xb4204
000b41d8  bl        #0xb41d8  rel→current_thread_info; CALL current_thread_info
000b41dc  ldr       r0, [r0, #0xc]
000b41e0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b41e4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b41e8  movw      r2, #0x16ed
000b41ec  b         #0xb4334
000b41f0  movw      r0, #0  rel→_u32AudioDbgLevel
000b41f4  movt      r0, #0  rel→_u32AudioDbgLevel
000b41f8  ldr       r0, [r0]
000b41fc  cmp       r0, #0x20
000b4200  bhs       #0xb4348
000b4204  add       sp, sp, #8
000b4208  pop       {r4, r5, r6, pc}
000b420c  mov       r0, #0
000b4210  mov       r1, #0x83
000b4214  mov       r2, r4
000b4218  bl        #0xb4218  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b421c  cmp       r0, #1
000b4220  bne       #0xb42d0
000b4224  mov       r0, #0
000b4228  mov       r1, #0x82
000b422c  mov       r2, r5
000b4230  bl        #0xb4230  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000b4234  cmp       r0, #1
000b4238  bne       #0xb430c
000b423c  add       r0, r6, r6, lsl #1
000b4240  movw      r1, #0  rel→_stAc3pCodecData
000b4244  movt      r1, #0  rel→_stAc3pCodecData
000b4248  add       r0, r1, r0, lsl #3
000b424c  str       r5, [r0, #8]
000b4250  str       r4, [r0, #0xc]
000b4254  movw      r0, #0  rel→_pastAudSlot
000b4258  movt      r0, #0  rel→_pastAudSlot
000b425c  ldr       r1, [r0]
000b4260  cmp       r1, #0
000b4264  beq       #0xb427c
000b4268  ldr       r2, [r1, #0xa2c]
000b426c  bic       r2, r2, #1
000b4270  cmp       r2, #4
000b4274  streq     r5, [r1, #0xa44]
000b4278  streq     r4, [r1, #0xa48]
000b427c  ldr       r0, [r0, #4]
000b4280  cmp       r0, #0
000b4284  beq       #0xb4204
000b4288  ldr       r1, [r0, #0xa2c]
000b428c  bic       r1, r1, #1
000b4290  cmp       r1, #4
000b4294  streq     r5, [r0, #0xa44]
000b4298  streq     r4, [r0, #0xa48]
000b429c  add       sp, sp, #8
000b42a0  pop       {r4, r5, r6, pc}
000b42a4  movw      r0, #0  rel→_u32AudioDbgLevel
000b42a8  movt      r0, #0  rel→_u32AudioDbgLevel
000b42ac  ldr       r0, [r0]
000b42b0  cmp       r0, #0x20
000b42b4  blo       #0xb4204
000b42b8  bl        #0xb42b8  rel→current_thread_info; CALL current_thread_info
000b42bc  ldr       r0, [r0, #0xc]
000b42c0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b42c4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b42c8  movw      r2, #0x16e7
000b42cc  b         #0xb42f8
000b42d0  movw      r0, #0  rel→_u32AudioDbgLevel
000b42d4  movt      r0, #0  rel→_u32AudioDbgLevel
000b42d8  ldr       r0, [r0]
000b42dc  cmp       r0, #0x20
000b42e0  blo       #0xb4204
000b42e4  bl        #0xb42e4  rel→current_thread_info; CALL current_thread_info
000b42e8  ldr       r0, [r0, #0xc]
000b42ec  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b42f0  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b42f4  movw      r2, #0x16f6
000b42f8  ldr       r3, [r0, #0x400]
000b42fc  movw      r0, #0  rel→.L.str.693
000b4300  str       r4, [sp]
000b4304  movt      r0, #0  rel→.L.str.693
000b4308  b         #0xb436c
000b430c  movw      r0, #0  rel→_u32AudioDbgLevel
000b4310  movt      r0, #0  rel→_u32AudioDbgLevel
000b4314  ldr       r0, [r0]
000b4318  cmp       r0, #0x20
000b431c  blo       #0xb4204
000b4320  bl        #0xb4320  rel→current_thread_info; CALL current_thread_info
000b4324  ldr       r0, [r0, #0xc]
000b4328  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b432c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b4330  movw      r2, #0x16fc
000b4334  ldr       r3, [r0, #0x400]
000b4338  movw      r0, #0  rel→.L.str.694
000b433c  str       r5, [sp]
000b4340  movt      r0, #0  rel→.L.str.694
000b4344  b         #0xb436c
000b4348  bl        #0xb4348  rel→current_thread_info; CALL current_thread_info
000b434c  ldr       r0, [r0, #0xc]
000b4350  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b4354  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetDolbyDrcScale
000b4358  movw      r2, #0x16df
000b435c  ldr       r3, [r0, #0x400]
000b4360  movw      r0, #0  rel→.L.str.691
000b4364  movt      r0, #0  rel→.L.str.691
000b4368  str       r6, [sp]
000b436c  bl        #0xb436c  rel→printk; CALL printk
000b4370  add       sp, sp, #8
000b4374  pop       {r4, r5, r6, pc}
