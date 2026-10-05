
===== MDrv_AUDIO_Get_AAC_License @ 0x422340 size 0x1c4 =====
0x422340  push    {r4, r5, r6, r7, fp, lr}
0x422344  mov     r0, #0x46
0x422348  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x42234c  sub     r0, r0, #1
0x422350  clz     r0, r0
0x422354  lsr     r4, r0, #5
0x422358  mov     r0, #0x50
0x42235c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422360  cmp     r0, #1
0x422364  mov     r0, #0x51
0x422368  orreq   r4, r4, #2
0x42236c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422370  cmp     r0, #1
0x422374  mov     r0, #0x52
0x422378  orreq   r4, r4, #4
0x42237c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422380  cmp     r0, #1
0x422384  mov     r0, #0x54
0x422388  orreq   r4, r4, #8
0x42238c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422390  cmp     r0, #1
0x422394  beq     #0x4223a8
0x422398  mov     r0, #9
0x42239c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4223a0  cmp     r0, #1
0x4223a4  bne     #0x4223b0
0x4223a8  orr     r4, r4, #0x10
0x4223ac  b       #0x4223c0
0x4223b0  mov     r0, #0x7d
0x4223b4  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4223b8  cmp     r0, #1
0x4223bc  orreq   r4, r4, #0x10
0x4223c0  movw    r7, #0
0x4223c4  movt    r7, #0
0x4223c8  ldr     r0, [r7]
0x4223cc  cmp     r0, #0
0x4223d0  beq     #0x4223f4
0x4223d4  ldr     r0, [r0, #0x4c8]
0x4223d8  cmp     r0, #4
0x4223dc  blo     #0x4223f4
0x4223e0  movw    r0, #0
0x4223e4  movt    r0, #0
0x4223e8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4223ec  cmp     r0, #1
0x4223f0  beq     #0x4224a0
0x4223f4  movw    r0, #0x2cf0
0x4223f8  movt    r0, #0x11
0x4223fc  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422400  mov     r6, #0x1f
0x422404  tst     r0, #0x1000
0x422408  beq     #0x422420
0x42240c  mov     r1, #0x10
0x422410  tst     r0, #4
0x422414  and     r1, r1, r0, lsl #4
0x422418  orrne   r1, r1, #0xe
0x42241c  orr     r6, r1, #1
0x422420  ldr     r0, [r7]
0x422424  cmp     r0, #0
0x422428  beq     #0x42248c
0x42242c  ldr     r0, [r0, #0x4c8]
0x422430  cmp     r0, #4
0x422434  blo     #0x42244c
0x422438  movw    r0, #0
0x42243c  movt    r0, #0
0x422440  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422444  cmp     r0, #1
0x422448  beq     #0x4224c0
0x42244c  ldr     r0, [r7]
0x422450  ands    r4, r6, r4
0x422454  mov     r5, #0
0x422458  mvneq   r5, #0
0x42245c  cmp     r0, #0
0x422460  beq     #0x422484
0x422464  ldr     r0, [r0, #0x4c8]
0x422468  cmp     r0, #4
0x42246c  blo     #0x422484
0x422470  movw    r0, #0
0x422474  movt    r0, #0
0x422478  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42247c  cmp     r0, #1
0x422480  beq     #0x4224e0
0x422484  mov     r0, r5
0x422488  pop     {r4, r5, r6, r7, fp, pc}
0x42248c  mov     r5, #0
0x422490  tst     r6, r4
0x422494  mvneq   r5, #0
0x422498  mov     r0, r5
0x42249c  pop     {r4, r5, r6, r7, fp, pc}
0x4224a0  movw    r0, #0
0x4224a4  movw    r1, #0
0x4224a8  movt    r0, #0
0x4224ac  movt    r1, #0
0x4224b0  movw    r2, #0x146
0x4224b4  mov     r3, r4
0x4224b8  bl      #0xfffffff8   ; CALL printk
0x4224bc  b       #0x4223f4
0x4224c0  movw    r0, #0
0x4224c4  movw    r1, #0
0x4224c8  movt    r0, #0
0x4224cc  movt    r1, #0
0x4224d0  movw    r2, #0x163
0x4224d4  mov     r3, r6
0x4224d8  bl      #0xfffffff8   ; CALL printk
0x4224dc  b       #0x42244c
0x4224e0  movw    r0, #0
0x4224e4  movw    r1, #0
0x4224e8  movt    r0, #0
0x4224ec  movt    r1, #0
0x4224f0  mov     r2, #0x16c
0x4224f4  mov     r3, r4
0x4224f8  bl      #0xfffffff8   ; CALL printk
0x4224fc  mov     r0, r5
0x422500  pop     {r4, r5, r6, r7, fp, pc}

===== MDrv_AUDIO_Get_AC3_License @ 0x422504 size 0x250 =====
0x422504  push    {r4, r5, r6, r7, fp, lr}
0x422508  mov     r0, #0xb
0x42250c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422510  cmp     r0, #1
0x422514  bne     #0x422520
0x422518  mov     r4, #1
0x42251c  b       #0x422534
0x422520  mov     r0, #0xc
0x422524  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422528  mov     r4, #0
0x42252c  cmp     r0, #1
0x422530  moveq   r4, #1
0x422534  mov     r0, #0x50
0x422538  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x42253c  cmp     r0, #1
0x422540  bne     #0x42254c
0x422544  orr     r4, r4, #2
0x422548  b       #0x42255c
0x42254c  mov     r0, #0x73
0x422550  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422554  cmp     r0, #1
0x422558  orreq   r4, r4, #2
0x42255c  mov     r0, #0x51
0x422560  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422564  cmp     r0, #1
0x422568  bne     #0x422574
0x42256c  orr     r4, r4, #4
0x422570  b       #0x422584
0x422574  mov     r0, #0x74
0x422578  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x42257c  cmp     r0, #1
0x422580  orreq   r4, r4, #4
0x422584  mov     r0, #0x52
0x422588  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x42258c  cmp     r0, #1
0x422590  bne     #0x42259c
0x422594  orr     r4, r4, #8
0x422598  b       #0x4225ac
0x42259c  mov     r0, #0x75
0x4225a0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225a4  cmp     r0, #1
0x4225a8  orreq   r4, r4, #8
0x4225ac  mov     r0, #0x54
0x4225b0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225b4  cmp     r0, #1
0x4225b8  beq     #0x4225fc
0x4225bc  mov     r0, #8
0x4225c0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225c4  cmp     r0, #1
0x4225c8  beq     #0x4225fc
0x4225cc  mov     r0, #9
0x4225d0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225d4  cmp     r0, #1
0x4225d8  beq     #0x4225fc
0x4225dc  mov     r0, #0x66
0x4225e0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225e4  cmp     r0, #1
0x4225e8  beq     #0x4225fc
0x4225ec  mov     r0, #0xa
0x4225f0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4225f4  cmp     r0, #1
0x4225f8  bne     #0x4226dc
0x4225fc  orr     r4, r4, #0x10
0x422600  movw    r7, #0
0x422604  movt    r7, #0
0x422608  ldr     r0, [r7]
0x42260c  cmp     r0, #0
0x422610  beq     #0x422634
0x422614  ldr     r0, [r0, #0x4c8]
0x422618  cmp     r0, #4
0x42261c  blo     #0x422634
0x422620  movw    r0, #0
0x422624  movt    r0, #0
0x422628  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42262c  cmp     r0, #1
0x422630  beq     #0x4226f0
0x422634  movw    r0, #0x2cf0
0x422638  movt    r0, #0x11
0x42263c  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422640  mov     r6, #0x1f
0x422644  tst     r0, #0x1000
0x422648  beq     #0x42265c
0x42264c  mov     r1, #0x10
0x422650  and     r6, r1, r0, lsl #4
0x422654  tst     r0, #3
0x422658  orrne   r6, r6, #0xf
0x42265c  ldr     r0, [r7]
0x422660  cmp     r0, #0
0x422664  beq     #0x4226c8
0x422668  ldr     r0, [r0, #0x4c8]
0x42266c  cmp     r0, #4
0x422670  blo     #0x422688
0x422674  movw    r0, #0
0x422678  movt    r0, #0
0x42267c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422680  cmp     r0, #1
0x422684  beq     #0x422710
0x422688  ldr     r0, [r7]
0x42268c  ands    r4, r6, r4
0x422690  mov     r5, #0
0x422694  mvneq   r5, #0
0x422698  cmp     r0, #0
0x42269c  beq     #0x4226c0
0x4226a0  ldr     r0, [r0, #0x4c8]
0x4226a4  cmp     r0, #4
0x4226a8  blo     #0x4226c0
0x4226ac  movw    r0, #0
0x4226b0  movt    r0, #0
0x4226b4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4226b8  cmp     r0, #1
0x4226bc  beq     #0x422730
0x4226c0  mov     r0, r5
0x4226c4  pop     {r4, r5, r6, r7, fp, pc}
0x4226c8  mov     r5, #0
0x4226cc  tst     r6, r4
0x4226d0  mvneq   r5, #0
0x4226d4  mov     r0, r5
0x4226d8  pop     {r4, r5, r6, r7, fp, pc}
0x4226dc  mov     r0, #0x7d
0x4226e0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4226e4  cmp     r0, #1
0x4226e8  orreq   r4, r4, #0x10
0x4226ec  b       #0x422600
0x4226f0  movw    r0, #0
0x4226f4  movw    r1, #0
0x4226f8  movt    r0, #0
0x4226fc  movt    r1, #0
0x422700  mov     r2, #0x19c
0x422704  mov     r3, r4
0x422708  bl      #0xfffffff8   ; CALL printk
0x42270c  b       #0x422634
0x422710  movw    r0, #0
0x422714  movw    r1, #0
0x422718  movt    r0, #0
0x42271c  movt    r1, #0
0x422720  movw    r2, #0x1ba
0x422724  mov     r3, r6
0x422728  bl      #0xfffffff8   ; CALL printk
0x42272c  b       #0x422688
0x422730  movw    r0, #0
0x422734  movw    r1, #0
0x422738  movt    r0, #0
0x42273c  movt    r1, #0
0x422740  movw    r2, #0x1c3
0x422744  mov     r3, r4
0x422748  bl      #0xfffffff8   ; CALL printk
0x42274c  mov     r0, r5
0x422750  pop     {r4, r5, r6, r7, fp, pc}

===== MDrv_AUDIO_Get_AC4_License @ 0x422754 size 0x1b4 =====
0x422754  push    {r4, r5, r6, r7, fp, lr}
0x422758  mov     r0, #0x79
0x42275c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422760  sub     r0, r0, #1
0x422764  clz     r0, r0
0x422768  lsr     r4, r0, #5
0x42276c  mov     r0, #0x7d
0x422770  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422774  cmp     r0, #1
0x422778  beq     #0x4227bc
0x42277c  mov     r0, #0xa
0x422780  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422784  cmp     r0, #1
0x422788  beq     #0x4227bc
0x42278c  mov     r0, #8
0x422790  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422794  cmp     r0, #1
0x422798  beq     #0x4227bc
0x42279c  mov     r0, #0x66
0x4227a0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4227a4  cmp     r0, #1
0x4227a8  beq     #0x4227bc
0x4227ac  mov     r0, #9
0x4227b0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4227b4  cmp     r0, #1
0x4227b8  bne     #0x422890
0x4227bc  orr     r4, r4, #2
0x4227c0  movw    r7, #0
0x4227c4  movt    r7, #0
0x4227c8  ldr     r0, [r7]
0x4227cc  cmp     r0, #0
0x4227d0  beq     #0x4227f4
0x4227d4  ldr     r0, [r0, #0x4c8]
0x4227d8  cmp     r0, #4
0x4227dc  blo     #0x4227f4
0x4227e0  movw    r0, #0
0x4227e4  movt    r0, #0
0x4227e8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4227ec  cmp     r0, #1
0x4227f0  beq     #0x4228a4
0x4227f4  movw    r0, #0x2cf0
0x4227f8  movt    r0, #0x11
0x4227fc  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422800  movw    r1, #0x1001
0x422804  and     r0, r0, r1
0x422808  subs    r6, r0, #0x1000
0x42280c  ldr     r0, [r7]
0x422810  movwne  r6, #3
0x422814  cmp     r0, #0
0x422818  beq     #0x42287c
0x42281c  ldr     r0, [r0, #0x4c8]
0x422820  cmp     r0, #4
0x422824  blo     #0x42283c
0x422828  movw    r0, #0
0x42282c  movt    r0, #0
0x422830  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422834  cmp     r0, #1
0x422838  beq     #0x4228c4
0x42283c  ldr     r0, [r7]
0x422840  ands    r4, r6, r4
0x422844  mov     r5, #0
0x422848  mvneq   r5, #0
0x42284c  cmp     r0, #0
0x422850  beq     #0x422874
0x422854  ldr     r0, [r0, #0x4c8]
0x422858  cmp     r0, #4
0x42285c  blo     #0x422874
0x422860  movw    r0, #0
0x422864  movt    r0, #0
0x422868  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42286c  cmp     r0, #1
0x422870  beq     #0x4228e4
0x422874  mov     r0, r5
0x422878  pop     {r4, r5, r6, r7, fp, pc}
0x42287c  mov     r5, #0
0x422880  tst     r6, r4
0x422884  mvneq   r5, #0
0x422888  mov     r0, r5
0x42288c  pop     {r4, r5, r6, r7, fp, pc}
0x422890  mov     r0, #0x54
0x422894  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422898  cmp     r0, #1
0x42289c  orreq   r4, r4, #2
0x4228a0  b       #0x4227c0
0x4228a4  movw    r0, #0
0x4228a8  movw    r1, #0
0x4228ac  movt    r0, #0
0x4228b0  movt    r1, #0
0x4228b4  mov     r2, #0x1e0
0x4228b8  mov     r3, r4
0x4228bc  bl      #0xfffffff8   ; CALL printk
0x4228c0  b       #0x4227f4
0x4228c4  movw    r0, #0
0x4228c8  movw    r1, #0
0x4228cc  movt    r0, #0
0x4228d0  movt    r1, #0
0x4228d4  movw    r2, #0x1eb
0x4228d8  mov     r3, r6
0x4228dc  bl      #0xfffffff8   ; CALL printk
0x4228e0  b       #0x42283c
0x4228e4  movw    r0, #0
0x4228e8  movw    r1, #0
0x4228ec  movt    r0, #0
0x4228f0  movt    r1, #0
0x4228f4  mov     r2, #0x1f4
0x4228f8  mov     r3, r4
0x4228fc  bl      #0xfffffff8   ; CALL printk
0x422900  mov     r0, r5
0x422904  pop     {r4, r5, r6, r7, fp, pc}

===== MDrv_AUDIO_Get_MAT_License @ 0x422908 size 0x198 =====
0x422908  push    {r4, r5, r6, lr}
0x42290c  mov     r0, #0x7d
0x422910  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422914  cmp     r0, #1
0x422918  beq     #0x42295c
0x42291c  mov     r0, #0xa
0x422920  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422924  cmp     r0, #1
0x422928  beq     #0x42295c
0x42292c  mov     r0, #8
0x422930  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422934  cmp     r0, #1
0x422938  beq     #0x42295c
0x42293c  mov     r0, #0x66
0x422940  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422944  cmp     r0, #1
0x422948  beq     #0x42295c
0x42294c  mov     r0, #9
0x422950  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422954  cmp     r0, #1
0x422958  bne     #0x422a24
0x42295c  mov     r4, #1
0x422960  movw    r6, #0
0x422964  movt    r6, #0
0x422968  ldr     r0, [r6]
0x42296c  cmp     r0, #0
0x422970  beq     #0x422994
0x422974  ldr     r0, [r0, #0x4c8]
0x422978  cmp     r0, #4
0x42297c  blo     #0x422994
0x422980  movw    r0, #0
0x422984  movt    r0, #0
0x422988  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42298c  cmp     r0, #1
0x422990  beq     #0x422a3c
0x422994  movw    r0, #0x2cf0
0x422998  movt    r0, #0x11
0x42299c  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x4229a0  movw    r1, #0x1001
0x4229a4  and     r0, r0, r1
0x4229a8  subs    r5, r0, #0x1000
0x4229ac  ldr     r0, [r6]
0x4229b0  movwne  r5, #1
0x4229b4  cmp     r0, #0
0x4229b8  beq     #0x422a18
0x4229bc  ldr     r0, [r0, #0x4c8]
0x4229c0  cmp     r0, #4
0x4229c4  blo     #0x4229dc
0x4229c8  movw    r0, #0
0x4229cc  movt    r0, #0
0x4229d0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4229d4  cmp     r0, #1
0x4229d8  beq     #0x422a5c
0x4229dc  and     r5, r4, r5
0x4229e0  ldr     r0, [r6]
0x4229e4  sub     r4, r5, #1
0x4229e8  cmp     r0, #0
0x4229ec  beq     #0x422a10
0x4229f0  ldr     r0, [r0, #0x4c8]
0x4229f4  cmp     r0, #4
0x4229f8  blo     #0x422a10
0x4229fc  movw    r0, #0
0x422a00  movt    r0, #0
0x422a04  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422a08  cmp     r0, #1
0x422a0c  beq     #0x422a7c
0x422a10  mov     r0, r4
0x422a14  pop     {r4, r5, r6, pc}
0x422a18  and     r0, r4, r5
0x422a1c  sub     r0, r0, #1
0x422a20  pop     {r4, r5, r6, pc}
0x422a24  mov     r0, #0x54
0x422a28  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422a2c  mov     r4, #0
0x422a30  cmp     r0, #1
0x422a34  moveq   r4, #1
0x422a38  b       #0x422960
0x422a3c  movw    r0, #0
0x422a40  movw    r1, #0
0x422a44  movt    r0, #0
0x422a48  movt    r1, #0
0x422a4c  mov     r2, #0x20c
0x422a50  mov     r3, r4
0x422a54  bl      #0xfffffff8   ; CALL printk
0x422a58  b       #0x422994
0x422a5c  movw    r0, #0
0x422a60  movw    r1, #0
0x422a64  movt    r0, #0
0x422a68  movt    r1, #0
0x422a6c  movw    r2, #0x216
0x422a70  mov     r3, r5
0x422a74  bl      #0xfffffff8   ; CALL printk
0x422a78  b       #0x4229dc
0x422a7c  movw    r0, #0
0x422a80  movw    r1, #0
0x422a84  movt    r0, #0
0x422a88  movt    r1, #0
0x422a8c  movw    r2, #0x21f
0x422a90  mov     r3, r5
0x422a94  bl      #0xfffffff8   ; CALL printk
0x422a98  mov     r0, r4
0x422a9c  pop     {r4, r5, r6, pc}

===== MDrv_AUDIO_Get_DTS_License @ 0x422aa0 size 0x178 =====
0x422aa0  push    {r4, r5, r6, r7, fp, lr}
0x422aa4  mov     r0, #0xf
0x422aa8  mov     r5, #0xf
0x422aac  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422ab0  sub     r0, r0, #1
0x422ab4  clz     r0, r0
0x422ab8  lsr     r4, r0, #5
0x422abc  mov     r0, #0x3a
0x422ac0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422ac4  cmp     r0, #1
0x422ac8  mov     r0, #0x12
0x422acc  orreq   r4, r4, #2
0x422ad0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422ad4  cmp     r0, #1
0x422ad8  mov     r0, #7
0x422adc  orreq   r4, r4, #4
0x422ae0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422ae4  movw    r7, #0
0x422ae8  cmp     r0, #1
0x422aec  movt    r7, #0
0x422af0  orreq   r4, r4, #8
0x422af4  ldr     r0, [r7]
0x422af8  cmp     r0, #0
0x422afc  beq     #0x422b20
0x422b00  ldr     r0, [r0, #0x4c8]
0x422b04  cmp     r0, #4
0x422b08  blo     #0x422b20
0x422b0c  movw    r0, #0
0x422b10  movt    r0, #0
0x422b14  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422b18  cmp     r0, #1
0x422b1c  beq     #0x422bb4
0x422b20  movw    r0, #0x2cf0
0x422b24  movt    r0, #0x11
0x422b28  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422b2c  lsl     r0, r0, #0x18
0x422b30  and     r6, r5, r0, asr #31
0x422b34  ldr     r0, [r7]
0x422b38  cmp     r0, #0
0x422b3c  beq     #0x422ba0
0x422b40  ldr     r0, [r0, #0x4c8]
0x422b44  cmp     r0, #4
0x422b48  blo     #0x422b60
0x422b4c  movw    r0, #0
0x422b50  movt    r0, #0
0x422b54  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422b58  cmp     r0, #1
0x422b5c  beq     #0x422bd4
0x422b60  ldr     r0, [r7]
0x422b64  ands    r4, r6, r4
0x422b68  mov     r5, #0
0x422b6c  mvneq   r5, #0
0x422b70  cmp     r0, #0
0x422b74  beq     #0x422b98
0x422b78  ldr     r0, [r0, #0x4c8]
0x422b7c  cmp     r0, #4
0x422b80  blo     #0x422b98
0x422b84  movw    r0, #0
0x422b88  movt    r0, #0
0x422b8c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422b90  cmp     r0, #1
0x422b94  beq     #0x422bf4
0x422b98  mov     r0, r5
0x422b9c  pop     {r4, r5, r6, r7, fp, pc}
0x422ba0  mov     r5, #0
0x422ba4  tst     r6, r4
0x422ba8  mvneq   r5, #0
0x422bac  mov     r0, r5
0x422bb0  pop     {r4, r5, r6, r7, fp, pc}
0x422bb4  movw    r0, #0
0x422bb8  movw    r1, #0
0x422bbc  movt    r0, #0
0x422bc0  movt    r1, #0
0x422bc4  movw    r2, #0x241
0x422bc8  mov     r3, r4
0x422bcc  bl      #0xfffffff8   ; CALL printk
0x422bd0  b       #0x422b20
0x422bd4  movw    r0, #0
0x422bd8  movw    r1, #0
0x422bdc  movt    r0, #0
0x422be0  movt    r1, #0
0x422be4  movw    r2, #0x252
0x422be8  mov     r3, r6
0x422bec  bl      #0xfffffff8   ; CALL printk
0x422bf0  b       #0x422b60
0x422bf4  movw    r0, #0
0x422bf8  movw    r1, #0
0x422bfc  movt    r0, #0
0x422c00  movt    r1, #0
0x422c04  movw    r2, #0x25b
0x422c08  mov     r3, r4
0x422c0c  bl      #0xfffffff8   ; CALL printk
0x422c10  mov     r0, r5
0x422c14  pop     {r4, r5, r6, r7, fp, pc}

===== MDrv_AUDIO_Get_WMA_License @ 0x422cd0 size 0xd0 =====
0x422cd0  push    {r4, lr}
0x422cd4  mov     r0, #0x1e
0x422cd8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422cdc  movw    r1, #0
0x422ce0  cmp     r0, #1
0x422ce4  movt    r1, #0
0x422ce8  ldr     r1, [r1]
0x422cec  bne     #0x422d34
0x422cf0  mov     r4, #0
0x422cf4  cmp     r1, #0
0x422cf8  beq     #0x422d60
0x422cfc  ldr     r0, [r1, #0x4c8]
0x422d00  cmp     r0, #4
0x422d04  blo     #0x422d60
0x422d08  movw    r0, #0
0x422d0c  movt    r0, #0
0x422d10  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422d14  cmp     r0, #1
0x422d18  bne     #0x422d60
0x422d1c  movw    r0, #0
0x422d20  movw    r1, #0
0x422d24  movt    r0, #0
0x422d28  movt    r1, #0
0x422d2c  movw    r2, #0x287
0x422d30  b       #0x422d98
0x422d34  mov     r4, #1
0x422d38  cmp     r1, #0
0x422d3c  beq     #0x422d60
0x422d40  ldr     r0, [r1, #0x4c8]
0x422d44  cmp     r0, #4
0x422d48  blo     #0x422d60
0x422d4c  movw    r0, #0
0x422d50  movt    r0, #0
0x422d54  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422d58  cmp     r0, #1
0x422d5c  beq     #0x422d84
0x422d60  movw    r0, #0x2cf0
0x422d64  movt    r0, #0x11
0x422d68  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422d6c  and     r0, r0, #0x800
0x422d70  mov     r1, #1
0x422d74  eor     r0, r1, r0, lsr #11
0x422d78  orr     r0, r4, r0
0x422d7c  rsb     r0, r0, #0
0x422d80  pop     {r4, pc}
0x422d84  movw    r0, #0
0x422d88  movw    r1, #0
0x422d8c  movt    r0, #0
0x422d90  movt    r1, #0
0x422d94  movw    r2, #0x28b
0x422d98  bl      #0xfffffff8   ; CALL printk
0x422d9c  b       #0x422d60

===== MDrv_AUDIO_Get_DRA_License @ 0x422da0 size 0xd0 =====
0x422da0  push    {r4, lr}
0x422da4  mov     r0, #0x41
0x422da8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x422dac  movw    r1, #0
0x422db0  cmp     r0, #1
0x422db4  movt    r1, #0
0x422db8  ldr     r1, [r1]
0x422dbc  bne     #0x422e04
0x422dc0  mov     r4, #0
0x422dc4  cmp     r1, #0
0x422dc8  beq     #0x422e30
0x422dcc  ldr     r0, [r1, #0x4c8]
0x422dd0  cmp     r0, #4
0x422dd4  blo     #0x422e30
0x422dd8  movw    r0, #0
0x422ddc  movt    r0, #0
0x422de0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422de4  cmp     r0, #1
0x422de8  bne     #0x422e30
0x422dec  movw    r0, #0
0x422df0  movw    r1, #0
0x422df4  movt    r0, #0
0x422df8  movt    r1, #0
0x422dfc  movw    r2, #0x2aa
0x422e00  b       #0x422e68
0x422e04  mov     r4, #1
0x422e08  cmp     r1, #0
0x422e0c  beq     #0x422e30
0x422e10  ldr     r0, [r1, #0x4c8]
0x422e14  cmp     r0, #4
0x422e18  blo     #0x422e30
0x422e1c  movw    r0, #0
0x422e20  movt    r0, #0
0x422e24  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x422e28  cmp     r0, #1
0x422e2c  beq     #0x422e54
0x422e30  movw    r0, #0x2cf0
0x422e34  movt    r0, #0x11
0x422e38  bl      #0x4413ec   ; CALL HAL_AUDIO_AbsReadReg
0x422e3c  and     r0, r0, #0x400
0x422e40  mov     r1, #1
0x422e44  eor     r0, r1, r0, lsr #10
0x422e48  orr     r0, r4, r0
0x422e4c  rsb     r0, r0, #0
0x422e50  pop     {r4, pc}
0x422e54  movw    r0, #0
0x422e58  movw    r1, #0
0x422e5c  movt    r0, #0
0x422e60  movt    r1, #0
0x422e64  movw    r2, #0x2ae
0x422e68  bl      #0xfffffff8   ; CALL printk
0x422e6c  b       #0x422e30

===== HAL_AUDIO_CheckHashkeyDone @ 0x4539b4 size 0x40 =====
0x4539b4  mov     r0, #0
0x4539b8  bx      lr
0x4539bc  push    {r4, r5, fp, lr}
0x4539c0  movw    r5, #0
0x4539c4  mov     r4, r0
0x4539c8  movt    r5, #0
0x4539cc  ldr     r0, [r5]
0x4539d0  cmp     r0, #0
0x4539d4  beq     #0x4539e8
0x4539d8  cmp     r4, #0
0x4539dc  beq     #0x453a00
0x4539e0  mov     r0, #0
0x4539e4  pop     {r4, r5, fp, pc}
0x4539e8  bl      #0x404e60   ; CALL MDrv_AUDIO_SHM_Init
0x4539ec  cmp     r4, #0
0x4539f0  bne     #0x4539e0

===== MDrv_AUDIO_Get_License @ 0x426c1c size 0x240 =====
0x426c1c  push    {r4, r5, r6, lr}
0x426c20  movw    r6, #0
0x426c24  mov     r5, r0
0x426c28  movt    r6, #0
0x426c2c  mov     r4, r1
0x426c30  ldr     r0, [r6]
0x426c34  cmp     r0, #0
0x426c38  bne     #0x426c4c
0x426c3c  bl      #0x404e60   ; CALL MDrv_AUDIO_SHM_Init
0x426c40  ldr     r0, [r6]
0x426c44  cmp     r0, #0
0x426c48  beq     #0x426dec
0x426c4c  cmp     r5, #0
0x426c50  beq     #0x426d84
0x426c54  cmp     r4, #0
0x426c58  beq     #0x426db0
0x426c5c  movw    r1, #0
0x426c60  mov     r0, r5
0x426c64  movt    r1, #0
0x426c68  mov     r2, #0xd
0x426c6c  bl      #0xfffffff8   ; CALL strncmp
0x426c70  cmp     r0, #0
0x426c74  beq     #0x426df4
0x426c78  movw    r1, #0
0x426c7c  mov     r0, r5
0x426c80  movt    r1, #0
0x426c84  mov     r2, #0xd
0x426c88  bl      #0xfffffff8   ; CALL strncmp
0x426c8c  cmp     r0, #0
0x426c90  beq     #0x426dfc
0x426c94  movw    r1, #0
0x426c98  mov     r0, r5
0x426c9c  movt    r1, #0
0x426ca0  mov     r2, #0xd
0x426ca4  bl      #0xfffffff8   ; CALL strncmp
0x426ca8  cmp     r0, #0
0x426cac  beq     #0x426e04
0x426cb0  movw    r1, #0
0x426cb4  mov     r0, r5
0x426cb8  movt    r1, #0
0x426cbc  mov     r2, #0xf
0x426cc0  bl      #0xfffffff8   ; CALL strncmp
0x426cc4  cmp     r0, #0
0x426cc8  beq     #0x426e0c
0x426ccc  movw    r1, #0
0x426cd0  mov     r0, r5
0x426cd4  movt    r1, #0
0x426cd8  mov     r2, #0xd
0x426cdc  bl      #0xfffffff8   ; CALL strncmp
0x426ce0  cmp     r0, #0
0x426ce4  beq     #0x426e14
0x426ce8  movw    r1, #0
0x426cec  mov     r0, r5
0x426cf0  movt    r1, #0
0x426cf4  mov     r2, #0xd
0x426cf8  bl      #0xfffffff8   ; CALL strncmp
0x426cfc  cmp     r0, #0
0x426d00  beq     #0x426e1c
0x426d04  movw    r1, #0
0x426d08  mov     r0, r5
0x426d0c  movt    r1, #0
0x426d10  mov     r2, #0xd
0x426d14  bl      #0xfffffff8   ; CALL strncmp
0x426d18  cmp     r0, #0
0x426d1c  beq     #0x426e44
0x426d20  movw    r1, #0
0x426d24  mov     r0, r5
0x426d28  movt    r1, #0
0x426d2c  mov     r2, #0xe
0x426d30  bl      #0xfffffff8   ; CALL strncmp
0x426d34  cmp     r0, #0
0x426d38  beq     #0x426e4c
0x426d3c  movw    r1, #0
0x426d40  mov     r0, r5
0x426d44  movt    r1, #0
0x426d48  mov     r2, #0xd
0x426d4c  bl      #0xfffffff8   ; CALL strncmp
0x426d50  cmp     r0, #0
0x426d54  beq     #0x426e54
0x426d58  movw    r1, #0
0x426d5c  mov     r0, r5
0x426d60  movt    r1, #0
0x426d64  mov     r2, #0x10
0x426d68  bl      #0xfffffff8   ; CALL strncmp
0x426d6c  cmp     r0, #0
0x426d70  beq     #0x426e54
0x426d74  mov     r0, r5
0x426d78  mov     r1, r4
0x426d7c  pop     {r4, r5, r6, lr}
0x426d80  b       #0x456f24   ; CALL HAL_AUDIO_Get_License
0x426d84  ldr     r0, [r0, #0x4c8]
0x426d88  mvn     r4, #0x15
0x426d8c  cmp     r0, #0
0x426d90  beq     #0x426da8
0x426d94  movw    r0, #0
0x426d98  movt    r0, #0
0x426d9c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x426da0  cmp     r0, #1
0x426da4  beq     #0x426e24
0x426da8  mov     r0, r4
0x426dac  pop     {r4, r5, r6, pc}
0x426db0  ldr     r0, [r0, #0x4c8]
0x426db4  mvn     r4, #0x15
0x426db8  cmp     r0, #0
0x426dbc  beq     #0x426da8
0x426dc0  movw    r0, #0
0x426dc4  movt    r0, #0
0x426dc8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x426dcc  cmp     r0, #1
0x426dd0  bne     #0x426da8
0x426dd4  movw    r0, #0
0x426dd8  movw    r1, #0
0x426ddc  movt    r0, #0
0x426de0  movt    r1, #0
0x426de4  movw    r2, #0x9bf
0x426de8  b       #0x426e38
0x426dec  mvn     r0, #0xd
0x426df0  pop     {r4, r5, r6, pc}
0x426df4  pop     {r4, r5, r6, lr}
0x426df8  b       #0x422338   ; CALL MDrv_AUDIO_Get_AAC_License
0x426dfc  pop     {r4, r5, r6, lr}
0x426e00  b       #0x4224fc   ; CALL MDrv_AUDIO_Get_AC3_License
0x426e04  pop     {r4, r5, r6, lr}
0x426e08  b       #0x42274c   ; CALL MDrv_AUDIO_Get_AC4_License
0x426e0c  pop     {r4, r5, r6, lr}
0x426e10  b       #0x422c10   ; CALL MDrv_AUDIO_Get_MPEGH_License
0x426e14  pop     {r4, r5, r6, lr}
0x426e18  b       #0x422cc8   ; CALL MDrv_AUDIO_Get_WMA_License
0x426e1c  pop     {r4, r5, r6, lr}
0x426e20  b       #0x422a98   ; CALL MDrv_AUDIO_Get_DTS_License
0x426e24  movw    r0, #0
0x426e28  movw    r1, #0
0x426e2c  movt    r0, #0
0x426e30  movt    r1, #0
0x426e34  movw    r2, #0x9b9
0x426e38  bl      #0xfffffff8   ; CALL printk
0x426e3c  mov     r0, r4
0x426e40  pop     {r4, r5, r6, pc}
0x426e44  pop     {r4, r5, r6, lr}
0x426e48  b       #0x422d98   ; CALL MDrv_AUDIO_Get_DRA_License
0x426e4c  pop     {r4, r5, r6, lr}
0x426e50  b       #0x422e68   ; CALL MDrv_AUDIO_Get_COOK_License
0x426e54  pop     {r4, r5, r6, lr}
0x426e58  b       #0x422900   ; CALL MDrv_AUDIO_Get_MAT_License

===== MDrv_AUDIO_Get_Decoder_Support @ 0x41f72c size 0x9a0 =====
0x41f72c  push    {r4, r5, r6, lr}
0x41f730  sub     sp, sp, #8
0x41f734  movw    r6, #0
0x41f738  mov     r5, r0
0x41f73c  movt    r6, #0
0x41f740  cmp     r5, #0
0x41f744  ldr     r0, [r6]
0x41f748  str     r0, [sp, #4]
0x41f74c  mvn     r0, #0
0x41f750  str     r0, [sp]
0x41f754  beq     #0x41f8d8
0x41f758  mov     r2, sp
0x41f75c  mov     r0, #0
0x41f760  mov     r1, #3
0x41f764  bl      #0x45e344   ; CALL HAL_MAD_GetAudioInfo2
0x41f768  movw    r1, #0
0x41f76c  mov     r0, r5
0x41f770  movt    r1, #0
0x41f774  mov     r2, #3
0x41f778  bl      #0xfffffff8   ; CALL strncmp
0x41f77c  cmp     r0, #0
0x41f780  beq     #0x41f928
0x41f784  movw    r1, #0
0x41f788  mov     r0, r5
0x41f78c  movt    r1, #0
0x41f790  mov     r2, #3
0x41f794  bl      #0xfffffff8   ; CALL strncmp
0x41f798  cmp     r0, #0
0x41f79c  beq     #0x41f988
0x41f7a0  movw    r1, #0
0x41f7a4  mov     r0, r5
0x41f7a8  movt    r1, #0
0x41f7ac  mov     r2, #3
0x41f7b0  bl      #0xfffffff8   ; CALL strncmp
0x41f7b4  cmp     r0, #0
0x41f7b8  beq     #0x41f9f4
0x41f7bc  movw    r1, #0
0x41f7c0  mov     r0, r5
0x41f7c4  movt    r1, #0
0x41f7c8  mov     r2, #5
0x41f7cc  bl      #0xfffffff8   ; CALL strncmp
0x41f7d0  cmp     r0, #0
0x41f7d4  beq     #0x41fab4
0x41f7d8  movw    r1, #0
0x41f7dc  mov     r0, r5
0x41f7e0  movt    r1, #0
0x41f7e4  mov     r2, #3
0x41f7e8  bl      #0xfffffff8   ; CALL strncmp
0x41f7ec  cmp     r0, #0
0x41f7f0  beq     #0x41fb20
0x41f7f4  movw    r1, #0
0x41f7f8  mov     r0, r5
0x41f7fc  movt    r1, #0
0x41f800  mov     r2, #3
0x41f804  bl      #0xfffffff8   ; CALL strncmp
0x41f808  cmp     r0, #0
0x41f80c  beq     #0x41fc34
0x41f810  movw    r1, #0
0x41f814  mov     r0, r5
0x41f818  movt    r1, #0
0x41f81c  mov     r2, #3
0x41f820  bl      #0xfffffff8   ; CALL strncmp
0x41f824  cmp     r0, #0
0x41f828  beq     #0x41fc94
0x41f82c  movw    r1, #0
0x41f830  mov     r0, r5
0x41f834  movt    r1, #0
0x41f838  mov     r2, #4
0x41f83c  bl      #0xfffffff8   ; CALL strncmp
0x41f840  cmp     r0, #0
0x41f844  beq     #0x41fdbc
0x41f848  movw    r1, #0
0x41f84c  mov     r0, r5
0x41f850  movt    r1, #0
0x41f854  mov     r2, #3
0x41f858  bl      #0xfffffff8   ; CALL strncmp
0x41f85c  cmp     r0, #0
0x41f860  beq     #0x41fe88
0x41f864  movw    r1, #0
0x41f868  mov     r0, r5
0x41f86c  movt    r1, #0
0x41f870  mov     r2, #6
0x41f874  bl      #0xfffffff8   ; CALL strncmp
0x41f878  cmp     r0, #0
0x41f87c  beq     #0x41fef4
0x41f880  movw    r0, #0
0x41f884  mov     r4, #0
0x41f888  movt    r0, #0
0x41f88c  ldr     r0, [r0]
0x41f890  cmp     r0, #0
0x41f894  beq     #0x420094
0x41f898  ldr     r0, [r0, #0x4c8]
0x41f89c  cmp     r0, #2
0x41f8a0  blo     #0x420094
0x41f8a4  movw    r0, #0
0x41f8a8  movt    r0, #0
0x41f8ac  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41f8b0  cmp     r0, #1
0x41f8b4  bne     #0x420094
0x41f8b8  movw    r0, #0
0x41f8bc  movw    r1, #0
0x41f8c0  movt    r0, #0
0x41f8c4  movt    r1, #0
0x41f8c8  movw    r2, #0x21fb
0x41f8cc  mov     r3, r5
0x41f8d0  bl      #0xfffffff8   ; CALL printk
0x41f8d4  b       #0x420094
0x41f8d8  movw    r0, #0
0x41f8dc  mov     r4, #0
0x41f8e0  movt    r0, #0
0x41f8e4  ldr     r0, [r0]
0x41f8e8  cmp     r0, #0
0x41f8ec  ldrne   r0, [r0, #0x4c8]
0x41f8f0  cmpne   r0, #0
0x41f8f4  beq     #0x420094
0x41f8f8  movw    r0, #0
0x41f8fc  movt    r0, #0
0x41f900  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41f904  cmp     r0, #1
0x41f908  bne     #0x420094
0x41f90c  movw    r0, #0
0x41f910  movw    r1, #0
0x41f914  movt    r0, #0
0x41f918  movt    r1, #0
0x41f91c  movw    r2, #0x217b
0x41f920  bl      #0xfffffff8   ; CALL printk
0x41f924  b       #0x420094
0x41f928  bl      #0x4224fc   ; CALL MDrv_AUDIO_Get_AC3_License
0x41f92c  cmp     r0, #0
0x41f930  beq     #0x41fa54
0x41f934  movw    r0, #0
0x41f938  mov     r4, #0
0x41f93c  movt    r0, #0
0x41f940  ldr     r0, [r0]
0x41f944  cmp     r0, #0
0x41f948  beq     #0x420094
0x41f94c  ldr     r0, [r0, #0x4c8]
0x41f950  cmp     r0, #4
0x41f954  blo     #0x420094
0x41f958  movw    r0, #0
0x41f95c  movt    r0, #0
0x41f960  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41f964  cmp     r0, #1
0x41f968  bne     #0x420094
0x41f96c  movw    r0, #0
0x41f970  movw    r1, #0
0x41f974  movt    r0, #0
0x41f978  movt    r1, #0
0x41f97c  movw    r2, #0x218a
0x41f980  bl      #0xfffffff8   ; CALL printk
0x41f984  b       #0x420094
0x41f988  bl      #0x42274c   ; CALL MDrv_AUDIO_Get_AC4_License
0x41f98c  cmp     r0, #0
0x41f990  bne     #0x41f9a0
0x41f994  ldrb    r0, [sp, #3]
0x41f998  tst     r0, #2
0x41f99c  bne     #0x41fbe0
0x41f9a0  movw    r0, #0
0x41f9a4  mov     r4, #0
0x41f9a8  movt    r0, #0
0x41f9ac  ldr     r0, [r0]
0x41f9b0  cmp     r0, #0
0x41f9b4  beq     #0x420094
0x41f9b8  ldr     r0, [r0, #0x4c8]
0x41f9bc  cmp     r0, #4
0x41f9c0  blo     #0x420094
0x41f9c4  movw    r0, #0
0x41f9c8  movt    r0, #0
0x41f9cc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41f9d0  cmp     r0, #1
0x41f9d4  bne     #0x420094
0x41f9d8  movw    r0, #0
0x41f9dc  movw    r1, #0
0x41f9e0  movt    r0, #0
0x41f9e4  movt    r1, #0
0x41f9e8  movw    r2, #0x2196
0x41f9ec  bl      #0xfffffff8   ; CALL printk
0x41f9f0  b       #0x420094
0x41f9f4  bl      #0x422338   ; CALL MDrv_AUDIO_Get_AAC_License
0x41f9f8  cmp     r0, #0
0x41f9fc  beq     #0x41fb80
0x41fa00  movw    r0, #0
0x41fa04  mov     r4, #0
0x41fa08  movt    r0, #0
0x41fa0c  ldr     r0, [r0]
0x41fa10  cmp     r0, #0
0x41fa14  beq     #0x420094
0x41fa18  ldr     r0, [r0, #0x4c8]
0x41fa1c  cmp     r0, #4
0x41fa20  blo     #0x420094
0x41fa24  movw    r0, #0
0x41fa28  movt    r0, #0
0x41fa2c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fa30  cmp     r0, #1
0x41fa34  bne     #0x420094
0x41fa38  movw    r0, #0
0x41fa3c  movw    r1, #0
0x41fa40  movt    r0, #0
0x41fa44  movt    r1, #0
0x41fa48  movw    r2, #0x21a2
0x41fa4c  bl      #0xfffffff8   ; CALL printk
0x41fa50  b       #0x420094
0x41fa54  ldrb    r0, [sp]
0x41fa58  tst     r0, #0x30
0x41fa5c  beq     #0x41f934
0x41fa60  movw    r0, #0
0x41fa64  mov     r4, #1
0x41fa68  movt    r0, #0
0x41fa6c  ldr     r0, [r0]
0x41fa70  cmp     r0, #0
0x41fa74  beq     #0x420094
0x41fa78  ldr     r0, [r0, #0x4c8]
0x41fa7c  cmp     r0, #4
0x41fa80  blo     #0x420094
0x41fa84  movw    r0, #0
0x41fa88  movt    r0, #0
0x41fa8c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fa90  cmp     r0, #1
0x41fa94  bne     #0x420094
0x41fa98  movw    r0, #0
0x41fa9c  movw    r1, #0
0x41faa0  movt    r0, #0
0x41faa4  movt    r1, #0
0x41faa8  movw    r2, #0x2185
0x41faac  bl      #0xfffffff8   ; CALL printk
0x41fab0  b       #0x420094
0x41fab4  bl      #0x422c10   ; CALL MDrv_AUDIO_Get_MPEGH_License
0x41fab8  cmp     r0, #0
0x41fabc  bne     #0x41facc
0x41fac0  ldrb    r0, [sp, #3]
0x41fac4  tst     r0, #4
0x41fac8  bne     #0x41fd68
0x41facc  movw    r0, #0
0x41fad0  mov     r4, #0
0x41fad4  movt    r0, #0
0x41fad8  ldr     r0, [r0]
0x41fadc  cmp     r0, #0
0x41fae0  beq     #0x420094
0x41fae4  ldr     r0, [r0, #0x4c8]
0x41fae8  cmp     r0, #4
0x41faec  blo     #0x420094
0x41faf0  movw    r0, #0
0x41faf4  movt    r0, #0
0x41faf8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fafc  cmp     r0, #1
0x41fb00  bne     #0x420094
0x41fb04  movw    r0, #0
0x41fb08  movw    r1, #0
0x41fb0c  movt    r0, #0
0x41fb10  movt    r1, #0
0x41fb14  movw    r2, #0x21ae
0x41fb18  bl      #0xfffffff8   ; CALL printk
0x41fb1c  b       #0x420094
0x41fb20  bl      #0x422a98   ; CALL MDrv_AUDIO_Get_DTS_License
0x41fb24  cmp     r0, #0
0x41fb28  beq     #0x41fd00
0x41fb2c  movw    r0, #0
0x41fb30  mov     r4, #0
0x41fb34  movt    r0, #0
0x41fb38  ldr     r0, [r0]
0x41fb3c  cmp     r0, #0
0x41fb40  beq     #0x420094
0x41fb44  ldr     r0, [r0, #0x4c8]
0x41fb48  cmp     r0, #4
0x41fb4c  blo     #0x420094
0x41fb50  movw    r0, #0
0x41fb54  movt    r0, #0
0x41fb58  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fb5c  cmp     r0, #1
0x41fb60  bne     #0x420094
0x41fb64  movw    r0, #0
0x41fb68  movw    r1, #0
0x41fb6c  movt    r0, #0
0x41fb70  movt    r1, #0
0x41fb74  movw    r2, #0x21ba
0x41fb78  bl      #0xfffffff8   ; CALL printk
0x41fb7c  b       #0x420094
0x41fb80  ldrh    r0, [sp]
0x41fb84  tst     r0, #0x3c0
0x41fb88  beq     #0x41fa00
0x41fb8c  movw    r0, #0
0x41fb90  mov     r4, #1
0x41fb94  movt    r0, #0
0x41fb98  ldr     r0, [r0]
0x41fb9c  cmp     r0, #0
0x41fba0  beq     #0x420094
0x41fba4  ldr     r0, [r0, #0x4c8]
0x41fba8  cmp     r0, #4
0x41fbac  blo     #0x420094
0x41fbb0  movw    r0, #0
0x41fbb4  movt    r0, #0
0x41fbb8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fbbc  cmp     r0, #1
0x41fbc0  bne     #0x420094
0x41fbc4  movw    r0, #0
0x41fbc8  movw    r1, #0
0x41fbcc  movt    r0, #0
0x41fbd0  movt    r1, #0
0x41fbd4  movw    r2, #0x219d
0x41fbd8  bl      #0xfffffff8   ; CALL printk
0x41fbdc  b       #0x420094
0x41fbe0  movw    r0, #0
0x41fbe4  mov     r4, #1
0x41fbe8  movt    r0, #0
0x41fbec  ldr     r0, [r0]
0x41fbf0  cmp     r0, #0
0x41fbf4  beq     #0x420094
0x41fbf8  ldr     r0, [r0, #0x4c8]
0x41fbfc  cmp     r0, #4
0x41fc00  blo     #0x420094
0x41fc04  movw    r0, #0
0x41fc08  movt    r0, #0
0x41fc0c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fc10  cmp     r0, #1
0x41fc14  bne     #0x420094
0x41fc18  movw    r0, #0
0x41fc1c  movw    r1, #0
0x41fc20  movt    r0, #0
0x41fc24  movt    r1, #0
0x41fc28  movw    r2, #0x2191
0x41fc2c  bl      #0xfffffff8   ; CALL printk
0x41fc30  b       #0x420094
0x41fc34  bl      #0x422cc8   ; CALL MDrv_AUDIO_Get_WMA_License
0x41fc38  cmp     r0, #0
0x41fc3c  beq     #0x41fe28
0x41fc40  movw    r0, #0
0x41fc44  mov     r4, #0
0x41fc48  movt    r0, #0
0x41fc4c  ldr     r0, [r0]
0x41fc50  cmp     r0, #0
0x41fc54  beq     #0x420094
0x41fc58  ldr     r0, [r0, #0x4c8]
0x41fc5c  cmp     r0, #4
0x41fc60  blo     #0x420094
0x41fc64  movw    r0, #0
0x41fc68  movt    r0, #0
0x41fc6c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fc70  cmp     r0, #1
0x41fc74  bne     #0x420094
0x41fc78  movw    r0, #0
0x41fc7c  movw    r1, #0
0x41fc80  movt    r0, #0
0x41fc84  movt    r1, #0
0x41fc88  movw    r2, #0x21c6
0x41fc8c  bl      #0xfffffff8   ; CALL printk
0x41fc90  b       #0x420094
0x41fc94  bl      #0x422d98   ; CALL MDrv_AUDIO_Get_DRA_License
0x41fc98  cmp     r0, #0
0x41fc9c  bne     #0x41fcac
0x41fca0  ldrb    r0, [sp, #2]
0x41fca4  tst     r0, #0x10
0x41fca8  bne     #0x41ff60
0x41fcac  movw    r0, #0
0x41fcb0  mov     r4, #0
0x41fcb4  movt    r0, #0
0x41fcb8  ldr     r0, [r0]
0x41fcbc  cmp     r0, #0
0x41fcc0  beq     #0x420094
0x41fcc4  ldr     r0, [r0, #0x4c8]
0x41fcc8  cmp     r0, #4
0x41fccc  blo     #0x420094
0x41fcd0  movw    r0, #0
0x41fcd4  movt    r0, #0
0x41fcd8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fcdc  cmp     r0, #1
0x41fce0  bne     #0x420094
0x41fce4  movw    r0, #0
0x41fce8  movw    r1, #0
0x41fcec  movt    r0, #0
0x41fcf0  movt    r1, #0
0x41fcf4  movw    r2, #0x21d2
0x41fcf8  bl      #0xfffffff8   ; CALL printk
0x41fcfc  b       #0x420094
0x41fd00  ldr     r1, [sp]
0x41fd04  movw    r0, #0x2000
0x41fd08  movt    r0, #0x1a0
0x41fd0c  tst     r1, r0
0x41fd10  beq     #0x41fb2c
0x41fd14  movw    r0, #0
0x41fd18  mov     r4, #1
0x41fd1c  movt    r0, #0
0x41fd20  ldr     r0, [r0]
0x41fd24  cmp     r0, #0
0x41fd28  beq     #0x420094
0x41fd2c  ldr     r0, [r0, #0x4c8]
0x41fd30  cmp     r0, #4
0x41fd34  blo     #0x420094
0x41fd38  movw    r0, #0
0x41fd3c  movt    r0, #0
0x41fd40  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fd44  cmp     r0, #1
0x41fd48  bne     #0x420094
0x41fd4c  movw    r0, #0
0x41fd50  movw    r1, #0
0x41fd54  movt    r0, #0
0x41fd58  movt    r1, #0
0x41fd5c  movw    r2, #0x21b5
0x41fd60  bl      #0xfffffff8   ; CALL printk
0x41fd64  b       #0x420094
0x41fd68  movw    r0, #0
0x41fd6c  mov     r4, #1
0x41fd70  movt    r0, #0
0x41fd74  ldr     r0, [r0]
0x41fd78  cmp     r0, #0
0x41fd7c  beq     #0x420094
0x41fd80  ldr     r0, [r0, #0x4c8]
0x41fd84  cmp     r0, #4
0x41fd88  blo     #0x420094
0x41fd8c  movw    r0, #0
0x41fd90  movt    r0, #0
0x41fd94  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fd98  cmp     r0, #1
0x41fd9c  bne     #0x420094
0x41fda0  movw    r0, #0
0x41fda4  movw    r1, #0
0x41fda8  movt    r0, #0
0x41fdac  movt    r1, #0
0x41fdb0  movw    r2, #0x21a9
0x41fdb4  bl      #0xfffffff8   ; CALL printk
0x41fdb8  b       #0x420094
0x41fdbc  bl      #0x422e68   ; CALL MDrv_AUDIO_Get_COOK_License
0x41fdc0  cmp     r0, #0
0x41fdc4  bne     #0x41fdd4
0x41fdc8  ldrb    r0, [sp, #1]
0x41fdcc  tst     r0, #0x10
0x41fdd0  bne     #0x41ffb4
0x41fdd4  movw    r0, #0
0x41fdd8  mov     r4, #0
0x41fddc  movt    r0, #0
0x41fde0  ldr     r0, [r0]
0x41fde4  cmp     r0, #0
0x41fde8  beq     #0x420094
0x41fdec  ldr     r0, [r0, #0x4c8]
0x41fdf0  cmp     r0, #4
0x41fdf4  blo     #0x420094
0x41fdf8  movw    r0, #0
0x41fdfc  movt    r0, #0
0x41fe00  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fe04  cmp     r0, #1
0x41fe08  bne     #0x420094
0x41fe0c  movw    r0, #0
0x41fe10  movw    r1, #0
0x41fe14  movt    r0, #0
0x41fe18  movt    r1, #0
0x41fe1c  movw    r2, #0x21de
0x41fe20  bl      #0xfffffff8   ; CALL printk
0x41fe24  b       #0x420094
0x41fe28  ldrb    r0, [sp, #1]
0x41fe2c  tst     r0, #0xc
0x41fe30  beq     #0x41fc40
0x41fe34  movw    r0, #0
0x41fe38  mov     r4, #1
0x41fe3c  movt    r0, #0
0x41fe40  ldr     r0, [r0]
0x41fe44  cmp     r0, #0
0x41fe48  beq     #0x420094
0x41fe4c  ldr     r0, [r0, #0x4c8]
0x41fe50  cmp     r0, #4
0x41fe54  blo     #0x420094
0x41fe58  movw    r0, #0
0x41fe5c  movt    r0, #0
0x41fe60  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fe64  cmp     r0, #1
0x41fe68  bne     #0x420094
0x41fe6c  movw    r0, #0
0x41fe70  movw    r1, #0
0x41fe74  movt    r0, #0
0x41fe78  movt    r1, #0
0x41fe7c  movw    r2, #0x21c1
0x41fe80  bl      #0xfffffff8   ; CALL printk
0x41fe84  b       #0x420094
0x41fe88  bl      #0x422900   ; CALL MDrv_AUDIO_Get_MAT_License
0x41fe8c  cmp     r0, #0
0x41fe90  bne     #0x41fea0
0x41fe94  ldrb    r0, [sp, #3]
0x41fe98  tst     r0, #0x20
0x41fe9c  bne     #0x420008
0x41fea0  movw    r0, #0
0x41fea4  mov     r4, #0
0x41fea8  movt    r0, #0
0x41feac  ldr     r0, [r0]
0x41feb0  cmp     r0, #0
0x41feb4  beq     #0x420094
0x41feb8  ldr     r0, [r0, #0x4c8]
0x41febc  cmp     r0, #4
0x41fec0  blo     #0x420094
0x41fec4  movw    r0, #0
0x41fec8  movt    r0, #0
0x41fecc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41fed0  cmp     r0, #1
0x41fed4  bne     #0x420094
0x41fed8  movw    r0, #0
0x41fedc  movw    r1, #0
0x41fee0  movt    r0, #0
0x41fee4  movt    r1, #0
0x41fee8  movw    r2, #0x21ea
0x41feec  bl      #0xfffffff8   ; CALL printk
0x41fef0  b       #0x420094
0x41fef4  bl      #0x422900   ; CALL MDrv_AUDIO_Get_MAT_License
0x41fef8  cmp     r0, #0
0x41fefc  bne     #0x41ff0c
0x41ff00  ldrb    r0, [sp, #3]
0x41ff04  tst     r0, #0x20
0x41ff08  bne     #0x42005c
0x41ff0c  movw    r0, #0
0x41ff10  mov     r4, #0
0x41ff14  movt    r0, #0
0x41ff18  ldr     r0, [r0]
0x41ff1c  cmp     r0, #0
0x41ff20  beq     #0x420094
0x41ff24  ldr     r0, [r0, #0x4c8]
0x41ff28  cmp     r0, #4
0x41ff2c  blo     #0x420094
0x41ff30  movw    r0, #0
0x41ff34  movt    r0, #0
0x41ff38  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41ff3c  cmp     r0, #1
0x41ff40  bne     #0x420094
0x41ff44  movw    r0, #0
0x41ff48  movw    r1, #0
0x41ff4c  movt    r0, #0
0x41ff50  movt    r1, #0
0x41ff54  movw    r2, #0x21f6
0x41ff58  bl      #0xfffffff8   ; CALL printk
0x41ff5c  b       #0x420094
0x41ff60  movw    r0, #0
0x41ff64  mov     r4, #1
0x41ff68  movt    r0, #0
0x41ff6c  ldr     r0, [r0]
0x41ff70  cmp     r0, #0
0x41ff74  beq     #0x420094
0x41ff78  ldr     r0, [r0, #0x4c8]
0x41ff7c  cmp     r0, #4
0x41ff80  blo     #0x420094
0x41ff84  movw    r0, #0
0x41ff88  movt    r0, #0
0x41ff8c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41ff90  cmp     r0, #1
0x41ff94  bne     #0x420094
0x41ff98  movw    r0, #0
0x41ff9c  movw    r1, #0
0x41ffa0  movt    r0, #0
0x41ffa4  movt    r1, #0
0x41ffa8  movw    r2, #0x21cd
0x41ffac  bl      #0xfffffff8   ; CALL printk
0x41ffb0  b       #0x420094
0x41ffb4  movw    r0, #0
0x41ffb8  mov     r4, #1
0x41ffbc  movt    r0, #0
0x41ffc0  ldr     r0, [r0]
0x41ffc4  cmp     r0, #0
0x41ffc8  beq     #0x420094
0x41ffcc  ldr     r0, [r0, #0x4c8]
0x41ffd0  cmp     r0, #4
0x41ffd4  blo     #0x420094
0x41ffd8  movw    r0, #0
0x41ffdc  movt    r0, #0
0x41ffe0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x41ffe4  cmp     r0, #1
0x41ffe8  bne     #0x420094
0x41ffec  movw    r0, #0
0x41fff0  movw    r1, #0
0x41fff4  movt    r0, #0
0x41fff8  movt    r1, #0
0x41fffc  movw    r2, #0x21d9
0x420000  bl      #0xfffffff8   ; CALL printk
0x420004  b       #0x420094
0x420008  movw    r0, #0
0x42000c  mov     r4, #1
0x420010  movt    r0, #0
0x420014  ldr     r0, [r0]
0x420018  cmp     r0, #0
0x42001c  beq     #0x420094
0x420020  ldr     r0, [r0, #0x4c8]
0x420024  cmp     r0, #4
0x420028  blo     #0x420094
0x42002c  movw    r0, #0
0x420030  movt    r0, #0
0x420034  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x420038  cmp     r0, #1
0x42003c  bne     #0x420094
0x420040  movw    r0, #0
0x420044  movw    r1, #0
0x420048  movt    r0, #0
0x42004c  movt    r1, #0
0x420050  movw    r2, #0x21e5
0x420054  bl      #0xfffffff8   ; CALL printk
0x420058  b       #0x420094
0x42005c  movw    r0, #0
0x420060  mov     r4, #1
0x420064  movt    r0, #0
0x420068  ldr     r0, [r0]
0x42006c  cmp     r0, #0
0x420070  beq     #0x420094
0x420074  ldr     r0, [r0, #0x4c8]
0x420078  cmp     r0, #4
0x42007c  blo     #0x420094
0x420080  movw    r0, #0
0x420084  movt    r0, #0
0x420088  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42008c  cmp     r0, #1
0x420090  beq     #0x4200b0
0x420094  ldr     r0, [r6]
0x420098  ldr     r1, [sp, #4]
0x42009c  subs    r0, r0, r1
0x4200a0  moveq   r0, r4
0x4200a4  addeq   sp, sp, #8
0x4200a8  popeq   {r4, r5, r6, pc}
0x4200ac  bl      #0xfffffff8   ; CALL __stack_chk_fail
0x4200b0  movw    r0, #0
0x4200b4  movw    r1, #0
0x4200b8  movt    r0, #0
0x4200bc  movt    r1, #0
0x4200c0  movw    r2, #0x21f1
0x4200c4  bl      #0xfffffff8   ; CALL printk
0x4200c8  b       #0x420094
