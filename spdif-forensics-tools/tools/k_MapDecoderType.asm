000a33e0  push      {r4, r5, fp, lr}
000a33e4  sub       r0, r0, #1
000a33e8  mov       r4, r1
000a33ec  cmp       r0, #0x16
000a33f0  bhi       #0xa3694
000a33f4  add       r1, pc, #0
000a33f8  ldr       pc, [r1, r0, lsl #2]
000a33fc  andeq     r3, sl, r8, ror r4  rel→
000a3400  strheq    r3, [sl], -r4  rel→
000a3404  strdeq    r3, r4, [sl], -r0  rel→
000a3408  andeq     r3, sl, ip, lsr #10  rel→
000a340c  andeq     r3, sl, r8, ror #10  rel→
000a3410  ldrdeq    r3, r4, [sl], -r0  rel→
000a3414  andeq     r3, sl, ip, lsl #14  rel→
000a3418  andeq     r3, sl, r4, lsr #11  rel→
000a341c  andeq     r3, sl, r8, asr #14  rel→
000a3420  andeq     r3, sl, r0, ror #11  rel→
000a3424  andeq     r3, sl, r4, lsl #15  rel→
000a3428  andeq     r3, sl, r8, asr r4  rel→
000a342c  andeq     r3, sl, r8, asr r4  rel→
000a3430  andeq     r3, sl, ip, lsl r6  rel→
000a3434  andeq     r3, sl, r0, asr #15  rel→
000a3438  andeq     r3, sl, r8, asr r6  rel→
000a343c  strdeq    r3, r4, [sl], -ip  rel→
000a3440  andeq     r3, sl, r8, lsr r8  rel→
000a3444  andeq     r3, sl, r4, ror r8  rel→
000a3448  strheq    r3, [sl], -r0  rel→
000a344c  andeq     r3, sl, ip, ror #17  rel→
000a3450  andeq     r3, sl, r8, lsr #18  rel→
000a3454  andeq     r3, sl, r4, ror #18  rel→
000a3458  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a345c  mov       r5, #9
000a3460  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3464  ldr       r0, [r0]
000a3468  cmp       r0, #0x40
000a346c  bhs       #0xa39a0
000a3470  str       r5, [r4]
000a3474  pop       {r4, r5, fp, pc}
000a3478  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a347c  mov       r5, #1
000a3480  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3484  ldr       r0, [r0]
000a3488  cmp       r0, #0x40
000a348c  blo       #0xa3470
000a3490  bl        #0xa3490  rel→current_thread_info; CALL current_thread_info
000a3494  ldr       r0, [r0, #0xc]
000a3498  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a349c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a34a0  movw      r3, #0x5d1
000a34a4  ldr       r1, [r0, #0x400]
000a34a8  movw      r0, #0  rel→.L.str.382; ; "
index:[MuteName, AutoUnmuteBaseTime, au32AutoUnmuteTimer]
"
000a34ac  movt      r0, #0  rel→.L.str.382; ; "
index:[MuteName, AutoUnmuteBaseTime, au32AutoUnmuteTimer]
"
000a34b0  b         #0xa39c0
000a34b4  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a34b8  mov       r5, #0x1a
000a34bc  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a34c0  ldr       r0, [r0]
000a34c4  cmp       r0, #0x40
000a34c8  blo       #0xa3470
000a34cc  bl        #0xa34cc  rel→current_thread_info; CALL current_thread_info
000a34d0  ldr       r0, [r0, #0xc]
000a34d4  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a34d8  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a34dc  movw      r3, #0x598
000a34e0  ldr       r1, [r0, #0x400]
000a34e4  movw      r0, #0  rel→.L.str.368; ; "3<MI3_ERR>%s[%d]: [PID:%d]Invalid Driver Standard %d...
"
000a34e8  movt      r0, #0  rel→.L.str.368; ; "3<MI3_ERR>%s[%d]: [PID:%d]Invalid Driver Standard %d...
"
000a34ec  b         #0xa39c0
000a34f0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a34f4  mov       r5, #5
000a34f8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a34fc  ldr       r0, [r0]
000a3500  cmp       r0, #0x40
000a3504  blo       #0xa3470
000a3508  bl        #0xa3508  rel→current_thread_info; CALL current_thread_info
000a350c  ldr       r0, [r0, #0xc]
000a3510  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3514  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3518  movw      r3, #0x594
000a351c  ldr       r1, [r0, #0x400]
000a3520  movw      r0, #0  rel→.L.str.367; ; "3<MI3_ERR>%s[%d]: [PID:%d]Invalid Aextin Standard %d...
"
000a3524  movt      r0, #0  rel→.L.str.367; ; "3<MI3_ERR>%s[%d]: [PID:%d]Invalid Aextin Standard %d...
"
000a3528  b         #0xa39c0
000a352c  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3530  mov       r5, #2
000a3534  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3538  ldr       r0, [r0]
000a353c  cmp       r0, #0x40
000a3540  blo       #0xa3470
000a3544  bl        #0xa3544  rel→current_thread_info; CALL current_thread_info
000a3548  ldr       r0, [r0, #0xc]
000a354c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3550  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3554  mov       r3, #0x580
000a3558  ldr       r1, [r0, #0x400]
000a355c  movw      r0, #0  rel→.L.str.362; ; "5<MI3_INFO>[PID:%d]Default Drv SoundMode %d...
"
000a3560  movt      r0, #0  rel→.L.str.362; ; "5<MI3_INFO>[PID:%d]Default Drv SoundMode %d...
"
000a3564  b         #0xa39c0
000a3568  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a356c  mov       r5, #3
000a3570  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3574  ldr       r0, [r0]
000a3578  cmp       r0, #0x40
000a357c  blo       #0xa3470
000a3580  bl        #0xa3580  rel→current_thread_info; CALL current_thread_info
000a3584  ldr       r0, [r0, #0xc]
000a3588  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a358c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3590  movw      r3, #0x584
000a3594  ldr       r1, [r0, #0x400]
000a3598  movw      r0, #0  rel→.L.str.363; ; "5<MI3_INFO>[PID:%d]ATV Prescale: Fm %d, FmInM %d, Hidev %d, HidevInM "
000a359c  movt      r0, #0  rel→.L.str.363; ; "5<MI3_INFO>[PID:%d]ATV Prescale: Fm %d, FmInM %d, Hidev %d, HidevInM "
000a35a0  b         #0xa39c0
000a35a4  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a35a8  mov       r5, #0x1c
000a35ac  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a35b0  ldr       r0, [r0]
000a35b4  cmp       r0, #0x40
000a35b8  blo       #0xa3470
000a35bc  bl        #0xa35bc  rel→current_thread_info; CALL current_thread_info
000a35c0  ldr       r0, [r0, #0xc]
000a35c4  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a35c8  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a35cc  mov       r3, #0x590
000a35d0  ldr       r1, [r0, #0x400]
000a35d4  movw      r0, #0  rel→.L.str.366; ; "6<MI3_DEBUG>[PID:%d]stAtvInfo->s8AtvStandard = %d,Use Standard Value!"
000a35d8  movt      r0, #0  rel→.L.str.366; ; "6<MI3_DEBUG>[PID:%d]stAtvInfo->s8AtvStandard = %d,Use Standard Value!"
000a35dc  b         #0xa39c0
000a35e0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a35e4  mov       r5, #0x11
000a35e8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a35ec  ldr       r0, [r0]
000a35f0  cmp       r0, #0x40
000a35f4  blo       #0xa3470
000a35f8  bl        #0xa35f8  rel→current_thread_info; CALL current_thread_info
000a35fc  ldr       r0, [r0, #0xc]
000a3600  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3604  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3608  movw      r3, #0x5a5
000a360c  ldr       r1, [r0, #0x400]
000a3610  movw      r0, #0  rel→.L.str.371; ; "3<MI3_ERR>%s[%d]: [PID:%d]Mute name length is 0.
"
000a3614  movt      r0, #0  rel→.L.str.371; ; "3<MI3_ERR>%s[%d]: [PID:%d]Mute name length is 0.
"
000a3618  b         #0xa39c0
000a361c  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3620  mov       r5, #8
000a3624  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3628  ldr       r0, [r0]
000a362c  cmp       r0, #0x40
000a3630  blo       #0xa3470
000a3634  bl        #0xa3634  rel→current_thread_info; CALL current_thread_info
000a3638  ldr       r0, [r0, #0xc]
000a363c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3640  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3644  movw      r3, #0x5b5
000a3648  ldr       r1, [r0, #0x400]
000a364c  movw      r0, #0  rel→.L.str.375; ; "TRUE"
000a3650  movt      r0, #0  rel→.L.str.375; ; "TRUE"
000a3654  b         #0xa39c0
000a3658  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a365c  mov       r5, #0xe
000a3660  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3664  ldr       r0, [r0]
000a3668  cmp       r0, #0x40
000a366c  blo       #0xa3470
000a3670  bl        #0xa3670  rel→current_thread_info; CALL current_thread_info
000a3674  ldr       r0, [r0, #0xc]
000a3678  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a367c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3680  movw      r3, #0x5b1
000a3684  ldr       r1, [r0, #0x400]
000a3688  movw      r0, #0  rel→.L.str.374; ; "0pszMuteName:%s, bMute:%s, u32AutoUnmuteTimer:%u
"
000a368c  movt      r0, #0  rel→.L.str.374; ; "0pszMuteName:%s, bMute:%s, u32AutoUnmuteTimer:%u
"
000a3690  b         #0xa39c0
000a3694  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3698  mov       r5, #0x1f
000a369c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a36a0  ldr       r0, [r0]
000a36a4  cmp       r0, #0x40
000a36a8  blo       #0xa3470
000a36ac  bl        #0xa36ac  rel→current_thread_info; CALL current_thread_info
000a36b0  ldr       r0, [r0, #0xc]
000a36b4  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a36b8  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a36bc  movw      r3, #0x5db
000a36c0  ldr       r1, [r0, #0x400]
000a36c4  movw      r0, #0  rel→.L.str.384; ; "c%d:["%s", "
000a36c8  movt      r0, #0  rel→.L.str.384; ; "c%d:["%s", "
000a36cc  b         #0xa39c0
000a36d0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a36d4  mov       r5, #0x19
000a36d8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a36dc  ldr       r0, [r0]
000a36e0  cmp       r0, #0x40
000a36e4  blo       #0xa3470
000a36e8  bl        #0xa36e8  rel→current_thread_info; CALL current_thread_info
000a36ec  ldr       r0, [r0, #0xc]
000a36f0  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a36f4  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a36f8  movw      r3, #0x588
000a36fc  ldr       r1, [r0, #0x400]
000a3700  movw      r0, #0  rel→.L.str.364; ; "6<MI3_DEBUG>[PID:%d]Index=%d,%d
"
000a3704  movt      r0, #0  rel→.L.str.364; ; "6<MI3_DEBUG>[PID:%d]Index=%d,%d
"
000a3708  b         #0xa39c0
000a370c  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3710  mov       r5, #4
000a3714  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3718  ldr       r0, [r0]
000a371c  cmp       r0, #0x40
000a3720  blo       #0xa3470
000a3724  bl        #0xa3724  rel→current_thread_info; CALL current_thread_info
000a3728  ldr       r0, [r0, #0xc]
000a372c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3730  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3734  movw      r3, #0x58c
000a3738  ldr       r1, [r0, #0x400]
000a373c  movw      r0, #0  rel→.L.str.365; ; "6<MI3_DEBUG>[PID:%d]Index=%d,0x%02X%02X
"
000a3740  movt      r0, #0  rel→.L.str.365; ; "6<MI3_DEBUG>[PID:%d]Index=%d,0x%02X%02X
"
000a3744  b         #0xa39c0
000a3748  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a374c  mov       r5, #0xb
000a3750  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3754  ldr       r0, [r0]
000a3758  cmp       r0, #0x40
000a375c  blo       #0xa3470
000a3760  bl        #0xa3760  rel→current_thread_info; CALL current_thread_info
000a3764  ldr       r0, [r0, #0xc]
000a3768  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a376c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3770  movw      r3, #0x5a1
000a3774  ldr       r1, [r0, #0x400]
000a3778  movw      r0, #0  rel→.L.str.370; ; "3<MI3_ERR>%s[%d]: pstMuteParams is NULL.
"
000a377c  movt      r0, #0  rel→.L.str.370; ; "3<MI3_ERR>%s[%d]: pstMuteParams is NULL.
"
000a3780  b         #0xa39c0
000a3784  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3788  mov       r5, #0x16
000a378c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3790  ldr       r0, [r0]
000a3794  cmp       r0, #0x40
000a3798  blo       #0xa3470
000a379c  bl        #0xa379c  rel→current_thread_info; CALL current_thread_info
000a37a0  ldr       r0, [r0, #0xc]
000a37a4  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a37a8  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a37ac  movw      r3, #0x5a9
000a37b0  ldr       r1, [r0, #0x400]
000a37b4  movw      r0, #0  rel→.L.str.372; ; "MI_AEXTIN_%s"
000a37b8  movt      r0, #0  rel→.L.str.372; ; "MI_AEXTIN_%s"
000a37bc  b         #0xa39c0
000a37c0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a37c4  mov       r5, #6
000a37c8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a37cc  ldr       r0, [r0]
000a37d0  cmp       r0, #0x40
000a37d4  blo       #0xa3470
000a37d8  bl        #0xa37d8  rel→current_thread_info; CALL current_thread_info
000a37dc  ldr       r0, [r0, #0xc]
000a37e0  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a37e4  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a37e8  movw      r3, #0x5ad
000a37ec  ldr       r1, [r0, #0x400]
000a37f0  movw      r0, #0  rel→.L.str.373; ; "3<MI3_ERR>%s[%d]: [PID:%d]Fail to snprintf szMuteName.
"
000a37f4  movt      r0, #0  rel→.L.str.373; ; "3<MI3_ERR>%s[%d]: [PID:%d]Fail to snprintf szMuteName.
"
000a37f8  b         #0xa39c0
000a37fc  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3800  mov       r5, #0xf
000a3804  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3808  ldr       r0, [r0]
000a380c  cmp       r0, #0x40
000a3810  blo       #0xa3470
000a3814  bl        #0xa3814  rel→current_thread_info; CALL current_thread_info
000a3818  ldr       r0, [r0, #0xc]
000a381c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3820  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3824  movw      r3, #0x5bd
000a3828  ldr       r1, [r0, #0x400]
000a382c  movw      r0, #0  rel→.L.str.377; ; "6<MI3_DEBUG>[PID:%d]pszMuteName:%s, bMute:%s, u32AutoUnmuteTimer:%u
"
000a3830  movt      r0, #0  rel→.L.str.377; ; "6<MI3_DEBUG>[PID:%d]pszMuteName:%s, bMute:%s, u32AutoUnmuteTimer:%u
"
000a3834  b         #0xa39c0
000a3838  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a383c  mov       r5, #0x10
000a3840  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3844  ldr       r0, [r0]
000a3848  cmp       r0, #0x40
000a384c  blo       #0xa3470
000a3850  bl        #0xa3850  rel→current_thread_info; CALL current_thread_info
000a3854  ldr       r0, [r0, #0xc]
000a3858  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a385c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3860  movw      r3, #0x5b9
000a3864  ldr       r1, [r0, #0x400]
000a3868  movw      r0, #0  rel→.L.str.376; ; "FALSE"
000a386c  movt      r0, #0  rel→.L.str.376; ; "FALSE"
000a3870  b         #0xa39c0
000a3874  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3878  mov       r5, #0x12
000a387c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3880  ldr       r0, [r0]
000a3884  cmp       r0, #0x40
000a3888  blo       #0xa3470
000a388c  bl        #0xa388c  rel→current_thread_info; CALL current_thread_info
000a3890  ldr       r0, [r0, #0xc]
000a3894  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3898  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a389c  movw      r3, #0x5c5
000a38a0  ldr       r1, [r0, #0x400]
000a38a4  movw      r0, #0  rel→.L.str.379; ; "u32DeviceIndex:%d
"
000a38a8  movt      r0, #0  rel→.L.str.379; ; "u32DeviceIndex:%d
"
000a38ac  b         #0xa39c0
000a38b0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a38b4  mov       r5, #0x13
000a38b8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a38bc  ldr       r0, [r0]
000a38c0  cmp       r0, #0x40
000a38c4  blo       #0xa3470
000a38c8  bl        #0xa38c8  rel→current_thread_info; CALL current_thread_info
000a38cc  ldr       r0, [r0, #0xc]
000a38d0  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a38d4  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a38d8  movw      r3, #0x5c9
000a38dc  ldr       r1, [r0, #0x400]
000a38e0  movw      r0, #0  rel→.L.str.380; ; "u32MagicNum:%d, s32DeviceMutex:%d, bUsed:%d, eAextinType:%d, hImplAext"
000a38e4  movt      r0, #0  rel→.L.str.380; ; "u32MagicNum:%d, s32DeviceMutex:%d, bUsed:%d, eAextinType:%d, hImplAext"
000a38e8  b         #0xa39c0
000a38ec  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a38f0  mov       r5, #0x14
000a38f4  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a38f8  ldr       r0, [r0]
000a38fc  cmp       r0, #0x40
000a3900  blo       #0xa3470
000a3904  bl        #0xa3904  rel→current_thread_info; CALL current_thread_info
000a3908  ldr       r0, [r0, #0xc]
000a390c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3910  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3914  movw      r3, #0x5c1
000a3918  ldr       r1, [r0, #0x400]
000a391c  movw      r0, #0  rel→.L.str.378; ; "3<MI3_ERR>%s[%d]: [PID:%d]Fail to call mi_aout_SetInputChannelMultiMu"
000a3920  movt      r0, #0  rel→.L.str.378; ; "3<MI3_ERR>%s[%d]: [PID:%d]Fail to call mi_aout_SetInputChannelMultiMu"
000a3924  b         #0xa39c0
000a3928  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a392c  mov       r5, #0x1b
000a3930  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3934  ldr       r0, [r0]
000a3938  cmp       r0, #0x40
000a393c  blo       #0xa3470
000a3940  bl        #0xa3940  rel→current_thread_info; CALL current_thread_info
000a3944  ldr       r0, [r0, #0xc]
000a3948  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a394c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3950  movw      r3, #0x5cd
000a3954  ldr       r1, [r0, #0x400]
000a3958  movw      r0, #0  rel→.L.str.381; ; "u32AextinPort:%d, hOutputModule:%x, u8VolumeIndex:%d, u16VolumeReg:%x,"
000a395c  movt      r0, #0  rel→.L.str.381; ; "u32AextinPort:%d, hOutputModule:%x, u8VolumeIndex:%d, u16VolumeReg:%x,"
000a3960  b         #0xa39c0
000a3964  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3968  mov       r5, #0x1d
000a396c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3970  ldr       r0, [r0]
000a3974  cmp       r0, #0x40
000a3978  blo       #0xa3470
000a397c  bl        #0xa397c  rel→current_thread_info; CALL current_thread_info
000a3980  ldr       r0, [r0, #0xc]
000a3984  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a3988  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a398c  movw      r3, #0x5d5
000a3990  ldr       r1, [r0, #0x400]
000a3994  movw      r0, #0  rel→.L.str.383; ; "
"
000a3998  movt      r0, #0  rel→.L.str.383; ; "
"
000a399c  b         #0xa39c0
000a39a0  bl        #0xa39a0  rel→current_thread_info; CALL current_thread_info
000a39a4  ldr       r0, [r0, #0xc]
000a39a8  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a39ac  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_CodecTypeMapDecoderType; ; "_MI_AUDIO_CodecTypeMapDecoderType"
000a39b0  movw      r3, #0x59d
000a39b4  ldr       r1, [r0, #0x400]
000a39b8  movw      r0, #0  rel→.L.str.369; ; "3<MI3_ERR>%s[%d]: pstAextinInsParams is NULL.
"
000a39bc  movt      r0, #0  rel→.L.str.369; ; "3<MI3_ERR>%s[%d]: pstAextinInsParams is NULL.
"
000a39c0  bl        #0xa39c0  rel→printk; CALL printk
000a39c4  str       r5, [r4]
000a39c8  pop       {r4, r5, fp, pc}
000a39cc  push      {r4, r5, r6, r7, r8, lr}
000a39d0  sub       sp, sp, #0x28
000a39d4  movw      r6, #0  rel→__stack_chk_guard
000a39d8  mov       r5, r0
000a39dc  movt      r6, #0  rel→__stack_chk_guard
000a39e0  ldr       r0, [r6]
000a39e4  str       r0, [sp, #0x24]
000a39e8  mov       r0, #0
000a39ec  str       r0, [sp, #0x20]
000a39f0  str       r0, [sp, #0x1c]
000a39f4  str       r0, [sp, #0x18]
000a39f8  mov       r0, r5
000a39fc  bl        #0x9d528
000a3a00  cmp       r0, #0
000a3a04  beq       #0xa3a40
000a3a08  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3a0c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3a10  ldr       r0, [r0]
000a3a14  cmp       r0, #0x20
000a3a18  blo       #0xa3d14
000a3a1c  bl        #0xa3a1c  rel→current_thread_info; CALL current_thread_info
000a3a20  ldr       r0, [r0, #0xc]
000a3a24  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3a28  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3a2c  movw      r2, #0x1acd
000a3a30  ldr       r3, [r0, #0x400]
000a3a34  movw      r0, #0  rel→.L.str; ; "3<MI3_ERR>%s[%d]: MI_DEV_UserCopyIoctl: alloc buf failed!!
"
000a3a38  movt      r0, #0  rel→.L.str; ; "3<MI3_ERR>%s[%d]: MI_DEV_UserCopyIoctl: alloc buf failed!!
"
000a3a3c  b         #0xa3d10
000a3a40  movw      r7, #0  rel→_u32AudioDbgLevel; ; " "
000a3a44  ldr       r4, [r5, #0xadc]
000a3a48  movt      r7, #0  rel→_u32AudioDbgLevel; ; " "
000a3a4c  ldr       r0, [r7]
000a3a50  cmp       r0, #0x40
000a3a54  bhs       #0xa3cac
000a3a58  add       r2, sp, #0x18
000a3a5c  mov       r0, r4
000a3a60  mov       r1, #0x1d
000a3a64  bl        #0xa3a64  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000a3a68  cmp       r0, #1
000a3a6c  bne       #0xa3bdc
000a3a70  add       r2, sp, #0x20
000a3a74  mov       r0, r4
000a3a78  mov       r1, #0x17
000a3a7c  bl        #0xa3a7c  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000a3a80  cmp       r0, #1
000a3a84  bne       #0xa3c10
000a3a88  add       r2, sp, #0x1c
000a3a8c  mov       r0, r4
000a3a90  mov       r1, #0x18
000a3a94  bl        #0xa3a94  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000a3a98  cmp       r0, #1
000a3a9c  bne       #0xa3c44
000a3aa0  ldr       r0, [sp, #0x20]
000a3aa4  ldr       r1, [sp, #0x1c]
000a3aa8  ldr       r3, [sp, #0x18]
000a3aac  add       r2, r1, r0
000a3ab0  str       r2, [r5, #0x9fc]
000a3ab4  add       r2, r5, #0xa00
000a3ab8  sub       r3, r0, r3
000a3abc  str       r0, [r5, #0x9f8]
000a3ac0  stm       r2, {r0, r1, r3}
000a3ac4  add       r2, sp, #0x20
000a3ac8  mov       r0, r4
000a3acc  mov       r1, #0x19
000a3ad0  bl        #0xa3ad0  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000a3ad4  cmp       r0, #1
000a3ad8  bne       #0xa3c78
000a3adc  add       r2, sp, #0x1c
000a3ae0  mov       r0, r4
000a3ae4  mov       r1, #0x1a
000a3ae8  bl        #0xa3ae8  rel→MApi_AUDIO_GetAudioInfo2; CALL MApi_AUDIO_GetAudioInfo2
000a3aec  cmp       r0, #1
000a3af0  bne       #0xa3ce0
000a3af4  ldr       r0, [sp, #0x20]
000a3af8  ldr       r1, [sp, #0x1c]
000a3afc  ldr       r3, [sp, #0x18]
000a3b00  add       r2, r1, r0
000a3b04  str       r2, [r5, #0xa10]
000a3b08  ldr       r2, [r5, #0xa08]
000a3b0c  sub       r3, r0, r3
000a3b10  str       r1, [r5, #0xa18]
000a3b14  mov       r1, #0x10
000a3b18  str       r0, [r5, #0xa0c]
000a3b1c  str       r0, [r5, #0xa14]
000a3b20  mov       r0, r4
000a3b24  str       r3, [r5, #0xa1c]
000a3b28  bl        #0xa3b28  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a3b2c  ldr       r2, [r5, #0x938]
000a3b30  mov       r0, r4
000a3b34  mov       r1, #0xf
000a3b38  bl        #0xa3b38  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a3b3c  mov       r0, r4
000a3b40  mov       r1, #0x14
000a3b44  mov       r2, #1
000a3b48  bl        #0xa3b48  rel→MApi_AUDIO_SetAudioParam2; CALL MApi_AUDIO_SetAudioParam2
000a3b4c  ldr       r0, [r7]
000a3b50  cmp       r0, #0x40
000a3b54  blo       #0xa3d14
000a3b58  bl        #0xa3b58  rel→current_thread_info; CALL current_thread_info
000a3b5c  mov       r8, r0
000a3b60  ldr       r0, [r0, #0xc]
000a3b64  ldr       r2, [r5, #0x9fc]
000a3b68  ldr       r3, [r5, #0xa00]
000a3b6c  ldr       r1, [r0, #0x400]
000a3b70  ldr       r0, [r5, #0x9f8]
000a3b74  ldr       ip, [r5, #0xa04]
000a3b78  ldr       r4, [r5, #0xa08]
000a3b7c  stm       sp, {r0, r2, r3, r4, ip}
000a3b80  movw      r0, #0  rel→.L.str.392; ; "STUDIOSOUND_II_SOUNDEFFECT_TRUSRNDX_EN"
000a3b84  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3b88  movt      r0, #0  rel→.L.str.392; ; "STUDIOSOUND_II_SOUNDEFFECT_TRUSRNDX_EN"
000a3b8c  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3b90  movw      r3, #0x1b03
000a3b94  bl        #0xa3b94  rel→printk; CALL printk
000a3b98  ldr       r0, [r7]
000a3b9c  cmp       r0, #0x40
000a3ba0  blo       #0xa3d14
000a3ba4  ldr       r0, [r8, #0xc]
000a3ba8  ldr       r2, [r5, #0xa10]
000a3bac  ldr       r3, [r5, #0xa14]
000a3bb0  ldr       r1, [r0, #0x400]
000a3bb4  ldr       r0, [r5, #0xa0c]
000a3bb8  ldr       r7, [r5, #0xa18]
000a3bbc  ldr       r5, [r5, #0xa1c]
000a3bc0  stm       sp, {r0, r2, r3, r5, r7}
000a3bc4  movw      r0, #0  rel→.L.str.393; ; "STUDIOSOUND_II_SOUNDEFFECT_TBHDX_EN"
000a3bc8  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3bcc  movt      r0, #0  rel→.L.str.393; ; "STUDIOSOUND_II_SOUNDEFFECT_TBHDX_EN"
000a3bd0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3bd4  movw      r3, #0x1b04
000a3bd8  b         #0xa3d10
000a3bdc  ldr       r0, [r7]
000a3be0  cmp       r0, #0x20
000a3be4  blo       #0xa3d14
000a3be8  bl        #0xa3be8  rel→current_thread_info; CALL current_thread_info
000a3bec  ldr       r0, [r0, #0xc]
000a3bf0  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3bf4  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3bf8  movw      r2, #0x1ad8
000a3bfc  ldr       r3, [r0, #0x400]
000a3c00  movw      r0, #0  rel→.L.str.387; ; "
au16VolumeTable"
000a3c04  str       r4, [sp]
000a3c08  movt      r0, #0  rel→.L.str.387; ; "
au16VolumeTable"
000a3c0c  b         #0xa3d10
000a3c10  ldr       r0, [r7]
000a3c14  cmp       r0, #0x20
000a3c18  blo       #0xa3d14
000a3c1c  bl        #0xa3c1c  rel→current_thread_info; CALL current_thread_info
000a3c20  ldr       r0, [r0, #0xc]
000a3c24  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c28  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c2c  movw      r2, #0x1add
000a3c30  ldr       r3, [r0, #0x400]
000a3c34  movw      r0, #0  rel→.L.str.388; ; "c[%d]:0x%x,"
000a3c38  str       r4, [sp]
000a3c3c  movt      r0, #0  rel→.L.str.388; ; "c[%d]:0x%x,"
000a3c40  b         #0xa3d10
000a3c44  ldr       r0, [r7]
000a3c48  cmp       r0, #0x20
000a3c4c  blo       #0xa3d14
000a3c50  bl        #0xa3c50  rel→current_thread_info; CALL current_thread_info
000a3c54  ldr       r0, [r0, #0xc]
000a3c58  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c5c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c60  movw      r2, #0x1ae2
000a3c64  ldr       r3, [r0, #0x400]
000a3c68  movw      r0, #0  rel→.L.str.389; ; "
====================================================================="
000a3c6c  str       r4, [sp]
000a3c70  movt      r0, #0  rel→.L.str.389; ; "
====================================================================="
000a3c74  b         #0xa3d10
000a3c78  ldr       r0, [r7]
000a3c7c  cmp       r0, #0x20
000a3c80  blo       #0xa3d14
000a3c84  bl        #0xa3c84  rel→current_thread_info; CALL current_thread_info
000a3c88  ldr       r0, [r0, #0xc]
000a3c8c  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c90  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3c94  movw      r2, #0x1aef
000a3c98  ldr       r3, [r0, #0x400]
000a3c9c  movw      r0, #0  rel→.L.str.390; ; "DTS_STUDIOSOUND_II"
000a3ca0  str       r4, [sp]
000a3ca4  movt      r0, #0  rel→.L.str.390; ; "DTS_STUDIOSOUND_II"
000a3ca8  b         #0xa3d10
000a3cac  movw      r0, #0x9f8
000a3cb0  add       r8, r5, r0
000a3cb4  bl        #0xa3cb4  rel→current_thread_info; CALL current_thread_info
000a3cb8  ldr       r0, [r0, #0xc]
000a3cbc  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3cc0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3cc4  movw      r3, #0x1ad4
000a3cc8  ldr       r1, [r0, #0x400]
000a3ccc  movw      r0, #0  rel→.L.str.386; ; "c%d]
"
000a3cd0  movt      r0, #0  rel→.L.str.386; ; "c%d]
"
000a3cd4  str       r8, [sp]
000a3cd8  bl        #0xa3cd8  rel→printk; CALL printk
000a3cdc  b         #0xa3a58
000a3ce0  ldr       r0, [r7]
000a3ce4  cmp       r0, #0x20
000a3ce8  blo       #0xa3d14
000a3cec  bl        #0xa3cec  rel→current_thread_info; CALL current_thread_info
000a3cf0  ldr       r0, [r0, #0xc]
000a3cf4  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3cf8  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_HandshakeBufferInit; ; "_MI_AUDIO_HandshakeBufferInit"
000a3cfc  movw      r2, #0x1af4
000a3d00  ldr       r3, [r0, #0x400]
000a3d04  movw      r0, #0  rel→.L.str.391; ; "STUDIOSOUND_II_SOUNDEFFECT_EN"
000a3d08  str       r4, [sp]
000a3d0c  movt      r0, #0  rel→.L.str.391; ; "STUDIOSOUND_II_SOUNDEFFECT_EN"
000a3d10  bl        #0xa3d10  rel→printk; CALL printk
000a3d14  ldr       r0, [r6]
000a3d18  ldr       r1, [sp, #0x24]
000a3d1c  subs      r0, r0, r1
000a3d20  addeq     sp, sp, #0x28
000a3d24  popeq     {r4, r5, r6, r7, r8, pc}
000a3d28  bl        #0xa3d28  rel→__stack_chk_fail; CALL __stack_chk_fail
000a3d2c  push      {r4, r5, r6, r7, r8, lr}
000a3d30  sub       sp, sp, #0x18
000a3d34  movw      r8, #0  rel→__stack_chk_guard
000a3d38  mov       r6, r0
000a3d3c  movt      r8, #0  rel→__stack_chk_guard
000a3d40  mov       r4, r1
000a3d44  ldr       r0, [r8]
000a3d48  add       r1, sp, #0x10
000a3d4c  str       r0, [sp, #0x14]
000a3d50  mvn       r0, #0
000a3d54  str       r0, [sp, #0x10]
000a3d58  ldr       r0, [r6, #0xad8]
000a3d5c  bl        #0xa3d5c  rel→mi_aout_GetInputChannel; CALL mi_aout_GetInputChannel
000a3d60  ldr       r7, [sp, #0x10]
000a3d64  bl        #0xa3d64  rel→current_thread_info; CALL current_thread_info
000a3d68  mov       r5, r0
000a3d6c  ldr       r0, [r0, #0xc]
000a3d70  sub       r2, r7, #1
000a3d74  cmp       r7, #3
000a3d78  clz       r2, r2
000a3d7c  movw      r3, #0x2101
000a3d80  ldr       r1, [r0, #0x400]
000a3d84  ldr       r0, [r6, #0xad8]
000a3d88  lsr       r6, r2, #5
000a3d8c  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_SetChVolFadingMode; ; "_MI_AUDIO_SetChVolFadingMode"
000a3d90  movweq    r6, #2
000a3d94  stm       sp, {r0, r6}
000a3d98  movw      r0, #0  rel→.L.str.394; ; "STUDIOSOUND_II_SOUNDEFFECT_MBHL_EN"
000a3d9c  movt      r0, #0  rel→.L.str.394; ; "STUDIOSOUND_II_SOUNDEFFECT_MBHL_EN"
000a3da0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_SetChVolFadingMode; ; "_MI_AUDIO_SetChVolFadingMode"
000a3da4  str       r4, [sp, #8]
000a3da8  bl        #0xa3da8  rel→printk; CALL printk
000a3dac  mov       r0, #0x59
000a3db0  mov       r1, r6
000a3db4  mov       r2, r4
000a3db8  bl        #0xa3db8  rel→MApi_SND_SetParam1; CALL MApi_SND_SetParam1
000a3dbc  cmp       r0, #1
000a3dc0  beq       #0xa3dd8
000a3dc4  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3dc8  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3dcc  ldr       r0, [r0]
000a3dd0  cmp       r0, #0x20
000a3dd4  bhs       #0xa3df0
000a3dd8  ldr       r0, [r8]
000a3ddc  ldr       r1, [sp, #0x14]
000a3de0  subs      r0, r0, r1
000a3de4  addeq     sp, sp, #0x18
000a3de8  popeq     {r4, r5, r6, r7, r8, pc}
000a3dec  bl        #0xa3dec  rel→__stack_chk_fail; CALL __stack_chk_fail
000a3df0  ldr       r0, [r5, #0xc]
000a3df4  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetChVolFadingMode; ; "_MI_AUDIO_SetChVolFadingMode"
000a3df8  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_SetChVolFadingMode; ; "_MI_AUDIO_SetChVolFadingMode"
000a3dfc  movw      r2, #0x2104
000a3e00  ldr       r3, [r0, #0x400]
000a3e04  movw      r0, #0  rel→.L.str.395; ; "STUDIOSOUND_II_SOUNDEFFECT_TRUVOLUMEHD_EN"
000a3e08  movt      r0, #0  rel→.L.str.395; ; "STUDIOSOUND_II_SOUNDEFFECT_TRUVOLUMEHD_EN"
000a3e0c  str       r6, [sp]
000a3e10  str       r4, [sp, #4]
000a3e14  bl        #0xa3e14  rel→printk; CALL printk
000a3e18  b         #0xa3dd8
000a3e1c  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
000a3e20  sub       sp, sp, #0x24
000a3e24  movw      r5, #0  rel→__stack_chk_guard
000a3e28  str       r2, [sp, #0x14]
000a3e2c  movt      r5, #0  rel→__stack_chk_guard
000a3e30  mov       r4, r0
000a3e34  ldr       r0, [r5]
000a3e38  mov       r6, r1
000a3e3c  str       r0, [sp, #0x20]
000a3e40  mov       r0, #0
000a3e44  cmp       r4, #0
000a3e48  str       r0, [sp, #0x1c]
000a3e4c  bne       #0xa3e60
000a3e50  mvn       sl, #0
000a3e54  cmp       r6, #0xf
000a3e58  mvn       sb, #0
000a3e5c  bhi       #0xa3ec0
000a3e60  add       r1, sp, #0x1c
000a3e64  str       r0, [sp, #0x1c]
000a3e68  mov       r0, r4
000a3e6c  bl        #0xb2d24
000a3e70  cmp       r0, #0
000a3e74  beq       #0xa3eb4
000a3e78  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3e7c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3e80  ldr       r0, [r0]
000a3e84  cmp       r0, #0x20
000a3e88  blo       #0xa40dc
000a3e8c  bl        #0xa3e8c  rel→current_thread_info; CALL current_thread_info
000a3e90  ldr       r0, [r0, #0xc]
000a3e94  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a3e98  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a3e9c  movw      r2, #0xe0c
000a3ea0  ldr       r3, [r0, #0x400]
000a3ea4  movw      r0, #0  rel→.L.str.396; ; "DTS_STUDIOSOUND_II_SET_VX_PARAMS_BY_CLI"
000a3ea8  movt      r0, #0  rel→.L.str.396; ; "DTS_STUDIOSOUND_II_SET_VX_PARAMS_BY_CLI"
000a3eac  bl        #0xa3eac  rel→printk; CALL printk
000a3eb0  b         #0xa40dc
000a3eb4  ldr       r0, [sp, #0x1c]
000a3eb8  ldr       sl, [r0, #0xab8]
000a3ebc  ldr       sb, [r0, #0xabc]
000a3ec0  movw      r0, #0  rel→_s32AudioSystemMutex
000a3ec4  movt      r0, #0  rel→_s32AudioSystemMutex
000a3ec8  ldr       r0, [r0]
000a3ecc  cmn       r0, #1
000a3ed0  beq       #0xa3ed8
000a3ed4  bl        #0xa3ed4  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000a3ed8  movw      r0, #0  rel→_s32CallbackMutex
000a3edc  movt      r0, #0  rel→_s32CallbackMutex
000a3ee0  ldr       r0, [r0]
000a3ee4  cmn       r0, #1
000a3ee8  beq       #0xa3ef4
000a3eec  mvn       r1, #0xff
000a3ef0  bl        #0xa3ef0  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000a3ef4  movw      r0, #0  rel→_pstAudioCallbackList
000a3ef8  movt      r0, #0  rel→_pstAudioCallbackList
000a3efc  ldr       r8, [r0]
000a3f00  cmp       r8, #0
000a3f04  beq       #0xa40a0
000a3f08  mov       r0, #1
000a3f0c  lsl       r5, r0, r6
000a3f10  b         #0xa3f30
000a3f14  cmp       r0, #0
000a3f18  ldrne     r0, [r8, #0xc]
000a3f1c  tstne     r0, r5
000a3f20  bne       #0xa3fec
000a3f24  ldr       r8, [r8, #0x14]
000a3f28  cmp       r8, #0
000a3f2c  beq       #0xa40a0
000a3f30  ldr       r0, [r8, #8]
000a3f34  cmp       r4, #0
000a3f38  beq       #0xa3f14
000a3f3c  cmp       r0, #0
000a3f40  ldrne     r0, [r8, #0xc]
000a3f44  tstne     r0, r5
000a3f48  beq       #0xa3f24
000a3f4c  ldrd      r0, r1, [r8]
000a3f50  eor       r1, sb, r1
000a3f54  eor       r0, sl, r0
000a3f58  orrs      r0, r0, r1
000a3f5c  bne       #0xa3f24
000a3f60  mvn       r0, #0
000a3f64  add       r1, sp, #0x18
000a3f68  str       r0, [sp, #0x18]
000a3f6c  mov       r0, r4
000a3f70  bl        #0xa3f70  rel→mi_audio_GetDecodePath; CALL mi_audio_GetDecodePath
000a3f74  mov       fp, r0
000a3f78  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3f7c  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3f80  cmp       fp, #0
000a3f84  ldr       r0, [r0]
000a3f88  bne       #0xa4098
000a3f8c  cmp       r0, #0x40
000a3f90  bhs       #0xa4068
000a3f94  ldr       r7, [r8, #8]
000a3f98  mov       r0, r4
000a3f9c  ldr       r3, [r8, #0x10]
000a3fa0  mov       r1, r6
000a3fa4  ldr       r2, [sp, #0x14]
000a3fa8  blx       r7
000a3fac  mov       r7, r0
000a3fb0  movw      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3fb4  movt      r0, #0  rel→_u32AudioDbgLevel; ; " "
000a3fb8  ldr       r0, [r0]
000a3fbc  cmp       r0, #0x40
000a3fc0  blo       #0xa3f24
000a3fc4  bl        #0xa3fc4  rel→current_thread_info; CALL current_thread_info
000a3fc8  ldr       r0, [r0, #0xc]
000a3fcc  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a3fd0  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a3fd4  movw      r3, #0xe29
000a3fd8  ldr       r1, [r0, #0x400]
000a3fdc  movw      r0, #0  rel→.L.str.399; ; "PROCESS_ENABLE:DtsStudioSoundI"
000a3fe0  str       r7, [sp]
000a3fe4  movt      r0, #0  rel→.L.str.399; ; "PROCESS_ENABLE:DtsStudioSoundI"
000a3fe8  b         #0xa4060
000a3fec  bl        #0xa3fec  rel→current_thread_info; CALL current_thread_info
000a3ff0  mov       fp, r0
000a3ff4  ldr       r0, [r0, #0xc]
000a3ff8  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a3ffc  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4000  ldr       r1, [r0, #0x400]
000a4004  ldm       r8, {r0, r3}
000a4008  stm       sp, {r0, r3}
000a400c  mov       r0, #0
000a4010  mov       r3, #0xe30
000a4014  str       r0, [sp, #8]
000a4018  movw      r0, #0  rel→.L.str.400; ; "5<MI3_INFO>[PID:%d][%s:%d][ProcessEnable] abSubProcessExist[E_MI_AOUT"
000a401c  movt      r0, #0  rel→.L.str.400; ; "5<MI3_INFO>[PID:%d][%s:%d][ProcessEnable] abSubProcessExist[E_MI_AOUT"
000a4020  str       r6, [sp, #0xc]
000a4024  bl        #0xa4024  rel→printk; CALL printk
000a4028  ldr       r7, [r8, #8]
000a402c  mov       r0, #0
000a4030  ldr       r3, [r8, #0x10]
000a4034  mov       r1, r6
000a4038  ldr       r2, [sp, #0x14]
000a403c  blx       r7
000a4040  ldr       r1, [fp, #0xc]
000a4044  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4048  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a404c  movw      r3, #0xe34
000a4050  ldr       r1, [r1, #0x400]
000a4054  str       r0, [sp]
000a4058  movw      r0, #0  rel→.L.str.401; ; "5<MI3_INFO>[PID:%d][%s:%d][ProcessEnable] abSubProcessExist[E_MI_AOUT"
000a405c  movt      r0, #0  rel→.L.str.401; ; "5<MI3_INFO>[PID:%d][%s:%d][ProcessEnable] abSubProcessExist[E_MI_AOUT"
000a4060  bl        #0xa4060  rel→printk; CALL printk
000a4064  b         #0xa3f24
000a4068  bl        #0xa4068  rel→current_thread_info; CALL current_thread_info
000a406c  ldr       r0, [r0, #0xc]
000a4070  movw      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4074  movt      r2, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4078  ldr       r1, [r0, #0x400]
000a407c  ldm       r8, {r0, r3}
000a4080  stm       sp, {r0, r3, r4, r6}
000a4084  movw      r0, #0  rel→.L.str.398; ; "3<MI3_ERR>%s[%d]: pstDtsStudioSoundIInfo is NULL.
"
000a4088  movt      r0, #0  rel→.L.str.398; ; "3<MI3_ERR>%s[%d]: pstDtsStudioSoundIInfo is NULL.
"
000a408c  movw      r3, #0xe25
000a4090  bl        #0xa4090  rel→printk; CALL printk
000a4094  b         #0xa3f94
000a4098  cmp       r0, #0x20
000a409c  bhs       #0xa40f4
000a40a0  movw      r0, #0  rel→_s32CallbackMutex
000a40a4  movt      r0, #0  rel→_s32CallbackMutex
000a40a8  ldr       r0, [r0]
000a40ac  cmn       r0, #1
000a40b0  beq       #0xa40b8
000a40b4  bl        #0xa40b4  rel→MI_OS_ReleaseMutex; CALL MI_OS_ReleaseMutex
000a40b8  movw      r0, #0  rel→_s32AudioSystemMutex
000a40bc  movw      r5, #0  rel→__stack_chk_guard
000a40c0  movt      r0, #0  rel→_s32AudioSystemMutex
000a40c4  movt      r5, #0  rel→__stack_chk_guard
000a40c8  ldr       r0, [r0]
000a40cc  cmn       r0, #1
000a40d0  beq       #0xa40dc
000a40d4  mvn       r1, #0xff
000a40d8  bl        #0xa40d8  rel→MI_OS_ObtainMutex; CALL MI_OS_ObtainMutex
000a40dc  ldr       r0, [r5]
000a40e0  ldr       r1, [sp, #0x20]
000a40e4  subs      r0, r0, r1
000a40e8  addeq     sp, sp, #0x24
000a40ec  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
000a40f0  bl        #0xa40f0  rel→__stack_chk_fail; CALL __stack_chk_fail
000a40f4  bl        #0xa40f4  rel→current_thread_info; CALL current_thread_info
000a40f8  ldr       r0, [r0, #0xc]
000a40fc  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4100  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_ExecuteEventCallback; ; "_MI_AUDIO_ExecuteEventCallback"
000a4104  movw      r2, #0xe21
000a4108  ldr       r3, [r0, #0x400]
000a410c  movw      r0, #0  rel→.L.str.397; ; "DTS_STUDIOSOUND_II_SET_TVHD_PARAMS_BY_CLI"
000a4110  movt      r0, #0  rel→.L.str.397; ; "DTS_STUDIOSOUND_II_SET_TVHD_PARAMS_BY_CLI"
000a4114  str       fp, [sp]
000a4118  str       r4, [sp, #4]
000a411c  bl        #0xa411c  rel→printk; CALL printk
000a4120  b         #0xa40a0
