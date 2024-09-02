			.data
txt_inteiro:		.asciz 	"Digite um numero inteiro: "
txt_forma_tri:		.asciz	"Os tres numeros formam um triangulo"
txt_nforma_tri: 	.asciz	"Os tres numeros nao formam um triangulo"

			.text
main:		
	li a7, 4
	la a0, txt_inteiro
	ecall
	li a7, 5
	ecall
	mv t0,a0
	li a7, 4
	la a0, txt_inteiro
	ecall
	li a7, 5
	ecall
	mv t1,a0
	li a7, 4
	la a0, txt_inteiro
	ecall
	li a7, 5
	ecall
	mv t2,a0
	ble t0, t1, b_maior_a
	ble t0, t2, c_maior
	add t3, t1, t2
	blt t3, t0, nao_eh_triangulo
	li a7, 4
	la a0, txt_forma_tri
	ecall
	j fim
b_maior_a:
	ble t1, t2, c_maior
	add t3, t0, t2
	blt t3, t1, nao_eh_triangulo
	li a7, 4
	la a0, txt_forma_tri
	ecall
	j fim
c_maior:
	add t3, t0, t1
	blt t3, t2, nao_eh_triangulo
	li a7, 4
	la a0, txt_forma_tri
	ecall
	j fim
nao_eh_triangulo:
	li a7, 4
	la a0, txt_nforma_tri
	ecall
fim:
	li a7,10
	ecall