===== kmods/utpa2k.ko MApi_AUDIO_GetAudioInfo2 sec_off=0x3fd0b0 size=0x11c mode=A =====
003fd0b0  push      {r4, r5, fp, lr}
003fd0b4  sub       sp, sp, #0x18
003fd0b8  movw      r4, #0  rel→__stack_chk_guard
003fd0bc  movw      r5, #0  rel→_pInstantAudio
003fd0c0  movt      r4, #0  rel→__stack_chk_guard
003fd0c4  movt      r5, #0  rel→_pInstantAudio
003fd0c8  ldr       r3, [r4]
003fd0cc  str       r3, [sp, #0x14]
003fd0d0  mov       r3, #0
003fd0d4  str       r3, [sp, #0xc]
003fd0d8  str       r3, [sp, #8]
003fd0dc  strb      r3, [sp, #0x10]
003fd0e0  str       r3, [sp, #4]
003fd0e4  str       r3, [sp]
003fd0e8  str       r0, [sp, #1]
003fd0ec  ldr       r0, [r5]
003fd0f0  str       r2, [sp, #9]
003fd0f4  cmp       r0, #0
003fd0f8  str       r1, [sp, #5]
003fd0fc  bne       #0x3fd148
003fd100  movw      r1, #0  rel→_pInstantAudio
003fd104  mov       r0, #0x80000034
003fd108  movt      r1, #0  rel→_pInstantAudio
003fd10c  mov       r2, #0
003fd110  mov       r3, #0
003fd114  bl        #0x3fd114  rel→UtopiaOpen; CALL UtopiaOpen
003fd118  cmp       r0, #0
003fd11c  beq       #0x3fd148
003fd120  movw      r0, #0  rel→.L.str
003fd124  movt      r0, #0  rel→.L.str
003fd128  bl        #0x3fd128  rel→UtopiaLogSystem; CALL UtopiaLogSystem
003fd12c  cmp       r0, #1
003fd130  beq       #0x3fd1a4
003fd134  movw      r0, #0  rel→.L.str
003fd138  movt      r0, #0  rel→.L.str
003fd13c  bl        #0x3fd13c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
003fd140  cmp       r0, #1
003fd144  beq       #0x3fd1b8
003fd148  ldr       r0, [r5]
003fd14c  mov       r2, sp
003fd150  mov       r1, #0xcf
003fd154  bl        #0x3fd154  rel→UtopiaIoctl; CALL UtopiaIoctl
003fd158  cmp       r0, #0
003fd15c  beq       #0x3fd174
003fd160  movw      r0, #0  rel→.L.str
003fd164  movt      r0, #0  rel→.L.str
003fd168  bl        #0x3fd168  rel→UtopiaLogSystem; CALL UtopiaLogSystem
003fd16c  cmp       r0, #1
003fd170  beq       #0x3fd190
003fd174  ldrb      r0, [sp]
003fd178  ldr       r1, [r4]
003fd17c  ldr       r2, [sp, #0x14]
003fd180  subs      r1, r1, r2
003fd184  addeq     sp, sp, #0x18
003fd188  popeq     {r4, r5, fp, pc}
003fd18c  bl        #0x3fd18c  rel→__stack_chk_fail; CALL __stack_chk_fail
003fd190  movw      r0, #0  rel→.L.str.248
003fd194  movw      r1, #0x1cc7
003fd198  movt      r0, #0  rel→.L.str.248
003fd19c  bl        #0x3fd19c  rel→printk; CALL printk
003fd1a0  b         #0x3fd174
003fd1a4  movw      r0, #0  rel→.L.str.274
003fd1a8  mov       r1, #0xa6
003fd1ac  movt      r0, #0  rel→.L.str.274
003fd1b0  bl        #0x3fd1b0  rel→printk; CALL printk
003fd1b4  b         #0x3fd134
003fd1b8  movw      r0, #0  rel→.L.str.248
003fd1bc  movw      r1, #0x1cc1
003fd1c0  movt      r0, #0  rel→.L.str.248
003fd1c4  bl        #0x3fd1c4  rel→printk; CALL printk
003fd1c8  b         #0x3fd148
