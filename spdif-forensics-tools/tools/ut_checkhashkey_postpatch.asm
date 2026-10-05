POST-PATCH MDrv_AUDIO_CheckHashkey regions (libs/utpa2k_dts_patched.ko)

===== IPCheck 0xb/0xc sites: 0x423504-0x4235ac =====
0x423504: e3a0000b  mov     r0, #0xb
0x423508: ebfffffe  bl      #0x423508   ; MDrv_AUTH_IPCheck=0x1390c
0x42350c: e5941000  ldr     r1, [r4]
0x423510: e3500000  cmp     r0, #0
0x423514: e1a00000  mov     r0, r0
0x423518: e3510000  cmp     r1, #0
0x42351c: 0a000017  beq     #0x423580
0x423520: e59104c8  ldr     r0, [r1, #0x4c8]
0x423524: e3500003  cmp     r0, #3
0x423528: 3a000014  blo     #0x423580
0x42352c: e3000000  movw    r0, #0   ; .L.str.77=0x6e885
0x423530: e3400000  movt    r0, #0   ; .L.str.77=0x6e885
0x423534: ebfffffe  bl      #0x423534   ; UtopiaLogSystem=0x2d54
0x423538: e3500001  cmp     r0, #1
0x42353c: 1a00000f  bne     #0x423580
0x423540: e3000000  movw    r0, #0   ; .L.str.79=0x66f4b
0x423544: e3400000  movt    r0, #0   ; .L.str.79=0x66f4b
0x423548: ea000518  b       #0x4249b0
0x42354c: e5910440  ldr     r0, [r1, #0x440]
0x423550: e3510000  cmp     r1, #0
0x423554: e3800001  orr     r0, r0, #1
0x423558: e5810440  str     r0, [r1, #0x440]
0x42355c: 0a000007  beq     #0x423580
0x423560: e59104c8  ldr     r0, [r1, #0x4c8]
0x423564: e3500003  cmp     r0, #3
0x423568: 3a000004  blo     #0x423580
0x42356c: e3000000  movw    r0, #0   ; .L.str.77=0x6e885
0x423570: e3400000  movt    r0, #0   ; .L.str.77=0x6e885
0x423574: ebfffffe  bl      #0x423574   ; UtopiaLogSystem=0x2d54
0x423578: e3500001  cmp     r0, #1
0x42357c: 0a000509  beq     #0x4249a8
0x423580: e3a0000c  mov     r0, #0xc
0x423584: ebfffffe  bl      #0x423584   ; MDrv_AUTH_IPCheck=0x1390c
0x423588: e5941000  ldr     r1, [r4]
0x42358c: e3500000  cmp     r0, #0
0x423590: e5912440  ldr     r2, [r1, #0x440]
0x423594: e1a00000  mov     r0, r0
0x423598: e3c20001  bic     r0, r2, #1
0x42359c: e5810440  str     r0, [r1, #0x440]
0x4235a0: e5d10581  ldrb    r0, [r1, #0x581]
0x4235a4: e3510000  cmp     r1, #0
0x4235a8: e3800001  orr     r0, r0, #1

===== final stores -> GET_INIT_FLAG: 0x424864-0x4248c0 =====
0x424864: 0a0000bb  beq     #0x424b58
0x424868: e5940000  ldr     r0, [r4]
0x42486c: e3500000  cmp     r0, #0
0x424870: e58064d0  str     r6, [r0, #0x4d0]
0x424874: e58054d4  str     r5, [r0, #0x4d4]
0x424878: e58084d8  str     r8, [r0, #0x4d8]
0x42487c: e3a07001  mov     r7, #1
0x424880: e5c0743e  strb    r7, [r0, #0x43e]
0x424884: e3a0a001  mov     sl, #1
0x424888: e5c0a43d  strb    sl, [r0, #0x43d]
0x42488c: ea000005  b       #0x4248a8
0x424890: 3a000004  blo     #0x4248a8
0x424894: e3000000  movw    r0, #0   ; .L.str.77=0x6e885
0x424898: e3400000  movt    r0, #0   ; .L.str.77=0x6e885
0x42489c: ebfffffe  bl      #0x42489c   ; UtopiaLogSystem=0x2d54
0x4248a0: e3500001  cmp     r0, #1
0x4248a4: 0a00000e  beq     #0x4248e4
0x4248a8: ebfffffe  bl      #0x4248a8   ; HAL_AUDIO_GET_INIT_FLAG=0x4411ac
0x4248ac: e3500001  cmp     r0, #1
0x4248b0: 05940000  ldreq   r0, [r4]
0x4248b4: 03a01001  moveq   r1, #1
0x4248b8: 05c01503  strbeq  r1, [r0, #0x503]
0x4248bc: e28dd010  add     sp, sp, #0x10
