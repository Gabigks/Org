			.data
vet:			.word	-1, 30, 2, 10, -8, 24
txt_menu:		.asciz 	"Escolha alguma opcao:\n\n1: Imprimir vetor.\n2: Mostrar menor valor e sua posicao\n3: Mostrar maior valor e sua posicao\n4: Fazer o swap entre dois valores.\n5: Ordenar vetor.\n\nOpcao: "
txt_menor:		.asciz 	"\nMenor valor: "
txt_maior:		.asciz 	"\nMaior valor: "
txt_indice:		.asciz	"\nDe indice: "
txt_space:		.asciz	", "
txt_teste:		.asciz	"eh os guri"
invalid_opt:		.asciz  "tamo junto fio"
vector_text:		.asciz  "\nVetor: "
nova_linha:		.asciz  "\n\n"
swap_1_text:		.asciz  "\nPrimeiro indice para fazer o swap: "
swap_2_text:		.asciz  "Segundo indice para fazer o swap: "
			.text
main:
		li a7, 4
		la a0, txt_menu
		ecall
		li a7, 5
		ecall
		mv s1, a0
		la a0, vet 		# a0 <- vector address
		li a1, 6		# a1 <- vector length
		li s2, 1
		beq s1, s2, prep_print
		li s2, 2
		beq s1, s2, prep_min
		li s2, 3
		beq s1, s2, prep_max
		li s2, 4
		beq s1, s2, prep_swap
		li s2, 5
		beq s1, s2, prep_sort
		li s2, 0
		beq s1, s2, fim
		li a7, 4
		la a0, invalid_opt
		ecall
		j main
		
prep_print:
		call print
		j main

prep_min:		
		call min
			
		li a7, 4
		la a0, txt_menor
		ecall
		li a7, 1
		mv a0, t4
		ecall
			
		li a7, 4
		la a0, txt_indice
		ecall
		li a7, 1
		mv a0, t5
		ecall
			
		li a7, 4
		la a0, nova_linha
		ecall
			
		j main

prep_max:
		call max
		j main
		
prep_swap:
		mv s1, a0
			
		li a7, 4
		la a0, swap_1_text
		ecall
		li a7, 5
		ecall
		mv a2, a0
			
		li a7, 4
		la a0, swap_2_text
		ecall
		li a7, 5
		ecall
		mv a3, a0
			
		mv a0, s1

		call swap
		j main
		
prep_sort:
		call sort
		call print
		j main

print:
		mv s1, a0
		li s2, 0
			
		li a7, 4
		la a0, vector_text
		ecall
			
loop_print:
		beq s2, a1, endloop_print
		add s3, s2, s2
		add s3, s3, s3
		add s3, s1, s3
		lw a0, 0(s3)
		li a7, 1
		ecall
			
		li a7, 4
		la a0, txt_space
		ecall
			
		addi s2, s2, 1
		j loop_print
endloop_print:
		li a7, 4
		la a0, nova_linha
		ecall
		
		ret
	
min:
		mv t1, a0
		li t2, 0
			
		lw t4, 0(t1)		# s4 <- min value
		li t5, 0		# s5 <- min index
			
loop_min:
		beq t2, a1, endloop_min
		add t3, t2, t2
		add t3, t3, t3
		add t3, t1, t3
			
		lw t6, 0(t3)
			
		bge t6, t4, end_if_min
		mv t4, t6
		mv t5, t2
end_if_min:
		addi t2, t2, 1
		j loop_min
endloop_min:
		ret

max:
		mv s1, a0
		li s2, 0
			
		lw s4, 0(s1)		# s4 <- max value
		li s5, 0		# s5 <- max index
			
loop_max:
		beq s2, a1, endloop_max
		add s3, s2, s2
		add s3, s3, s3
		add s3, s1, s3
			
		lw s6, 0(s3)
			
		ble s6, s4, end_if_max
		mv s4, s6
		mv s5, s2
end_if_max:
		addi s2, s2, 1
		j loop_max
endloop_max:
		li a7, 4
		la a0, txt_maior
		ecall
		li a7, 1
		mv a0, s4
		ecall
			
		li a7, 4
		la a0, txt_indice
		ecall
		li a7, 1
		mv a0, s5
		ecall
			
		li a7, 4
		la a0, nova_linha
		ecall
			
		ret
		
swap:		
		mv s8, a0
		mv s9, a2
		mv s10, a3
			
		add a2, a2, a2
		add a2, a2, a2
		add a2, s1, a2
		
		add a3, a3, a3
		add a3, a3, a3
		add a3, s1, a3
		
		lw t1, 0(a2)
		lw t2, 0(a3)
		
		sw t1, 0(a3)
		sw t2, 0(a2)
			
		mv a0, s8
		mv a2, s9
		mv a3, s10
			
		ret		
sort:		
		mv s1, a0
		mv s2, a1
		li s3, 0
		mv s11, ra
		
loop_sort:
		beq s3, s2, endloop_sort
		add a0, s3, s3
		add a0, a0, a0
		
		add a0, s1, a0		# a0 <- start min vector
		sub a1, s2, s3		# a1 <- min vector length
		
		li t6, 1
		beq a1, t6, endloop_sort
		
		call min
		
		mv a2, zero
		mv a3, t5
		
		call swap
		
		addi s3, s3, 1
		j loop_sort
endloop_sort:
		mv a0, s1
		mv a1, s2
		mv ra, s11
		ret
		
fim:
		li a7, 10
		ecall
