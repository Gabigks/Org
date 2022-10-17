	.data
Print1:	.string "O maior valor é: "
Print2:	.string "O menor valor é: "
Print3:	.string "A media dos 3 valores é: "
I:	.word	3
Cont:	.word	0


	.text
	la	t0, Cont
	lw	s1, 0(t0)
	la	t0, I
	lw 	s2, 0(t0)
	
volta:	beq	s1, s2, f_laco
	li	a7, 5
	ecall
	add	s5, s5, a0
	beq 	s1, zero, fst
	blt	s3, a0, maior
	blt	a0, s4	menor
	
maior:	mv	s3, a0
	addi	s1, s1, 1
	j volta

menor:	mv	s4, a0
	addi	s1, s1, 1
	j volta
	
fst:	mv	s3, a0
	mv	s4, a0
	addi	s1, s1, 1
	j	volta

f_laco:	li	a7, 4
	la	a0, Print1
	ecall
	li	a7, 1
	mv	a0, s3
	ecall
	
	li	a7, 4
	la	a0, Print2
	ecall
	li	a7, 1
	mv	a0, s4
	ecall
	
	div	s5, s5, s2
	
	li	a7, 4
	la	a0, Print3
	ecall
	li	a7, 1
	mv	a0, s5
	ecall
