;;; Segment code (00000000)

;; fn00000000: 00000000
fn00000000 proc
	bn.lbz?	r23,-0x11(r14)
	bn.lhz	r28,-0x6E(r5)
	bg.lwz	r25,0xA4(r1)
	bt.addi?	r24,0x8
	bg.addi	r23,r10,0x250C
	bn.sw	(r12),r24
	bn.sw	(r25),r23
	bg.addi	r25,r0,-0x78E
	bg.sh	0x250C(r10),r25
	bg.lwz	r24,0xA0(r10)
	bg.addi	r25,r0,0x4E1F
	bg.sh	0x250E(r10),r25
	bg.beqi?	r24,0x0,00000162

l0000002E:
	bg.lwz	r24,-0x7A70(r11)
	bg.ori	r25,r0,0x6000
	bn.sw	(r12),r25
	bn.ori	r25,r0,0x15
	bg.sh	0x2510(r10),r25
