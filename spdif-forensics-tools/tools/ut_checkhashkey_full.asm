===== MDrv_AUDIO_CheckHashkey @ 0x423494 size 0x16fc ARM (relocs applied) =====
0x423494  push    {r4, r5, r6, r7, r8, sb, sl, lr}
0x423498  sub     sp, sp, #0x10
0x42349c  movw    r4, #0
0x4234a0  movt    r4, #0
0x4234a4  ldr     r0, [r4]
0x4234a8  cmp     r0, #0
0x4234ac  bne     #0x4234c0
0x4234b0  bl      #0x404e60   ; CALL MDrv_AUDIO_SHM_Init
0x4234b4  ldr     r0, [r4]
0x4234b8  cmp     r0, #0
0x4234bc  beq     #0x4248bc
0x4234c0  ldrb    r1, [r0, #0x503]   ; <<F503>>
0x4234c4  cmp     r1, #1
0x4234c8  beq     #0x4248bc
0x4234cc  mov     r1, #0
0x4234d0  mvn     r2, #0xff000000
0x4234d4  str     r1, [r0, #0x57e]   ; <<F57e>>
0x4234d8  str     r1, [r0, #0x440]   ; <<F440>>
0x4234dc  str     r2, [r0, #0x444]   ; <<F444>>
0x4234e0  strb    r1, [r0, #0x582]   ; <<F582>>
0x4234e4  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x4234e8  cmp     r0, #3
0x4234ec  blo     #0x423504
0x4234f0  movw    r0, #0
0x4234f4  movt    r0, #0
0x4234f8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4234fc  cmp     r0, #1
0x423500  beq     #0x4248c4
0x423504  mov     r0, #0xb
0x423508  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xb
0x42350c  ldr     r1, [r4]
0x423510  cmp     r0, #0
0x423514  beq     #0x42354c
0x423518  cmp     r1, #0
0x42351c  beq     #0x423580
0x423520  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423524  cmp     r0, #3
0x423528  blo     #0x423580
0x42352c  movw    r0, #0
0x423530  movt    r0, #0
0x423534  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423538  cmp     r0, #1
0x42353c  bne     #0x423580
0x423540  movw    r0, #0
0x423544  movt    r0, #0
0x423548  b       #0x4249b0
0x42354c  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423550  cmp     r1, #0
0x423554  orr     r0, r0, #1
0x423558  str     r0, [r1, #0x440]   ; <<F440>>
0x42355c  beq     #0x423580
0x423560  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423564  cmp     r0, #3
0x423568  blo     #0x423580
0x42356c  movw    r0, #0
0x423570  movt    r0, #0
0x423574  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423578  cmp     r0, #1
0x42357c  beq     #0x4249a8
0x423580  mov     r0, #0xc
0x423584  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xc
0x423588  ldr     r1, [r4]
0x42358c  cmp     r0, #0
0x423590  ldr     r2, [r1, #0x440]   ; <<F440>>
0x423594  beq     #0x4235e0
0x423598  bic     r0, r2, #1
0x42359c  str     r0, [r1, #0x440]   ; <<F440>>
0x4235a0  ldrb    r0, [r1, #0x581]   ; <<F581>>
0x4235a4  cmp     r1, #0
0x4235a8  orr     r0, r0, #1
0x4235ac  strb    r0, [r1, #0x581]   ; <<F581>>
0x4235b0  beq     #0x423610
0x4235b4  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4235b8  cmp     r0, #3
0x4235bc  blo     #0x423610
0x4235c0  movw    r0, #0
0x4235c4  movt    r0, #0
0x4235c8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4235cc  cmp     r0, #1
0x4235d0  bne     #0x423610
0x4235d4  movw    r0, #0
0x4235d8  movt    r0, #0
0x4235dc  b       #0x4249c0
0x4235e0  cmp     r1, #0
0x4235e4  orr     r0, r2, #2
0x4235e8  str     r0, [r1, #0x440]   ; <<F440>>
0x4235ec  beq     #0x423610
0x4235f0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4235f4  cmp     r0, #3
0x4235f8  blo     #0x423610
0x4235fc  movw    r0, #0
0x423600  movt    r0, #0
0x423604  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423608  cmp     r0, #1
0x42360c  beq     #0x4249b8
0x423610  mov     r0, #0x50
0x423614  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x50
0x423618  cmp     r0, #0
0x42361c  beq     #0x423674
0x423620  ldr     r0, [r4]
0x423624  mov     r6, #2
0x423628  mov     sl, #1
0x42362c  cmp     r0, #0
0x423630  ldrb    r1, [r0, #0x580]   ; <<F580>>
0x423634  ldrb    r2, [r0, #0x581]   ; <<F581>>
0x423638  orr     r1, r1, #1
0x42363c  strb    r1, [r0, #0x580]   ; <<F580>>
0x423640  orr     r1, r2, #1
0x423644  strb    r1, [r0, #0x581]   ; <<F581>>
0x423648  beq     #0x42366c
0x42364c  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x423650  cmp     r0, #3
0x423654  blo     #0x42366c
0x423658  movw    r0, #0
0x42365c  movt    r0, #0
0x423660  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423664  cmp     r0, #1
0x423668  beq     #0x42491c
0x42366c  mov     r7, #1
0x423670  b       #0x4236b8
0x423674  mov     r0, #0x73
0x423678  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x73
0x42367c  ldr     r1, [r4]
0x423680  cmp     r0, #0
0x423684  ldr     r2, [r1, #0x440]   ; <<F440>>
0x423688  beq     #0x4237ac
0x42368c  orr     r0, r2, #0x10
0x423690  str     r0, [r1, #0x440]   ; <<F440>>
0x423694  ldrb    r0, [r1, #0x580]   ; <<F580>>
0x423698  mov     r6, #2
0x42369c  ldrb    r2, [r1, #0x581]   ; <<F581>>
0x4236a0  mov     r7, #1
0x4236a4  orr     r0, r0, #1
0x4236a8  strb    r0, [r1, #0x580]   ; <<F580>>
0x4236ac  orr     r0, r2, #1
0x4236b0  strb    r0, [r1, #0x581]   ; <<F581>>
0x4236b4  mov     sl, #0
0x4236b8  mov     r0, #0x53
0x4236bc  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x53
0x4236c0  ldr     r1, [r4]
0x4236c4  cmp     r0, #0
0x4236c8  beq     #0x423704
0x4236cc  cmp     r1, #0
0x4236d0  beq     #0x423710
0x4236d4  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4236d8  cmp     r0, #3
0x4236dc  blo     #0x423710
0x4236e0  movw    r0, #0
0x4236e4  movt    r0, #0
0x4236e8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4236ec  cmp     r0, #1
0x4236f0  bne     #0x423710
0x4236f4  movw    r0, #0
0x4236f8  movt    r0, #0
0x4236fc  bl      #0xfffffff8   ; CALL printk
0x423700  b       #0x423710
0x423704  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423708  orr     r0, r0, #0x40000
0x42370c  str     r0, [r1, #0x440]   ; <<F440>>
0x423710  mov     r0, #0x52
0x423714  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x52
0x423718  cmp     r0, #0
0x42371c  beq     #0x42376c
0x423720  ldr     r0, [r4]
0x423724  mov     sb, #6
0x423728  mov     r6, #3
0x42372c  mov     sl, #1
0x423730  cmp     r0, #0
0x423734  ldrb    r1, [r0, #0x57f]   ; <<F57f>>
0x423738  orr     r1, r1, #1
0x42373c  strb    r1, [r0, #0x57f]   ; <<F57f>>
0x423740  beq     #0x423764
0x423744  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x423748  cmp     r0, #3
0x42374c  blo     #0x423764
0x423750  movw    r0, #0
0x423754  movt    r0, #0
0x423758  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42375c  cmp     r0, #1
0x423760  beq     #0x424930
0x423764  mov     r7, #1
0x423768  b       #0x42381c
0x42376c  mov     r0, #0x75
0x423770  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x75
0x423774  ldr     r1, [r4]
0x423778  cmp     r0, #0
0x42377c  ldr     r2, [r1, #0x440]   ; <<F440>>
0x423780  beq     #0x423810
0x423784  orr     r0, r2, #0x10
0x423788  str     r0, [r1, #0x440]   ; <<F440>>
0x42378c  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x423790  mov     sb, #6
0x423794  mov     r6, #3
0x423798  mov     r7, #1
0x42379c  orr     r0, r0, #1
0x4237a0  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x4237a4  mov     sl, #0
0x4237a8  b       #0x42381c
0x4237ac  cmp     r1, #0
0x4237b0  orr     r0, r2, #0x200
0x4237b4  str     r0, [r1, #0x440]   ; <<F440>>
0x4237b8  beq     #0x423800
0x4237bc  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4237c0  mov     sl, #0
0x4237c4  mov     r7, #0
0x4237c8  mov     r6, #0
0x4237cc  cmp     r0, #3
0x4237d0  blo     #0x4236b8
0x4237d4  movw    r0, #0
0x4237d8  movt    r0, #0
0x4237dc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4237e0  mov     sl, #0
0x4237e4  cmp     r0, #1
0x4237e8  mov     r7, #0
0x4237ec  mov     r6, #0
0x4237f0  bne     #0x4236b8
0x4237f4  movw    r0, #0
0x4237f8  movt    r0, #0
0x4237fc  bl      #0xfffffff8   ; CALL printk
0x423800  mov     sl, #0
0x423804  mov     r7, #0
0x423808  mov     r6, #0
0x42380c  b       #0x4236b8
0x423810  mov     sb, r6
0x423814  orr     r0, r2, #0x80000
0x423818  str     r0, [r1, #0x440]   ; <<F440>>
0x42381c  mov     r0, #0x51
0x423820  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x51
0x423824  cmp     r0, #0
0x423828  beq     #0x423878
0x42382c  ldr     r0, [r4]
0x423830  mov     sb, #4
0x423834  mov     r6, #3
0x423838  mov     sl, #1
0x42383c  cmp     r0, #0
0x423840  ldrb    r1, [r0, #0x57f]   ; <<F57f>>
0x423844  orr     r1, r1, #1
0x423848  strb    r1, [r0, #0x57f]   ; <<F57f>>
0x42384c  beq     #0x423870
0x423850  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x423854  cmp     r0, #3
0x423858  blo     #0x423870
0x42385c  movw    r0, #0
0x423860  movt    r0, #0
0x423864  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423868  cmp     r0, #1
0x42386c  beq     #0x424944
0x423870  mov     r7, #1
0x423874  b       #0x4238c0
0x423878  mov     r0, #0x74
0x42387c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x74
0x423880  ldr     r1, [r4]
0x423884  cmp     r0, #0
0x423888  ldr     r2, [r1, #0x440]   ; <<F440>>
0x42388c  beq     #0x4238b8
0x423890  orr     r0, r2, #0x10
0x423894  str     r0, [r1, #0x440]   ; <<F440>>
0x423898  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x42389c  mov     sb, #4
0x4238a0  mov     r6, #3
0x4238a4  mov     r7, #1
0x4238a8  orr     r0, r0, #1
0x4238ac  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x4238b0  mov     sl, #0
0x4238b4  b       #0x4238c0
0x4238b8  orr     r0, r2, #0x200000
0x4238bc  str     r0, [r1, #0x440]   ; <<F440>>
0x4238c0  mov     r0, #0xe
0x4238c4  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xe
0x4238c8  cmp     r0, #0
0x4238cc  beq     #0x423908
0x4238d0  ldr     r0, [r4]
0x4238d4  mov     sl, #1
0x4238d8  cmp     r0, #0
0x4238dc  beq     #0x423900
0x4238e0  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x4238e4  cmp     r0, #3
0x4238e8  blo     #0x423900
0x4238ec  movw    r0, #0
0x4238f0  movt    r0, #0
0x4238f4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4238f8  cmp     r0, #1
0x4238fc  beq     #0x424958
0x423900  mov     r7, #1
0x423904  b       #0x423978
0x423908  mov     r0, #0x50
0x42390c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x50
0x423910  cmp     r0, #0
0x423914  bne     #0x423978
0x423918  mov     r0, #0x51
0x42391c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x51
0x423920  cmp     r0, #0
0x423924  bne     #0x423978
0x423928  mov     r0, #0x52
0x42392c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x52
0x423930  cmp     r0, #0
0x423934  bne     #0x423978
0x423938  mov     r0, #0x54
0x42393c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x54
0x423940  cmp     r0, #0
0x423944  bne     #0x423978
0x423948  mov     r0, #9
0x42394c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x9
0x423950  cmp     r0, #0
0x423954  bne     #0x423978
0x423958  mov     r0, #0x7d
0x42395c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7d
0x423960  cmp     r0, #0
0x423964  bne     #0x423978
0x423968  ldr     r0, [r4]
0x42396c  ldr     r1, [r0, #0x440]   ; <<F440>>
0x423970  orr     r1, r1, #0x10
0x423974  str     r1, [r0, #0x440]   ; <<F440>>
0x423978  mov     r0, #0x46
0x42397c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x46
0x423980  ldr     r1, [r4]
0x423984  cmp     r0, #0
0x423988  beq     #0x4239c0
0x42398c  cmp     r1, #0
0x423990  beq     #0x4239f4
0x423994  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423998  cmp     r0, #3
0x42399c  blo     #0x4239f4
0x4239a0  movw    r0, #0
0x4239a4  movt    r0, #0
0x4239a8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4239ac  cmp     r0, #1
0x4239b0  bne     #0x4239f4
0x4239b4  movw    r0, #0
0x4239b8  movt    r0, #0
0x4239bc  b       #0x4249d0
0x4239c0  ldr     r0, [r1, #0x440]   ; <<F440>>
0x4239c4  cmp     r1, #0
0x4239c8  orr     r0, r0, #0x100
0x4239cc  str     r0, [r1, #0x440]   ; <<F440>>
0x4239d0  beq     #0x4239f4
0x4239d4  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4239d8  cmp     r0, #3
0x4239dc  blo     #0x4239f4
0x4239e0  movw    r0, #0
0x4239e4  movt    r0, #0
0x4239e8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4239ec  cmp     r0, #1
0x4239f0  beq     #0x4249c8
0x4239f4  mov     r0, #0xd
0x4239f8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xd
0x4239fc  ldr     r1, [r4]
0x423a00  cmp     r0, #0
0x423a04  beq     #0x423a40
0x423a08  mov     r7, #1
0x423a0c  cmp     r1, #0
0x423a10  beq     #0x423a74
0x423a14  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423a18  cmp     r0, #3
0x423a1c  blo     #0x423a74
0x423a20  movw    r0, #0
0x423a24  movt    r0, #0
0x423a28  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423a2c  cmp     r0, #1
0x423a30  bne     #0x423a74
0x423a34  movw    r0, #0
0x423a38  movt    r0, #0
0x423a3c  b       #0x4249e0
0x423a40  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423a44  cmp     r1, #0
0x423a48  orr     r0, r0, #4
0x423a4c  str     r0, [r1, #0x440]   ; <<F440>>
0x423a50  beq     #0x423a74
0x423a54  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423a58  cmp     r0, #3
0x423a5c  blo     #0x423a74
0x423a60  movw    r0, #0
0x423a64  movt    r0, #0
0x423a68  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423a6c  cmp     r0, #1
0x423a70  beq     #0x4249d8
0x423a74  mov     r0, #0xf
0x423a78  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xf
0x423a7c  ldr     r1, [r4]
0x423a80  cmp     r0, #0
0x423a84  beq     #0x423ac0
0x423a88  mov     r8, #1
0x423a8c  cmp     r1, #0
0x423a90  beq     #0x423af8
0x423a94  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423a98  cmp     r0, #3
0x423a9c  blo     #0x423af8
0x423aa0  movw    r0, #0
0x423aa4  movt    r0, #0
0x423aa8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423aac  cmp     r0, #1
0x423ab0  bne     #0x423af8
0x423ab4  movw    r0, #0
0x423ab8  movt    r0, #0
0x423abc  b       #0x4249f0
0x423ac0  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423ac4  mov     r8, #0
0x423ac8  cmp     r1, #0
0x423acc  orr     r0, r0, #8
0x423ad0  str     r0, [r1, #0x440]   ; <<F440>>
0x423ad4  beq     #0x423af8
0x423ad8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423adc  cmp     r0, #3
0x423ae0  blo     #0x423af8
0x423ae4  movw    r0, #0
0x423ae8  movt    r0, #0
0x423aec  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423af0  cmp     r0, #1
0x423af4  beq     #0x4249e8
0x423af8  mov     r0, #0x1e
0x423afc  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x1e
0x423b00  ldr     r1, [r4]
0x423b04  cmp     r0, #0
0x423b08  beq     #0x423b40
0x423b0c  cmp     r1, #0
0x423b10  beq     #0x423b74
0x423b14  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423b18  cmp     r0, #3
0x423b1c  blo     #0x423b74
0x423b20  movw    r0, #0
0x423b24  movt    r0, #0
0x423b28  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423b2c  cmp     r0, #1
0x423b30  bne     #0x423b74
0x423b34  movw    r0, #0
0x423b38  movt    r0, #0
0x423b3c  b       #0x424a00
0x423b40  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423b44  cmp     r1, #0
0x423b48  orr     r0, r0, #0x20
0x423b4c  str     r0, [r1, #0x440]   ; <<F440>>
0x423b50  beq     #0x423b74
0x423b54  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423b58  cmp     r0, #3
0x423b5c  blo     #0x423b74
0x423b60  movw    r0, #0
0x423b64  movt    r0, #0
0x423b68  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423b6c  cmp     r0, #1
0x423b70  beq     #0x4249f8
0x423b74  mov     r0, #0x41
0x423b78  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x41
0x423b7c  ldr     r1, [r4]
0x423b80  cmp     r0, #0
0x423b84  beq     #0x423bbc
0x423b88  cmp     r1, #0
0x423b8c  beq     #0x423bf0
0x423b90  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423b94  cmp     r0, #3
0x423b98  blo     #0x423bf0
0x423b9c  movw    r0, #0
0x423ba0  movt    r0, #0
0x423ba4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423ba8  cmp     r0, #1
0x423bac  bne     #0x423bf0
0x423bb0  movw    r0, #0
0x423bb4  movt    r0, #0
0x423bb8  b       #0x424a10
0x423bbc  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423bc0  cmp     r1, #0
0x423bc4  orr     r0, r0, #0x40
0x423bc8  str     r0, [r1, #0x440]   ; <<F440>>
0x423bcc  beq     #0x423bf0
0x423bd0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423bd4  cmp     r0, #3
0x423bd8  blo     #0x423bf0
0x423bdc  movw    r0, #0
0x423be0  movt    r0, #0
0x423be4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423be8  cmp     r0, #1
0x423bec  beq     #0x424a08
0x423bf0  mov     r0, #0x3a
0x423bf4  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x3a
0x423bf8  ldr     r1, [r4]
0x423bfc  cmp     r0, #0
0x423c00  beq     #0x423c38
0x423c04  cmp     r1, #0
0x423c08  beq     #0x423c6c
0x423c0c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423c10  cmp     r0, #3
0x423c14  blo     #0x423c6c
0x423c18  movw    r0, #0
0x423c1c  movt    r0, #0
0x423c20  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423c24  cmp     r0, #1
0x423c28  bne     #0x423c6c
0x423c2c  movw    r0, #0
0x423c30  movt    r0, #0
0x423c34  b       #0x424a20
0x423c38  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423c3c  cmp     r1, #0
0x423c40  orr     r0, r0, #0x80
0x423c44  str     r0, [r1, #0x440]   ; <<F440>>
0x423c48  beq     #0x423c6c
0x423c4c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423c50  cmp     r0, #3
0x423c54  blo     #0x423c6c
0x423c58  movw    r0, #0
0x423c5c  movt    r0, #0
0x423c60  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423c64  cmp     r0, #1
0x423c68  beq     #0x424a18
0x423c6c  mov     r0, #0x49
0x423c70  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x49
0x423c74  ldr     r1, [r4]
0x423c78  cmp     r0, #0
0x423c7c  beq     #0x423cb4
0x423c80  cmp     r1, #0
0x423c84  beq     #0x423ce8
0x423c88  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423c8c  cmp     r0, #3
0x423c90  blo     #0x423ce8
0x423c94  movw    r0, #0
0x423c98  movt    r0, #0
0x423c9c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423ca0  cmp     r0, #1
0x423ca4  bne     #0x423ce8
0x423ca8  movw    r0, #0
0x423cac  movt    r0, #0
0x423cb0  b       #0x424a30
0x423cb4  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423cb8  cmp     r1, #0
0x423cbc  orr     r0, r0, #0x400
0x423cc0  str     r0, [r1, #0x440]   ; <<F440>>
0x423cc4  beq     #0x423ce8
0x423cc8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423ccc  cmp     r0, #3
0x423cd0  blo     #0x423ce8
0x423cd4  movw    r0, #0
0x423cd8  movt    r0, #0
0x423cdc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423ce0  cmp     r0, #1
0x423ce4  beq     #0x424a28
0x423ce8  mov     r0, #3
0x423cec  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x3
0x423cf0  ldr     r1, [r4]
0x423cf4  cmp     r0, #0
0x423cf8  beq     #0x423d30
0x423cfc  cmp     r1, #0
0x423d00  beq     #0x423d64
0x423d04  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423d08  cmp     r0, #3
0x423d0c  blo     #0x423d64
0x423d10  movw    r0, #0
0x423d14  movt    r0, #0
0x423d18  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423d1c  cmp     r0, #1
0x423d20  bne     #0x423d64
0x423d24  movw    r0, #0
0x423d28  movt    r0, #0
0x423d2c  b       #0x424a40
0x423d30  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423d34  cmp     r1, #0
0x423d38  orr     r0, r0, #0x2000
0x423d3c  str     r0, [r1, #0x440]   ; <<F440>>
0x423d40  beq     #0x423d64
0x423d44  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423d48  cmp     r0, #3
0x423d4c  blo     #0x423d64
0x423d50  movw    r0, #0
0x423d54  movt    r0, #0
0x423d58  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423d5c  cmp     r0, #1
0x423d60  beq     #0x424a38
0x423d64  mov     r0, #0x37
0x423d68  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x37
0x423d6c  ldr     r1, [r4]
0x423d70  cmp     r0, #0
0x423d74  beq     #0x423dac
0x423d78  cmp     r1, #0
0x423d7c  beq     #0x423de0
0x423d80  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423d84  cmp     r0, #3
0x423d88  blo     #0x423de0
0x423d8c  movw    r0, #0
0x423d90  movt    r0, #0
0x423d94  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423d98  cmp     r0, #1
0x423d9c  bne     #0x423de0
0x423da0  movw    r0, #0
0x423da4  movt    r0, #0
0x423da8  b       #0x424a50
0x423dac  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423db0  cmp     r1, #0
0x423db4  orr     r0, r0, #0x4000
0x423db8  str     r0, [r1, #0x440]   ; <<F440>>
0x423dbc  beq     #0x423de0
0x423dc0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423dc4  cmp     r0, #3
0x423dc8  blo     #0x423de0
0x423dcc  movw    r0, #0
0x423dd0  movt    r0, #0
0x423dd4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423dd8  cmp     r0, #1
0x423ddc  beq     #0x424a48
0x423de0  mov     r0, #0x45
0x423de4  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x45
0x423de8  ldr     r1, [r4]
0x423dec  cmp     r0, #0
0x423df0  beq     #0x423e28
0x423df4  cmp     r1, #0
0x423df8  beq     #0x423e5c
0x423dfc  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423e00  cmp     r0, #3
0x423e04  blo     #0x423e5c
0x423e08  movw    r0, #0
0x423e0c  movt    r0, #0
0x423e10  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423e14  cmp     r0, #1
0x423e18  bne     #0x423e5c
0x423e1c  movw    r0, #0
0x423e20  movt    r0, #0
0x423e24  b       #0x424a60
0x423e28  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423e2c  cmp     r1, #0
0x423e30  orr     r0, r0, #0x8000
0x423e34  str     r0, [r1, #0x440]   ; <<F440>>
0x423e38  beq     #0x423e5c
0x423e3c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423e40  cmp     r0, #3
0x423e44  blo     #0x423e5c
0x423e48  movw    r0, #0
0x423e4c  movt    r0, #0
0x423e50  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423e54  cmp     r0, #1
0x423e58  beq     #0x424a58
0x423e5c  mov     r0, #0x1c
0x423e60  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x1c
0x423e64  ldr     r1, [r4]
0x423e68  cmp     r0, #0
0x423e6c  beq     #0x423ea4
0x423e70  cmp     r1, #0
0x423e74  beq     #0x423ed8
0x423e78  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423e7c  cmp     r0, #3
0x423e80  blo     #0x423ed8
0x423e84  movw    r0, #0
0x423e88  movt    r0, #0
0x423e8c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423e90  cmp     r0, #1
0x423e94  bne     #0x423ed8
0x423e98  movw    r0, #0
0x423e9c  movt    r0, #0
0x423ea0  b       #0x424a70
0x423ea4  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423ea8  cmp     r1, #0
0x423eac  orr     r0, r0, #0x10000
0x423eb0  str     r0, [r1, #0x440]   ; <<F440>>
0x423eb4  beq     #0x423ed8
0x423eb8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423ebc  cmp     r0, #3
0x423ec0  blo     #0x423ed8
0x423ec4  movw    r0, #0
0x423ec8  movt    r0, #0
0x423ecc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423ed0  cmp     r0, #1
0x423ed4  beq     #0x424a68
0x423ed8  mov     r0, #0x12
0x423edc  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x12
0x423ee0  ldr     r1, [r4]
0x423ee4  cmp     r0, #0
0x423ee8  ldr     r2, [r1, #0x440]   ; <<F440>>
0x423eec  beq     #0x423f30
0x423ef0  mov     r8, #2
0x423ef4  cmp     r1, #0
0x423ef8  bic     r0, r2, #0x400
0x423efc  str     r0, [r1, #0x440]   ; <<F440>>
0x423f00  beq     #0x423f60
0x423f04  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423f08  cmp     r0, #3
0x423f0c  blo     #0x423f60
0x423f10  movw    r0, #0
0x423f14  movt    r0, #0
0x423f18  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423f1c  cmp     r0, #1
0x423f20  bne     #0x423f60
0x423f24  movw    r0, #0
0x423f28  movt    r0, #0
0x423f2c  b       #0x424a80
0x423f30  cmp     r1, #0
0x423f34  orr     r0, r2, #0x20000
0x423f38  str     r0, [r1, #0x440]   ; <<F440>>
0x423f3c  beq     #0x423f60
0x423f40  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423f44  cmp     r0, #3
0x423f48  blo     #0x423f60
0x423f4c  movw    r0, #0
0x423f50  movt    r0, #0
0x423f54  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423f58  cmp     r0, #1
0x423f5c  beq     #0x424a78
0x423f60  mov     r0, #0x38
0x423f64  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x38
0x423f68  ldr     r1, [r4]
0x423f6c  cmp     r0, #0
0x423f70  beq     #0x423fa8
0x423f74  cmp     r1, #0
0x423f78  beq     #0x423fdc
0x423f7c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423f80  cmp     r0, #3
0x423f84  blo     #0x423fdc
0x423f88  movw    r0, #0
0x423f8c  movt    r0, #0
0x423f90  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423f94  cmp     r0, #1
0x423f98  bne     #0x423fdc
0x423f9c  movw    r0, #0
0x423fa0  movt    r0, #0
0x423fa4  b       #0x424a90
0x423fa8  ldr     r0, [r1, #0x440]   ; <<F440>>
0x423fac  cmp     r1, #0
0x423fb0  orr     r0, r0, #0x400000
0x423fb4  str     r0, [r1, #0x440]   ; <<F440>>
0x423fb8  beq     #0x423fdc
0x423fbc  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423fc0  cmp     r0, #3
0x423fc4  blo     #0x423fdc
0x423fc8  movw    r0, #0
0x423fcc  movt    r0, #0
0x423fd0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x423fd4  cmp     r0, #1
0x423fd8  beq     #0x424a88
0x423fdc  mov     r0, #0x42
0x423fe0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x42
0x423fe4  ldr     r1, [r4]
0x423fe8  cmp     r0, #0
0x423fec  beq     #0x424024
0x423ff0  cmp     r1, #0
0x423ff4  beq     #0x424058
0x423ff8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x423ffc  cmp     r0, #3
0x424000  blo     #0x424058
0x424004  movw    r0, #0
0x424008  movt    r0, #0
0x42400c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424010  cmp     r0, #1
0x424014  bne     #0x424058
0x424018  movw    r0, #0
0x42401c  movt    r0, #0
0x424020  b       #0x424aa0
0x424024  ldr     r0, [r1, #0x440]   ; <<F440>>
0x424028  cmp     r1, #0
0x42402c  orr     r0, r0, #0x800000
0x424030  str     r0, [r1, #0x440]   ; <<F440>>
0x424034  beq     #0x424058
0x424038  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x42403c  cmp     r0, #3
0x424040  blo     #0x424058
0x424044  movw    r0, #0
0x424048  movt    r0, #0
0x42404c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424050  cmp     r0, #1
0x424054  beq     #0x424a98
0x424058  mov     r0, #0x79
0x42405c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x79
0x424060  ldr     r1, [r4]
0x424064  cmp     r0, #0
0x424068  beq     #0x4240b0
0x42406c  ldr     r0, [r1, #0x444]   ; <<F444>>
0x424070  mov     r6, #3
0x424074  cmp     r1, #0
0x424078  bic     r0, r0, #1
0x42407c  str     r0, [r1, #0x444]   ; <<F444>>
0x424080  beq     #0x4240d8
0x424084  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424088  cmp     r0, #3
0x42408c  blo     #0x4240d8
0x424090  movw    r0, #0
0x424094  movt    r0, #0
0x424098  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42409c  cmp     r0, #1
0x4240a0  bne     #0x4240d8
0x4240a4  movw    r0, #0
0x4240a8  movt    r0, #0
0x4240ac  b       #0x424ab0
0x4240b0  cmp     r1, #0
0x4240b4  beq     #0x4240d8
0x4240b8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4240bc  cmp     r0, #3
0x4240c0  blo     #0x4240d8
0x4240c4  movw    r0, #0
0x4240c8  movt    r0, #0
0x4240cc  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4240d0  cmp     r0, #1
0x4240d4  beq     #0x424aa8
0x4240d8  mov     r0, #0x54
0x4240dc  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x54
0x4240e0  ldr     r1, [r4]
0x4240e4  cmp     r0, #0
0x4240e8  beq     #0x4241d0
0x4240ec  ldr     r0, [r1, #0x444]   ; <<F444>>
0x4240f0  mov     sb, #7
0x4240f4  mov     r6, #4
0x4240f8  mov     sl, #1
0x4240fc  bic     r0, r0, #0x80
0x424100  str     r0, [r1, #0x444]   ; <<F444>>
0x424104  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x424108  cmp     r1, #0
0x42410c  orr     r0, r0, #1
0x424110  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x424114  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x424118  orr     r0, r0, #1
0x42411c  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x424120  beq     #0x424144
0x424124  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424128  cmp     r0, #3
0x42412c  blo     #0x424144
0x424130  movw    r0, #0
0x424134  movt    r0, #0
0x424138  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42413c  cmp     r0, #1
0x424140  beq     #0x424968
0x424144  mov     r7, #1
0x424148  mov     r0, #8
0x42414c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x8
0x424150  ldr     r1, [r4]
0x424154  cmp     r0, #0
0x424158  beq     #0x424208
0x42415c  ldr     r0, [r1, #0x440]   ; <<F440>>
0x424160  mov     sb, #7
0x424164  ldr     r2, [r1, #0x444]   ; <<F444>>
0x424168  mov     r6, #4
0x42416c  orr     r0, r0, #0x10
0x424170  str     r0, [r1, #0x440]   ; <<F440>>
0x424174  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x424178  mov     r7, #1
0x42417c  mov     sl, #0
0x424180  cmp     r1, #0
0x424184  orr     r0, r0, #1
0x424188  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x42418c  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x424190  bic     r2, r2, #0x80
0x424194  str     r2, [r1, #0x444]   ; <<F444>>
0x424198  orr     r0, r0, #1
0x42419c  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x4241a0  beq     #0x424230
0x4241a4  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4241a8  cmp     r0, #3
0x4241ac  blo     #0x424230
0x4241b0  movw    r0, #0
0x4241b4  movt    r0, #0
0x4241b8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4241bc  cmp     r0, #1
0x4241c0  bne     #0x424230
0x4241c4  movw    r0, #0
0x4241c8  movt    r0, #0
0x4241cc  b       #0x424ac0
0x4241d0  cmp     r1, #0
0x4241d4  beq     #0x424148
0x4241d8  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4241dc  cmp     r0, #3
0x4241e0  blo     #0x424148
0x4241e4  movw    r0, #0
0x4241e8  movt    r0, #0
0x4241ec  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4241f0  cmp     r0, #1
0x4241f4  bne     #0x424148
0x4241f8  movw    r0, #0
0x4241fc  movt    r0, #0
0x424200  bl      #0xfffffff8   ; CALL printk
0x424204  b       #0x424148
0x424208  cmp     r1, #0
0x42420c  beq     #0x424230
0x424210  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424214  cmp     r0, #3
0x424218  blo     #0x424230
0x42421c  movw    r0, #0
0x424220  movt    r0, #0
0x424224  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424228  cmp     r0, #1
0x42422c  beq     #0x424ab8
0x424230  mov     r0, #0x66
0x424234  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x66
0x424238  ldr     r1, [r4]
0x42423c  cmp     r0, #0
0x424240  beq     #0x4242b8
0x424244  ldr     r0, [r1, #0x440]   ; <<F440>>
0x424248  mov     sb, #9
0x42424c  ldr     r2, [r1, #0x444]   ; <<F444>>
0x424250  mov     r6, #4
0x424254  orr     r0, r0, #0x10
0x424258  str     r0, [r1, #0x440]   ; <<F440>>
0x42425c  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x424260  mov     r7, #1
0x424264  mov     sl, #0
0x424268  cmp     r1, #0
0x42426c  orr     r0, r0, #1
0x424270  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x424274  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x424278  bic     r2, r2, #0x200
0x42427c  str     r2, [r1, #0x444]   ; <<F444>>
0x424280  orr     r0, r0, #1
0x424284  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x424288  beq     #0x4242e0
0x42428c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424290  cmp     r0, #3
0x424294  blo     #0x4242e0
0x424298  movw    r0, #0
0x42429c  movt    r0, #0
0x4242a0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4242a4  cmp     r0, #1
0x4242a8  bne     #0x4242e0
0x4242ac  movw    r0, #0
0x4242b0  movt    r0, #0
0x4242b4  b       #0x424ad0
0x4242b8  cmp     r1, #0
0x4242bc  beq     #0x4242e0
0x4242c0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4242c4  cmp     r0, #3
0x4242c8  blo     #0x4242e0
0x4242cc  movw    r0, #0
0x4242d0  movt    r0, #0
0x4242d4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4242d8  cmp     r0, #1
0x4242dc  beq     #0x424ac8
0x4242e0  mov     r0, #9
0x4242e4  mov     r5, #9
0x4242e8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck
0x4242ec  ldr     r1, [r4]
0x4242f0  cmp     r0, #0
0x4242f4  beq     #0x424354
0x4242f8  ldr     r0, [r1, #0x444]   ; <<F444>>
0x4242fc  mov     r6, #4
0x424300  mov     sl, #1
0x424304  cmp     r1, #0
0x424308  bic     r0, r0, #0x200
0x42430c  str     r0, [r1, #0x444]   ; <<F444>>
0x424310  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x424314  orr     r0, r0, #1
0x424318  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x42431c  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x424320  orr     r0, r0, #1
0x424324  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x424328  beq     #0x42434c
0x42432c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424330  cmp     r0, #3
0x424334  blo     #0x42434c
0x424338  movw    r0, #0
0x42433c  movt    r0, #0
0x424340  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424344  cmp     r0, #1
0x424348  beq     #0x424978
0x42434c  mov     r7, #1
0x424350  b       #0x424380
0x424354  cmp     r1, #0
0x424358  beq     #0x42437c
0x42435c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424360  cmp     r0, #3
0x424364  blo     #0x42437c
0x424368  movw    r0, #0
0x42436c  movt    r0, #0
0x424370  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424374  cmp     r0, #1
0x424378  beq     #0x424ad8
0x42437c  mov     r5, sb
0x424380  mov     r0, #0xa
0x424384  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0xa
0x424388  ldr     r1, [r4]
0x42438c  cmp     r0, #0
0x424390  beq     #0x42440c
0x424394  ldr     r0, [r1, #0x440]   ; <<F440>>
0x424398  mov     r5, #8
0x42439c  ldr     r2, [r1, #0x444]   ; <<F444>>
0x4243a0  mov     r6, #4
0x4243a4  orr     r0, r0, #0x10
0x4243a8  str     r0, [r1, #0x440]   ; <<F440>>
0x4243ac  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x4243b0  mov     r7, #1
0x4243b4  mov     sl, #0
0x4243b8  cmp     r1, #0
0x4243bc  orr     r0, r0, #1
0x4243c0  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x4243c4  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x4243c8  orr     r0, r0, #1
0x4243cc  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x4243d0  orr     r0, r2, #0x280
0x4243d4  bic     r0, r0, #2
0x4243d8  str     r0, [r1, #0x444]   ; <<F444>>
0x4243dc  beq     #0x424434
0x4243e0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4243e4  cmp     r0, #3
0x4243e8  blo     #0x424434
0x4243ec  movw    r0, #0
0x4243f0  movt    r0, #0
0x4243f4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4243f8  cmp     r0, #1
0x4243fc  bne     #0x424434
0x424400  movw    r0, #0
0x424404  movt    r0, #0
0x424408  b       #0x424af0
0x42440c  cmp     r1, #0
0x424410  beq     #0x424434
0x424414  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424418  cmp     r0, #3
0x42441c  blo     #0x424434
0x424420  movw    r0, #0
0x424424  movt    r0, #0
0x424428  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42442c  cmp     r0, #1
0x424430  beq     #0x424ae8
0x424434  mov     r0, #0x7d
0x424438  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7d
0x42443c  ldr     r1, [r4]
0x424440  cmp     r0, #0
0x424444  beq     #0x424508
0x424448  ldr     r0, [r1, #0x440]   ; <<F440>>
0x42444c  mov     r5, #8
0x424450  ldr     r2, [r1, #0x444]   ; <<F444>>
0x424454  mov     r6, #4
0x424458  bic     r0, r0, #0x10
0x42445c  str     r0, [r1, #0x440]   ; <<F440>>
0x424460  ldrb    r0, [r1, #0x57f]   ; <<F57f>>
0x424464  mov     sl, #1
0x424468  cmp     r1, #0
0x42446c  orr     r0, r0, #1
0x424470  strb    r0, [r1, #0x57f]   ; <<F57f>>
0x424474  ldrb    r0, [r1, #0x57e]   ; <<F57e>>
0x424478  orr     r0, r0, #1
0x42447c  strb    r0, [r1, #0x57e]   ; <<F57e>>
0x424480  orr     r0, r2, #0x280
0x424484  bic     r0, r0, #2
0x424488  str     r0, [r1, #0x444]   ; <<F444>>
0x42448c  beq     #0x4244b0
0x424490  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424494  cmp     r0, #3
0x424498  blo     #0x4244b0
0x42449c  movw    r0, #0
0x4244a0  movt    r0, #0
0x4244a4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4244a8  cmp     r0, #1
0x4244ac  beq     #0x424988
0x4244b0  mov     r7, #1
0x4244b4  mov     r0, #0x7e
0x4244b8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7e
0x4244bc  ldr     r1, [r4]
0x4244c0  cmp     r0, #0
0x4244c4  beq     #0x424540
0x4244c8  ldr     r0, [r1, #0x444]   ; <<F444>>
0x4244cc  cmp     r1, #0
0x4244d0  bic     r0, r0, #4
0x4244d4  str     r0, [r1, #0x444]   ; <<F444>>
0x4244d8  beq     #0x424568
0x4244dc  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4244e0  cmp     r0, #3
0x4244e4  blo     #0x424568
0x4244e8  movw    r0, #0
0x4244ec  movt    r0, #0
0x4244f0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4244f4  cmp     r0, #1
0x4244f8  bne     #0x424568
0x4244fc  movw    r0, #0
0x424500  movt    r0, #0
0x424504  b       #0x424b00
0x424508  cmp     r1, #0
0x42450c  beq     #0x4244b4
0x424510  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424514  cmp     r0, #3
0x424518  blo     #0x4244b4
0x42451c  movw    r0, #0
0x424520  movt    r0, #0
0x424524  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424528  cmp     r0, #1
0x42452c  bne     #0x4244b4
0x424530  movw    r0, #0
0x424534  movt    r0, #0
0x424538  bl      #0xfffffff8   ; CALL printk
0x42453c  b       #0x4244b4
0x424540  cmp     r1, #0
0x424544  beq     #0x424568
0x424548  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x42454c  cmp     r0, #3
0x424550  blo     #0x424568
0x424554  movw    r0, #0
0x424558  movt    r0, #0
0x42455c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424560  cmp     r0, #1
0x424564  beq     #0x424af8
0x424568  mov     r0, #0x7c
0x42456c  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7c
0x424570  ldr     r1, [r4]
0x424574  cmp     r0, #0
0x424578  beq     #0x4245bc
0x42457c  ldr     r0, [r1, #0x444]   ; <<F444>>
0x424580  cmp     r1, #0
0x424584  bic     r0, r0, #8
0x424588  str     r0, [r1, #0x444]   ; <<F444>>
0x42458c  beq     #0x4245e4
0x424590  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424594  cmp     r0, #3
0x424598  blo     #0x4245e4
0x42459c  movw    r0, #0
0x4245a0  movt    r0, #0
0x4245a4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4245a8  cmp     r0, #1
0x4245ac  bne     #0x4245e4
0x4245b0  movw    r0, #0
0x4245b4  movt    r0, #0
0x4245b8  b       #0x424b10
0x4245bc  cmp     r1, #0
0x4245c0  beq     #0x4245e4
0x4245c4  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4245c8  cmp     r0, #3
0x4245cc  blo     #0x4245e4
0x4245d0  movw    r0, #0
0x4245d4  movt    r0, #0
0x4245d8  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4245dc  cmp     r0, #1
0x4245e0  beq     #0x424b08
0x4245e4  mov     r0, #6
0x4245e8  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x6
0x4245ec  ldr     r1, [r4]
0x4245f0  cmp     r0, #0
0x4245f4  beq     #0x424638
0x4245f8  ldr     r0, [r1, #0x444]   ; <<F444>>
0x4245fc  cmp     r1, #0
0x424600  bic     r0, r0, #0x10
0x424604  str     r0, [r1, #0x444]   ; <<F444>>
0x424608  beq     #0x424660
0x42460c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424610  cmp     r0, #3
0x424614  blo     #0x424660
0x424618  movw    r0, #0
0x42461c  movt    r0, #0
0x424620  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424624  cmp     r0, #1
0x424628  bne     #0x424660
0x42462c  movw    r0, #0
0x424630  movt    r0, #0
0x424634  b       #0x424b20
0x424638  cmp     r1, #0
0x42463c  beq     #0x424660
0x424640  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424644  cmp     r0, #3
0x424648  blo     #0x424660
0x42464c  movw    r0, #0
0x424650  movt    r0, #0
0x424654  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424658  cmp     r0, #1
0x42465c  beq     #0x424b18
0x424660  mov     r0, #0x40
0x424664  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x40
0x424668  ldr     r1, [r4]
0x42466c  cmp     r0, #0
0x424670  beq     #0x4246b4
0x424674  ldr     r0, [r1, #0x444]   ; <<F444>>
0x424678  cmp     r1, #0
0x42467c  bic     r0, r0, #0x40
0x424680  str     r0, [r1, #0x444]   ; <<F444>>
0x424684  beq     #0x4246dc
0x424688  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x42468c  cmp     r0, #3
0x424690  blo     #0x4246dc
0x424694  movw    r0, #0
0x424698  movt    r0, #0
0x42469c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4246a0  cmp     r0, #1
0x4246a4  bne     #0x4246dc
0x4246a8  movw    r0, #0
0x4246ac  movt    r0, #0
0x4246b0  b       #0x424b30
0x4246b4  cmp     r1, #0
0x4246b8  beq     #0x4246dc
0x4246bc  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4246c0  cmp     r0, #3
0x4246c4  blo     #0x4246dc
0x4246c8  movw    r0, #0
0x4246cc  movt    r0, #0
0x4246d0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4246d4  cmp     r0, #1
0x4246d8  beq     #0x424b28
0x4246dc  mov     r0, #7
0x4246e0  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7
0x4246e4  ldr     r1, [r4]
0x4246e8  cmp     r0, #0
0x4246ec  beq     #0x42473c
0x4246f0  mov     r0, #1
0x4246f4  mov     r8, #3
0x4246f8  strb    r0, [r1, #0x582]   ; <<F582>>
0x4246fc  cmp     r1, #0
0x424700  ldr     r0, [r1, #0x444]   ; <<F444>>
0x424704  bic     r0, r0, #0x100
0x424708  str     r0, [r1, #0x444]   ; <<F444>>
0x42470c  beq     #0x424764
0x424710  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424714  cmp     r0, #3
0x424718  blo     #0x424764
0x42471c  movw    r0, #0
0x424720  movt    r0, #0
0x424724  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424728  cmp     r0, #1
0x42472c  bne     #0x424764
0x424730  movw    r0, #0
0x424734  movt    r0, #0
0x424738  b       #0x424b40
0x42473c  cmp     r1, #0
0x424740  beq     #0x424764
0x424744  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424748  cmp     r0, #3
0x42474c  blo     #0x424764
0x424750  movw    r0, #0
0x424754  movt    r0, #0
0x424758  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42475c  cmp     r0, #1
0x424760  beq     #0x424b38
0x424764  mov     r0, #5
0x424768  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x5
0x42476c  ldr     r1, [r4]
0x424770  cmp     r0, #0
0x424774  beq     #0x4247b8
0x424778  ldr     r0, [r1, #0x444]   ; <<F444>>
0x42477c  cmp     r1, #0
0x424780  bic     r0, r0, #0x20
0x424784  str     r0, [r1, #0x444]   ; <<F444>>
0x424788  beq     #0x4247e0
0x42478c  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x424790  cmp     r0, #3
0x424794  blo     #0x4247e0
0x424798  movw    r0, #0
0x42479c  movt    r0, #0
0x4247a0  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4247a4  cmp     r0, #1
0x4247a8  bne     #0x4247e0
0x4247ac  movw    r0, #0
0x4247b0  movt    r0, #0
0x4247b4  b       #0x424b50
0x4247b8  cmp     r1, #0
0x4247bc  beq     #0x4247e0
0x4247c0  ldr     r0, [r1, #0x4c8]   ; <<dbg>>
0x4247c4  cmp     r0, #3
0x4247c8  blo     #0x4247e0
0x4247cc  movw    r0, #0
0x4247d0  movt    r0, #0
0x4247d4  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4247d8  cmp     r0, #1
0x4247dc  beq     #0x424b48
0x4247e0  mov     r0, #0x7f
0x4247e4  bl      #0x13904   ; CALL MDrv_AUTH_IPCheck IPID=0x7f
0x4247e8  cmp     r0, #0
0x4247ec  beq     #0x424828
0x4247f0  ldr     r0, [r4]
0x4247f4  cmp     r0, #0
0x4247f8  ldr     r1, [r0, #0x440]   ; <<F440>>
0x4247fc  orr     r1, r1, #0x1000
0x424800  str     r1, [r0, #0x440]   ; <<F440>>
0x424804  beq     #0x424828
0x424808  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x42480c  cmp     r0, #3
0x424810  blo     #0x424828
0x424814  movw    r0, #0
0x424818  movt    r0, #0
0x42481c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x424820  cmp     r0, #1
0x424824  beq     #0x424998
0x424828  ldr     r0, [r4]
0x42482c  cmp     r0, #0
0x424830  beq     #0x424854
0x424834  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x424838  cmp     r0, #3
0x42483c  blo     #0x424854
0x424840  movw    r0, #0
0x424844  movt    r0, #0
0x424848  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x42484c  cmp     r0, #1
0x424850  beq     #0x4248d4
0x424854  ldr     r0, [r4]
0x424858  ldr     r0, [r0, #0x440]   ; <<F440>>
0x42485c  bl      #0x4539ac   ; CALL HAL_AUDIO_CheckHashkeyDone
0x424860  cmn     r0, #0x16
0x424864  beq     #0x424b58
0x424868  ldr     r0, [r4]
0x42486c  cmp     r0, #0
0x424870  str     r6, [r0, #0x4d0]   ; <<F4d0>>
0x424874  str     r5, [r0, #0x4d4]   ; <<F4d4>>
0x424878  str     r8, [r0, #0x4d8]   ; <<F4d8>>
0x42487c  strb    r7, [r0, #0x43e]   ; <<F43e>>
0x424880  strb    sl, [r0, #0x43d]   ; <<F43d>>
0x424884  beq     #0x4248a8
0x424888  ldr     r0, [r0, #0x4c8]   ; <<dbg>>
0x42488c  cmp     r0, #3
0x424890  blo     #0x4248a8
0x424894  movw    r0, #0
0x424898  movt    r0, #0
0x42489c  bl      #0x2d4c   ; CALL UtopiaLogSystem
0x4248a0  cmp     r0, #1
0x4248a4  beq     #0x4248e4
0x4248a8  bl      #0x4411a4   ; CALL HAL_AUDIO_GET_INIT_FLAG
0x4248ac  cmp     r0, #1
0x4248b0  ldreq   r0, [r4]
0x4248b4  moveq   r1, #1
0x4248b8  strbeq  r1, [r0, #0x503]   ; <<F503>>
0x4248bc  add     sp, sp, #0x10
0x4248c0  pop     {r4, r5, r6, r7, r8, sb, sl, pc}
0x4248c4  movw    r0, #0
0x4248c8  movt    r0, #0
0x4248cc  bl      #0xfffffff8   ; CALL printk
0x4248d0  b       #0x423504
0x4248d4  movw    r0, #0
0x4248d8  movt    r0, #0
0x4248dc  bl      #0xfffffff8   ; CALL printk
0x4248e0  b       #0x424854
0x4248e4  ldr     r0, [r4]
0x4248e8  ldrb    r1, [r0, #0x43e]   ; <<F43e>>
0x4248ec  ldr     r2, [r0, #0x4d0]   ; <<F4d0>>
0x4248f0  ldrb    r3, [r0, #0x43d]   ; <<F43d>>
0x4248f4  ldr     r7, [r0, #0x440]   ; <<F440>>
0x4248f8  ldr     r0, [r0, #0x444]   ; <<F444>>
0x4248fc  stm     sp, {r1, r7}
0x424900  movw    r1, #0
0x424904  movt    r1, #0
0x424908  str     r0, [sp, #8]
0x42490c  movw    r0, #0
0x424910  movt    r0, #0
0x424914  bl      #0xfffffff8   ; CALL printk
0x424918  b       #0x4248a8
0x42491c  movw    r0, #0
0x424920  movt    r0, #0
0x424924  bl      #0xfffffff8   ; CALL printk
0x424928  mov     r7, #1
0x42492c  b       #0x4236b8
0x424930  movw    r0, #0
0x424934  movt    r0, #0
0x424938  bl      #0xfffffff8   ; CALL printk
0x42493c  mov     r7, #1
0x424940  b       #0x42381c
0x424944  movw    r0, #0
0x424948  movt    r0, #0
0x42494c  bl      #0xfffffff8   ; CALL printk
0x424950  mov     r7, #1
0x424954  b       #0x4238c0
0x424958  movw    r0, #0
0x42495c  movt    r0, #0
0x424960  bl      #0xfffffff8   ; CALL printk
0x424964  b       #0x423900
0x424968  movw    r0, #0
0x42496c  movt    r0, #0
0x424970  bl      #0xfffffff8   ; CALL printk
0x424974  b       #0x424144
0x424978  movw    r0, #0
0x42497c  movt    r0, #0
0x424980  bl      #0xfffffff8   ; CALL printk
0x424984  b       #0x42434c
0x424988  movw    r0, #0
0x42498c  movt    r0, #0
0x424990  bl      #0xfffffff8   ; CALL printk
0x424994  b       #0x4244b0
0x424998  movw    r0, #0
0x42499c  movt    r0, #0
0x4249a0  bl      #0xfffffff8   ; CALL printk
0x4249a4  b       #0x424828
0x4249a8  movw    r0, #0
0x4249ac  movt    r0, #0
0x4249b0  bl      #0xfffffff8   ; CALL printk
0x4249b4  b       #0x423580
0x4249b8  movw    r0, #0
0x4249bc  movt    r0, #0
0x4249c0  bl      #0xfffffff8   ; CALL printk
0x4249c4  b       #0x423610
0x4249c8  movw    r0, #0
0x4249cc  movt    r0, #0
0x4249d0  bl      #0xfffffff8   ; CALL printk
0x4249d4  b       #0x4239f4
0x4249d8  movw    r0, #0
0x4249dc  movt    r0, #0
0x4249e0  bl      #0xfffffff8   ; CALL printk
0x4249e4  b       #0x423a74
0x4249e8  movw    r0, #0
0x4249ec  movt    r0, #0
0x4249f0  bl      #0xfffffff8   ; CALL printk
0x4249f4  b       #0x423af8
0x4249f8  movw    r0, #0
0x4249fc  movt    r0, #0
0x424a00  bl      #0xfffffff8   ; CALL printk
0x424a04  b       #0x423b74
0x424a08  movw    r0, #0
0x424a0c  movt    r0, #0
0x424a10  bl      #0xfffffff8   ; CALL printk
0x424a14  b       #0x423bf0
0x424a18  movw    r0, #0
0x424a1c  movt    r0, #0
0x424a20  bl      #0xfffffff8   ; CALL printk
0x424a24  b       #0x423c6c
0x424a28  movw    r0, #0
0x424a2c  movt    r0, #0
0x424a30  bl      #0xfffffff8   ; CALL printk
0x424a34  b       #0x423ce8
0x424a38  movw    r0, #0
0x424a3c  movt    r0, #0
0x424a40  bl      #0xfffffff8   ; CALL printk
0x424a44  b       #0x423d64
0x424a48  movw    r0, #0
0x424a4c  movt    r0, #0
0x424a50  bl      #0xfffffff8   ; CALL printk
0x424a54  b       #0x423de0
0x424a58  movw    r0, #0
0x424a5c  movt    r0, #0
0x424a60  bl      #0xfffffff8   ; CALL printk
0x424a64  b       #0x423e5c
0x424a68  movw    r0, #0
0x424a6c  movt    r0, #0
0x424a70  bl      #0xfffffff8   ; CALL printk
0x424a74  b       #0x423ed8
0x424a78  movw    r0, #0
0x424a7c  movt    r0, #0
0x424a80  bl      #0xfffffff8   ; CALL printk
0x424a84  b       #0x423f60
0x424a88  movw    r0, #0
0x424a8c  movt    r0, #0
0x424a90  bl      #0xfffffff8   ; CALL printk
0x424a94  b       #0x423fdc
0x424a98  movw    r0, #0
0x424a9c  movt    r0, #0
0x424aa0  bl      #0xfffffff8   ; CALL printk
0x424aa4  b       #0x424058
0x424aa8  movw    r0, #0
0x424aac  movt    r0, #0
0x424ab0  bl      #0xfffffff8   ; CALL printk
0x424ab4  b       #0x4240d8
0x424ab8  movw    r0, #0
0x424abc  movt    r0, #0
0x424ac0  bl      #0xfffffff8   ; CALL printk
0x424ac4  b       #0x424230
0x424ac8  movw    r0, #0
0x424acc  movt    r0, #0
0x424ad0  bl      #0xfffffff8   ; CALL printk
0x424ad4  b       #0x4242e0
0x424ad8  movw    r0, #0
0x424adc  movt    r0, #0
0x424ae0  bl      #0xfffffff8   ; CALL printk
0x424ae4  b       #0x42437c
0x424ae8  movw    r0, #0
0x424aec  movt    r0, #0
0x424af0  bl      #0xfffffff8   ; CALL printk
0x424af4  b       #0x424434
0x424af8  movw    r0, #0
0x424afc  movt    r0, #0
0x424b00  bl      #0xfffffff8   ; CALL printk
0x424b04  b       #0x424568
0x424b08  movw    r0, #0
0x424b0c  movt    r0, #0
0x424b10  bl      #0xfffffff8   ; CALL printk
0x424b14  b       #0x4245e4
0x424b18  movw    r0, #0
0x424b1c  movt    r0, #0
0x424b20  bl      #0xfffffff8   ; CALL printk
0x424b24  b       #0x424660
0x424b28  movw    r0, #0
0x424b2c  movt    r0, #0
0x424b30  bl      #0xfffffff8   ; CALL printk
0x424b34  b       #0x4246dc
0x424b38  movw    r0, #0
0x424b3c  movt    r0, #0
0x424b40  bl      #0xfffffff8   ; CALL printk
0x424b44  b       #0x424764
0x424b48  movw    r0, #0
0x424b4c  movt    r0, #0
0x424b50  bl      #0xfffffff8   ; CALL printk
0x424b54  b       #0x4247e0
0x424b58  movw    r0, #0x65f
0x424b5c  movw    r1, #0
0x424b60  movw    r2, #0
0x424b64  movw    r3, #0
0x424b68  str     r0, [sp]
0x424b6c  movw    r0, #0
0x424b70  movt    r0, #0
0x424b74  movt    r1, #0
0x424b78  movt    r2, #0
0x424b7c  movt    r3, #0
0x424b80  bl      #0xfffffff8   ; CALL printk
0x424b84  movw    r0, #0
0x424b88  movt    r0, #0
0x424b8c  bl      #0xfffffff8   ; CALL panic
