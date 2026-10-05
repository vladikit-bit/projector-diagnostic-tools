===== kmods/utpa2k.ko HAL_DEC_R2_Get_SHM_INFO sec_off=0x4592a8 size=0x79c mode=A =====
004592a8  push      {r4, r5, r6, lr}
004592ac  movw      r5, #0  rel→g_virDecR2shm
004592b0  mov       r6, r0
004592b4  movt      r5, #0  rel→g_virDecR2shm
004592b8  mov       r4, r1
004592bc  ldr       r0, [r5]
004592c0  cmp       r0, #0
004592c4  bne       #0x4592f0
004592c8  mov       r0, #2
004592cc  bl        #0x4592cc  rel→HAL_AUDIO_GetDspMadBaseAddr; CALL HAL_AUDIO_GetDspMadBaseAddr
004592d0  movw      r2, #0x1000
004592d4  movt      r2, #0xe0
004592d8  adds      r0, r0, r2
004592dc  adc       r1, r1, #0
004592e0  bl        #0x4592e0  rel→MsOS_PA2KSEG1; CALL MsOS_PA2KSEG1
004592e4  cmp       r0, #0
004592e8  str       r0, [r5]
004592ec  beq       #0x45949c
004592f0  cmp       r4, #1
004592f4  mov       r5, #0
004592f8  cmpls     r6, #0x5a
004592fc  bls       #0x459308
00459300  mov       r0, r5
00459304  pop       {r4, r5, r6, pc}
00459308  sub       r1, r4, #1
0045930c  add       r2, pc, #0xc
00459310  clz       r1, r1
00459314  lsr       r1, r1, #5
00459318  lsl       r1, r1, #1
0045931c  ldr       pc, [r2, r6, lsl #2]
00459320  subeq     sb, r5, ip, lsl #9  rel→
00459324  subeq     sb, r5, ip, ror #9  rel→
00459328  strdeq    sb, sl, [r5], #-0x4c  rel→
0045932c  subeq     sb, r5, ip, lsl #10  rel→
00459330  subeq     sb, r5, ip, lsl r5  rel→
00459334  subeq     sb, r5, ip, lsr #10  rel→
00459338  subeq     sb, r5, ip, lsr r5  rel→
0045933c  subeq     sb, r5, ip, asr #10  rel→
00459340  subeq     sb, r5, ip, asr r5  rel→
00459344  subeq     sb, r5, r4, ror #10  rel→
00459348  subeq     sb, r5, r4, ror r5  rel→
0045934c  subeq     sb, r5, r8, lsl #11  rel→
00459350  umaaleq   sb, r5, r4, r5  rel→
00459354  subeq     sb, r5, r4, lsr #11  rel→
00459358  strheq    sb, [r5], #-0x54  rel→
0045935c  subeq     sb, r5, r0, asr #11  rel→
00459360  ldrdeq    sb, sl, [r5], #-0x50  rel→
00459364  subeq     sb, r5, r0, ror #11  rel→
00459368  strdeq    sb, sl, [r5], #-0x50  rel→
0045936c  subeq     sb, r5, r0, lsl #12  rel→
00459370  subeq     sb, r5, r0, lsl r6  rel→
00459374  subeq     sb, r5, r0, lsr #12  rel→
00459378  subeq     sb, r5, r0, lsr r6  rel→
0045937c  subeq     sb, r5, r0, asr #12  rel→
00459380  subeq     sb, r5, r0, asr r6  rel→
00459384  subeq     sb, r5, r0, ror #12  rel→
00459388  subeq     sb, r5, r0, ror r6  rel→
0045938c  subeq     sb, r5, r0, lsl #13  rel→
00459390  umaaleq   sb, r5, r0, r6  rel→
00459394  subeq     sb, r5, r0, lsr #13  rel→
00459398  strheq    sb, [r5], #-0x60  rel→
0045939c  subeq     sb, r5, r0, asr #13  rel→
004593a0  ldrdeq    sb, sl, [r5], #-0x60  rel→
004593a4  subeq     sb, r5, r0, ror #13  rel→
004593a8  strdeq    sb, sl, [r5], #-0x60  rel→
004593ac  subeq     sb, r5, r0, lsl #6  rel→
004593b0  subeq     sb, r5, r0, lsl #14  rel→
004593b4  subeq     sb, r5, r0, lsl #6  rel→
004593b8  subeq     sb, r5, r0, lsl r7  rel→
004593bc  subeq     sb, r5, r0, lsl #6  rel→
004593c0  subeq     sb, r5, r0, lsr #14  rel→
004593c4  subeq     sb, r5, r0, lsl #6  rel→
004593c8  subeq     sb, r5, r0, lsr r7  rel→
004593cc  subeq     sb, r5, r0, lsl #6  rel→
004593d0  subeq     sb, r5, r0, asr #14  rel→
004593d4  subeq     sb, r5, r0, asr r7  rel→
004593d8  subeq     sb, r5, r0, ror #14  rel→
004593dc  subeq     sb, r5, r0, ror r7  rel→
004593e0  subeq     sb, r5, r0, lsl #15  rel→
004593e4  umaaleq   sb, r5, r0, r7  rel→
004593e8  subeq     sb, r5, r0, lsr #15  rel→
004593ec  strheq    sb, [r5], #-0x70  rel→
004593f0  subeq     sb, r5, r0, asr #15  rel→
004593f4  ldrdeq    sb, sl, [r5], #-0x70  rel→
004593f8  subeq     sb, r5, r0, ror #15  rel→
004593fc  strdeq    sb, sl, [r5], #-0x70  rel→
00459400  subeq     sb, r5, r4, lsl #16  rel→
00459404  subeq     sb, r5, r4, lsl r8  rel→
00459408  subeq     sb, r5, r8, lsr #16  rel→
0045940c  subeq     sb, r5, r8, lsr r8  rel→
00459410  subeq     sb, r5, ip, asr #16  rel→
00459414  subeq     sb, r5, r0, ror #16  rel→
00459418  subeq     sb, r5, r4, ror r8  rel→
0045941c  subeq     sb, r5, r4, lsl #17  rel→
00459420  umaaleq   sb, r5, r4, r8  rel→
00459424  subeq     sb, r5, r4, lsr #17  rel→
00459428  strheq    sb, [r5], #-0x88  rel→
0045942c  subeq     sb, r5, ip, asr #17  rel→
00459430  subeq     sb, r5, r0, ror #17  rel→
00459434  subeq     sb, r5, ip, ror #17  rel→
00459438  subeq     sb, r5, r0, lsl #6  rel→
0045943c  subeq     sb, r5, r0, lsl #18  rel→
00459440  subeq     sb, r5, r0, lsl sb  rel→
00459444  subeq     sb, r5, r0, lsl #6  rel→
00459448  subeq     sb, r5, r4, lsr #18  rel→
0045944c  subeq     sb, r5, r0, lsr sb  rel→
00459450  subeq     sb, r5, ip, lsr sb  rel→
00459454  subeq     sb, r5, r4, asr #18  rel→
00459458  subeq     sb, r5, r4, asr sb  rel→
0045945c  subeq     sb, r5, r0, ror #18  rel→
00459460  subeq     sb, r5, r0, ror sb  rel→
00459464  subeq     sb, r5, r0, lsl #19  rel→
00459468  umaaleq   sb, r5, r4, sb  rel→
0045946c  subeq     sb, r5, r8, lsr #19  rel→
00459470  strheq    sb, [r5], #-0x98  rel→
00459474  subeq     sb, r5, ip, asr #19  rel→
00459478  ldrdeq    sb, sl, [r5], #-0x9c  rel→
0045947c  subeq     sb, r5, ip, ror #19  rel→
00459480  subeq     sb, r5, r0, lsl #20  rel→
00459484  subeq     sb, r5, r4, lsl sl  rel→
00459488  subeq     sb, r5, r8, lsr #20  rel→
0045948c  mov       r1, #0x4f0
00459490  smlabb    r0, r4, r1, r0
00459494  add       r4, r0, #0x80
00459498  b         #0x459a34
0045949c  movw      r0, #0  rel→g_AudioVars2
004594a0  mov       r5, #0
004594a4  movt      r0, #0  rel→g_AudioVars2
004594a8  ldr       r0, [r0]
004594ac  cmp       r0, #0
004594b0  ldrne     r0, [r0, #0x4c8]
004594b4  cmpne     r0, #0
004594b8  beq       #0x459300
004594bc  movw      r0, #0  rel→.L.str.9
004594c0  movt      r0, #0  rel→.L.str.9
004594c4  bl        #0x4594c4  rel→UtopiaLogSystem; CALL UtopiaLogSystem
004594c8  cmp       r0, #1
004594cc  bne       #0x459300
004594d0  movw      r0, #0  rel→.L.str.31
004594d4  movw      r1, #0  rel→.L__FUNCTION__.HAL_DEC_R2_Get_SHM_INFO
004594d8  movt      r0, #0  rel→.L.str.31
004594dc  movt      r1, #0  rel→.L__FUNCTION__.HAL_DEC_R2_Get_SHM_INFO
004594e0  bl        #0x4594e0  rel→printk; CALL printk
004594e4  mov       r0, r5
004594e8  pop       {r4, r5, r6, pc}
004594ec  mov       r1, #0x4f0
004594f0  smlabb    r0, r4, r1, r0
004594f4  add       r4, r0, #0x84
004594f8  b         #0x459a34
004594fc  mov       r1, #0x4f0
00459500  smlabb    r0, r4, r1, r0
00459504  add       r4, r0, #0x88
00459508  b         #0x459a34
0045950c  mov       r1, #0x4f0
00459510  smlabb    r0, r4, r1, r0
00459514  add       r4, r0, #0x94
00459518  b         #0x459a34
0045951c  mov       r1, #0x4f0
00459520  smlabb    r0, r4, r1, r0
00459524  add       r4, r0, #0xa0
00459528  b         #0x459a34
0045952c  mov       r1, #0x4f0
00459530  smlabb    r0, r4, r1, r0
00459534  add       r4, r0, #0xa4
00459538  b         #0x459a34
0045953c  mov       r1, #0x4f0
00459540  smlabb    r0, r4, r1, r0
00459544  add       r4, r0, #0xa8
00459548  b         #0x459a34
0045954c  mov       r1, #0x4f0
00459550  smlabb    r0, r4, r1, r0
00459554  add       r4, r0, #0xac
00459558  b         #0x459a34
0045955c  add       r4, r0, r1, lsl #5
00459560  b         #0x459a34
00459564  mov       r1, #0x4f0
00459568  smlabb    r0, r4, r1, r0
0045956c  add       r4, r0, #0xb0
00459570  b         #0x459a34
00459574  mov       r1, #0x4f0
00459578  smlabb    r0, r4, r1, r0
0045957c  movw      r1, #0x4cc
00459580  add       r4, r0, r1
00459584  b         #0x459a34
00459588  add       r0, r0, r1, lsl #5
0045958c  add       r4, r0, #4
00459590  b         #0x459a34
00459594  mov       r1, #0x4f0
00459598  smlabb    r0, r4, r1, r0
0045959c  add       r4, r0, #0x118
004595a0  b         #0x459a34
004595a4  mov       r1, #0x4f0
004595a8  smlabb    r0, r4, r1, r0
004595ac  add       r4, r0, #0x8c
004595b0  b         #0x459a34
004595b4  add       r0, r0, r1, lsl #5
004595b8  add       r4, r0, #8
004595bc  b         #0x459a34
004595c0  mov       r1, #0x4f0
004595c4  smlabb    r0, r4, r1, r0
004595c8  add       r4, r0, #0xcc
004595cc  b         #0x459a34
004595d0  mov       r1, #0x4f0
004595d4  smlabb    r0, r4, r1, r0
004595d8  add       r4, r0, #0xd0
004595dc  b         #0x459a34
004595e0  mov       r1, #0x4f0
004595e4  smlabb    r0, r4, r1, r0
004595e8  add       r4, r0, #0xd4
004595ec  b         #0x459a34
004595f0  mov       r1, #0x4f0
004595f4  smlabb    r0, r4, r1, r0
004595f8  add       r4, r0, #0xd8
004595fc  b         #0x459a34
00459600  mov       r1, #0x4f0
00459604  smlabb    r0, r4, r1, r0
00459608  add       r4, r0, #0xdc
0045960c  b         #0x459a34
00459610  mov       r1, #0x4f0
00459614  smlabb    r0, r4, r1, r0
00459618  add       r4, r0, #0xe0
0045961c  b         #0x459a34
00459620  mov       r1, #0x4f0
00459624  smlabb    r0, r4, r1, r0
00459628  add       r4, r0, #0xe4
0045962c  b         #0x459a34
00459630  mov       r1, #0x4f0
00459634  smlabb    r0, r4, r1, r0
00459638  add       r4, r0, #0xe8
0045963c  b         #0x459a34
00459640  mov       r1, #0x4f0
00459644  smlabb    r0, r4, r1, r0
00459648  add       r4, r0, #0xec
0045964c  b         #0x459a34
00459650  mov       r1, #0x4f0
00459654  smlabb    r0, r4, r1, r0
00459658  add       r4, r0, #0xf0
0045965c  b         #0x459a34
00459660  mov       r1, #0x4f0
00459664  smlabb    r0, r4, r1, r0
00459668  add       r4, r0, #0xf4
0045966c  b         #0x459a34
00459670  mov       r1, #0x4f0
00459674  smlabb    r0, r4, r1, r0
00459678  add       r4, r0, #0xf8
0045967c  b         #0x459a34
00459680  mov       r1, #0x4f0
00459684  smlabb    r0, r4, r1, r0
00459688  add       r4, r0, #0xfc
0045968c  b         #0x459a34
00459690  mov       r1, #0x4f0
00459694  smlabb    r0, r4, r1, r0
00459698  add       r4, r0, #0x104
0045969c  b         #0x459a34
004596a0  mov       r1, #0x4f0
004596a4  smlabb    r0, r4, r1, r0
004596a8  add       r4, r0, #0x108
004596ac  b         #0x459a34
004596b0  mov       r1, #0x4f0
004596b4  smlabb    r0, r4, r1, r0
004596b8  add       r4, r0, #0x10c
004596bc  b         #0x459a34
004596c0  mov       r1, #0x4f0
004596c4  smlabb    r0, r4, r1, r0
004596c8  add       r4, r0, #0x110
004596cc  b         #0x459a34
004596d0  mov       r1, #0x4f0
004596d4  smlabb    r0, r4, r1, r0
004596d8  add       r4, r0, #0x114
004596dc  b         #0x459a34
004596e0  mov       r1, #0x4f0
004596e4  smlabb    r0, r4, r1, r0
004596e8  add       r4, r0, #0x100
004596ec  b         #0x459a34
004596f0  mov       r1, #0x4f0
004596f4  smlabb    r0, r4, r1, r0
004596f8  add       r4, r0, #0xb8
004596fc  b         #0x459a34
00459700  mov       r1, #0x4f0
00459704  smlabb    r0, r4, r1, r0
00459708  add       r4, r0, #0xbc
0045970c  b         #0x459a34
00459710  mov       r1, #0x4f0
00459714  smlabb    r0, r4, r1, r0
00459718  add       r4, r0, #0xc0
0045971c  b         #0x459a34
00459720  mov       r1, #0x4f0
00459724  smlabb    r0, r4, r1, r0
00459728  add       r4, r0, #0xc4
0045972c  b         #0x459a34
00459730  mov       r1, #0x4f0
00459734  smlabb    r0, r4, r1, r0
00459738  add       r4, r0, #0x164
0045973c  b         #0x459a34
00459740  mov       r1, #0x4f0
00459744  smlabb    r0, r4, r1, r0
00459748  add       r4, r0, #0x124
0045974c  b         #0x459a34
00459750  mov       r1, #0x4f0
00459754  smlabb    r0, r4, r1, r0
00459758  add       r4, r0, #0x128
0045975c  b         #0x459a34
00459760  mov       r1, #0x4f0
00459764  smlabb    r0, r4, r1, r0
00459768  add       r4, r0, #0x12c
0045976c  b         #0x459a34
00459770  mov       r1, #0x4f0
00459774  smlabb    r0, r4, r1, r0
00459778  add       r4, r0, #0x11c
0045977c  b         #0x459a34
00459780  mov       r1, #0x4f0
00459784  smlabb    r0, r4, r1, r0
00459788  add       r4, r0, #0x120
0045978c  b         #0x459a34
00459790  mov       r1, #0x4f0
00459794  smlabb    r0, r4, r1, r0
00459798  add       r4, r0, #0xb4
0045979c  b         #0x459a34
004597a0  mov       r1, #0x4f0
004597a4  smlabb    r0, r4, r1, r0
004597a8  add       r4, r0, #0x144
004597ac  b         #0x459a34
004597b0  mov       r1, #0x4f0
004597b4  smlabb    r0, r4, r1, r0
004597b8  add       r4, r0, #0x168
004597bc  b         #0x459a34
004597c0  mov       r1, #0x4f0
004597c4  smlabb    r0, r4, r1, r0
004597c8  add       r4, r0, #0x16c
004597cc  b         #0x459a34
004597d0  mov       r1, #0x4f0
004597d4  smlabb    r0, r4, r1, r0
004597d8  add       r4, r0, #0x170
004597dc  b         #0x459a34
004597e0  mov       r1, #0x4f0
004597e4  smlabb    r0, r4, r1, r0
004597e8  add       r4, r0, #0x174
004597ec  b         #0x459a34
004597f0  mov       r1, #0x4f0
004597f4  smlabb    r0, r4, r1, r0
004597f8  movw      r1, #0x448
004597fc  add       r4, r0, r1
00459800  b         #0x459a34
00459804  mov       r1, #0x4f0
00459808  smlabb    r0, r4, r1, r0
0045980c  add       r4, r0, #0x450
00459810  b         #0x459a34
00459814  mov       r1, #0x4f0
00459818  smlabb    r0, r4, r1, r0
0045981c  movw      r1, #0x46c
00459820  add       r4, r0, r1
00459824  b         #0x459a34
00459828  mov       r1, #0x4f0
0045982c  smlabb    r0, r4, r1, r0
00459830  add       r4, r0, #0x470
00459834  b         #0x459a34
00459838  mov       r1, #0x4f0
0045983c  smlabb    r0, r4, r1, r0
00459840  movw      r1, #0x474
00459844  add       r4, r0, r1
00459848  b         #0x459a34
0045984c  mov       r1, #0x4f0
00459850  smlabb    r0, r4, r1, r0
00459854  movw      r1, #0x4b4
00459858  add       r4, r0, r1
0045985c  b         #0x459a34
00459860  mov       r1, #0x4f0
00459864  smlabb    r0, r4, r1, r0
00459868  movw      r1, #0x498
0045986c  add       r4, r0, r1
00459870  b         #0x459a34
00459874  mov       r1, #0x4f0
00459878  smlabb    r0, r4, r1, r0
0045987c  add       r4, r0, #0x98
00459880  b         #0x459a34
00459884  mov       r1, #0x4f0
00459888  smlabb    r0, r4, r1, r0
0045988c  add       r4, r0, #0x9c
00459890  b         #0x459a34
00459894  mov       r1, #0x4f0
00459898  smlabb    r0, r4, r1, r0
0045989c  add       r4, r0, #0x160
004598a0  b         #0x459a34
004598a4  mov       r1, #0x4f0
004598a8  smlabb    r0, r4, r1, r0
004598ac  movw      r1, #0x4bc
004598b0  add       r4, r0, r1
004598b4  b         #0x459a34
004598b8  mov       r1, #0x4f0
004598bc  smlabb    r0, r4, r1, r0
004598c0  movw      r1, #0x4d4
004598c4  add       r4, r0, r1
004598c8  b         #0x459a34
004598cc  mov       r1, #0x4f0
004598d0  smlabb    r0, r4, r1, r0
004598d4  movw      r1, #0x4d8
004598d8  add       r4, r0, r1
004598dc  b         #0x459a34
004598e0  movw      r1, #0xd08
004598e4  add       r4, r0, r1
004598e8  b         #0x459a34
004598ec  mov       r1, #0x4f0
004598f0  smlabb    r0, r4, r1, r0
004598f4  movw      r1, #0x4dc
004598f8  add       r4, r0, r1
004598fc  b         #0x459a34
00459900  mov       r1, #0x4f0
00459904  smlabb    r0, r4, r1, r0
00459908  add       r4, r0, #0xc8
0045990c  b         #0x459a34
00459910  mov       r1, #0x4f0
00459914  smlabb    r0, r4, r1, r0
00459918  movw      r1, #0x454
0045991c  add       r4, r0, r1
00459920  b         #0x459a34
00459924  movw      r1, #0xcf8
00459928  add       r4, r0, r1
0045992c  b         #0x459a34
00459930  movw      r1, #0xcfc
00459934  add       r4, r0, r1
00459938  b         #0x459a34
0045993c  add       r4, r0, #0xd00
00459940  b         #0x459a34
00459944  mov       r1, #0x4f0
00459948  smlabb    r0, r4, r1, r0
0045994c  add       r4, r0, #0x17c
00459950  b         #0x459a34
00459954  movw      r1, #0xd0c
00459958  add       r4, r0, r1
0045995c  b         #0x459a34
00459960  mov       r1, #0x4f0
00459964  smlabb    r0, r4, r1, r0
00459968  add       r4, r0, #0x180
0045996c  b         #0x459a34
00459970  mov       r1, #0x4f0
00459974  smlabb    r0, r4, r1, r0
00459978  add       r4, r0, #0x3cc
0045997c  b         #0x459a34
00459980  mov       r1, #0x4f0
00459984  smlabb    r0, r4, r1, r0
00459988  movw      r1, #0x4f4
0045998c  add       r4, r0, r1
00459990  b         #0x459a34
00459994  mov       r1, #0x4f0
00459998  smlabb    r0, r4, r1, r0
0045999c  movw      r1, #0x4f8
004599a0  add       r4, r0, r1
004599a4  b         #0x459a34
004599a8  mov       r1, #0x4f0
004599ac  smlabb    r0, r4, r1, r0
004599b0  add       r4, r0, #0x178
004599b4  b         #0x459a34
004599b8  mov       r1, #0x4f0
004599bc  smlabb    r0, r4, r1, r0
004599c0  movw      r1, #0x50c
004599c4  add       r4, r0, r1
004599c8  b         #0x459a34
004599cc  mov       r1, #0x4f0
004599d0  smlabb    r0, r4, r1, r0
004599d4  add       r4, r0, #0x510
004599d8  b         #0x459a34
004599dc  mov       r1, #0x4f0
004599e0  smlabb    r0, r4, r1, r0
004599e4  add       r4, r0, #0x480
004599e8  b         #0x459a34
004599ec  mov       r1, #0x4f0
004599f0  smlabb    r0, r4, r1, r0
004599f4  movw      r1, #0x484
004599f8  add       r4, r0, r1
004599fc  b         #0x459a34
00459a00  mov       r1, #0x4f0
00459a04  smlabb    r0, r4, r1, r0
00459a08  movw      r1, #0x488
00459a0c  add       r4, r0, r1
00459a10  b         #0x459a34
00459a14  mov       r1, #0x4f0
00459a18  smlabb    r0, r4, r1, r0
00459a1c  movw      r1, #0x48c
00459a20  add       r4, r0, r1
00459a24  b         #0x459a34
00459a28  mov       r1, #0x4f0
00459a2c  smlabb    r0, r4, r1, r0
00459a30  add       r4, r0, #0x490
00459a34  bl        #0x459a34  rel→MsOS_FlushMemory; CALL MsOS_FlushMemory
00459a38  ldr       r5, [r4]
00459a3c  mov       r0, r5
00459a40  pop       {r4, r5, r6, pc}
