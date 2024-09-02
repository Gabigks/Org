    .data

vetor_a:	.word 1, -2, -8, 10, 1
n:		.word 3
txt:		.asciz "A quantidade de numeros menores eh: "
txt2:		.asciz "\nIndice do elemento com maior diferenca: "

    .text
main:
	la a0, vetor_a  
	li a1, 5
	la t0, n
	lw a2, 0(t0)
	li s11, 0
	
	call qtd_comparacao
	
	li a7, 4
	la a0, txt
	ecall
	
	li a7, 1
	mv a0, s11
	ecall
	
	li a7, 4
	la a0, txt2
	ecall
	
	mv a1, t5
	addi a1, a1, -1
	li a7, 1
	mv a0, a1
	ecall
	
	j fim
	
qtd_comparacao:
	mv s0, a0
	li s1, 0
	mv s2, ra
	lw s10, 0(a0)
	
laco_compara:
	beq s1, a1, fim_laco_compara
	add t1, s1, s1
	add t1, t1, t1
	add t1, s0, t1
	
	lw t6, 0(t1)
	
	addi s1, s1, 1
	
	blt t6, a2, eh_menor
	j laco_compara
eh_menor:
	addi s11, s11, 1
	call maior_dif
	j laco_compara
	
fim_laco_compara:
	mv ra, s2
	ret

maior_dif:
	blt t6, s10, sim
	ret
sim:
	mv s10, t6
	mv t5, s1
	ret
fim:		
	li a7, 10
	ecall
