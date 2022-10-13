	.data
Maior:	.space
Menor:	.space
I:	.word	3
Cont:	.word	0


	.text
	la	t0, Cont
	lw	s1, 0(t0)
	la	t0, I
	lw 	s2, 0(t0)
	
volta:	beq	s1, s2, fim_laco
	li	a7, 5
	ecall
	beq 	s1, zero, fst
	lw	t1, 0(s3)
	blt	t1, a0, maior
	lw	t2, 0(s4)
	blt	a0, t2	menor
	
maior:	sw	a0, 0(s3)
	addi	s1, s1, 1
	j volta

menor:	sw	a0, 0(s4)
	addi	s1, s1, 1
	j volta
	
fst:	la	s3, Maior
	sw 	a0, 0(s3)
	la	s4, Menor
	sw 	a0, 0(s4)
	addi	s1, s1, 1
	j	volta

fim_laco: