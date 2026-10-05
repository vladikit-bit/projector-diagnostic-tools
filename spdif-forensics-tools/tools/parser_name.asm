===== libs/audio.primary.mt5889.so _Z27utils_get_audio_parser_name14audio_format_t @ 0x28258 size 0x74 =====
00028258  and       r1, r0, #0xff000000
0002825c  cmp.w     r1, #0xa000000
00028260  bge       #0x28276
00028262  cmp.w     r1, #0x6000000
00028266  bge       #0x2828e
00028268  cmp.w     r1, #0x4000000
0002826c  beq       #0x2829c
0002826e  cmp.w     r1, #0x5000000
00028272  beq       #0x2829c
00028274  b         #0x282b0
00028276  ldr       r0, [pc, #0x48]  pool=-0xe8da
00028278  cmp.w     r1, #0xc000000
0002827c  add       r0, pc  ; "dts"
0002827e  bge       #0x282a2
00028280  cmp.w     r1, #0xa000000
00028284  beq       #0x28296
00028286  cmp.w     r1, #0xb000000
0002828a  bne       #0x282b0
0002828c  bx        lr
0002828e  beq       #0x2829c
00028290  cmp.w     r1, #0x9000000
00028294  bne       #0x282b0
00028296  ldr       r0, [pc, #0x24]  pool=-0xa993
00028298  add       r0, pc  ; "ac3"
0002829a  bx        lr
0002829c  ldr       r0, [pc, #0x18]  pool=-0x11d7e
0002829e  add       r0, pc
000282a0  bx        lr
000282a2  beq       #0x2828c
000282a4  cmp.w     r1, #0x22000000
000282a8  bne       #0x282b0
000282aa  ldr       r0, [pc, #0x1c]  pool=-0xae16
000282ac  add       r0, pc  ; "ac4"
000282ae  bx        lr
000282b0  ldr       r0, [pc, #0x10]  pool=-0xf355
000282b2  add       r0, pc
000282b4  bx        lr
000282b6  nop       
000282b8  b         #0x287c0

