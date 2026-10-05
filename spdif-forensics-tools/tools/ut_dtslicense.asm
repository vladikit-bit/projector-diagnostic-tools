===== kmods/utpa2k.ko MDrv_AUDIO_Get_DTS_License sec_off=0x422aa0 size=0x178 mode=A =====
00422aa0  push      {r4, r5, r6, r7, fp, lr}
00422aa4  mov       r0, #0xf
00422aa8  mov       r5, #0xf
00422aac  bl        #0x422aac  rel→MDrv_AUTH_IPCheck; CALL MDrv_AUTH_IPCheck
00422ab0  sub       r0, r0, #1
00422ab4  clz       r0, r0
00422ab8  lsr       r4, r0, #5
00422abc  mov       r0, #0x3a
00422ac0  bl        #0x422ac0  rel→MDrv_AUTH_IPCheck; CALL MDrv_AUTH_IPCheck
00422ac4  cmp       r0, #1
00422ac8  mov       r0, #0x12
00422acc  orreq     r4, r4, #2
00422ad0  bl        #0x422ad0  rel→MDrv_AUTH_IPCheck; CALL MDrv_AUTH_IPCheck
00422ad4  cmp       r0, #1
00422ad8  mov       r0, #7
00422adc  orreq     r4, r4, #4
00422ae0  bl        #0x422ae0  rel→MDrv_AUTH_IPCheck; CALL MDrv_AUTH_IPCheck
00422ae4  movw      r7, #0  rel→g_AudioVars2
00422ae8  cmp       r0, #1
00422aec  movt      r7, #0  rel→g_AudioVars2
00422af0  orreq     r4, r4, #8
00422af4  ldr       r0, [r7]
00422af8  cmp       r0, #0
00422afc  beq       #0x422b20
00422b00  ldr       r0, [r0, #0x4c8]
00422b04  cmp       r0, #4
00422b08  blo       #0x422b20
00422b0c  movw      r0, #0  rel→.L.str.49
00422b10  movt      r0, #0  rel→.L.str.49
00422b14  bl        #0x422b14  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00422b18  cmp       r0, #1
00422b1c  beq       #0x422bb4
00422b20  movw      r0, #0x2cf0
00422b24  movt      r0, #0x11
00422b28  bl        #0x422b28  rel→HAL_AUDIO_AbsReadReg; CALL HAL_AUDIO_AbsReadReg
00422b2c  lsl       r0, r0, #0x18
00422b30  and       r6, r5, r0, asr #31
00422b34  ldr       r0, [r7]
00422b38  cmp       r0, #0
00422b3c  beq       #0x422ba0
00422b40  ldr       r0, [r0, #0x4c8]
00422b44  cmp       r0, #4
00422b48  blo       #0x422b60
00422b4c  movw      r0, #0  rel→.L.str.49
00422b50  movt      r0, #0  rel→.L.str.49
00422b54  bl        #0x422b54  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00422b58  cmp       r0, #1
00422b5c  beq       #0x422bd4
00422b60  ldr       r0, [r7]
00422b64  ands      r4, r6, r4
00422b68  mov       r5, #0
00422b6c  mvneq     r5, #0
00422b70  cmp       r0, #0
00422b74  beq       #0x422b98
00422b78  ldr       r0, [r0, #0x4c8]
00422b7c  cmp       r0, #4
00422b80  blo       #0x422b98
00422b84  movw      r0, #0  rel→.L.str.49
00422b88  movt      r0, #0  rel→.L.str.49
00422b8c  bl        #0x422b8c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00422b90  cmp       r0, #1
00422b94  beq       #0x422bf4
00422b98  mov       r0, r5
00422b9c  pop       {r4, r5, r6, r7, fp, pc}
00422ba0  mov       r5, #0
00422ba4  tst       r6, r4
00422ba8  mvneq     r5, #0
00422bac  mov       r0, r5
00422bb0  pop       {r4, r5, r6, r7, fp, pc}
00422bb4  movw      r0, #0  rel→.L.str.62
00422bb8  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422bbc  movt      r0, #0  rel→.L.str.62
00422bc0  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422bc4  movw      r2, #0x241
00422bc8  mov       r3, r4
00422bcc  bl        #0x422bcc  rel→printk; CALL printk
00422bd0  b         #0x422b20
00422bd4  movw      r0, #0  rel→.L.str.63
00422bd8  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422bdc  movt      r0, #0  rel→.L.str.63
00422be0  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422be4  movw      r2, #0x252
00422be8  mov       r3, r6
00422bec  bl        #0x422bec  rel→printk; CALL printk
00422bf0  b         #0x422b60
00422bf4  movw      r0, #0  rel→.L.str.64
00422bf8  movw      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422bfc  movt      r0, #0  rel→.L.str.64
00422c00  movt      r1, #0  rel→.L__FUNCTION__.MDrv_AUDIO_Get_DTS_License
00422c04  movw      r2, #0x25b
00422c08  mov       r3, r4
00422c0c  bl        #0x422c0c  rel→printk; CALL printk
00422c10  mov       r0, r5
00422c14  pop       {r4, r5, r6, r7, fp, pc}
