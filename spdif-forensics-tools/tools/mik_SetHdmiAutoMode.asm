_MI_AOUT_SetHdmiAutoMode (unnamed static, mik.ko 0x989cc..0x98fe8, ARM)
args: r0 = HDMI-TX EDID audio-format bitmap (CEA-861 codes), r1 = codec type id
calls: MApi_AUDIO_SetDTSCommonCtrl / SetAC3PInfo / SetAudioParam2;
       MApi_AUDIO_HDMI_TX_SetMode(r4); MApi_AUDIO_SPDIF_SetMode(r4)
r4: 2=BYPASS 3=TRANSCODE 1=AC3P-variant 0=PCM

0x0989cc  push     {r4, r5, r6, r7, fp, lr}
0x0989d0  sub      sp, sp, #8
0x0989d4  sub      r1, r1, #4
0x0989d8  cmp      r1, #0x13
0x0989dc  bhi      #0x98b8c
0x0989e0  add      r2, pc, #0
0x0989e4  ldr      pc, [r2, r1, lsl #2]
0x0989e8  andeq    r8, sb, r8, lsl #21
0x0989ec  andeq    r8, sb, ip, lsr fp
0x0989f0  andeq    r8, sb, ip, lsl #23
0x0989f4  andeq    r8, sb, r8, lsl #21
0x0989f8  andeq    r8, sb, r8, lsr #23
0x0989fc  andeq    r8, sb, r8, lsr sl
0x098a00  andeq    r8, sb, r8, lsr sl
0x098a04  andeq    r8, sb, r8, lsr sl
0x098a08  andeq    r8, sb, ip, lsl #23
0x098a0c  andeq    r8, sb, ip, lsl #23
0x098a10  andeq    r8, sb, ip, lsl #23
0x098a14  andeq    r8, sb, ip, lsl #23
0x098a18  andeq    r8, sb, ip, lsl #23
0x098a1c  andeq    r8, sb, ip, lsl #23
0x098a20  andeq    r8, sb, ip, lsl #23
0x098a24  andeq    r8, sb, ip, lsl #23
0x098a28  andeq    r8, sb, ip, lsl #23
0x098a2c  andeq    r8, sb, ip, lsl #23
0x098a30  andeq    r8, sb, ip, lsl #23
0x098a34  andeq    r8, sb, r8, lsr sl
0x098a38  tst      r0, #0x800
0x098a3c  bne      #0x98ad4
0x098a40  movw     r7, #0   ; _u32AoutDbgLevel
0x098a44  tst      r0, #0x80
0x098a48  movt     r7, #0   ; _u32AoutDbgLevel
0x098a4c  ldr      r1, [r7]
0x098a50  bne      #0x98c04
0x098a54  mov      r5, #1
0x098a58  mov      r6, #0
0x098a5c  cmp      r1, #0x40
0x098a60  blo      #0x98c14
0x098a64  bl       #0x98a64   ; current_thread_info
0x098a68  ldr      r0, [r0, #0xc]
0x098a6c  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098a70  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098a74  movw     r3, #0x1d99
0x098a78  ldr      r1, [r0, #0x400]
0x098a7c  movw     r0, #0   ; .L.str.1454
0x098a80  movt     r0, #0   ; .L.str.1454
0x098a84  b        #0x98f38
0x098a88  movw     r1, #0   ; _u32AoutDbgLevel
0x098a8c  movw     r2, #0x1404
0x098a90  movt     r1, #0   ; _u32AoutDbgLevel
0x098a94  tst      r0, r2
0x098a98  ldr      r1, [r1]
0x098a9c  beq      #0x98c80
0x098aa0  mov      r5, #2
0x098aa4  mov      r6, #1
0x098aa8  cmp      r1, #0x40
0x098aac  blo      #0x98c90
0x098ab0  bl       #0x98ab0   ; current_thread_info
0x098ab4  ldr      r0, [r0, #0xc]
0x098ab8  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098abc  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098ac0  movw     r3, #0x1d5a
0x098ac4  ldr      r1, [r0, #0x400]
0x098ac8  movw     r0, #0   ; .L.str.1447
0x098acc  movt     r0, #0   ; .L.str.1447
0x098ad0  b        #0x98f60
0x098ad4  movw     r5, #0   ; _u32AoutDbgLevel
0x098ad8  movt     r5, #0   ; _u32AoutDbgLevel
0x098adc  ldr      r0, [r5]
0x098ae0  cmp      r0, #0x40
0x098ae4  bhs      #0x98e00
0x098ae8  movw     r0, #0   ; _eCurHdmiAudioType
0x098aec  mov      r1, #9
0x098af0  movt     r0, #0   ; _eCurHdmiAudioType
0x098af4  mov      r4, #1
0x098af8  str      r1, [r0]
0x098afc  mov      r0, #0x10
0x098b00  mov      r1, #1
0x098b04  bl       #0x98b04   ; MApi_AUDIO_SetDTSCommonCtrl
0x098b08  ldr      r0, [r5]
0x098b0c  and      r1, r0, #0xf
0x098b10  sub      r1, r1, #1
0x098b14  cmp      r1, #1
0x098b18  bls      #0x98e28
0x098b1c  and      r1, r0, #0xf
0x098b20  cmp      r1, #2
0x098b24  beq      #0x98e60
0x098b28  mov      r5, #0xb
0x098b2c  mov      r6, #3
0x098b30  cmp      r0, #0x40
0x098b34  blo      #0x98c5c
0x098b38  b        #0x98d98
0x098b3c  tst      r0, #0x1400
0x098b40  beq      #0x98cec
0x098b44  movw     r0, #0   ; _u32AoutDbgLevel
0x098b48  mov      r5, #0xa
0x098b4c  movt     r0, #0   ; _u32AoutDbgLevel
0x098b50  mov      r6, #3
0x098b54  ldr      r0, [r0]
0x098b58  mov      r4, #1
0x098b5c  cmp      r0, #0x40
0x098b60  blo      #0x98d64
0x098b64  bl       #0x98b64   ; current_thread_info
0x098b68  ldr      r0, [r0, #0xc]
0x098b6c  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098b70  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098b74  movw     r3, #0x1d3d
0x098b78  ldr      r1, [r0, #0x400]
0x098b7c  movw     r0, #0   ; .L.str.1444
0x098b80  movt     r0, #0   ; .L.str.1444
0x098b84  bl       #0x98b84   ; printk
0x098b88  b        #0x98d64
0x098b8c  movw     r0, #0   ; _eCurHdmiAudioType
0x098b90  mov      r1, #0xc
0x098b94  movt     r0, #0   ; _eCurHdmiAudioType
0x098b98  mov      r5, #1
0x098b9c  mov      r4, #0
0x098ba0  mov      r6, #0
0x098ba4  b        #0x98d80
0x098ba8  tst      r0, #0x1000
0x098bac  bne      #0x98ca4
0x098bb0  movw     r1, #0   ; _u32AoutDbgLevel
0x098bb4  movw     r2, #0x404
0x098bb8  movt     r1, #0   ; _u32AoutDbgLevel
0x098bbc  tst      r0, r2
0x098bc0  ldr      r1, [r1]
0x098bc4  beq      #0x98d18
0x098bc8  mov      r5, #2
0x098bcc  mov      r6, #1
0x098bd0  mov      r4, #0
0x098bd4  cmp      r1, #0x40
0x098bd8  blo      #0x98d2c
0x098bdc  bl       #0x98bdc   ; current_thread_info
0x098be0  ldr      r0, [r0, #0xc]
0x098be4  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098be8  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098bec  movw     r3, #0x1d75
0x098bf0  ldr      r1, [r0, #0x400]
0x098bf4  movw     r0, #0   ; .L.str.1450
0x098bf8  movt     r0, #0   ; .L.str.1450
0x098bfc  bl       #0x98bfc   ; printk
0x098c00  b        #0x98d2c
0x098c04  mov      r5, #7
0x098c08  mov      r6, #1
0x098c0c  cmp      r1, #0x40
0x098c10  bhs      #0x98f18
0x098c14  movw     r0, #0   ; _eCurHdmiAudioType
0x098c18  mov      r1, #9
0x098c1c  movt     r0, #0   ; _eCurHdmiAudioType
0x098c20  mov      r4, #0
0x098c24  str      r1, [r0]
0x098c28  mov      r0, #0x10
0x098c2c  mov      r1, #0
0x098c30  bl       #0x98c30   ; MApi_AUDIO_SetDTSCommonCtrl
0x098c34  ldr      r0, [r7]
0x098c38  and      r1, r0, #0xf
0x098c3c  sub      r1, r1, #1
0x098c40  cmp      r1, #1
0x098c44  bls      #0x98ea4
0x098c48  and      r1, r0, #0xf
0x098c4c  cmp      r1, #2
0x098c50  beq      #0x98edc
0x098c54  cmp      r0, #0x40
0x098c58  bhs      #0x98d98
0x098c5c  cmp      r6, #3
0x098c60  beq      #0x98dcc
0x098c64  cmp      r6, #1
0x098c68  bne      #0x98c74
0x098c6c  mov      r4, #2
0x098c70  b        #0x98dd0
0x098c74  mov      r0, #0
0x098c78  mov      r4, #0
0x098c7c  b        #0x98dd4
0x098c80  mov      r5, #1
0x098c84  mov      r6, #0
0x098c88  cmp      r1, #0x40
0x098c8c  bhs      #0x98f40
0x098c90  movw     r0, #0   ; _eCurHdmiAudioType
0x098c94  mov      r1, #4
0x098c98  movt     r0, #0   ; _eCurHdmiAudioType
0x098c9c  mov      r4, #0
0x098ca0  b        #0x98d80
0x098ca4  movw     r0, #0   ; _u32AoutDbgLevel
0x098ca8  mov      r5, #0xc
0x098cac  movt     r0, #0   ; _u32AoutDbgLevel
0x098cb0  mov      r6, #3
0x098cb4  ldr      r0, [r0]
0x098cb8  mov      r4, #1
0x098cbc  cmp      r0, #0x40
0x098cc0  blo      #0x98d2c
0x098cc4  bl       #0x98cc4   ; current_thread_info
0x098cc8  ldr      r0, [r0, #0xc]
0x098ccc  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098cd0  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098cd4  movw     r3, #0x1d6e
0x098cd8  ldr      r1, [r0, #0x400]
0x098cdc  movw     r0, #0   ; .L.str.1449
0x098ce0  movt     r0, #0   ; .L.str.1449
0x098ce4  bl       #0x98ce4   ; printk
0x098ce8  b        #0x98d2c
0x098cec  movw     r1, #0   ; _u32AoutDbgLevel
0x098cf0  tst      r0, #4
0x098cf4  movt     r1, #0   ; _u32AoutDbgLevel
0x098cf8  ldr      r1, [r1]
0x098cfc  bne      #0x98d50
0x098d00  mov      r5, #1
0x098d04  mov      r4, #0
0x098d08  cmp      r1, #0x40
0x098d0c  bhs      #0x98f68
0x098d10  mov      r6, #0
0x098d14  b        #0x98d64
0x098d18  mov      r5, #1
0x098d1c  mov      r4, #0
0x098d20  cmp      r1, #0x40
0x098d24  bhs      #0x98f94
0x098d28  mov      r6, #0
0x098d2c  movw     r0, #0   ; _eCurHdmiAudioType
0x098d30  mov      r1, #8
0x098d34  movt     r0, #0   ; _eCurHdmiAudioType
0x098d38  mov      r2, r4
0x098d3c  str      r1, [r0]
0x098d40  mov      r0, #0
0x098d44  mov      r1, #0x18
0x098d48  bl       #0x98d48   ; MApi_AUDIO_SetAudioParam2
0x098d4c  b        #0x98d84
0x098d50  mov      r5, #2
0x098d54  mov      r6, #1
0x098d58  mov      r4, #0
0x098d5c  cmp      r1, #0x40
0x098d60  bhs      #0x98fc0
0x098d64  mov      r0, #9
0x098d68  mov      r1, r4
0x098d6c  mov      r2, #0
0x098d70  bl       #0x98d70   ; MApi_AUDIO_SetAC3PInfo
0x098d74  movw     r0, #0   ; _eCurHdmiAudioType
0x098d78  mov      r1, #5
0x098d7c  movt     r0, #0   ; _eCurHdmiAudioType
0x098d80  str      r1, [r0]
0x098d84  movw     r0, #0   ; _u32AoutDbgLevel
0x098d88  movt     r0, #0   ; _u32AoutDbgLevel
0x098d8c  ldr      r0, [r0]
0x098d90  cmp      r0, #0x40
0x098d94  blo      #0x98c5c
0x098d98  bl       #0x98d98   ; current_thread_info
0x098d9c  ldr      r0, [r0, #0xc]
0x098da0  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098da4  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098da8  movw     r3, #0x1db3
0x098dac  ldr      r1, [r0, #0x400]
0x098db0  movw     r0, #0   ; .L.str.1457
0x098db4  movt     r0, #0   ; .L.str.1457
0x098db8  str      r6, [sp]
0x098dbc  str      r4, [sp, #4]
0x098dc0  bl       #0x98dc0   ; printk
0x098dc4  cmp      r6, #3
0x098dc8  bne      #0x98c64
0x098dcc  mov      r4, #3
0x098dd0  mov      r0, r6
0x098dd4  bl       #0x98dd4   ; MApi_AUDIO_HDMI_TX_SetMode
0x098dd8  mov      r0, r4
0x098ddc  bl       #0x98ddc   ; MApi_AUDIO_SPDIF_SetMode
0x098de0  movw     r0, #0   ; _stAoutSndParam
0x098de4  movt     r0, #0   ; _stAoutSndParam
0x098de8  str      r6, [r0, #0x7c]
0x098dec  str      r5, [r0, #0x80]
0x098df0  str      r6, [r0, #0x6c]
0x098df4  str      r5, [r0, #0x70]
0x098df8  add      sp, sp, #8
0x098dfc  pop      {r4, r5, r6, r7, fp, pc}
0x098e00  bl       #0x98e00   ; current_thread_info
0x098e04  ldr      r0, [r0, #0xc]
0x098e08  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e0c  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e10  movw     r3, #0x1d8d
0x098e14  ldr      r1, [r0, #0x400]
0x098e18  movw     r0, #0   ; .L.str.1452
0x098e1c  movt     r0, #0   ; .L.str.1452
0x098e20  bl       #0x98e20   ; printk
0x098e24  b        #0x98ae8
0x098e28  bl       #0x98e28   ; current_thread_info
0x098e2c  ldr      r0, [r0, #0xc]
0x098e30  movw     r2, #0x50c
0x098e34  movw     r3, #0x1da0
0x098e38  ldr      r1, [r0, #0x400]
0x098e3c  add      r0, r0, r2
0x098e40  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e44  stm      sp, {r0, r1}
0x098e48  movw     r0, #0   ; .L.str.1455
0x098e4c  movt     r0, #0   ; .L.str.1455
0x098e50  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e54  bl       #0x98e54   ; printk
0x098e58  ldr      r0, [r5]
0x098e5c  b        #0x98b1c
0x098e60  bl       #0x98e60   ; current_thread_info
0x098e64  ldr      r0, [r0, #0xc]
0x098e68  movw     r2, #0x50c
0x098e6c  movw     r3, #0x1da1
0x098e70  ldr      r1, [r0, #0x400]
0x098e74  add      r0, r0, r2
0x098e78  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e7c  stm      sp, {r0, r1}
0x098e80  movw     r0, #0   ; .L.str.230
0x098e84  movt     r0, #0   ; .L.str.230
0x098e88  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098e8c  bl       #0x98e8c   ; printk
0x098e90  bl       #0x98e90   ; dump_stack
0x098e94  mov      r5, #0xb
0x098e98  mov      r6, #3
0x098e9c  mov      r4, #1
0x098ea0  b        #0x98d84
0x098ea4  bl       #0x98ea4   ; current_thread_info
0x098ea8  ldr      r0, [r0, #0xc]
0x098eac  movw     r2, #0x50c
0x098eb0  movw     r3, #0x1da6
0x098eb4  ldr      r1, [r0, #0x400]
0x098eb8  add      r0, r0, r2
0x098ebc  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098ec0  stm      sp, {r0, r1}
0x098ec4  movw     r0, #0   ; .L.str.1456
0x098ec8  movt     r0, #0   ; .L.str.1456
0x098ecc  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098ed0  bl       #0x98ed0   ; printk
0x098ed4  ldr      r0, [r7]
0x098ed8  b        #0x98c48
0x098edc  bl       #0x98edc   ; current_thread_info
0x098ee0  ldr      r0, [r0, #0xc]
0x098ee4  movw     r2, #0x50c
0x098ee8  movw     r3, #0x1da7
0x098eec  ldr      r1, [r0, #0x400]
0x098ef0  add      r0, r0, r2
0x098ef4  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098ef8  stm      sp, {r0, r1}
0x098efc  movw     r0, #0   ; .L.str.230
0x098f00  movt     r0, #0   ; .L.str.230
0x098f04  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f08  bl       #0x98f08   ; printk
0x098f0c  bl       #0x98f0c   ; dump_stack
0x098f10  mov      r4, #0
0x098f14  b        #0x98d84
0x098f18  bl       #0x98f18   ; current_thread_info
0x098f1c  ldr      r0, [r0, #0xc]
0x098f20  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f24  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f28  movw     r3, #0x1d93
0x098f2c  ldr      r1, [r0, #0x400]
0x098f30  movw     r0, #0   ; .L.str.1453
0x098f34  movt     r0, #0   ; .L.str.1453
0x098f38  bl       #0x98f38   ; printk
0x098f3c  b        #0x98c14
0x098f40  bl       #0x98f40   ; current_thread_info
0x098f44  ldr      r0, [r0, #0xc]
0x098f48  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f4c  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f50  movw     r3, #0x1d60
0x098f54  ldr      r1, [r0, #0x400]
0x098f58  movw     r0, #0   ; .L.str.1448
0x098f5c  movt     r0, #0   ; .L.str.1448
0x098f60  bl       #0x98f60   ; printk
0x098f64  b        #0x98c90
0x098f68  bl       #0x98f68   ; current_thread_info
0x098f6c  ldr      r0, [r0, #0xc]
0x098f70  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f74  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098f78  movw     r3, #0x1d49
0x098f7c  ldr      r1, [r0, #0x400]
0x098f80  movw     r0, #0   ; .L.str.1446
0x098f84  movt     r0, #0   ; .L.str.1446
0x098f88  bl       #0x98f88   ; printk
0x098f8c  mov      r4, #0
0x098f90  b        #0x98d10
0x098f94  bl       #0x98f94   ; current_thread_info
0x098f98  ldr      r0, [r0, #0xc]
0x098f9c  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098fa0  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098fa4  movw     r3, #0x1d7b
0x098fa8  ldr      r1, [r0, #0x400]
0x098fac  movw     r0, #0   ; .L.str.1451
0x098fb0  movt     r0, #0   ; .L.str.1451
0x098fb4  bl       #0x98fb4   ; printk
0x098fb8  mov      r4, #0
0x098fbc  b        #0x98d28
0x098fc0  bl       #0x98fc0   ; current_thread_info
0x098fc4  ldr      r0, [r0, #0xc]
0x098fc8  movw     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098fcc  movt     r2, #0   ; .L__FUNCTION__._MI_AOUT_SetHdmiAutoMode
0x098fd0  movw     r3, #0x1d43
0x098fd4  ldr      r1, [r0, #0x400]
0x098fd8  movw     r0, #0   ; .L.str.1445
0x098fdc  movt     r0, #0   ; .L.str.1445
0x098fe0  bl       #0x98fe0   ; printk
0x098fe4  b        #0x98d64
