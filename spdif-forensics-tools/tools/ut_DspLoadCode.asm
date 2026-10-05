===== kmods/utpa2k.ko HAL_AUDSP_DspLoadCode sec_off=0x46f5a8 size=0xb94 mode=A =====
0046f5a8  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
0046f5ac  sub       sp, sp, #0x24
0046f5b0  movw      r7, #0  rel→__stack_chk_guard
0046f5b4  movw      sb, #0  rel→g_AudioVars2
0046f5b8  movt      r7, #0  rel→__stack_chk_guard
0046f5bc  mov       r4, r0
0046f5c0  ldr       r0, [r7]
0046f5c4  movt      sb, #0  rel→g_AudioVars2
0046f5c8  str       r0, [sp, #0x20]
0046f5cc  ldr       r0, [sb]
0046f5d0  cmp       r0, #0
0046f5d4  bne       #0x46f5e8
0046f5d8  bl        #0x46f5d8  rel→MDrv_AUDIO_SHM_Init; CALL MDrv_AUDIO_SHM_Init
0046f5dc  ldr       r0, [sb]
0046f5e0  cmp       r0, #0
0046f5e4  beq       #0x46fbb8
0046f5e8  ldr       r0, [r0, #0x4c8]
0046f5ec  cmp       r0, #3
0046f5f0  blo       #0x46f608
0046f5f4  movw      r0, #0  rel→.L.str.11
0046f5f8  movt      r0, #0  rel→.L.str.11
0046f5fc  bl        #0x46f5fc  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f600  cmp       r0, #1
0046f604  beq       #0x46fc30
0046f608  mov       r5, #1
0046f60c  cmp       r4, #0x1d
0046f610  blo       #0x46fc14
0046f614  cmp       r4, #0x49
0046f618  beq       #0x46fc14
0046f61c  sub       r0, r4, #0x59
0046f620  cmp       r0, #5
0046f624  blo       #0x46f63c
0046f628  sub       r0, r4, #0x33
0046f62c  cmp       r0, #0x15
0046f630  subhs     r0, r4, #0x4f
0046f634  cmphs     r0, #6
0046f638  bhs       #0x46fbc0
0046f63c  movw      r0, #0  rel→dsp_info
0046f640  mov       r1, #0
0046f644  movt      r0, #0  rel→dsp_info
0046f648  ldr       r2, [r0, #0x34]
0046f64c  cmp       r2, r4
0046f650  beq       #0x46f6c4
0046f654  ldr       r2, [r0, #0x6c]
0046f658  mov       r1, #1
0046f65c  cmp       r2, r4
0046f660  beq       #0x46f6c4
0046f664  ldr       r2, [r0, #0xa4]
0046f668  mov       r1, #2
0046f66c  cmp       r2, r4
0046f670  beq       #0x46f6c4
0046f674  ldr       r2, [r0, #0xdc]
0046f678  mov       r1, #3
0046f67c  cmp       r2, r4
0046f680  beq       #0x46f6c4
0046f684  ldr       r2, [r0, #0x114]
0046f688  mov       r1, #4
0046f68c  cmp       r2, r4
0046f690  beq       #0x46f6c4
0046f694  ldr       r2, [r0, #0x14c]
0046f698  mov       r1, #5
0046f69c  cmp       r2, r4
0046f6a0  beq       #0x46f6c4
0046f6a4  ldr       r2, [r0, #0x184]
0046f6a8  mov       r1, #6
0046f6ac  cmp       r2, r4
0046f6b0  beq       #0x46f6c4
0046f6b4  ldr       r2, [r0, #0x1bc]
0046f6b8  mov       r1, #7
0046f6bc  cmp       r2, r4
0046f6c0  bne       #0x470014
0046f6c4  rsb       r1, r1, r1, lsl #3
0046f6c8  add       r6, r0, r1, lsl #3
0046f6cc  mov       sl, r6
0046f6d0  ldr       r0, [sl, #4]!
0046f6d4  cmp       r0, #0
0046f6d8  beq       #0x46fc14
0046f6dc  movw      r0, #0  rel→g_loadcodeinfo
0046f6e0  mov       r1, #1
0046f6e4  movt      r0, #0  rel→g_loadcodeinfo
0046f6e8  mov       r2, #1
0046f6ec  strb      r1, [r0, #4]
0046f6f0  mov       r1, #1
0046f6f4  str       r6, [r0]
0046f6f8  movw      r0, #0x2a7e
0046f6fc  movt      r0, #0x11
0046f700  bl        #0x46f700  rel→HAL_AUDIO_AbsWriteMaskByte; CALL HAL_AUDIO_AbsWriteMaskByte
0046f704  cmp       r4, #0x4a
0046f708  bne       #0x46f72c
0046f70c  movw      r0, #0x4596
0046f710  str       r0, [sl]
0046f714  mov       r0, #8
0046f718  str       r0, [r6]
0046f71c  movw      r0, #0  rel→mst_codec_pm1
0046f720  movt      r0, #0  rel→mst_codec_pm1
0046f724  add       r0, r0, #0x1e
0046f728  str       r0, [r6, #8]
0046f72c  ldr       r0, [sb]
0046f730  cmp       r0, #0
0046f734  beq       #0x46f7b0
0046f738  ldr       r0, [r0, #0x4c8]
0046f73c  cmp       r0, #4
0046f740  blo       #0x46f758
0046f744  movw      r0, #0  rel→.L.str.15
0046f748  movt      r0, #0  rel→.L.str.15
0046f74c  bl        #0x46f74c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f750  cmp       r0, #1
0046f754  beq       #0x46fef4
0046f758  ldr       r0, [sb]
0046f75c  cmp       r0, #0
0046f760  beq       #0x46f7b0
0046f764  ldr       r0, [r0, #0x4c8]
0046f768  cmp       r0, #4
0046f76c  blo       #0x46f784
0046f770  movw      r0, #0  rel→.L.str.15
0046f774  movt      r0, #0  rel→.L.str.15
0046f778  bl        #0x46f778  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f77c  cmp       r0, #1
0046f780  beq       #0x46ff50
0046f784  ldr       r0, [sb]
0046f788  cmp       r0, #0
0046f78c  beq       #0x46f7b0
0046f790  ldr       r0, [r0, #0x4c8]
0046f794  cmp       r0, #4
0046f798  blo       #0x46f7b0
0046f79c  movw      r0, #0  rel→.L.str.15
0046f7a0  movt      r0, #0  rel→.L.str.15
0046f7a4  bl        #0x46f7a4  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f7a8  cmp       r0, #1
0046f7ac  beq       #0x46ffa8
0046f7b0  str       r6, [sp]
0046f7b4  mov       r3, #1
0046f7b8  ldr       r0, [r6, #0xc]!
0046f7bc  mov       fp, r6
0046f7c0  mov       r8, r6
0046f7c4  ldr       r2, [fp, #4]!
0046f7c8  ldr       r1, [r8, #8]!
0046f7cc  bl        #0x46f7cc  rel→HAL_AUDSP_DspLoadCodeSegment; CALL HAL_AUDSP_DspLoadCodeSegment
0046f7d0  mov       r5, #0
0046f7d4  cmp       r0, #0
0046f7d8  beq       #0x46fc0c
0046f7dc  ldr       r2, [fp]
0046f7e0  mov       r3, #1
0046f7e4  ldr       r1, [r8]
0046f7e8  ldr       r0, [r6]
0046f7ec  bl        #0x46f7ec  rel→HAL_AUDSP_DspVerifySegmentCode; CALL HAL_AUDSP_DspVerifySegmentCode
0046f7f0  cmp       r0, #0
0046f7f4  beq       #0x46fc0c
0046f7f8  ldr       r0, [sb]
0046f7fc  movw      r7, #0  rel→__stack_chk_guard
0046f800  ldr       fp, [sp]
0046f804  movt      r7, #0  rel→__stack_chk_guard
0046f808  cmp       r0, #0
0046f80c  beq       #0x46f888
0046f810  ldr       r0, [r0, #0x4c8]
0046f814  cmp       r0, #4
0046f818  blo       #0x46f830
0046f81c  movw      r0, #0  rel→.L.str.15
0046f820  movt      r0, #0  rel→.L.str.15
0046f824  bl        #0x46f824  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f828  cmp       r0, #1
0046f82c  beq       #0x46ffbc
0046f830  ldr       r0, [sb]
0046f834  cmp       r0, #0
0046f838  beq       #0x46f888
0046f83c  ldr       r0, [r0, #0x4c8]
0046f840  cmp       r0, #4
0046f844  blo       #0x46f85c
0046f848  movw      r0, #0  rel→.L.str.15
0046f84c  movt      r0, #0  rel→.L.str.15
0046f850  bl        #0x46f850  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f854  cmp       r0, #1
0046f858  beq       #0x470050
0046f85c  ldr       r0, [sb]
0046f860  cmp       r0, #0
0046f864  beq       #0x46f888
0046f868  ldr       r0, [r0, #0x4c8]
0046f86c  cmp       r0, #4
0046f870  blo       #0x46f888
0046f874  movw      r0, #0  rel→.L.str.15
0046f878  movt      r0, #0  rel→.L.str.15
0046f87c  bl        #0x46f87c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f880  cmp       r0, #1
0046f884  beq       #0x470064
0046f888  mov       r6, fp
0046f88c  ldr       r2, [sl]
0046f890  ldr       r1, [r6, #8]!
0046f894  mov       r3, #1
0046f898  ldr       r0, [fp]
0046f89c  bl        #0x46f89c  rel→HAL_AUDSP_DspLoadCodeSegment; CALL HAL_AUDSP_DspLoadCodeSegment
0046f8a0  cmp       r0, #0
0046f8a4  beq       #0x46fc14
0046f8a8  ldr       r2, [sl]
0046f8ac  mov       r3, #1
0046f8b0  ldr       r1, [r6]
0046f8b4  ldr       r0, [fp]
0046f8b8  bl        #0x46f8b8  rel→HAL_AUDSP_DspVerifySegmentCode; CALL HAL_AUDSP_DspVerifySegmentCode
0046f8bc  cmp       r0, #0
0046f8c0  beq       #0x46fc14
0046f8c4  mov       r8, fp
0046f8c8  ldr       r0, [r8, #0x28]!
0046f8cc  cmp       r0, #0
0046f8d0  beq       #0x46f9b8
0046f8d4  ldr       r0, [sb]
0046f8d8  cmp       r0, #0
0046f8dc  beq       #0x46f958
0046f8e0  ldr       r0, [r0, #0x4c8]
0046f8e4  cmp       r0, #4
0046f8e8  blo       #0x46f900
0046f8ec  movw      r0, #0  rel→.L.str.15
0046f8f0  movt      r0, #0  rel→.L.str.15
0046f8f4  bl        #0x46f8f4  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f8f8  cmp       r0, #1
0046f8fc  beq       #0x470078
0046f900  ldr       r0, [sb]
0046f904  cmp       r0, #0
0046f908  beq       #0x46f958
0046f90c  ldr       r0, [r0, #0x4c8]
0046f910  cmp       r0, #4
0046f914  blo       #0x46f92c
0046f918  movw      r0, #0  rel→.L.str.15
0046f91c  movt      r0, #0  rel→.L.str.15
0046f920  bl        #0x46f920  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f924  cmp       r0, #1
0046f928  beq       #0x4700d0
0046f92c  ldr       r0, [sb]
0046f930  cmp       r0, #0
0046f934  beq       #0x46f958
0046f938  ldr       r0, [r0, #0x4c8]
0046f93c  cmp       r0, #4
0046f940  blo       #0x46f958
0046f944  movw      r0, #0  rel→.L.str.15
0046f948  movt      r0, #0  rel→.L.str.15
0046f94c  bl        #0x46f94c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f950  cmp       r0, #1
0046f954  beq       #0x4700f8
0046f958  mov       r0, #1
0046f95c  ldr       sl, [fp, #0x24]
0046f960  bl        #0x46f960  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
0046f964  mov       r5, r0
0046f968  mov       r6, r1
0046f96c  mov       r0, #3
0046f970  umlal     r5, r6, sl, r0
0046f974  ldr       r0, [sb]
0046f978  cmp       r0, #0
0046f97c  beq       #0x46f9a0
0046f980  ldr       r0, [r0, #0x4c8]
0046f984  cmp       r0, #4
0046f988  blo       #0x46f9a0
0046f98c  movw      r0, #0  rel→.L.str.15
0046f990  movt      r0, #0  rel→.L.str.15
0046f994  bl        #0x46f994  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f998  cmp       r0, #1
0046f99c  beq       #0x47008c
0046f9a0  mov       r0, r5
0046f9a4  mov       r1, r6
0046f9a8  bl        #0x46f9a8  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046f9ac  ldr       r1, [fp, #0x2c]
0046f9b0  ldr       r2, [r8]
0046f9b4  bl        #0x46f9b4  rel→memcpy; CALL memcpy
0046f9b8  mov       r8, fp
0046f9bc  ldr       r0, [r8, #0x1c]!
0046f9c0  cmp       r0, #0
0046f9c4  beq       #0x46faac
0046f9c8  ldr       r0, [sb]
0046f9cc  cmp       r0, #0
0046f9d0  beq       #0x46fa4c
0046f9d4  ldr       r0, [r0, #0x4c8]
0046f9d8  cmp       r0, #4
0046f9dc  blo       #0x46f9f4
0046f9e0  movw      r0, #0  rel→.L.str.15
0046f9e4  movt      r0, #0  rel→.L.str.15
0046f9e8  bl        #0x46f9e8  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046f9ec  cmp       r0, #1
0046f9f0  beq       #0x4700a4
0046f9f4  ldr       r0, [sb]
0046f9f8  cmp       r0, #0
0046f9fc  beq       #0x46fa4c
0046fa00  ldr       r0, [r0, #0x4c8]
0046fa04  cmp       r0, #4
0046fa08  blo       #0x46fa20
0046fa0c  movw      r0, #0  rel→.L.str.15
0046fa10  movt      r0, #0  rel→.L.str.15
0046fa14  bl        #0x46fa14  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fa18  cmp       r0, #1
0046fa1c  beq       #0x4700e4
0046fa20  ldr       r0, [sb]
0046fa24  cmp       r0, #0
0046fa28  beq       #0x46fa4c
0046fa2c  ldr       r0, [r0, #0x4c8]
0046fa30  cmp       r0, #4
0046fa34  blo       #0x46fa4c
0046fa38  movw      r0, #0  rel→.L.str.15
0046fa3c  movt      r0, #0  rel→.L.str.15
0046fa40  bl        #0x46fa40  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fa44  cmp       r0, #1
0046fa48  beq       #0x47010c
0046fa4c  mov       r0, #1
0046fa50  ldr       sl, [fp, #0x18]
0046fa54  bl        #0x46fa54  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
0046fa58  mov       r5, r0
0046fa5c  mov       r6, r1
0046fa60  mov       r0, #3
0046fa64  umlal     r5, r6, sl, r0
0046fa68  ldr       r0, [sb]
0046fa6c  cmp       r0, #0
0046fa70  beq       #0x46fa94
0046fa74  ldr       r0, [r0, #0x4c8]
0046fa78  cmp       r0, #4
0046fa7c  blo       #0x46fa94
0046fa80  movw      r0, #0  rel→.L.str.15
0046fa84  movt      r0, #0  rel→.L.str.15
0046fa88  bl        #0x46fa88  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fa8c  cmp       r0, #1
0046fa90  beq       #0x4700b8
0046fa94  mov       r0, r5
0046fa98  mov       r1, r6
0046fa9c  bl        #0x46fa9c  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046faa0  ldr       r1, [fp, #0x20]
0046faa4  ldr       r2, [r8]
0046faa8  bl        #0x46faa8  rel→memcpy; CALL memcpy
0046faac  cmp       r4, #0x4a
0046fab0  bne       #0x46fe48
0046fab4  movw      r0, #0x3080
0046fab8  mov       r1, #0
0046fabc  movt      r0, #0x16
0046fac0  mov       r6, #0
0046fac4  bl        #0x46fac4  rel→HAL_AUDIO_AbsWriteByte; CALL HAL_AUDIO_AbsWriteByte
0046fac8  movw      r0, #0x39e
0046facc  movw      r1, #0xffff
0046fad0  movt      r0, #0x16
0046fad4  mov       r2, #0
0046fad8  bl        #0x46fad8  rel→HAL_AUDIO_AbsWriteMaskReg; CALL HAL_AUDIO_AbsWriteMaskReg
0046fadc  movw      r0, #0x2ddc
0046fae0  movw      r1, #0xffff
0046fae4  movt      r0, #0x11
0046fae8  mov       r2, #0
0046faec  bl        #0x46faec  rel→HAL_AUDIO_AbsWriteMaskReg; CALL HAL_AUDIO_AbsWriteMaskReg
0046faf0  mov       r0, #1
0046faf4  bl        #0x46faf4  rel→MsOS_DelayTask; CALL MsOS_DelayTask
0046faf8  movw      r0, #0x2a7e
0046fafc  movw      r1, #0xffff
0046fb00  movt      r0, #0x11
0046fb04  mov       r2, #0
0046fb08  add       r0, r0, #0x350
0046fb0c  bl        #0x46fb0c  rel→HAL_AUDIO_AbsWriteMaskReg; CALL HAL_AUDIO_AbsWriteMaskReg
0046fb10  ldr       r0, [sb]
0046fb14  movw      r2, #0  rel→mst_snd_r2_MS12V22
0046fb18  movw      fp, #0  rel→mst_snd_r2
0046fb1c  movt      r2, #0  rel→mst_snd_r2_MS12V22
0046fb20  movt      fp, #0  rel→mst_snd_r2
0046fb24  movw      r7, #0  rel→mst_codec_r2
0046fb28  ldr       r1, [r0, #0x4d0]
0046fb2c  movw      r8, #0x3f48
0046fb30  movw      r5, #0xc0f4
0046fb34  movt      r7, #0  rel→mst_codec_r2
0046fb38  cmp       r1, #4
0046fb3c  movt      r8, #0x17
0046fb40  moveq     fp, r2
0046fb44  movw      r2, #0  rel→mst_codec_r2_MS12V22
0046fb48  movt      r2, #0  rel→mst_codec_r2_MS12V22
0046fb4c  movt      r5, #0x29
0046fb50  moveq     r7, r2
0046fb54  cmp       r1, #4
0046fb58  ldrb      r1, [r0, #9]
0046fb5c  movweq    r8, #0x6930
0046fb60  movweq    r5, #0x401c
0046fb64  movteq    r8, #0x1b
0046fb68  movteq    r5, #0x1e
0046fb6c  cmp       r1, #1
0046fb70  bne       #0x46fc44
0046fb74  cmp       r0, #0
0046fb78  strb      r6, [r0, #9]
0046fb7c  beq       #0x46fd2c
0046fb80  ldr       r0, [r0, #0x4c8]
0046fb84  cmp       r0, #4
0046fb88  blo       #0x46fd2c
0046fb8c  movw      r0, #0  rel→.L.str.15
0046fb90  movt      r0, #0  rel→.L.str.15
0046fb94  bl        #0x46fb94  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fb98  cmp       r0, #1
0046fb9c  bne       #0x46fd2c
0046fba0  movw      r0, #0  rel→.L.str.30
0046fba4  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fba8  movt      r0, #0  rel→.L.str.30
0046fbac  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fbb0  bl        #0x46fbb0  rel→printk; CALL printk
0046fbb4  b         #0x46fd2c
0046fbb8  mov       r5, #0
0046fbbc  b         #0x46fc14
0046fbc0  cmp       r4, #0x4a
0046fbc4  subne     r0, r4, #0x20
0046fbc8  cmpne     r0, #0x11
0046fbcc  bls       #0x46f63c
0046fbd0  ldr       r0, [sb]
0046fbd4  mov       r5, #0
0046fbd8  cmp       r0, #0
0046fbdc  ldrne     r0, [r0, #0x4c8]
0046fbe0  cmpne     r0, #0
0046fbe4  beq       #0x46fc14
0046fbe8  movw      r0, #0  rel→.L.str.8
0046fbec  movt      r0, #0  rel→.L.str.8
0046fbf0  bl        #0x46fbf0  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fbf4  cmp       r0, #1
0046fbf8  bne       #0x46fc14
0046fbfc  movw      r0, #0  rel→.L.str.14
0046fc00  movt      r0, #0  rel→.L.str.14
0046fc04  bl        #0x46fc04  rel→printk; CALL printk
0046fc08  b         #0x46fc14
0046fc0c  movw      r7, #0  rel→__stack_chk_guard
0046fc10  movt      r7, #0  rel→__stack_chk_guard
0046fc14  ldr       r0, [r7]
0046fc18  ldr       r1, [sp, #0x20]
0046fc1c  subs      r0, r0, r1
0046fc20  moveq     r0, r5
0046fc24  addeq     sp, sp, #0x24
0046fc28  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
0046fc2c  bl        #0x46fc2c  rel→__stack_chk_fail; CALL __stack_chk_fail
0046fc30  movw      r0, #0  rel→.L.str.12
0046fc34  mov       r1, r4
0046fc38  movt      r0, #0  rel→.L.str.12
0046fc3c  bl        #0x46fc3c  rel→printk; CALL printk
0046fc40  b         #0x46f608
0046fc44  movw      r1, #0x24f0
0046fc48  ldr       r0, [r0, r1]
0046fc4c  cmp       r0, #1
0046fc50  bhi       #0x46fca0
0046fc54  mov       r0, #2
0046fc58  bl        #0x46fc58  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
0046fc5c  mov       r6, r0
0046fc60  mov       sl, r1
0046fc64  bl        #0x46fc64  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046fc68  mov       r1, #0
0046fc6c  mov       r2, #0x700000
0046fc70  bl        #0x46fc70  rel→memset; CALL memset
0046fc74  mov       r0, r6
0046fc78  mov       r1, sl
0046fc7c  bl        #0x46fc7c  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046fc80  mov       r1, r7
0046fc84  mov       r2, r5
0046fc88  bl        #0x46fc88  rel→memcpy; CALL memcpy
0046fc8c  bl        #0x46fc8c  rel→HAL_DEC_R2_init_SHM_param; CALL HAL_DEC_R2_init_SHM_param
0046fc90  mov       r0, #1
0046fc94  bl        #0x46fc94  rel→MsOS_DelayTask; CALL MsOS_DelayTask
0046fc98  bl        #0x46fc98  rel→MsOS_FlushMemory; CALL MsOS_FlushMemory
0046fc9c  b         #0x46fd2c
0046fca0  bl        #0x46fca0  rel→HAL_DEC_R2_init_SHM_param; CALL HAL_DEC_R2_init_SHM_param
0046fca4  mov       r0, #1
0046fca8  bl        #0x46fca8  rel→MsOS_DelayTask; CALL MsOS_DelayTask
0046fcac  bl        #0x46fcac  rel→MsOS_FlushMemory; CALL MsOS_FlushMemory
0046fcb0  mov       r6, #0
0046fcb4  mov       r0, #2
0046fcb8  str       r6, [sp, #4]
0046fcbc  bl        #0x46fcbc  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
0046fcc0  str       r0, [sp, #8]
0046fcc4  mov       r1, #0x700000
0046fcc8  ldr       r0, [sb]
0046fccc  str       r1, [sp, #0xc]
0046fcd0  add       r1, sp, #4
0046fcd4  str       r6, [sp, #0x18]
0046fcd8  ldr       r0, [r0, #0x4d0]
0046fcdc  str       r6, [sp, #0x14]
0046fce0  cmp       r0, #4
0046fce4  str       r5, [sp, #0x10]
0046fce8  movwne    r0, #3
0046fcec  str       r0, [sp, #0x1c]
0046fcf0  mov       r0, #3
0046fcf4  bl        #0x46fcf4  rel→MDrv_AUDIO_TEE_R_Send_Cmd; CALL MDrv_AUDIO_TEE_R_Send_Cmd
0046fcf8  cmp       r0, #0
0046fcfc  beq       #0x46fd2c
0046fd00  mov       r5, r0
0046fd04  ldr       r0, [sb]
0046fd08  cmp       r0, #0
0046fd0c  ldrne     r0, [r0, #0x4c8]
0046fd10  cmpne     r0, #0
0046fd14  beq       #0x46fd2c
0046fd18  movw      r0, #0  rel→.L.str.8
0046fd1c  movt      r0, #0  rel→.L.str.8
0046fd20  bl        #0x46fd20  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fd24  cmp       r0, #1
0046fd28  beq       #0x470120
0046fd2c  mov       r0, #2
0046fd30  bl        #0x46fd30  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
0046fd34  adds      r7, r0, #0x700000
0046fd38  adc       r6, r1, #0
0046fd3c  mov       r0, r7
0046fd40  mov       r1, r6
0046fd44  bl        #0x46fd44  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046fd48  mov       r1, fp
0046fd4c  mov       r2, #0xa000
0046fd50  bl        #0x46fd50  rel→memcpy; CALL memcpy
0046fd54  mov       r0, r7
0046fd58  mov       r1, r6
0046fd5c  bl        #0x46fd5c  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046fd60  movw      r2, #0x5600
0046fd64  add       r0, r0, #0xaa00
0046fd68  movt      r2, #0x6f
0046fd6c  mov       r1, #0
0046fd70  mov       r5, #0
0046fd74  bl        #0x46fd74  rel→memset; CALL memset
0046fd78  mov       r0, r7
0046fd7c  mov       r1, r6
0046fd80  bl        #0x46fd80  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
0046fd84  add       r0, r0, #0xaa00
0046fd88  add       r1, fp, #0xaa00
0046fd8c  mov       r2, r8
0046fd90  bl        #0x46fd90  rel→memcpy; CALL memcpy
0046fd94  bl        #0x46fd94  rel→HAL_SND_R2_init_SHM_param; CALL HAL_SND_R2_init_SHM_param
0046fd98  mov       r0, #1
0046fd9c  bl        #0x46fd9c  rel→MsOS_DelayTask; CALL MsOS_DelayTask
0046fda0  bl        #0x46fda0  rel→MsOS_FlushMemory; CALL MsOS_FlushMemory
0046fda4  mov       r0, #1
0046fda8  bl        #0x46fda8  rel→HAL_SND_R2_EnableR2; CALL HAL_SND_R2_EnableR2
0046fdac  mov       r0, #1
0046fdb0  bl        #0x46fdb0  rel→HAL_DEC_R2_EnableR2; CALL HAL_DEC_R2_EnableR2
0046fdb4  movw      r8, #0  rel→mst_codec_pm1
0046fdb8  mov       r0, #1
0046fdbc  movt      r8, #0  rel→mst_codec_pm1
0046fdc0  add       r6, r8, #9
0046fdc4  mov       r2, #0x15
0046fdc8  mov       r3, #1
0046fdcc  mov       r1, r6
0046fdd0  bl        #0x46fdd0  rel→HAL_AUDSP_DspLoadCodeSegment; CALL HAL_AUDSP_DspLoadCodeSegment
0046fdd4  cmp       r0, #0
0046fdd8  beq       #0x46fea8
0046fddc  mov       r0, #1
0046fde0  mov       r1, r6
0046fde4  mov       r2, #0x15
0046fde8  mov       r3, #1
0046fdec  bl        #0x46fdec  rel→HAL_AUDSP_DspVerifySegmentCode; CALL HAL_AUDSP_DspVerifySegmentCode
0046fdf0  movw      r7, #0  rel→__stack_chk_guard
0046fdf4  cmp       r0, #0
0046fdf8  movt      r7, #0  rel→__stack_chk_guard
0046fdfc  beq       #0x46ff08
0046fe00  add       r6, r8, #6
0046fe04  mov       r0, #0
0046fe08  mov       r2, #3
0046fe0c  mov       r3, #1
0046fe10  mov       r1, r6
0046fe14  mov       r5, #0
0046fe18  bl        #0x46fe18  rel→HAL_AUDSP_DspLoadCodeSegment; CALL HAL_AUDSP_DspLoadCodeSegment
0046fe1c  cmp       r0, #0
0046fe20  beq       #0x46ff64
0046fe24  mov       r0, #0
0046fe28  mov       r1, r6
0046fe2c  mov       r2, #3
0046fe30  mov       r3, #1
0046fe34  mov       r5, #0
0046fe38  bl        #0x46fe38  rel→HAL_AUDSP_DspVerifySegmentCode; CALL HAL_AUDSP_DspVerifySegmentCode
0046fe3c  ldr       fp, [sp]
0046fe40  cmp       r0, #0
0046fe44  beq       #0x46ffd0
0046fe48  bl        #0x46fe48  rel→MsOS_FlushMemory; CALL MsOS_FlushMemory
0046fe4c  movw      r0, #0  rel→g_u8DspCodeTypeLoaded
0046fe50  mov       r5, #1
0046fe54  movt      r0, #0  rel→g_u8DspCodeTypeLoaded
0046fe58  strb      r4, [r0]
0046fe5c  ldr       r0, [sb]
0046fe60  cmp       r0, #0
0046fe64  beq       #0x46fc14
0046fe68  ldr       r0, [r0, #0x4c8]
0046fe6c  cmp       r0, #3
0046fe70  blo       #0x46fc14
0046fe74  movw      r0, #0  rel→.L.str.11
0046fe78  movt      r0, #0  rel→.L.str.11
0046fe7c  bl        #0x46fe7c  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fe80  cmp       r0, #1
0046fe84  bne       #0x46fc14
0046fe88  ldr       r2, [fp, #0x30]
0046fe8c  movw      r0, #0  rel→.L.str.33
0046fe90  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fe94  movt      r0, #0  rel→.L.str.33
0046fe98  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fe9c  mov       r3, r4
0046fea0  bl        #0x46fea0  rel→printk; CALL printk
0046fea4  b         #0x46fc14
0046fea8  ldr       r0, [sb]
0046feac  movw      r7, #0  rel→__stack_chk_guard
0046feb0  movt      r7, #0  rel→__stack_chk_guard
0046feb4  cmp       r0, #0
0046feb8  ldrne     r0, [r0, #0x4c8]
0046febc  cmpne     r0, #0
0046fec0  beq       #0x46fc14
0046fec4  movw      r0, #0  rel→.L.str.8
0046fec8  movt      r0, #0  rel→.L.str.8
0046fecc  bl        #0x46fecc  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fed0  cmp       r0, #1
0046fed4  bne       #0x46fc14
0046fed8  movw      r0, #0  rel→.L.str.32
0046fedc  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fee0  movt      r0, #0  rel→.L.str.32
0046fee4  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046fee8  movw      r2, #0x39e
0046feec  bl        #0x46feec  rel→printk; CALL printk
0046fef0  b         #0x46fc14
0046fef4  ldr       r1, [r6, #0xc]
0046fef8  movw      r0, #0  rel→.L.str.16
0046fefc  movt      r0, #0  rel→.L.str.16
0046ff00  bl        #0x46ff00  rel→printk; CALL printk
0046ff04  b         #0x46f758
0046ff08  ldr       r0, [sb]
0046ff0c  mov       r5, #0
0046ff10  cmp       r0, #0
0046ff14  ldrne     r0, [r0, #0x4c8]
0046ff18  cmpne     r0, #0
0046ff1c  beq       #0x46fc14
0046ff20  movw      r0, #0  rel→.L.str.8
0046ff24  movt      r0, #0  rel→.L.str.8
0046ff28  bl        #0x46ff28  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046ff2c  cmp       r0, #1
0046ff30  bne       #0x46fc14
0046ff34  movw      r0, #0  rel→.L.str.32
0046ff38  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046ff3c  movt      r0, #0  rel→.L.str.32
0046ff40  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046ff44  movw      r2, #0x3a3
0046ff48  bl        #0x46ff48  rel→printk; CALL printk
0046ff4c  b         #0x46fc14
0046ff50  ldr       r1, [r6, #0x14]
0046ff54  movw      r0, #0  rel→.L.str.17
0046ff58  movt      r0, #0  rel→.L.str.17
0046ff5c  bl        #0x46ff5c  rel→printk; CALL printk
0046ff60  b         #0x46f784
0046ff64  ldr       r0, [sb]
0046ff68  cmp       r0, #0
0046ff6c  ldrne     r0, [r0, #0x4c8]
0046ff70  cmpne     r0, #0
0046ff74  beq       #0x46fc14
0046ff78  movw      r0, #0  rel→.L.str.8
0046ff7c  movt      r0, #0  rel→.L.str.8
0046ff80  bl        #0x46ff80  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046ff84  cmp       r0, #1
0046ff88  bne       #0x46fc14
0046ff8c  movw      r0, #0  rel→.L.str.32
0046ff90  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046ff94  movt      r0, #0  rel→.L.str.32
0046ff98  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
0046ff9c  mov       r2, #0x3a8
0046ffa0  bl        #0x46ffa0  rel→printk; CALL printk
0046ffa4  b         #0x46fc14
0046ffa8  ldr       r1, [r6, #0x10]
0046ffac  movw      r0, #0  rel→.L.str.18
0046ffb0  movt      r0, #0  rel→.L.str.18
0046ffb4  bl        #0x46ffb4  rel→printk; CALL printk
0046ffb8  b         #0x46f7b0
0046ffbc  ldr       r1, [fp]
0046ffc0  movw      r0, #0  rel→.L.str.19
0046ffc4  movt      r0, #0  rel→.L.str.19
0046ffc8  bl        #0x46ffc8  rel→printk; CALL printk
0046ffcc  b         #0x46f830
0046ffd0  ldr       r0, [sb]
0046ffd4  cmp       r0, #0
0046ffd8  ldrne     r0, [r0, #0x4c8]
0046ffdc  cmpne     r0, #0
0046ffe0  beq       #0x46fc14
0046ffe4  movw      r0, #0  rel→.L.str.8
0046ffe8  movt      r0, #0  rel→.L.str.8
0046ffec  bl        #0x46ffec  rel→UtopiaLogSystem; CALL UtopiaLogSystem
0046fff0  cmp       r0, #1
0046fff4  bne       #0x46fc14
0046fff8  movw      r0, #0  rel→.L.str.32
0046fffc  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
00470000  movt      r0, #0  rel→.L.str.32
00470004  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
00470008  movw      r2, #0x3ad
0047000c  bl        #0x47000c  rel→printk; CALL printk
00470010  b         #0x46fc14
00470014  ldr       r0, [sb]
00470018  mov       r5, #0
0047001c  cmp       r0, #0
00470020  ldrne     r0, [r0, #0x4c8]
00470024  cmpne     r0, #0
00470028  beq       #0x46fc14
0047002c  movw      r0, #0  rel→.L.str.8
00470030  movt      r0, #0  rel→.L.str.8
00470034  bl        #0x470034  rel→UtopiaLogSystem; CALL UtopiaLogSystem
00470038  cmp       r0, #1
0047003c  bne       #0x46fc14
00470040  movw      r0, #0  rel→.L.str.13
00470044  movt      r0, #0  rel→.L.str.13
00470048  bl        #0x470048  rel→printk; CALL printk
0047004c  b         #0x46fc14
00470050  ldr       r1, [fp, #8]
00470054  movw      r0, #0  rel→.L.str.20
00470058  movt      r0, #0  rel→.L.str.20
0047005c  bl        #0x47005c  rel→printk; CALL printk
00470060  b         #0x46f85c
00470064  ldr       r1, [sl]
00470068  movw      r0, #0  rel→.L.str.21
0047006c  movt      r0, #0  rel→.L.str.21
00470070  bl        #0x470070  rel→printk; CALL printk
00470074  b         #0x46f888
00470078  ldr       r1, [fp, #0x24]
0047007c  movw      r0, #0  rel→.L.str.22
00470080  movt      r0, #0  rel→.L.str.22
00470084  bl        #0x470084  rel→printk; CALL printk
00470088  b         #0x46f900
0047008c  movw      r0, #0  rel→.L.str.25
00470090  mov       r2, r5
00470094  movt      r0, #0  rel→.L.str.25
00470098  mov       r3, r6
0047009c  bl        #0x47009c  rel→printk; CALL printk
004700a0  b         #0x46f9a0
004700a4  ldr       r1, [fp, #0x18]
004700a8  movw      r0, #0  rel→.L.str.26
004700ac  movt      r0, #0  rel→.L.str.26
004700b0  bl        #0x4700b0  rel→printk; CALL printk
004700b4  b         #0x46f9f4
004700b8  movw      r0, #0  rel→.L.str.29
004700bc  mov       r2, r5
004700c0  movt      r0, #0  rel→.L.str.29
004700c4  mov       r3, r6
004700c8  bl        #0x4700c8  rel→printk; CALL printk
004700cc  b         #0x46fa94
004700d0  ldr       r1, [fp, #0x2c]
004700d4  movw      r0, #0  rel→.L.str.23
004700d8  movt      r0, #0  rel→.L.str.23
004700dc  bl        #0x4700dc  rel→printk; CALL printk
004700e0  b         #0x46f92c
004700e4  ldr       r1, [fp, #0x20]
004700e8  movw      r0, #0  rel→.L.str.27
004700ec  movt      r0, #0  rel→.L.str.27
004700f0  bl        #0x4700f0  rel→printk; CALL printk
004700f4  b         #0x46fa20
004700f8  ldr       r1, [r8]
004700fc  movw      r0, #0  rel→.L.str.24
00470100  movt      r0, #0  rel→.L.str.24
00470104  bl        #0x470104  rel→printk; CALL printk
00470108  b         #0x46f958
0047010c  ldr       r1, [r8]
00470110  movw      r0, #0  rel→.L.str.28
00470114  movt      r0, #0  rel→.L.str.28
00470118  bl        #0x470118  rel→printk; CALL printk
0047011c  b         #0x46fa4c
00470120  movw      r0, #0  rel→.L.str.31
00470124  movw      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
00470128  movt      r0, #0  rel→.L.str.31
0047012c  movt      r1, #0  rel→.L__FUNCTION__.HAL_AUDSP_DspLoadCode
00470130  mov       r2, r5
00470134  bl        #0x470134  rel→printk; CALL printk
00470138  b         #0x46fd2c
