===== kmods/mik.ko mi_audio_SetCodecType sec_off=0xb07f8 size=0x18c mode=A =====
000b07f8  push      {r4, r5, r6, r7, fp, lr}
000b07fc  sub       sp, sp, #0x10
000b0800  mov       r4, #8
000b0804  cmp       r0, #1
000b0808  bhi       #0xb08f4
000b080c  mov       r6, r0
000b0810  movw      r0, #0  rel→_pastAudSlot
000b0814  movt      r0, #0  rel→_pastAudSlot
000b0818  mov       r5, r1
000b081c  ldr       r7, [r0]
000b0820  cmp       r7, #0
000b0824  beq       #0xb0834
000b0828  ldr       r1, [r7, #0xb18]
000b082c  cmp       r1, r6
000b0830  beq       #0xb084c
000b0834  ldr       r7, [r0, #4]
000b0838  cmp       r7, #0
000b083c  beq       #0xb0894
000b0840  ldr       r0, [r7, #0xb18]
000b0844  cmp       r0, r6
000b0848  bne       #0xb0894
000b084c  mov       r0, r7
000b0850  bl        #0x9d528
000b0854  cmp       r0, #0
000b0858  beq       #0xb08d0
000b085c  movw      r0, #0  rel→_u32AudioDbgLevel
000b0860  movt      r0, #0  rel→_u32AudioDbgLevel
000b0864  ldr       r0, [r0]
000b0868  cmp       r0, #0x20
000b086c  blo       #0xb08f4
000b0870  bl        #0xb0870  rel→current_thread_info; CALL current_thread_info
000b0874  ldr       r0, [r0, #0xc]
000b0878  movw      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetInstance
000b087c  movt      r1, #0  rel→.L__FUNCTION__._MI_AUDIO_GetInstance
000b0880  movw      r2, #0xc54
000b0884  ldr       r3, [r0, #0x400]
000b0888  movw      r0, #0  rel→.L.str.705
000b088c  movt      r0, #0  rel→.L.str.705
000b0890  bl        #0xb0890  rel→printk; CALL printk
000b0894  movw      r0, #0  rel→_u32AudioDbgLevel
000b0898  movt      r0, #0  rel→_u32AudioDbgLevel
000b089c  ldr       r0, [r0]
000b08a0  cmp       r0, #0x20
000b08a4  blo       #0xb08f4
000b08a8  bl        #0xb08a8  rel→current_thread_info; CALL current_thread_info
000b08ac  ldr       r0, [r0, #0xc]
000b08b0  movw      r1, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b08b4  movt      r1, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b08b8  movw      r2, #0x2a66
000b08bc  ldr       r3, [r0, #0x400]
000b08c0  movw      r0, #0  rel→.L.str.164
000b08c4  movt      r0, #0  rel→.L.str.164
000b08c8  bl        #0xb08c8  rel→printk; CALL printk
000b08cc  b         #0xb08f4
000b08d0  ldr       r0, [r7, #0x958]
000b08d4  cmp       r0, r5
000b08d8  bne       #0xb0900
000b08dc  movw      r0, #0  rel→_u32AudioDbgLevel
000b08e0  mov       r4, #0
000b08e4  movt      r0, #0  rel→_u32AudioDbgLevel
000b08e8  ldr       r0, [r0]
000b08ec  cmp       r0, #0x50
000b08f0  bhs       #0xb0958
000b08f4  mov       r0, r4
000b08f8  add       sp, sp, #0x10
000b08fc  pop       {r4, r5, r6, r7, fp, pc}
000b0900  movw      r0, #0  rel→_aeCurAudioDecoderType
000b0904  mov       r4, #1
000b0908  movt      r0, #0  rel→_aeCurAudioDecoderType
000b090c  str       r5, [r7, #0x958]
000b0910  str       r5, [r7, #0xa2c]
000b0914  str       r5, [r0, r6, lsl #2]
000b0918  strb      r4, [r7, #0x84d]
000b091c  bl        #0xb091c  rel→current_thread_info; CALL current_thread_info
000b0920  ldr       r0, [r0, #0xc]
000b0924  movw      r2, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b0928  movt      r2, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b092c  movw      r3, #0x2a75
000b0930  ldr       r1, [r0, #0x400]
000b0934  ldr       r0, [r7, #0xadc]
000b0938  str       r6, [sp]
000b093c  stmib     sp, {r0, r5}
000b0940  movw      r0, #0  rel→.L.str.166
000b0944  movt      r0, #0  rel→.L.str.166
000b0948  str       r4, [sp, #0xc]
000b094c  bl        #0xb094c  rel→printk; CALL printk
000b0950  mov       r4, #0
000b0954  b         #0xb08f4
000b0958  bl        #0xb0958  rel→current_thread_info; CALL current_thread_info
000b095c  ldr       r0, [r0, #0xc]
000b0960  movw      r2, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b0964  movt      r2, #0  rel→.L__FUNCTION__.mi_audio_SetCodecType
000b0968  movw      r3, #0x2a6c
000b096c  ldr       r1, [r0, #0x400]
000b0970  movw      r0, #0  rel→.L.str.165
000b0974  movt      r0, #0  rel→.L.str.165
000b0978  str       r5, [sp]
000b097c  bl        #0xb097c  rel→printk; CALL printk
000b0980  b         #0xb08f4
