===== libs/libmi3.so MI_AUDIO_Write @ 0x62afc size 0x190 =====
00062afc  push      {r4, r5, r6, r7, lr}
00062afe  sub       sp, #0x3c
00062b00  mov       r3, r0
00062b02  ldr       r0, [pc, #0x13c]  pool=0x4fa08
00062b04  add       r0, pc
00062b06  ldr       r7, [r0]
00062b08  ldr       r0, [r7]
00062b0a  str       r0, [sp, #0x38]
00062b0c  ldr       r0, [pc, #0x134]  pool=0x53e0a
00062b0e  add       r0, pc
00062b10  ldr       r0, [r0]
00062b12  cmp.w     r0, #-1
00062b16  ble       #0x62b9c
00062b18  cmp       r1, #0
00062b1a  beq       #0x62bba
00062b1c  mov       r5, r2
00062b1e  cmp       r2, #0
00062b20  beq       #0x62bd2
00062b22  mov       r2, sp
00062b24  vmov.i32  q8, #0
00062b28  mov.w     ip, #0x34
00062b2c  movs      r6, #0
00062b2e  mov       r4, r2
00062b30  str       r6, [sp, #0x30]
00062b32  vst1.64   {d16, d17}, [r4], ip
00062b36  str       r6, [r4]
00062b38  add.w     r4, r2, #0x20
00062b3c  vst1.64   {d16, d17}, [r4]
00062b40  add.w     r4, r2, #0x10
00062b44  vst1.64   {d16, d17}, [r4]
00062b48  str       r6, [sp, #0xc]
00062b4a  str       r3, [sp]
00062b4c  ldrd      r6, r3, [r1]
00062b50  cmp       r3, #0
00062b52  str       r6, [sp, #8]
00062b54  beq       #0x62bfc
00062b56  add.w     r6, r1, #8
00062b5a  str       r3, [sp, #0x10]
00062b5c  vld1.64   {d16, d17}, [r6]
00062b60  add.w     r6, r2, #0x18
00062b64  vst1.64   {d16, d17}, [r6]
00062b68  ldrd      r1, r3, [r1, #0x18]
00062b6c  strd      r1, r3, [sp, #0x28]
00062b70  movw      r1, #0x100a
00062b74  movt      r1, #0xc038
00062b78  blx       #0xaffe0
00062b7c  cmp       r0, #0
00062b7e  beq       #0x62c1c
00062b80  mov       r4, r0
00062b82  ldr       r0, [pc, #0xf4]  pool=0x53d8c
00062b84  add       r0, pc
00062b86  ldrb      r0, [r0]
00062b88  cmp       r0, #0x20
00062b8a  blo       #0x62bee
00062b8c  ldr       r0, [pc, #0xec]  pool=-0x27214
00062b8e  ldr       r1, [pc, #0xf0]  pool=-0x48c9f
00062b90  mov.w     r2, #0x15c
00062b94  mov       r3, r4
00062b96  add       r0, pc
00062b98  add       r1, pc  ; "MI_AUDIO_Write"
00062b9a  b         #0x62c16
00062b9c  ldr       r0, [pc, #0xa8]  pool=0x53d72
00062b9e  add       r0, pc  ; "�� "
00062ba0  ldrb      r0, [r0]
00062ba2  cmp       r0, #0x20
00062ba4  blo       #0x62bb6
00062ba6  ldr       r0, [pc, #0xa4]  pool=-0x373ac
00062ba8  ldr       r1, [pc, #0xa4]  pool=-0x48cb7
00062baa  movw      r2, #0x147
00062bae  add       r0, pc
00062bb0  add       r1, pc  ; "MI_AUDIO_Write"
00062bb2  blx       #0xaf300
00062bb6  movs      r4, #4
00062bb8  b         #0x62bee
00062bba  ldr       r0, [pc, #0x98]  pool=0x53d54
00062bbc  add       r0, pc
00062bbe  ldrb      r0, [r0]
00062bc0  cmp       r0, #0x20
00062bc2  blo       #0x62bec
00062bc4  ldr       r0, [pc, #0x90]  pool=-0x4348f
00062bc6  ldr       r1, [pc, #0x94]  pool=-0x48cd5
00062bc8  mov.w     r2, #0x148
00062bcc  add       r0, pc
00062bce  add       r1, pc
00062bd0  b         #0x62be8
00062bd2  ldr       r0, [pc, #0x8c]  pool=0x53d3c
00062bd4  add       r0, pc
00062bd6  ldrb      r0, [r0]
00062bd8  cmp       r0, #0x20
00062bda  blo       #0x62bec
00062bdc  ldr       r0, [pc, #0x84]  pool=-0x48dd5
00062bde  ldr       r1, [pc, #0x88]  pool=-0x48ced
00062be0  movw      r2, #0x149
00062be4  add       r0, pc
00062be6  add       r1, pc
00062be8  blx       #0xaf300
00062bec  movs      r4, #8
00062bee  ldr       r0, [r7]
00062bf0  ldr       r1, [sp, #0x38]
00062bf2  subs      r0, r0, r1
00062bf4  bne       #0x62c3c
00062bf6  mov       r0, r4
00062bf8  add       sp, #0x3c
00062bfa  pop       {r4, r5, r6, r7, pc}
00062bfc  ldr       r0, [pc, #0x6c]  pool=0x53d12
00062bfe  add       r0, pc  ; "�� "
00062c00  ldrb      r0, [r0]
00062c02  cmp       r0, #0x20
00062c04  blo       #0x62bec
00062c06  ldr       r0, [pc, #0x68]  pool=-0x434a4
00062c08  ldr       r1, [pc, #0x68]  pool=-0x48d1b
00062c0a  movw      r2, #0x151
00062c0e  movs      r3, #8
00062c10  movs      r4, #8
00062c12  add       r0, pc
00062c14  add       r1, pc  ; "MI_AUDIO_Write"
00062c16  blx       #0xaf300
00062c1a  b         #0x62bee
00062c1c  ldr       r0, [sp, #0x30]
00062c1e  str       r0, [r5]
00062c20  ldr       r0, [pc, #0x60]  pool=0x53cee
00062c22  add       r0, pc  ; "�� "
00062c24  ldrb      r0, [r0]
00062c26  cmp       r0, #0x40
00062c28  blo       #0x62c38
00062c2a  ldr       r0, [pc, #0x5c]  pool=-0x2880c
00062c2c  movs      r1, #0
00062c2e  movs      r4, #0
00062c30  add       r0, pc
00062c32  blx       #0xaf300
00062c36  b         #0x62bee
00062c38  movs      r4, #0
00062c3a  b         #0x62bee
00062c3c  blx       #0xaf550

