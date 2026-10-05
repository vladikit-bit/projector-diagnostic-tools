===== libs/libmi3.so MI_AUDIO_SetCodecParams @ 0x63004 size 0xd0 =====
00063004  push      {r4, r5, r6, lr}
00063006  sub       sp, #0x90
00063008  ldr       r2, [pc, #0xa0]  pool=0x4f502
0006300a  add       r2, pc
0006300c  ldr       r6, [r2]
0006300e  ldr       r2, [r6]
00063010  str       r2, [sp, #0x8c]
00063012  ldr       r2, [pc, #0x9c]  pool=0x53904
00063014  add       r2, pc
00063016  ldr       r4, [r2]
00063018  cmp.w     r4, #-1
0006301c  ble       #0x6302a
0006301e  cbz       r1, #0x63048
00063020  ldr       r2, [r1]
00063022  cmp       r2, #2
00063024  bne       #0x63066
00063026  movs      r4, #5
00063028  b         #0x63098
0006302a  ldr       r0, [pc, #0x88]  pool=0x538e4
0006302c  add       r0, pc
0006302e  ldrb      r0, [r0]
00063030  cmp       r0, #0x20
00063032  blo       #0x63044
00063034  ldr       r0, [pc, #0x80]  pool=-0x3783a
00063036  ldr       r1, [pc, #0x84]  pool=-0x39e54
00063038  mov.w     r2, #0x1a0
0006303c  add       r0, pc
0006303e  add       r1, pc
00063040  blx       #0xaf300
00063044  movs      r4, #4
00063046  b         #0x63098
00063048  ldr       r0, [pc, #0x74]  pool=0x538c6
0006304a  add       r0, pc  ; "�� "
0006304c  ldrb      r0, [r0]
0006304e  cmp       r0, #0x20
00063050  blo       #0x63062
00063052  ldr       r0, [pc, #0x70]  pool=-0x236ef
00063054  ldr       r1, [pc, #0x70]  pool=-0x39e72
00063056  movw      r2, #0x1a1
0006305a  add       r0, pc
0006305c  add       r1, pc  ; "MI_AUDIO_SetCodecParams"
0006305e  blx       #0xaf300
00063062  movs      r4, #8
00063064  b         #0x63098
00063066  mov       r5, sp
00063068  str       r0, [sp]
0006306a  movs      r2, #0x88
0006306c  adds      r0, r5, #4
0006306e  blx       #0xaf620
00063072  movw      r1, #0x100c
00063076  mov       r0, r4
00063078  mov       r2, r5
0006307a  movt      r1, #0xc08c
0006307e  blx       #0xaffe0
00063082  mov       r4, r0
00063084  ldr       r0, [pc, #0x44]  pool=0x5388a
00063086  add       r0, pc  ; "�� "
00063088  ldrb      r0, [r0]
0006308a  cmp       r0, #0x40
0006308c  blo       #0x63098
0006308e  ldr       r0, [pc, #0x40]  pool=-0x3c880
00063090  mov       r1, r4
00063092  add       r0, pc
00063094  blx       #0xaf300
00063098  ldr       r0, [r6]
0006309a  ldr       r1, [sp, #0x8c]
0006309c  subs      r0, r0, r1
0006309e  bne       #0x630a6
000630a0  mov       r0, r4
000630a2  add       sp, #0x90
000630a4  pop       {r4, r5, r6, pc}
000630a6  blx       #0xaf550
000630aa  nop       
000630ac  add.w     r0, r2, #0x840000
000630b0  subs      r1, #4
000630b2  movs      r5, r0
000630b4  subs      r0, #0xe4
000630b6  movs      r5, r0
000630b8  strh      r6, [r0, #0x3e]

