    .data

vetor_a:   .word 1, 2, 3, 4, 5
vetor_b:   .word 3, 5, 2, 1, 7
vetor_c:   .space 20
txt_space:  .asciz ", "

    .text
main:
	la a0, vetor_a  # Carrega o endereço do vetor_a
	la a1, vetor_b  # Carrega o endereço do vetor_b
	la a2, vetor_c  # Carrega o endereço do vetor_c
	li a3, 5        # Define o tamanho do vetor
	
	call verifica_posicao_elementos
	
	mv a0, a2
	call print
	
	j fim

verifica_posicao_elementos:
	mv s0, a0
	mv s3, a2
	li t0, 0        # Inicializa o índice t0 com 0
	mv s2, ra
	
laco_vet_a:
	beq t0, a3, fim_laco_vet_a  # Verifica se terminou o laço
	add t1, t0, t0
	add t1, t1, t1
	add t2, s0, t1
	add t4, s3, t1
	
	lw s10, 0(t2)
	
	call find_index
	sw s11, 0(t4)
	addi t0, t0, 1
	j laco_vet_a

fim_laco_vet_a:
	mv a0, s0
	mv ra, s2
	ret
find_index:
	mv s1, a1
	li t2, 0
laco_vet_b:
	beq t2, a3, fim_laco_vet_b
	add t3, t2, t2
	add t3, t3, t3
	add t3, s1, t3
	
	lw s9, 0(t3)
	
	beq s9, s10, is_equal
	addi t2, t2, 1
	j laco_vet_b
	
fim_laco_vet_b:
	li s11, -1
	ret
is_equal:
	mv s11, t2
	ret
	
print:
	mv s0, a0
	li s1, 0
print_loop:
	beq s1, a3, end_print
	add t1, s1, s1
	add t1, t1, t1
	add t1, s0, t1
		
	lw a0, 0(t1)
	li a7, 1
	ecall
	
	li a7, 4
	la a0, txt_space
	ecall
		
	addi s1, s1, 1
	j print_loop
end_print:
	mv a0, s0
	ret

fim:		
	li a7, 10
	ecall
	
	
	
	