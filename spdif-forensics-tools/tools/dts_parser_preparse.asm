===== libs/libaudioparser.so dts_parser_preparse @ 0xb708 size 0xe0 =====
0000b708  push      {r4, r5, r7, lr}
0000b70a  sub       sp, #8
0000b70c  ldr       r1, [pc, #0xb4]  pool=-0x79ee
0000b70e  ldr       r2, [pc, #0xb8]  pool=-0x96ab
0000b710  mov       r4, r0
0000b712  movs      r0, #4
0000b714  add       r1, pc  ; "dts_parser"
0000b716  add       r2, pc
0000b718  blx       #0xf670
0000b71c  ldr       r1, [pc, #0xac]  pool=0xbf
0000b71e  movw      r0, #0x10d0
0000b722  mov       r2, r4
0000b724  movs      r3, #0
0000b726  add       r1, pc
0000b728  str       r1, [r4, r0]
0000b72a  mov       r0, r4
0000b72c  movs      r1, #0
0000b72e  blx       #0xf7d0
0000b732  mov       r5, r0
0000b734  adds      r0, #4
0000b736  cmp       r0, #4
0000b738  bhi       #0xb7aa
0000b73a  tbb       [pc, r0]
0000b73e  adds      r6, #3
0000b740  movs      r6, #0x18
0000b742  movs      r4, r6
0000b744  ldr       r0, [r4, #0x14]
0000b746  ldr       r3, [r4, #4]
0000b748  ldr       r2, [r4, #0x1c]
0000b74a  str       r0, [sp]
0000b74c  movs      r0, #2
0000b74e  ldr       r1, [pc, #0x88]  pool=-0x8705
0000b750  add       r1, pc  ; "remove offset=%d size = %d flush sync offset=%d"
0000b752  blx       #0xf630
0000b756  ldr       r1, [r4, #0x14]
0000b758  ldr       r0, [r4, #0x38]
0000b75a  blx       #0xf7e0
0000b75e  ldr       r2, [r4, #4]
0000b760  ldr       r1, [r4, #0x1c]
0000b762  ldr       r0, [r4, #0x38]
0000b764  blx       #0xf700
0000b768  mov.w     r5, #-1
0000b76c  b         #0xb7be
0000b76e  ldr       r1, [r4, #0x14]
0000b770  ldr       r0, [r4, #0x38]
0000b772  blx       #0xf7e0
0000b776  ldr       r1, [pc, #0x64]  pool=-0x7a56
0000b778  ldr       r2, [pc, #0x64]  pool=-0x98d3
0000b77a  movs      r0, #4
0000b77c  add       r1, pc  ; "dts_parser"
0000b77e  add       r2, pc
0000b780  blx       #0xf670
0000b784  mvn       r5, #1
0000b788  b         #0xb7be
0000b78a  ldr       r1, [r4, #0x14]
0000b78c  ldr       r0, [r4, #0x38]
0000b78e  blx       #0xf7e0
0000b792  ldr       r1, [pc, #0x3c]  pool=-0x7a72
0000b794  ldr       r2, [pc, #0x3c]  pool=-0x86c8
0000b796  movs      r0, #4
0000b798  add       r1, pc  ; "dts_parser"
0000b79a  add       r2, pc
0000b79c  blx       #0xf670
0000b7a0  mov.w     r5, #-1
0000b7a4  b         #0xb7be
0000b7a6  movs      r0, #9
0000b7a8  str       r0, [r4, #0x3c]
0000b7aa  ldr       r2, [r4, #0x14]
0000b7ac  ldr       r1, [pc, #0x34]  pool=-0x7abc
0000b7ae  movs      r0, #2
0000b7b0  add       r1, pc  ; "Sync header found, offset 0x%x"
0000b7b2  blx       #0xf630
0000b7b6  ldr       r1, [r4, #0x14]
0000b7b8  ldr       r0, [r4, #0x38]
0000b7ba  blx       #0xf7e0
0000b7be  mov       r0, r5
0000b7c0  add       sp, #8
0000b7c2  pop       {r4, r5, r7, pc}
0000b7c4  strh      r2, [r2, #0x30]

