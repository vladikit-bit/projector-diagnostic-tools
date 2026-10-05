===== libs/audio.primary.mt5889.so _Z15mi_decoder_openP16mstar_stream_outP12audio_config @ 0x2f408 size 0x39c =====
0002f408  push.w    {r4, r5, r6, r7, r8, sb, sl, fp, lr}
0002f40c  sub       sp, #0x34
0002f40e  mov       r6, r0
0002f410  ldr       r0, [pc, #0x2e8]  pool=0x10d6e
0002f412  movs      r4, #0
0002f414  mov       r7, r1
0002f416  add       r0, pc
0002f418  ldr.w     sb, [r0]
0002f41c  ldr.w     r0, [sb]
0002f420  str       r0, [sp, #0x30]
0002f422  movs      r0, #1
0002f424  strb.w    r4, [sp, #0x2c]
0002f428  strb.w    r4, [sp, #0x2b]
0002f42c  str       r0, [sp, #0x24]
0002f42e  ldr.w     sl, [r6, #0x170]
0002f432  mov       r0, r6
0002f434  ldr       r1, [pc, #0x2c8]  pool=-0x149ff
0002f436  add       r1, pc
0002f438  str       r1, [r0, #0xd0]!
0002f43c  movs      r1, #3
0002f43e  str       r1, [r0, #4]
0002f440  movs      r1, #5
0002f442  sub.w     fp, r0, #4
0002f446  str       r4, [r0, #8]
0002f448  str       r1, [sp, #0x20]
0002f44a  mov       r1, fp
0002f44c  blx       #0x3e0f0
0002f450  cbz       r0, #0x2f460
0002f452  str       r0, [sp]
0002f454  mov       r5, r0
0002f456  ldr       r1, [pc, #0x2ac]  pool=-0x17ddf
0002f458  ldr       r2, [pc, #0x2ac]  pool=-0x1457f
0002f45a  add       r1, pc
0002f45c  add       r2, pc  ; "%s: MI_AUDIO_Open failed, ret=0x%x !!"
0002f45e  b         #0x2f5ec
0002f460  ldr.w     r0, [sl, #0x174]
0002f464  ldr.w     r1, [fp]
0002f468  strb.w    r4, [sp, #0x2c]
0002f46c  cbz       r0, #0x2f492
0002f46e  add       r2, sp, #0x2c
0002f470  blx       #0x3e060
0002f474  cbz       r0, #0x2f4ac
0002f476  ldr.w     r1, [sl, #0x174]
0002f47a  ldr.w     r2, [fp]
0002f47e  ldr       r3, [pc, #0x290]  pool=-0x18d75
0002f480  add       r3, pc  ; "ALL"
0002f482  stm.w     sp, {r0, r1, r3}
0002f486  str       r2, [sp, #0xc]
0002f488  ldr       r1, [pc, #0x288]  pool=-0x17e11
0002f48a  ldr       r2, [pc, #0x28c]  pool=-0x13be7
0002f48c  add       r1, pc  ; "audio_hw_primary"
0002f48e  add       r2, pc
0002f490  b         #0x2f4a2
0002f492  ldr       r0, [pc, #0x288]  pool=-0x18d89
0002f494  add       r0, pc  ; "ALL"
0002f496  strd      r0, r1, [sp]
0002f49a  ldr       r1, [pc, #0x284]  pool=-0x17e23
0002f49c  ldr       r2, [pc, #0x284]  pool=-0x19f5f
0002f49e  add       r1, pc
0002f4a0  add       r2, pc  ; "%s: MI_AOUT handle is Null, MI_AOUT path=%s, MI_AUDIO handle"
0002f4a2  ldr       r3, [pc, #0x284]  pool=-0x14998
0002f4a4  movs      r0, #5
0002f4a6  add       r3, pc
0002f4a8  blx       #0x3d100
0002f4ac  movs      r0, #0
0002f4ae  mov       r8, r6
0002f4b0  str       r0, [r8, #0xdc]!
0002f4b4  ldr       r0, [r7, #8]
0002f4b6  cmp.w     r0, #0x9000000
0002f4ba  bge       #0x2f4e2
0002f4bc  movs      r1, #0xff
0002f4be  movt      r1, #0x400
0002f4c2  cmp       r0, r1
0002f4c4  bgt       #0x2f4fa
0002f4c6  add.w     r1, r0, #-0x4000000
0002f4ca  cmp       r1, #0x10
0002f4cc  bhi.w     #0x2f6da
0002f4d0  movs      r2, #1
0002f4d2  lsl.w     r1, r2, r1
0002f4d6  movs      r2, #5
0002f4d8  movt      r2, #1
0002f4dc  tst       r1, r2
0002f4de  bne       #0x2f514
0002f4e0  b         #0x2f6da
0002f4e2  cmp.w     r0, #0xb000000
0002f4e6  bge       #0x2f518
0002f4e8  movs      r1, #5
0002f4ea  add.w     r2, r0, #-0xa000000
0002f4ee  cmp       r2, #2
0002f4f0  blo       #0x2f52e
0002f4f2  cmp.w     r0, #0x9000000
0002f4f6  beq       #0x2f52e
0002f4f8  b         #0x2f6da
0002f4fa  movw      r1, #0x100
0002f4fe  movt      r1, #0x400
0002f502  cmp       r0, r1
0002f504  beq       #0x2f514
0002f506  cmp.w     r0, #0x5000000
0002f50a  beq       #0x2f514
0002f50c  cmp.w     r0, #0x6000000
0002f510  bne.w     #0x2f6da
0002f514  movs      r1, #7
0002f516  b         #0x2f52e
0002f518  beq       #0x2f528
0002f51a  cmp.w     r0, #0x22000000
0002f51e  beq       #0x2f52c
0002f520  cmp.w     r0, #0xc000000
0002f524  bne.w     #0x2f6da
0002f528  movs      r1, #9
0002f52a  b         #0x2f52e
0002f52c  movs      r1, #6
0002f52e  mov       r0, r6
0002f530  str.w     r1, [r6, #0xdc]
0002f534  blx       #0x3d4b0
0002f538  cmp       r0, #0
0002f53a  beq       #0x2f5ce
0002f53c  mov.w     r0, #0x3e8
0002f540  str       r0, [sp, #0x1c]
0002f542  movs      r0, #8
0002f544  str       r0, [sp, #0x18]
0002f546  mov.w     r0, #0x3f800000
0002f54a  str.w     r0, [r6, #0x308]
0002f54e  movs      r0, #0
0002f550  strb.w    r0, [sp, #0x17]
0002f554  ldr.w     r0, [r6, #0xcc]
0002f558  add       r1, sp, #0x18
0002f55a  blx       #0x3e100
0002f55e  vldr      s0, [r6, #0x308]
0002f562  ldr       r1, [sp, #0x1c]
0002f564  vcvt.f64.f32 d16, s0
0002f568  cbz       r0, #0x2f580
0002f56a  str       r1, [sp, #8]
0002f56c  vstr      d16, [sp]
0002f570  movs      r0, #6
0002f572  ldr       r1, [pc, #0x1d0]  pool=-0x17efd
0002f574  ldr       r2, [pc, #0x1d0]  pool=-0x17819
0002f576  ldr       r3, [pc, #0x1d4]  pool=-0x14a6e
0002f578  add       r1, pc  ; "audio_hw_primary"
0002f57a  add       r2, pc
0002f57c  add       r3, pc  ; "mi_decoder_open"
0002f57e  b         #0x2f594
0002f580  str       r1, [sp, #8]
0002f582  vstr      d16, [sp]
0002f586  movs      r0, #4
0002f588  ldr       r1, [pc, #0x1ac]  pool=-0x17f13
0002f58a  ldr       r2, [pc, #0x1b0]  pool=-0x1244e
0002f58c  ldr       r3, [pc, #0x1b0]  pool=-0x14a84
0002f58e  add       r1, pc
0002f590  add       r2, pc  ; "%s: set playbackrateActive: %f(%d) sucess !!"
0002f592  add       r3, pc
0002f594  blx       #0x3d100
0002f598  movs      r0, #1
0002f59a  add.w     r2, sp, #0x17
0002f59e  movw      r1, #0x606
0002f5a2  strb.w    r0, [sp, #0x17]
0002f5a6  ldr.w     r0, [fp]
0002f5aa  blx       #0x3dfb0
0002f5ae  ldr       r1, [pc, #0x1a0]  pool=-0x17f35
0002f5b0  add       r1, pc  ; "audio_hw_primary"
0002f5b2  cbz       r0, #0x2f5c0
0002f5b4  ldr       r2, [pc, #0x1a4]  pool=-0x11b56
0002f5b6  ldr       r3, [pc, #0x1a8]  pool=-0x14aae
0002f5b8  movs      r0, #6
0002f5ba  add       r2, pc
0002f5bc  add       r3, pc  ; "mi_decoder_open"
0002f5be  b         #0x2f5ca
0002f5c0  ldr       r2, [pc, #0x190]  pool=-0x18f63
0002f5c2  ldr       r3, [pc, #0x194]  pool=-0x14aba
0002f5c4  movs      r0, #4
0002f5c6  add       r2, pc
0002f5c8  add       r3, pc  ; "mi_decoder_open"
0002f5ca  blx       #0x3d100
0002f5ce  ldr.w     r0, [fp]
0002f5d2  mov       r1, r8
0002f5d4  blx       #0x3e110
0002f5d8  cbz       r0, #0x2f608
0002f5da  mov       r5, r0
0002f5dc  ldr.w     r0, [fp]
0002f5e0  strd      r0, r5, [sp]
0002f5e4  ldr       r1, [pc, #0x17c]  pool=-0x17f6d
0002f5e6  ldr       r2, [pc, #0x180]  pool=-0x11467
0002f5e8  add       r1, pc  ; "audio_hw_primary"
0002f5ea  add       r2, pc
0002f5ec  ldr       r3, [pc, #0x11c]  pool=-0x14ae2
0002f5ee  movs      r0, #5
0002f5f0  add       r3, pc  ; "mi_decoder_open"
0002f5f2  blx       #0x3d100
0002f5f6  ldr.w     r0, [sb]
0002f5fa  ldr       r1, [sp, #0x30]
0002f5fc  subs      r0, r0, r1
0002f5fe  bne       #0x2f6f8
0002f600  mov       r0, r5
0002f602  add       sp, #0x34
0002f604  pop.w     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
0002f608  mov       r0, r6
0002f60a  blx       #0x3d490
0002f60e  cmp       r0, #0
0002f610  beq       #0x2f69e
0002f612  movw      r0, #0x3c94
0002f616  ldr.w     r0, [sl, r0]
0002f61a  cmp       r0, #1
0002f61c  bne       #0x2f628
0002f61e  movs      r0, #2
0002f620  str       r0, [sp, #0x24]
0002f622  movs      r0, #1
0002f624  strb.w    r0, [sp, #0x2b]
0002f628  ldr.w     r0, [fp]
0002f62c  add.w     r2, sp, #0x2b
0002f630  mov.w     r1, #0x204
0002f634  blx       #0x3dfb0
0002f638  cbz       r0, #0x2f652
0002f63a  ldrb.w    r0, [sp, #0x2b]
0002f63e  str       r0, [sp]
0002f640  movs      r0, #5
0002f642  ldr       r1, [pc, #0x128]  pool=-0x17fcd
0002f644  ldr       r2, [pc, #0x128]  pool=-0x14b2c
0002f646  ldr       r3, [pc, #0x12c]  pool=-0x14b3e
0002f648  add       r1, pc  ; "audio_hw_primary"
0002f64a  add       r2, pc
0002f64c  add       r3, pc  ; "mi_decoder_open"
0002f64e  blx       #0x3d100
0002f652  ldr.w     r0, [fp]
0002f656  add       r2, sp, #0x20
0002f658  movw      r1, #0x205
0002f65c  blx       #0x3dfb0
0002f660  cbz       r0, #0x2f678
0002f662  ldr       r0, [sp, #0x20]
0002f664  str       r0, [sp]
0002f666  movs      r0, #5
0002f668  ldr       r1, [pc, #0x10c]  pool=-0x17ff3
0002f66a  ldr       r2, [pc, #0x110]  pool=-0x14315
0002f66c  ldr       r3, [pc, #0x110]  pool=-0x14b64
0002f66e  add       r1, pc
0002f670  add       r2, pc  ; "%s: set pts gap fade threshold failed, threshold %u"
0002f672  add       r3, pc
0002f674  blx       #0x3d100
0002f678  ldr.w     r0, [fp]
0002f67c  add       r2, sp, #0x24
0002f67e  movw      r1, #0x607
0002f682  blx       #0x3dfb0
0002f686  cbz       r0, #0x2f69e
0002f688  ldr       r0, [sp, #0x24]
0002f68a  str       r0, [sp]
0002f68c  movs      r0, #5
0002f68e  ldr       r1, [pc, #0xf4]  pool=-0x18019
0002f690  ldr       r2, [pc, #0xf4]  pool=-0x1823d
0002f692  ldr       r3, [pc, #0xf8]  pool=-0x14b8a
0002f694  add       r1, pc  ; "audio_hw_primary"
0002f696  add       r2, pc
0002f698  add       r3, pc  ; "mi_decoder_open"
0002f69a  blx       #0x3d100
0002f69e  ldrb.w    r2, [sp, #0x2b]
0002f6a2  ldr.w     r0, [r8]
0002f6a6  ldr.w     r1, [fp]
0002f6aa  ldrd      r3, r7, [sp, #0x20]
0002f6ae  ldr       r4, [pc, #0xe0]  pool=-0x1a69c
0002f6b0  ldr       r5, [pc, #0xe0]  pool=-0x1326b
0002f6b2  add       r5, pc
0002f6b4  add       r4, pc  ; "disable"
0002f6b6  cmp       r2, #0
0002f6b8  it        eq
0002f6ba  moveq     r5, r4
0002f6bc  stm.w     sp, {r0, r1, r5}
0002f6c0  strd      r3, r7, [sp, #0xc]
0002f6c4  movs      r0, #4
0002f6c6  ldr       r1, [pc, #0xd0]  pool=-0x18051
0002f6c8  ldr       r2, [pc, #0xd0]  pool=-0x1a58f
0002f6ca  ldr       r3, [pc, #0xd4]  pool=-0x14bc2
0002f6cc  add       r1, pc  ; "audio_hw_primary"
0002f6ce  add       r2, pc
0002f6d0  add       r3, pc  ; "mi_decoder_open"
0002f6d2  blx       #0x3d100
0002f6d6  movs      r5, #0
0002f6d8  b         #0x2f5f6
0002f6da  str       r0, [sp]
0002f6dc  movs      r0, #6
0002f6de  ldr       r1, [pc, #0x4c]  pool=-0x18069
0002f6e0  ldr       r2, [pc, #0x4c]  pool=-0x174ed
0002f6e2  ldr       r3, [pc, #0x50]  pool=-0x14bda
0002f6e4  add       r1, pc  ; "audio_hw_primary"
0002f6e6  add       r2, pc
0002f6e8  add       r3, pc  ; "mi_decoder_open"
0002f6ea  blx       #0x3d100
0002f6ee  movs      r0, #0
0002f6f0  movs      r5, #3
0002f6f2  str.w     r0, [r8]
0002f6f6  b         #0x2f5f6
0002f6f8  blx       #0x3d210
0002f6fc  lsrs      r6, r5, #0x15
0002f6fe  movs      r1, r0

