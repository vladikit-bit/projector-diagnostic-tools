0x020150: push.w     {r4, r5, r6, r7, r8, sb, sl, fp, lr}
0x020154: sub        sp, #0xc
0x020156: mov        r6, r0
0x020158: ldr        r0, [pc, #0x334]
0x02015a: mov        sl, r2
0x02015c: mov        r4, r1
0x02015e: add        r0, pc
0x020160: ldr.w      r8, [r0]
0x020164: ldr.w      r0, [r8]
0x020168: str        r0, [sp, #8]
0x02016a: movs       r0, #0
0x02016c: blx        #0x3d140
0x020170: ldr        r1, [pc, #0x320]
0x020172: mov        r0, r4
0x020174: add        r1, pc
0x020176: blx        #0x3d150
0x02017a: cbz        r0, #0x20183
0x02017c: mvn        r4, #0x15
0x020180: b          #0x20467
0x020182: ldr        r1, [pc, #0x314]
0x020184: ldr        r2, [pc, #0x314]
0x020186: ldr        r3, [pc, #0x318]
0x020188: movs       r0, #4
0x02018a: add        r1, pc
0x02018c: add        r2, pc
0x02018e: add        r3, pc
0x020190: blx        #0x3d100
0x020194: movs       r0, #1
0x020196: movw       r1, #0x3ca0
0x02019a: mov.w      sb, #1
0x02019e: blx        #0x3d160
0x0201a2: cmp        r0, #0
0x0201a4: beq.w      #0x202fb
0x0201a8: mov        r4, r0
0x0201aa: movw       r0, #0x3584
0x0201ae: adds       r7, r4, r0
0x0201b0: mov        r0, r4
0x0201b2: blx        #0x3d170
0x0201b6: ldr        r0, [pc, #0x2ec]
0x0201b8: movw       r1, #0x4454
0x0201bc: adr        r2, #0x2c0
0x0201be: movt       r1, #0x4857
0x0201c2: vld1.64    {d16, d17}, [r2]
0x0201c6: add        r0, pc
0x0201c8: str.w      r0, [r4, #0x88]   ; <=== adev.create_audio_patch (+0x88) = r0
0x0201cc: ldr        r0, [pc, #0x2d8]
0x0201ce: add        r0, pc
0x0201d0: str.w      r0, [r4, #0x84]   ; <=== adev.get_master_mute (+0x84) = r0
0x0201d4: ldr        r0, [pc, #0x2d4]
0x0201d6: add        r0, pc
0x0201d8: str        r0, [r4, #0x50]   ; <=== adev.get_master_volume (+0x50) = r0
0x0201da: ldr        r0, [pc, #0x2d4]
0x0201dc: add        r0, pc
0x0201de: str        r0, [r4, #0x4c]   ; <=== adev.set_master_volume (+0x4c) = r0
0x0201e0: ldr        r0, [pc, #0x2d0]
0x0201e2: add        r0, pc
0x0201e4: str        r0, [r4, #0x48]   ; <=== adev.set_voice_volume (+0x48) = r0
0x0201e6: ldr        r0, [pc, #0x2d0]
0x0201e8: add        r0, pc
0x0201ea: str        r0, [r4, #0x44]   ; <=== adev.init_check (+0x44) = r0
0x0201ec: ldr        r0, [pc, #0x2cc]
0x0201ee: add        r0, pc
0x0201f0: str        r0, [r4, #0x3c]
0x0201f2: mov.w      r0, #0x300
0x0201f6: strd       r1, r0, [r4]
0x0201fa: str        r6, [r4, #8]
0x0201fc: ldr        r0, [pc, #0x2c0]
0x0201fe: add        r0, pc
0x020200: str.w      r0, [r4, #0x98]
0x020204: ldr        r0, [pc, #0x2bc]
0x020206: add        r0, pc
0x020208: str.w      r0, [r4, #0x94]   ; <=== adev.set_audio_port_config (+0x94) = r0
0x02020c: ldr        r0, [pc, #0x2b8]
0x02020e: add        r0, pc
0x020210: str.w      r0, [r4, #0x90]   ; <=== adev.get_audio_port (+0x90) = r0
0x020214: ldr        r0, [pc, #0x2b4]
0x020216: add        r0, pc
0x020218: str.w      r0, [r4, #0x8c]   ; <=== adev.release_audio_patch (+0x8c) = r0
0x02021c: ldr        r0, [pc, #0x2b0]
0x02021e: add        r0, pc
0x020220: mov        ip, r0
0x020222: ldr        r0, [pc, #0x2b0]
0x020224: add        r0, pc
0x020226: mov        lr, r0
0x020228: ldr        r0, [pc, #0x2ac]
0x02022a: ldr        r3, [pc, #0x2b0]
0x02022c: ldr        r5, [pc, #0x2b0]
0x02022e: ldr        r1, [pc, #0x2b4]
0x020230: add        r0, pc
0x020232: add        r3, pc
0x020234: add        r5, pc
0x020236: add        r1, pc
0x020238: mov        fp, r0
0x02023a: ldr        r0, [pc, #0x2ac]
0x02023c: ldr        r6, [pc, #0x2ac]
0x02023e: add        r6, pc
0x020240: add        r0, pc
0x020242: str        r6, [r4, #0x60]   ; <=== adev.get_parameters (+0x60) = r6
0x020244: ldr        r6, [pc, #0x2a8]
0x020246: add        r6, pc
0x020248: str        r6, [r4, #0x5c]   ; <=== adev.get_mic_mute (+0x5c) = r6
0x02024a: ldr        r6, [pc, #0x2a8]
0x02024c: add        r6, pc
0x02024e: str        r6, [r4, #0x58]   ; <=== adev.set_mic_mute (+0x58) = r6
0x020250: ldr        r6, [pc, #0x2a4]
0x020252: add        r6, pc
0x020254: str        r6, [r4, #0x54]   ; <=== adev.set_mode (+0x54) = r6
0x020256: movs       r6, #0
0x020258: str.w      r6, [r7, #0xf4]
0x02025c: ldr        r2, [pc, #0x29c]
0x02025e: str        r0, [r4, #0x64]   ; <=== adev.set_parameters (+0x64) = r0
0x020260: add.w      r0, r4, #0x70
0x020264: str        r1, [r4, #0x68]   ; <=== adev.get_input_buffer_size (+0x68) = r1
0x020266: str        r5, [r4, #0x6c]   ; <=== adev.open_output_stream (+0x6c) = r5
0x020268: mov.w      r1, #0x320
0x02026c: stm.w      r0, {r3, fp, lr}
0x020270: movs       r0, #3
0x020272: add        r2, pc
0x020274: strd       r2, ip, [r4, #0x7c]
0x020278: str.w      r0, [r7, #0x108]
0x02027c: add.w      r0, r7, #0x98
0x020280: strb.w     r6, [r7, #0x94]
0x020284: strb.w     r6, [r4, #0x170]
0x020288: strh.w     r6, [r7, #0x12c]
0x02028c: str.w      sb, [r7, #0x128]
0x020290: str.w      sb, [r7, #0x674]
0x020294: str.w      r6, [r7, #0x688]
0x020298: str.w      r6, [r7, #0x144]
0x02029c: strb.w     r6, [r7, #0x260]
0x0202a0: strb.w     r6, [r7, #0x14c]
0x0202a4: strb.w     r6, [r7, #0x140]
0x0202a8: vst1.32    {d16, d17}, [r0]
0x0202ac: movs       r0, #1
0x0202ae: blx        #0x3d160
0x0202b2: str.w      r0, [r7, #0x134]
0x0202b6: strb.w     r6, [r4, #0x16c]
0x0202ba: str.w      r6, [r7, #0x710]
0x0202be: addw       sb, r7, #0x674
0x0202c2: ldr        r5, [pc, #0x23c]
0x0202c4: add        r5, pc
0x0202c6: ldrb       r0, [r5]
0x0202c8: cbnz       r0, #0x202d5
0x0202ca: mov        r0, r4
0x0202cc: blx        #0x3d180
0x0202d0: movs       r0, #1
0x0202d2: strb       r0, [r5]
0x0202d4: str.w      r4, [sl]
0x0202d8: str        r6, [sp, #4]
0x0202da: ldr        r0, [pc, #0x228]
0x0202dc: add        r1, sp, #4
0x0202de: add        r0, pc
0x0202e0: blx        #0x3d190
0x0202e4: cbz        r0, #0x20301
0x0202e6: ldr        r1, [pc, #0x234]
0x0202e8: ldr        r2, [pc, #0x234]
0x0202ea: ldr        r3, [pc, #0x238]
0x0202ec: movs       r0, #6
0x0202ee: add        r1, pc
0x0202f0: add        r2, pc
0x0202f2: add        r3, pc
0x0202f4: blx        #0x3d100
0x0202f8: b          #0x20335
0x0202fa: mvn        r4, #0xb
0x0202fe: b          #0x20467
0x020300: ldr        r1, [pc, #0x204]
0x020302: ldr        r2, [pc, #0x208]
0x020304: movs       r0, #2
0x020306: add        r1, pc
0x020308: add        r2, pc
0x02030a: blx        #0x3d1a0
0x02030e: ldr        r0, [sp, #4]
0x020310: add.w      r5, r7, #0xc
0x020314: mov        r2, r5
0x020316: ldr        r1, [r0, #0x14]
0x020318: ldr        r3, [r1]
0x02031a: ldr        r1, [pc, #0x1f4]
0x02031c: add        r1, pc
0x02031e: blx        r3
0x020320: cbz        r0, #0x20335
0x020322: ldr        r1, [pc, #0x1f0]
0x020324: ldr        r2, [pc, #0x1f0]
0x020326: movs       r0, #6
0x020328: add        r1, pc
0x02032a: add        r2, pc
0x02032c: blx        #0x3d100
0x020330: movs       r0, #0
0x020332: str        r0, [r5]
0x020334: add.w      r0, r4, #0xe8
0x020338: movs       r1, #0x80
0x02033a: blx        #0x3d1b0
0x02033e: movs       r5, #1
0x020340: mov.w      r0, #-1
0x020344: movs       r1, #0
0x020346: mov        r2, sb
0x020348: strd       r5, r0, [r7, #0x58]
0x02034c: strd       r5, r0, [r7, #0x48]
0x020350: strb.w     r1, [r7, #0x60]
0x020354: strb.w     r1, [r7, #0x50]
0x020358: strd       r5, r0, [r7, #0x38]
0x02035c: strb.w     r1, [r7, #0x40]
0x020360: strd       r5, r0, [r7, #0x88]
0x020364: strd       r5, r0, [r7, #0x78]
0x020368: strb.w     r1, [r7, #0x90]
0x02036c: strb.w     r1, [r7, #0x80]
0x020370: strd       r5, r0, [r7, #0x68]
0x020374: strb.w     r1, [r7, #0x70]
0x020378: mov        r0, r4
0x02037a: movs       r1, #3
0x02037c: ldr        r3, [r7]
0x02037e: blx        r3
0x020380: str.w      r5, [r7, #0xf8]
0x020384: add.w      r0, r4, #0x3680
0x020388: movs       r1, #0
0x02038a: mov        r3, r4
0x02038c: ldr        r2, [pc, #0x198]
0x02038e: add        r2, pc
0x020390: blx        #0x3d1c0
0x020394: str.w      r5, [r7, #0x10c]
0x020398: movw       r0, #0x3694
0x02039c: mov        r3, r4
0x02039e: ldr        r1, [pc, #0x18c]
0x0203a0: add        r0, r4
0x0203a2: add        r1, pc
0x0203a4: ldr        r2, [r1]
0x0203a6: movs       r1, #0
0x0203a8: blx        #0x3d1c0
0x0203ac: ldr        r0, [pc, #0x180]
0x0203ae: add        r0, pc
0x0203b0: ldr        r5, [r0]
0x0203b2: blx        #0x3d1d0
0x0203b6: str        r0, [r5]
0x0203b8: ldr        r0, [pc, #0x178]
0x0203ba: add        r0, pc
0x0203bc: ldr        r5, [r0]
0x0203be: blx        #0x3d1e0
0x0203c2: str        r0, [r5]
0x0203c4: mov        r0, r4
0x0203c6: blx        #0x3d1f0
0x0203ca: ldr        r0, [pc, #0x16c]
0x0203cc: add.w      r5, r7, #0x13c
0x0203d0: mov        r1, r5
0x0203d2: add        r0, pc
0x0203d4: blx        #0x3d200
0x0203d8: cbz        r0, #0x203ed
0x0203da: str        r0, [sp]
0x0203dc: movs       r0, #5
0x0203de: ldr        r1, [pc, #0x15c]
0x0203e0: ldr        r2, [pc, #0x15c]
0x0203e2: ldr        r3, [pc, #0x160]
0x0203e4: add        r1, pc
0x0203e6: add        r2, pc
0x0203e8: add        r3, pc
0x0203ea: b          #0x203ff
0x0203ec: ldr        r0, [r5]
0x0203ee: str        r0, [sp]
0x0203f0: movs       r0, #4
0x0203f2: ldr        r1, [pc, #0x154]
0x0203f4: ldr        r2, [pc, #0x154]
0x0203f6: ldr        r3, [pc, #0x158]
0x0203f8: add        r1, pc
0x0203fa: add        r2, pc
0x0203fc: add        r3, pc
0x0203fe: blx        #0x3d100
0x020402: ldr        r0, [pc, #0x150]
0x020404: add.w      r5, r7, #0x258
0x020408: mov        r1, r5
0x02040a: add        r0, pc
0x02040c: blx        #0x3d200
0x020410: cbz        r0, #0x20425
0x020412: str        r0, [sp]
0x020414: movs       r0, #5
0x020416: ldr        r1, [pc, #0x140]
0x020418: ldr        r2, [pc, #0x140]
0x02041a: ldr        r3, [pc, #0x144]
0x02041c: add        r1, pc
0x02041e: add        r2, pc
0x020420: add        r3, pc
0x020422: b          #0x20437
0x020424: ldr        r0, [r5]
0x020426: str        r0, [sp]
0x020428: movs       r0, #4
0x02042a: ldr        r1, [pc, #0x138]
0x02042c: ldr        r2, [pc, #0x138]
0x02042e: ldr        r3, [pc, #0x13c]
0x020430: add        r1, pc
0x020432: add        r2, pc
0x020434: add        r3, pc
0x020436: blx        #0x3d100
0x02043a: ldr        r1, [pc, #0x134]
0x02043c: movw       r0, #0x3c58
0x020440: add        r0, r4
0x020442: add        r1, pc
0x020444: ldm        r1!, {r2, r3, r4, r5, r6}
0x020446: stm        r0!, {r2, r3, r4, r5, r6}
0x020448: ldm.w      r1, {r2, r3, r4, r5, r6}
0x02044c: stm        r0!, {r2, r3, r4, r5, r6}
0x02044e: movs       r4, #0
0x020450: str.w      r4, [r7, #0x70c]
0x020454: movs       r0, #4
0x020456: ldr        r1, [pc, #0x11c]
0x020458: ldr        r2, [pc, #0x11c]
0x02045a: ldr        r3, [pc, #0x120]
0x02045c: add        r1, pc
0x02045e: add        r2, pc
0x020460: add        r3, pc
0x020462: blx        #0x3d100
0x020466: ldr.w      r0, [r8]
0x02046a: ldr        r1, [sp, #8]
0x02046c: subs       r0, r0, r1
0x02046e: bne        #0x20479
0x020470: mov        r0, r4
0x020472: add        sp, #0xc
0x020474: pop.w      {r4, r5, r6, r7, r8, sb, sl, fp, pc}
0x020478: blx        #0x3d210
0x02047c: nop        
0x02047e: nop        
0x020480: movs       r1, r0
0x020482: movs       r0, r0
0x020484: movs       r0, r0
0x020486: movs       r0, r0
0x020488: movs       r0, r0
0x02048a: movs       r0, r0
0x02048c: movs       r0, r0
0x02048e: movs       r0, r0
0x020490: movs       r6, r4
0x020492: movs       r2, r0
0x020494: ldrb       r5, [r7, #0x15]
