===== libs/libaudioparser.so Parser_Do_Parse @ 0x6cc4 size 0x3e4 =====
00006cc4  push.w    {r4, r5, r6, r7, r8, sb, lr}
00006cc8  sub       sp, #0x14
00006cca  ldr       r1, [pc, #0x34c]  pool=-0x4bd1
00006ccc  mov       r7, r2
00006cce  ldr       r2, [pc, #0x34c]  pool=-0x3367
00006cd0  mov       r5, r0
00006cd2  movs      r0, #2
00006cd4  mov       r8, r3
00006cd6  add       r1, pc
00006cd8  add       r2, pc  ; "Parser_Do_Parse"
00006cda  blx       #0xf630
00006cde  ldr       r4, [sp, #0x30]
00006ce0  movs      r0, #0
00006ce2  str       r0, [r7]
00006ce4  cmp       r4, #0
00006ce6  beq       #0x6da6
00006ce8  cmp       r5, #0
00006cea  beq       #0x6db0
00006cec  ldr       r6, [r5, #8]
00006cee  cmp       r6, #0
00006cf0  beq       #0x6dba
00006cf2  movw      r0, #0x10d0
00006cf6  ldr       r0, [r6, r0]
00006cf8  cbnz      r0, #0x6d04
00006cfa  ldr.w     r0, [r6, #0x8c]
00006cfe  cmp       r0, #0
00006d00  beq.w     #0x6e30
00006d04  ldr       r0, [r5, #0x10]
00006d06  cmp       r0, #0
00006d08  beq       #0x6dce
00006d0a  vmov.i32  q8, #0
00006d0e  movs      r1, #0x34
00006d10  mov       r2, r6
00006d12  movs      r0, #0
00006d14  mov       r3, r8
00006d16  vst1.8    {d16, d17}, [r2], r1
00006d1a  str       r0, [r6, #0x30]
00006d1c  movs      r1, #0
00006d1e  str       r0, [r2]
00006d20  add.w     r0, r6, #0x20
00006d24  mov       r2, r7
00006d26  vst1.8    {d16, d17}, [r0]
00006d2a  add.w     r0, r6, #0x10
00006d2e  vst1.8    {d16, d17}, [r0]
00006d32  ldr       r0, [r5, #8]
00006d34  ldr       r5, [r5, #0x10]
00006d36  blx       r5
00006d38  adds      r1, r0, #4
00006d3a  beq.w     #0x6e4c
00006d3e  adds      r1, r0, #1
00006d40  beq.w     #0x6eae
00006d44  cmp       r0, #0
00006d46  bne       #0x6dce
00006d48  ldr       r0, [r6, #4]
00006d4a  str       r0, [r7]
00006d4c  ldr.w     sb, [r6, #0x14]
00006d50  ldr       r5, [r6, #0x38]
00006d52  cmp.w     sb, #1
00006d56  blt       #0x6d64
00006d58  ldr       r1, [pc, #0x2dc]  pool=-0x4797
00006d5a  movs      r0, #2
00006d5c  mov       r2, sb
00006d5e  add       r1, pc
00006d60  blx       #0xf630
00006d64  cmp       r5, #0
00006d66  beq.w     #0x6efe
00006d6a  ldr       r3, [r5, #0x14]
00006d6c  cmp       r3, sb
00006d6e  bhs       #0x6d86
00006d70  str.w     sb, [sp]
00006d74  movs      r0, #6
00006d76  ldr       r1, [pc, #0x2cc]  pool=-0x293d
00006d78  ldr       r2, [pc, #0x2cc]  pool=-0x4fd0
00006d7a  add       r1, pc
00006d7c  add       r2, pc  ; "level (0x%x)smaller than request size(0x%x)"
00006d7e  blx       #0xf670
00006d82  ldr       r3, [r5, #0x14]
00006d84  mov       sb, r3
00006d86  ldr       r0, [r5, #8]
00006d88  ldr       r1, [r5, #0x10]
00006d8a  add       r0, sb
00006d8c  cmp       r0, r1
00006d8e  blo       #0x6d96
00006d90  subs      r0, r0, r1
00006d92  ldr       r1, [r5, #0xc]
00006d94  add       r0, r1
00006d96  str       r0, [r5, #8]
00006d98  sub.w     r0, r3, sb
00006d9c  str       r0, [r5, #0x14]
00006d9e  ldr       r0, [r5, #0x18]
00006da0  add       r0, sb
00006da2  str       r0, [r5, #0x18]
00006da4  b         #0x6f0c
00006da6  ldr       r1, [pc, #0x278]  pool=-0x296d
00006da8  ldr       r2, [pc, #0x278]  pool=-0x460a
00006daa  add       r1, pc
00006dac  add       r2, pc  ; "info is NULL"
00006dae  b         #0x6dc2
00006db0  ldr       r1, [pc, #0x274]  pool=-0x2977
00006db2  ldr       r2, [pc, #0x278]  pool=-0x2f65
00006db4  add       r1, pc  ; "audio_parser"
00006db6  add       r2, pc
00006db8  b         #0x6dc2
00006dba  ldr       r1, [pc, #0x274]  pool=-0x2981
00006dbc  ldr       r2, [pc, #0x274]  pool=-0x4ca2
00006dbe  add       r1, pc
00006dc0  add       r2, pc  ; "parser is NULL"
00006dc2  movs      r0, #6
00006dc4  blx       #0xf670
00006dc8  mvn       r7, #2
00006dcc  b         #0x6fe2
00006dce  ldr       r5, [r6, #0x14]
00006dd0  ldr       r7, [r6, #0x38]
00006dd2  cmp       r5, #1
00006dd4  blt       #0x6de2
00006dd6  ldr       r1, [pc, #0x2bc]  pool=-0x4815
00006dd8  movs      r0, #2
00006dda  mov       r2, r5
00006ddc  add       r1, pc  ; "Flush size: 0x%x @@"
00006dde  blx       #0xf630
00006de2  cbz       r7, #0x6e1c
00006de4  ldr       r3, [r7, #0x14]
00006de6  cmp       r3, r5
00006de8  bhs       #0x6dfe
00006dea  str       r5, [sp]
00006dec  movs      r0, #6
00006dee  ldr       r1, [pc, #0x2b0]  pool=-0x29b5
00006df0  ldr       r2, [pc, #0x2b0]  pool=-0x5048
00006df2  add       r1, pc
00006df4  add       r2, pc  ; "level (0x%x)smaller than request size(0x%x)"
00006df6  blx       #0xf670
00006dfa  ldr       r3, [r7, #0x14]
00006dfc  mov       r5, r3
00006dfe  ldr       r0, [r7, #8]
00006e00  ldr       r1, [r7, #0x10]
00006e02  add       r0, r5
00006e04  cmp       r0, r1
00006e06  blo       #0x6e0e
00006e08  subs      r0, r0, r1
00006e0a  ldr       r1, [r7, #0xc]
00006e0c  add       r0, r1
00006e0e  str       r0, [r7, #8]
00006e10  subs      r0, r3, r5
00006e12  str       r0, [r7, #0x14]
00006e14  ldr       r0, [r7, #0x18]
00006e16  add       r0, r5
00006e18  str       r0, [r7, #0x18]
00006e1a  b         #0x6e2a
00006e1c  ldr       r1, [pc, #0x278]  pool=-0x29e5
00006e1e  ldr       r2, [pc, #0x27c]  pool=-0x29da
00006e20  movs      r0, #6
00006e22  add       r1, pc
00006e24  add       r2, pc  ; "ringbuffer is NULL"
00006e26  blx       #0xf670
00006e2a  mvn       r7, #1
00006e2e  b         #0x6f80
00006e30  ldr       r0, [r6, #0x38]
00006e32  mov       r1, r4
00006e34  mov       r2, r8
00006e36  ldr       r0, [r0, #0x14]
00006e38  str       r0, [r7]
00006e3a  movs      r7, #0
00006e3c  mov       r0, r6
00006e3e  strd      r7, r7, [sp]
00006e42  strd      r7, r7, [sp, #8]
00006e46  blx       #0xf6e0
00006e4a  b         #0x6fe2
00006e4c  ldr       r0, [r6, #0x14]
00006e4e  ldr       r3, [r6, #4]
00006e50  ldr       r2, [r6, #0x1c]
00006e52  str       r0, [sp]
00006e54  movs      r0, #2
00006e56  ldr       r1, [pc, #0x224]  pool=-0x4a22
00006e58  add       r1, pc  ; "remove offset=0x%x size = 0x%x flush sync offset=0x%x"
00006e5a  blx       #0xf630
00006e5e  ldr       r5, [r6, #0x14]
00006e60  ldr       r7, [r6, #0x38]
00006e62  cmp       r5, #1
00006e64  blt       #0x6e72
00006e66  ldr       r1, [pc, #0x218]  pool=-0x48a5
00006e68  movs      r0, #2
00006e6a  mov       r2, r5
00006e6c  add       r1, pc  ; "Flush size: 0x%x @@"
00006e6e  blx       #0xf630
00006e72  cmp       r7, #0
00006e74  beq       #0x6f54
00006e76  ldr       r3, [r7, #0x14]
00006e78  cmp       r3, r5
00006e7a  bhs       #0x6e90
00006e7c  str       r5, [sp]
00006e7e  movs      r0, #6
00006e80  ldr       r1, [pc, #0x208]  pool=-0x2a47
00006e82  ldr       r2, [pc, #0x20c]  pool=-0x50da
00006e84  add       r1, pc  ; "audio_parser"
00006e86  add       r2, pc
00006e88  blx       #0xf670
00006e8c  ldr       r3, [r7, #0x14]
00006e8e  mov       r5, r3
00006e90  ldr       r0, [r7, #8]
00006e92  ldr       r1, [r7, #0x10]
00006e94  add       r0, r5
00006e96  cmp       r0, r1
00006e98  blo       #0x6ea0
00006e9a  subs      r0, r0, r1
00006e9c  ldr       r1, [r7, #0xc]
00006e9e  add       r0, r1
00006ea0  str       r0, [r7, #8]
00006ea2  subs      r0, r3, r5
00006ea4  str       r0, [r7, #0x14]
00006ea6  ldr       r0, [r7, #0x18]
00006ea8  add       r0, r5
00006eaa  str       r0, [r7, #0x18]
00006eac  b         #0x6f62
00006eae  ldr       r5, [r6, #0x14]
00006eb0  ldr       r7, [r6, #0x38]
00006eb2  cmp       r5, #1
00006eb4  blt       #0x6ec2
00006eb6  ldr       r1, [pc, #0x1b0]  pool=-0x48f5
00006eb8  movs      r0, #2
00006eba  mov       r2, r5
00006ebc  add       r1, pc  ; "Flush size: 0x%x @@"
00006ebe  blx       #0xf630
00006ec2  cmp       r7, #0
00006ec4  beq       #0x6f6e
00006ec6  ldr       r3, [r7, #0x14]
00006ec8  cmp       r3, r5
00006eca  bhs       #0x6ee0
00006ecc  str       r5, [sp]
00006ece  movs      r0, #6
00006ed0  ldr       r1, [pc, #0x1a0]  pool=-0x2a97
00006ed2  ldr       r2, [pc, #0x1a4]  pool=-0x512a
00006ed4  add       r1, pc  ; "audio_parser"
00006ed6  add       r2, pc
00006ed8  blx       #0xf670
00006edc  ldr       r3, [r7, #0x14]
00006ede  mov       r5, r3
00006ee0  ldr       r0, [r7, #8]
00006ee2  ldr       r1, [r7, #0x10]
00006ee4  add       r0, r5
00006ee6  cmp       r0, r1
00006ee8  blo       #0x6ef0
00006eea  subs      r0, r0, r1
00006eec  ldr       r1, [r7, #0xc]
00006eee  add       r0, r1
00006ef0  str       r0, [r7, #8]
00006ef2  subs      r0, r3, r5
00006ef4  str       r0, [r7, #0x14]
00006ef6  ldr       r0, [r7, #0x18]
00006ef8  add       r0, r5
00006efa  str       r0, [r7, #0x18]
00006efc  b         #0x6f7c
00006efe  ldr       r1, [pc, #0x13c]  pool=-0x2ac7
00006f00  ldr       r2, [pc, #0x13c]  pool=-0x2abc
00006f02  movs      r0, #6
00006f04  add       r1, pc  ; "audio_parser"
00006f06  add       r2, pc
00006f08  blx       #0xf670
00006f0c  ldr       r2, [r6, #0x14]
00006f0e  cbz       r2, #0x6f1a
00006f10  ldr       r1, [pc, #0x138]  pool=-0x4368
00006f12  movs      r0, #2
00006f14  add       r1, pc  ; "Flush size: offset %d bytes @@ "
00006f16  blx       #0xf630
00006f1a  ldr       r1, [r6, #0x38]
00006f1c  ldr       r0, [r7]
00006f1e  ldr       r3, [r1, #0x14]
00006f20  cmp       r0, r3
00006f22  bls       #0x6f50
00006f24  str       r0, [sp]
00006f26  movs      r0, #5
00006f28  ldr       r1, [pc, #0x124]  pool=-0x2aef
00006f2a  ldr       r2, [pc, #0x128]  pool=-0x3c24
00006f2c  add       r1, pc  ; "audio_parser"
00006f2e  add       r2, pc
00006f30  blx       #0xf670
00006f34  ldr.w     r0, [r6, #0x88]
00006f38  ldr       r1, [pc, #0x11c]  pool=-0x425a
00006f3a  add       r1, pc
00006f3c  blx       #0xf6f0
00006f40  cbz       r0, #0x6f4a
00006f42  ldr.w     r0, [r6, #0x94]
00006f46  cmp       r0, #0
00006f48  beq       #0x6fea
00006f4a  ldr       r0, [r6, #0x38]
00006f4c  ldr       r0, [r0, #0x14]
00006f4e  str       r0, [r7]
00006f50  movs      r7, #0
00006f52  b         #0x6f80
00006f54  ldr       r1, [pc, #0x12c]  pool=-0x2b1d
00006f56  ldr       r2, [pc, #0x130]  pool=-0x2b12
00006f58  movs      r0, #6
00006f5a  add       r1, pc
00006f5c  add       r2, pc  ; "ringbuffer is NULL"
00006f5e  blx       #0xf670
00006f62  ldr       r2, [r6, #4]
00006f64  ldr       r1, [r6, #0x1c]
00006f66  ldr       r0, [r6, #0x38]
00006f68  blx       #0xf700
00006f6c  b         #0x6f7c
00006f6e  ldr       r1, [pc, #0xfc]  pool=-0x2b37
00006f70  ldr       r2, [pc, #0xfc]  pool=-0x2b2c
00006f72  movs      r0, #6
00006f74  add       r1, pc  ; "audio_parser"
00006f76  add       r2, pc
00006f78  blx       #0xf670
00006f7c  mov.w     r7, #-1
00006f80  ldrd      r0, r1, [r6, #0x58]
00006f84  and.w     r2, r0, r1
00006f88  adds      r2, #1
00006f8a  beq       #0x6f90
00006f8c  strd      r0, r1, [r6, #0x68]
00006f90  cbnz      r7, #0x6fb0
00006f92  ldr.w     r0, [r6, #0x9c]
00006f96  cbz       r0, #0x6fa2
00006f98  ldrd      r0, r1, [r6, #0x60]
00006f9c  strd      r0, r1, [r8]
00006fa0  b         #0x6fb0
00006fa2  ldrd      r0, r1, [r8]
00006fa6  movs      r2, #1
00006fa8  str.w     r2, [r6, #0x9c]
00006fac  strd      r0, r1, [r6, #0x60]
00006fb0  movs      r1, #0x30
00006fb2  add.w     r0, r6, #0x20
00006fb6  add.w     r2, r6, #0x10
00006fba  vld1.8    {d16, d17}, [r6], r1
00006fbe  vld1.8    {d18, d19}, [r0]
00006fc2  vld1.8    {d20, d21}, [r2]
00006fc6  add.w     r0, r4, #0x20
00006fca  vld1.8    {d22}, [r6]
00006fce  vst1.8    {d18, d19}, [r0]
00006fd2  add.w     r0, r4, #0x10
00006fd6  vst1.8    {d16, d17}, [r4], r1
00006fda  vst1.8    {d20, d21}, [r0]
00006fde  vst1.8    {d22}, [r4]
00006fe2  mov       r0, r7
00006fe4  add       sp, #0x14
00006fe6  pop.w     {r4, r5, r6, r7, r8, sb, pc}
00006fea  ldr.w     r0, [r6, #0x90]
00006fee  cbz       r0, #0x700c
00006ff0  ldr       r1, [pc, #0x68]  pool=-0x2bb9
00006ff2  ldr       r2, [pc, #0x6c]  pool=-0x2b9b
00006ff4  movs      r0, #6
00006ff6  add       r1, pc
00006ff8  add       r2, pc  ; "revieve eos"
00006ffa  blx       #0xf670
00006ffe  ldr       r1, [r6, #0x38]
00007000  ldr       r0, [r6, #4]
00007002  ldr       r1, [r1, #0x14]
00007004  cmp       r1, r0
00007006  it        lo
00007008  movlo     r0, r1
0000700a  b         #0x6f4e
0000700c  ldr       r1, [pc, #0x54]  pool=-0x3467
0000700e  movs      r0, #2
00007010  add       r1, pc  ; "WARNING !!!, found header, but data not enough"
00007012  blx       #0xf630
00007016  b         #0x6f7c
00007018  push      {r0, r1, r2, r3, r5}

