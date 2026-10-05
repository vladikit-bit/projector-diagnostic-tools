===== kmods/utpa2k.ko ulogtag_proc_write sec_off=0x15b78 size=0x2c0 mode=A =====
00015b78  push      {r4, r5, r6, r7, r8, sb, sl, fp, lr}
00015b7c  sub       sp, sp, #0x4c
00015b80  movw      r7, #0  rel→__stack_chk_guard
00015b84  mov       sb, r2
00015b88  movt      r7, #0  rel→__stack_chk_guard
00015b8c  mov       r5, r1
00015b90  ldr       r0, [r7]
00015b94  mov       r1, #0
00015b98  str       r0, [sp, #0x48]
00015b9c  mov       r0, #0
00015ba0  str       r0, [sp, #4]
00015ba4  add       r0, sp, #8
00015ba8  mov       r2, #0x40
00015bac  bl        #0x15bac  rel→memset; CALL memset
00015bb0  cmp       sb, #0x40
00015bb4  bhi       #0x15e08
00015bb8  add       r6, sp, #8
00015bbc  mov       r1, sb
00015bc0  mov       r2, #0
00015bc4  mov       r0, r6
00015bc8  bl        #0x15bc8  rel→__check_object_size; CALL __check_object_size
00015bcc  bl        #0x15bcc  rel→current_thread_info; CALL current_thread_info
00015bd0  ldr       r1, [r0, #8]
00015bd4  adds      r2, r5, sb
00015bd8  sbcslo    r2, r2, r1
00015bdc  movlo     r1, #0
00015be0  cmp       r1, #0
00015be4  mov       r2, sb
00015be8  bne       #0x15c24
00015bec  add       r0, r0, #0x14
00015bf0  mrc       p15, #0, r4, c3, c0, #0
00015bf4  mov       r1, r4
00015bf8  mov       r0, #1
00015bfc  mov       r2, sb
00015c00  bfi       r1, r0, #2, #2
00015c04  add       r0, sp, #8
00015c08  mcr       p15, #0, r1, c3, c0, #0
00015c0c  mov       r1, r5
00015c10  isb       sy
00015c14  bl        #0x15c14  rel→arm_copy_from_user; CALL arm_copy_from_user
00015c18  mov       r2, r0
00015c1c  mcr       p15, #0, r4, c3, c0, #0
00015c20  isb       sy
00015c24  cmp       r2, #0
00015c28  bne       #0x15e24
00015c2c  movw      r1, #0  rel→.L.str.21
00015c30  add       r0, sp, #8
00015c34  movt      r1, #0  rel→.L.str.21
00015c38  mov       r2, #7
00015c3c  bl        #0x15c3c  rel→bcmp; CALL bcmp
00015c40  cmp       r0, #0
00015c44  beq       #0x15dec
00015c48  add       r5, sp, #8
00015c4c  movw      r1, #0  rel→.L.str.22
00015c50  movt      r1, #0  rel→.L.str.22
00015c54  mov       r2, #6
00015c58  mov       r0, r5
00015c5c  bl        #0x15c5c  rel→bcmp; CALL bcmp
00015c60  cmp       r0, #0
00015c64  beq       #0x15df8
00015c68  movw      r1, #0  rel→bIsULogTagEnable
00015c6c  mov       r2, #0
00015c70  movt      r1, #0  rel→bIsULogTagEnable
00015c74  ldrb      r0, [r1]
00015c78  cmp       r0, #1
00015c7c  bne       #0x15c94
00015c80  mov       r0, #0
00015c84  strb      r0, [r1]
00015c88  mov       r0, #0x3e8
00015c8c  bl        #0x15c8c  rel→MsOS_DelayTask; CALL MsOS_DelayTask
00015c90  mov       r2, #1
00015c94  movw      r6, #0  rel→utagHead
00015c98  str       r2, [sp]
00015c9c  movt      r6, #0  rel→utagHead
00015ca0  ldr       r4, [r6]
00015ca4  cmp       r4, r6
00015ca8  beq       #0x15ce4
00015cac  mov       r0, r4
00015cb0  ldr       r7, [r4]
00015cb4  bl        #0x15cb4  rel→__list_del_entry_valid; CALL __list_del_entry_valid
00015cb8  cmp       r0, #0
00015cbc  ldmne     r4, {r0, r1}
00015cc0  strne     r1, [r0, #4]
00015cc4  strne     r0, [r1]
00015cc8  mov       r0, r4
00015ccc  str       r4, [r4, #4]
00015cd0  str       r4, [r4]
00015cd4  bl        #0x15cd4  rel→kfree; CALL kfree
00015cd8  cmp       r7, r6
00015cdc  mov       r4, r7
00015ce0  bne       #0x15cac
00015ce4  movw      r1, #0  rel→.L.str.20
00015ce8  add       r0, sp, #4
00015cec  movt      r1, #0  rel→.L.str.20
00015cf0  str       r6, [r6, #4]
00015cf4  str       r6, [r6]
00015cf8  str       r5, [sp, #4]
00015cfc  bl        #0x15cfc  rel→strsep; CALL strsep
00015d00  cmp       r0, #0
00015d04  beq       #0x15dc8
00015d08  movw      fp, #0  rel→.L.str.20
00015d0c  add       sl, sp, #4
00015d10  mov       r7, r0
00015d14  movt      fp, #0  rel→.L.str.20
00015d18  mov       r8, #0
00015d1c  b         #0x15d38
00015d20  mov       r0, sl
00015d24  mov       r1, fp
00015d28  bl        #0x15d28  rel→strsep; CALL strsep
00015d2c  mov       r7, r0
00015d30  cmp       r0, #0
00015d34  beq       #0x15dc8
00015d38  ldrb      r0, [r7]
00015d3c  cmp       r0, #0
00015d40  beq       #0x15d20
00015d44  movw      r0, #0  rel→kmalloc_caches
00015d48  movw      r1, #0xc0
00015d4c  movt      r0, #0  rel→kmalloc_caches
00015d50  movt      r1, #0x60
00015d54  ldr       r0, [r0, #0x18]
00015d58  mov       r2, #0x18
00015d5c  bl        #0x15d5c  rel→kmem_cache_alloc_trace; CALL kmem_cache_alloc_trace
00015d60  cmp       r0, #0
00015d64  beq       #0x15d20
00015d68  mov       r5, r0
00015d6c  mov       r4, r0
00015d70  str       r8, [r0, #0xc]
00015d74  str       r8, [r0, #0x10]
00015d78  str       r8, [r0, #0x14]
00015d7c  mov       r0, r7
00015d80  str       r8, [r5, #8]!
00015d84  bl        #0x15d84  rel→strlen; CALL strlen
00015d88  mov       r2, r0
00015d8c  cmp       r0, #0xf
00015d90  movhs     r2, #0xf
00015d94  mov       r0, r5
00015d98  mov       r1, r7
00015d9c  bl        #0x15d9c  rel→memcpy; CALL memcpy
00015da0  ldr       r7, [r6, #4]
00015da4  mov       r0, r4
00015da8  mov       r2, r6
00015dac  mov       r1, r7
00015db0  bl        #0x15db0  rel→__list_add_valid; CALL __list_add_valid
00015db4  cmp       r0, #0
00015db8  strdne    r6, r7, [r4]
00015dbc  strne     r4, [r6, #4]
00015dc0  strne     r4, [r7]
00015dc4  b         #0x15d20
00015dc8  ldr       r0, [sp]
00015dcc  movw      r7, #0  rel→__stack_chk_guard
00015dd0  movt      r7, #0  rel→__stack_chk_guard
00015dd4  cmp       r0, #0
00015dd8  movwne    r1, #0  rel→bIsULogTagEnable
00015ddc  movne     r0, #1
00015de0  movtne    r1, #0  rel→bIsULogTagEnable
00015de4  strbne    r0, [r1]
00015de8  b         #0x15e08
00015dec  movw      r0, #0  rel→bIsULogTagEnable
00015df0  mov       r1, #0
00015df4  b         #0x15e00
00015df8  movw      r0, #0  rel→bIsULogTagEnable
00015dfc  mov       r1, #1
00015e00  movt      r0, #0  rel→bIsULogTagEnable
00015e04  strb      r1, [r0]
00015e08  ldr       r0, [r7]
00015e0c  ldr       r1, [sp, #0x48]
00015e10  subs      r0, r0, r1
00015e14  moveq     r0, sb
00015e18  addeq     sp, sp, #0x4c
00015e1c  popeq     {r4, r5, r6, r7, r8, sb, sl, fp, pc}
00015e20  bl        #0x15e20  rel→__stack_chk_fail; CALL __stack_chk_fail
00015e24  sub       r0, sb, r2
00015e28  mov       r1, #0
00015e2c  add       r0, r6, r0
00015e30  bl        #0x15e30  rel→memset; CALL memset
00015e34  b         #0x15e08
