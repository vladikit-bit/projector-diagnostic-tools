
===== HAL_AUDIO_DDELoadCode @ 0x443e98 size 0xbc =====
0x443e98  push    {r4, lr}
0x443e9c  movw    r4, #0
0x443ea0  movt    r4, #0
0x443ea4  ldr     r0, [r4]
0x443ea8  cmp     r0, #0
0x443eac  bne     #0x443ec0
0x443eb0  bl      #0x404e60   ; CALL MDrv_AUDIO_SHM_Init
0x443eb4  ldr     r0, [r4]
0x443eb8  cmp     r0, #0
0x443ebc  popeq   {r4, pc}
0x443ec0  ldr     r0, [r0, #0x4c8]
0x443ec4  cmp     r0, #4
0x443ec8  blo     #0x443ee0
0x443ecc  movw    r0, #0
0x443ed0  movt    r0, #0
0x443ed4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x443ed8  cmp     r0, #1
0x443edc  beq     #0x443f34
0x443ee0  ldr     r0, [r4]
0x443ee4  cmp     r0, #0
0x443ee8  beq     #0x443f04
0x443eec  ldr     r1, [r0, #0x4d0]
0x443ef0  sub     r1, r1, #1
0x443ef4  cmp     r1, #4
0x443ef8  ldrhs   r0, [r0, #0x4c8]
0x443efc  cmphs   r0, #4
0x443f00  bhs     #0x443f08
0x443f04  pop     {r4, pc}
0x443f08  movw    r0, #0
0x443f0c  movt    r0, #0
0x443f10  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x443f14  cmp     r0, #1
0x443f18  bne     #0x443f04
0x443f1c  movw    r0, #0
0x443f20  movw    r1, #0
0x443f24  movt    r0, #0
0x443f28  movt    r1, #0
0x443f2c  pop     {r4, lr}
0x443f30  b       #0xfffffff8   ; CALL printk
0x443f34  ldr     r0, [r4]
0x443f38  movw    r1, #0
0x443f3c  movt    r1, #0
0x443f40  ldr     r2, [r0, #0x4d0]
0x443f44  movw    r0, #0
0x443f48  movt    r0, #0
0x443f4c  bl      #0xfffffff8   ; CALL printk
0x443f50  b       #0x443ee0

===== HAL_AUDIO_DDPELoadCode @ 0x443f54 size 0xbc =====
0x443f54  push    {r4, lr}
0x443f58  movw    r4, #0
0x443f5c  movt    r4, #0
0x443f60  ldr     r0, [r4]
0x443f64  cmp     r0, #0
0x443f68  bne     #0x443f7c
0x443f6c  bl      #0x404e60   ; CALL MDrv_AUDIO_SHM_Init
0x443f70  ldr     r0, [r4]
0x443f74  cmp     r0, #0
0x443f78  popeq   {r4, pc}
0x443f7c  ldr     r0, [r0, #0x4c8]
0x443f80  cmp     r0, #4
0x443f84  blo     #0x443f9c
0x443f88  movw    r0, #0
0x443f8c  movt    r0, #0
0x443f90  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x443f94  cmp     r0, #1
0x443f98  beq     #0x443ff0
0x443f9c  ldr     r0, [r4]
0x443fa0  cmp     r0, #0
0x443fa4  beq     #0x443fc0
0x443fa8  ldr     r1, [r0, #0x4d0]
0x443fac  sub     r1, r1, #1
0x443fb0  cmp     r1, #4
0x443fb4  ldrhs   r0, [r0, #0x4c8]
0x443fb8  cmphs   r0, #4
0x443fbc  bhs     #0x443fc4
0x443fc0  pop     {r4, pc}
0x443fc4  movw    r0, #0
0x443fc8  movt    r0, #0
0x443fcc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x443fd0  cmp     r0, #1
0x443fd4  bne     #0x443fc0
0x443fd8  movw    r0, #0
0x443fdc  movw    r1, #0
0x443fe0  movt    r0, #0
0x443fe4  movt    r1, #0
0x443fe8  pop     {r4, lr}
0x443fec  b       #0xfffffff8   ; CALL printk
0x443ff0  ldr     r0, [r4]
0x443ff4  movw    r1, #0
0x443ff8  movt    r1, #0
0x443ffc  ldr     r2, [r0, #0x4d0]
0x444000  movw    r0, #0
0x444004  movt    r0, #0
0x444008  bl      #0xfffffff8   ; CALL printk
0x44400c  b       #0x443f9c

===== HAL_AUDIO_Encoder_Channel_Lock @ 0x43f168 size 0x94 =====
0x43f168  push    {fp, lr}
0x43f16c  mov     r2, r0
0x43f170  movw    r0, #0
0x43f174  movt    r0, #0
0x43f178  ldr     r0, [r0]
0x43f17c  ldr     r1, [r0, #0x4d0]
0x43f180  sub     r3, r1, #1
0x43f184  cmp     r3, #2
0x43f188  blo     #0x43f1d8
0x43f18c  cmp     r1, #4
0x43f190  cmpne   r1, #3
0x43f194  bne     #0x43f1b0
0x43f198  mov     r0, #0x6d
0x43f19c  mov     r1, #0
0x43f1a0  mov     r3, #0
0x43f1a4  bl      #0x459df4   ; CALL HAL_SND_R2_Set_SHM_PARAM
0x43f1a8  mov     r0, #1
0x43f1ac  pop     {fp, pc}
0x43f1b0  cmp     r0, #0
0x43f1b4  beq     #0x43f1d8
0x43f1b8  ldr     r0, [r0, #0x4c8]
0x43f1bc  cmp     r0, #4
0x43f1c0  blo     #0x43f1d8
0x43f1c4  movw    r0, #0
0x43f1c8  movt    r0, #0
0x43f1cc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x43f1d0  cmp     r0, #1
0x43f1d4  beq     #0x43f1e0
0x43f1d8  mov     r0, #1
0x43f1dc  pop     {fp, pc}
0x43f1e0  movw    r0, #0
0x43f1e4  movw    r1, #0
0x43f1e8  movt    r0, #0
0x43f1ec  movt    r1, #0
0x43f1f0  bl      #0xfffffff8   ; CALL printk
0x43f1f4  mov     r0, #1
0x43f1f8  pop     {fp, pc}
