===== libs/audio.primary.mt5889.so _Z31utils_ApplyDigitalOutputSettingP18mstar_audio_deviceP14audio_format_t @ 0x28684 size 0xbd8 =====
00028684  push.w    {r4, r5, r6, r7, r8, sb, sl, fp, lr}
00028688  sub       sp, #0xa4
0002868a  mov       sb, r0
0002868c  ldr       r0, [pc, #0x3b0]  pool=0x17aec
0002868e  mov       r2, r1
00028690  vmov.i32  q8, #0
00028694  add.w     sl, sp, #0x20
00028698  add       r0, pc
0002869a  ldr.w     r8, [r0]
0002869e  ldr.w     r0, [r8]
000286a2  str       r0, [sp, #0xa0]
000286a4  add       r1, sp, #0x60
000286a6  add.w     r0, r1, #0x20
000286aa  vst1.64   {d16, d17}, [r0]
000286ae  add.w     r0, r1, #0x10
000286b2  vst1.64   {d16, d17}, [r0]
000286b6  movs      r0, #0x30
000286b8  vst1.64   {d16, d17}, [r1], r0
000286bc  cmp.w     sb, #0
000286c0  vst1.64   {d16, d17}, [r1]
000286c4  add.w     r1, sl, #0x20
000286c8  vst1.64   {d16, d17}, [r1]
000286cc  add.w     r1, sl, #0x10
000286d0  vst1.64   {d16, d17}, [r1]
000286d4  mov       r1, sl
000286d6  vst1.64   {d16, d17}, [r1], r0
000286da  vst1.64   {d16, d17}, [r1]
000286de  beq       #0x287a6
000286e0  movw      r0, #0x3584
000286e4  str       r2, [sp, #0x1c]
000286e6  add.w     r6, sb, r0
000286ea  movw      r0, #0x35c8
000286ee  add.w     fp, sb, r0
000286f2  mov       r0, fp
000286f4  blx       #0x3d110
000286f8  ldrb.w    r0, [r6, #0x50]
000286fc  cmp       r0, #0
000286fe  beq.w     #0x28806
00028702  ldr       r0, [r6, #0x48]
00028704  cbz       r0, #0x28710
00028706  ldrb.w    r1, [r6, #0x94]
0002870a  cmp       r1, #0
0002870c  beq.w     #0x28b00
00028710  movs      r0, #0
00028712  movs      r1, #0x40
00028714  movs      r2, #0x40
00028716  movs      r4, #0x40
00028718  str       r0, [r6, #0x78]
0002871a  add       r0, sp, #0x60
0002871c  ldr       r7, [pc, #0x324]  pool=-0x11835
0002871e  add       r7, pc
00028720  mov       r3, r7
00028722  bl        #0x25150
00028726  cmp       r0, #0x40
00028728  blo       #0x28748
0002872a  movw      r1, #0x2ad
0002872e  strd      r1, r7, [sp]
00028732  strd      r0, r4, [sp, #8]
00028736  movs      r0, #5
00028738  ldr       r1, [pc, #0x30c]  pool=-0x110c3
0002873a  ldr       r2, [pc, #0x310]  pool=-0xf427
0002873c  ldr       r3, [pc, #0x310]  pool=-0xb2a8
0002873e  add       r1, pc
00028740  add       r2, pc  ; "%s: line %d snprintf '%s' failed, ret %d, length %d"
00028742  add       r3, pc
00028744  blx       #0x3d100
00028748  add       r0, sp, #0x20
0002874a  ldr       r7, [pc, #0x308]  pool=-0xc240
0002874c  movs      r1, #0x40
0002874e  movs      r2, #0x40
00028750  movs      r4, #0x40
00028752  add       r7, pc
00028754  mov       r3, r7
00028756  bl        #0x25150
0002875a  cmp       r0, #0x40
0002875c  blo       #0x2877c
0002875e  movw      r1, #0x2ae
00028762  strd      r1, r7, [sp]
00028766  strd      r0, r4, [sp, #8]
0002876a  movs      r0, #5
0002876c  ldr       r1, [pc, #0x2e8]  pool=-0x110f7
0002876e  ldr       r2, [pc, #0x2ec]  pool=-0xf45b
00028770  ldr       r3, [pc, #0x2ec]  pool=-0xb2dc
00028772  add       r1, pc
00028774  add       r2, pc  ; "%s: line %d snprintf '%s' failed, ret %d, length %d"
00028776  add       r3, pc
00028778  blx       #0x3d100
0002877c  ldr       r3, [r6]
0002877e  ldr       r0, [r6, #0x4c]
00028780  str       r0, [r6, #0x7c]
00028782  cbz       r3, #0x28796
00028784  add       r2, sp, #0x20
00028786  mov       r0, sb
00028788  movs      r1, #3
0002878a  blx       r3
0002878c  ldr       r3, [r6]
0002878e  add       r2, sp, #0x60
00028790  mov       r0, sb
00028792  movs      r1, #3
00028794  blx       r3
00028796  ldr       r1, [r6, #0x48]
00028798  ldr       r0, [pc, #0x2c8]  pool=0x17320; ; "ms, request sleep time %d, bytes_written %d, bytes %d"
0002879a  cmp       r1, #3
0002879c  add       r0, pc
0002879e  bhi       #0x287be
000287a0  ldr.w     r5, [r0, r1, lsl #2]
000287a4  b         #0x287c2
000287a6  ldr       r1, [pc, #0x2c0]  pool=-0x11133
000287a8  ldr       r2, [pc, #0x2c0]  pool=-0xf351
000287aa  ldr       r3, [pc, #0x2c4]  pool=-0xb318
000287ac  movs      r0, #6
000287ae  add       r1, pc
000287b0  add       r2, pc  ; "%s: adev should not be NULL !!"
000287b2  add       r3, pc
000287b4  blx       #0x3d100
000287b8  mvn       r0, #0x15
000287bc  b         #0x28a2e
000287be  ldr       r5, [pc, #0x2b4]  pool=-0xa2c5
000287c0  add       r5, pc  ; "un-know"
000287c2  ldr       r1, [r6, #0x78]
000287c4  cmp       r1, #3
000287c6  bhi       #0x287ce
000287c8  ldr.w     r4, [r0, r1, lsl #2]
000287cc  b         #0x287d2
000287ce  ldr       r4, [pc, #0x2a8]  pool=-0xa2d5
000287d0  add       r4, pc  ; "un-know"
000287d2  ldr       r0, [r6, #0x4c]
000287d4  blx       #0x3d460
000287d8  mov       r7, r0
000287da  ldr       r0, [r6, #0x7c]
000287dc  blx       #0x3d460
000287e0  strd      r5, r4, [sp]
000287e4  strd      r7, r0, [sp, #8]
000287e8  add       r0, sp, #0x60
000287ea  strd      r0, sl, [sp, #0x10]
000287ee  movs      r0, #4
000287f0  ldr       r1, [pc, #0x288]  pool=-0x1117b
000287f2  ldr       r2, [pc, #0x28c]  pool=-0xa89b
000287f4  ldr       r3, [pc, #0x28c]  pool=-0xb360
000287f6  add       r1, pc
000287f8  add       r2, pc  ; "%s: hdmi arc mode = ui(%s), current(%s); hdmi arc type = ui("
000287fa  add       r3, pc
000287fc  blx       #0x3d100
00028800  movs      r0, #0
00028802  strb.w    r0, [r6, #0x50]
00028806  mov       r0, fp
00028808  blx       #0x3d130
0002880c  movw      r0, #0x35d8
00028810  add.w     fp, sb, r0
00028814  mov       r0, fp
00028816  blx       #0x3d110
0002881a  ldrb.w    r0, [r6, #0x60]
0002881e  cmp       r0, #0
00028820  beq       #0x2891a
00028822  ldr       r0, [r6, #0x58]
00028824  cbz       r0, #0x28830
00028826  ldrb.w    r1, [r6, #0x94]
0002882a  cmp       r1, #0
0002882c  beq.w     #0x28b84
00028830  movs      r0, #0
00028832  movs      r1, #0x40
00028834  movs      r2, #0x40
00028836  movs      r4, #0x40
00028838  str.w     r0, [r6, #0x88]
0002883c  add       r0, sp, #0x60
0002883e  ldr       r7, [pc, #0x248]  pool=-0xee81
00028840  add       r7, pc  ; "SetHdmiTxOutputMode=PCM"
00028842  mov       r3, r7
00028844  bl        #0x25150
00028848  cmp       r0, #0x40
0002884a  blo       #0x2886a
0002884c  mov.w     r1, #0x2f4
00028850  strd      r1, r7, [sp]
00028854  strd      r0, r4, [sp, #8]
00028858  movs      r0, #5
0002885a  ldr       r1, [pc, #0x230]  pool=-0x111e5
0002885c  ldr       r2, [pc, #0x230]  pool=-0xf549
0002885e  ldr       r3, [pc, #0x234]  pool=-0xb3ca
00028860  add       r1, pc  ; "audio_hw_primary"
00028862  add       r2, pc
00028864  add       r3, pc  ; "utils_ApplyDigitalOutputSetting"
00028866  blx       #0x3d100
0002886a  add       r0, sp, #0x20
0002886c  ldr       r7, [pc, #0x228]  pool=-0xe382
0002886e  movs      r1, #0x40
00028870  movs      r2, #0x40
00028872  movs      r4, #0x40
00028874  add       r7, pc  ; "SetHdmiTxOutputType=NONE"
00028876  mov       r3, r7
00028878  bl        #0x25150
0002887c  cmp       r0, #0x40
0002887e  blo       #0x2889e
00028880  movw      r1, #0x2f5
00028884  strd      r1, r7, [sp]
00028888  strd      r0, r4, [sp, #8]
0002888c  movs      r0, #5
0002888e  ldr       r1, [pc, #0x20c]  pool=-0x11219
00028890  ldr       r2, [pc, #0x20c]  pool=-0xf57d
00028892  ldr       r3, [pc, #0x210]  pool=-0xb3fe
00028894  add       r1, pc  ; "audio_hw_primary"
00028896  add       r2, pc
00028898  add       r3, pc  ; "utils_ApplyDigitalOutputSetting"
0002889a  blx       #0x3d100
0002889e  ldr       r3, [r6]
000288a0  ldr       r0, [r6, #0x5c]
000288a2  str.w     r0, [r6, #0x8c]
000288a6  cbz       r3, #0x288ba
000288a8  add       r2, sp, #0x20
000288aa  mov       r0, sb
000288ac  movs      r1, #3
000288ae  blx       r3
000288b0  ldr       r3, [r6]
000288b2  add       r2, sp, #0x60
000288b4  mov       r0, sb
000288b6  movs      r1, #3
000288b8  blx       r3
000288ba  ldr       r0, [r6, #0x58]
000288bc  cmp       r0, #3
000288be  bhi       #0x288ca
000288c0  ldr       r1, [pc, #0x1e4]  pool=0x171fa; ; "annels"
000288c2  add       r1, pc
000288c4  ldr.w     r5, [r1, r0, lsl #2]
000288c8  b         #0x288ce
000288ca  ldr       r5, [pc, #0x1e0]  pool=-0xa3d1
000288cc  add       r5, pc  ; "un-know"
000288ce  ldr.w     r0, [r6, #0x88]
000288d2  cmp       r0, #3
000288d4  bhi       #0x288e0
000288d6  ldr       r1, [pc, #0x1d8]  pool=0x171e4; ; " sound_type(%s)"
000288d8  add       r1, pc
000288da  ldr.w     r4, [r1, r0, lsl #2]
000288de  b         #0x288e4
000288e0  ldr       r4, [pc, #0x1d0]  pool=-0xa3e7
000288e2  add       r4, pc
000288e4  ldr       r0, [r6, #0x5c]
000288e6  blx       #0x3d460
000288ea  mov       r7, r0
000288ec  ldr.w     r0, [r6, #0x8c]
000288f0  blx       #0x3d460
000288f4  strd      r5, r4, [sp]
000288f8  strd      r7, r0, [sp, #8]
000288fc  add       r0, sp, #0x60
000288fe  strd      r0, sl, [sp, #0x10]
00028902  movs      r0, #4
00028904  ldr       r1, [pc, #0x1b0]  pool=-0x1128f
00028906  ldr       r2, [pc, #0x1b4]  pool=-0xdfbe
00028908  ldr       r3, [pc, #0x1b4]  pool=-0xb474
0002890a  add       r1, pc
0002890c  add       r2, pc  ; "%s: hdmi tx mode  = ui(%s), current(%s); hdmi tx type  = ui("
0002890e  add       r3, pc
00028910  blx       #0x3d100
00028914  movs      r0, #0
00028916  strb.w    r0, [r6, #0x60]
0002891a  mov       r0, fp
0002891c  blx       #0x3d130
00028920  movw      r0, #0x35b8
00028924  add.w     fp, sb, r0
00028928  mov       r0, fp
0002892a  blx       #0x3d110
0002892e  ldrb.w    r0, [r6, #0x40]
00028932  cmp       r0, #0
00028934  beq       #0x28a26
00028936  ldr       r0, [r6, #0x38]
00028938  cbz       r0, #0x28944
0002893a  ldrb.w    r1, [r6, #0x94]
0002893e  cmp       r1, #0
00028940  beq.w     #0x28c0a
00028944  movs      r0, #0
00028946  movs      r1, #0x40
00028948  movs      r2, #0x40
0002894a  movs      r4, #0x40
0002894c  str       r0, [r6, #0x68]
0002894e  add       r0, sp, #0x60
00028950  ldr       r5, [pc, #0x170]  pool=-0xf9ed
00028952  add       r5, pc
00028954  mov       r3, r5
00028956  bl        #0x25150
0002895a  cmp       r0, #0x40
0002895c  blo       #0x2897c
0002895e  mov.w     r1, #0x330
00028962  strd      r1, r5, [sp]
00028966  strd      r0, r4, [sp, #8]
0002896a  movs      r0, #5
0002896c  ldr       r1, [pc, #0x158]  pool=-0x112f7
0002896e  ldr       r2, [pc, #0x15c]  pool=-0xf65b
00028970  ldr       r3, [pc, #0x15c]  pool=-0xb4dc
00028972  add       r1, pc
00028974  add       r2, pc  ; "%s: line %d snprintf '%s' failed, ret %d, length %d"
00028976  add       r3, pc
00028978  blx       #0x3d100
0002897c  add       r0, sp, #0x20
0002897e  ldr       r5, [pc, #0x154]  pool=-0x12ac8
00028980  movs      r1, #0x40
00028982  movs      r2, #0x40
00028984  movs      r4, #0x40
00028986  add       r5, pc
00028988  mov       r3, r5
0002898a  bl        #0x25150
0002898e  cmp       r0, #0x40
00028990  blo       #0x289b0
00028992  movw      r1, #0x331
00028996  strd      r1, r5, [sp]
0002899a  strd      r0, r4, [sp, #8]
0002899e  movs      r0, #5
000289a0  ldr       r1, [pc, #0x134]  pool=-0x1132b
000289a2  ldr       r2, [pc, #0x138]  pool=-0xf68f
000289a4  ldr       r3, [pc, #0x138]  pool=-0xb510
000289a6  add       r1, pc
000289a8  add       r2, pc  ; "%s: line %d snprintf '%s' failed, ret %d, length %d"
000289aa  add       r3, pc
000289ac  blx       #0x3d100
000289b0  ldr       r3, [r6]
000289b2  ldr       r0, [r6, #0x3c]
000289b4  str       r0, [r6, #0x6c]
000289b6  cbz       r3, #0x289ca
000289b8  add       r2, sp, #0x20
000289ba  mov       r0, sb
000289bc  movs      r1, #3
000289be  blx       r3
000289c0  ldr       r3, [r6]
000289c2  add       r2, sp, #0x60
000289c4  mov       r0, sb
000289c6  movs      r1, #3
000289c8  blx       r3
000289ca  ldr       r0, [r6, #0x38]
000289cc  cmp       r0, #3
000289ce  bhi       #0x289da
000289d0  ldr       r1, [pc, #0x110]  pool=0x170ea; ; "er level, ret 0x%x"
000289d2  add       r1, pc
000289d4  ldr.w     r5, [r1, r0, lsl #2]
000289d8  b         #0x289de
000289da  ldr       r5, [pc, #0x10c]  pool=-0xa4e1
000289dc  add       r5, pc  ; "un-know"
000289de  ldr       r0, [r6, #0x68]
000289e0  cmp       r0, #3
000289e2  bhi       #0x289ee
000289e4  ldr       r1, [pc, #0x104]  pool=0x170d6; ; "%s: can not get buffer level, ret 0x%x"
000289e6  add       r1, pc
000289e8  ldr.w     r7, [r1, r0, lsl #2]
000289ec  b         #0x289f2
000289ee  ldr       r7, [pc, #0x100]  pool=-0xa4f5
000289f0  add       r7, pc  ; "un-know"
000289f2  ldr       r0, [r6, #0x3c]
000289f4  blx       #0x3d460
000289f8  mov       r4, r0
000289fa  ldr       r0, [r6, #0x6c]
000289fc  blx       #0x3d460
00028a00  strd      r5, r7, [sp]
00028a04  strd      r4, r0, [sp, #8]
00028a08  add       r0, sp, #0x60
00028a0a  strd      r0, sl, [sp, #0x10]
00028a0e  movs      r0, #4
00028a10  ldr       r1, [pc, #0xe0]  pool=-0x1139b
00028a12  ldr       r2, [pc, #0xe4]  pool=-0xf59a
00028a14  ldr       r3, [pc, #0xe4]  pool=-0xb580
00028a16  add       r1, pc
00028a18  add       r2, pc  ; "%s: spdif mode    = ui(%s), current(%s); spdif type    = ui("
00028a1a  add       r3, pc
00028a1c  blx       #0x3d100
00028a20  movs      r0, #0
00028a22  strb.w    r0, [r6, #0x40]
00028a26  mov       r0, fp
00028a28  blx       #0x3d130
00028a2c  movs      r0, #0
00028a2e  ldr.w     r1, [r8]
00028a32  ldr       r2, [sp, #0xa0]
00028a34  subs      r1, r1, r2
00028a36  bne.w     #0x291e4
00028a3a  add       sp, #0xa4
00028a3c  pop.w     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
00028a40  ldrb      r4, [r5, #0xb]
00028a42  movs      r1, r0
00028a44  b         #0x289de
00028a46  vcvt.u32.f32 d30, d29, #2

