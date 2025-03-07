#	Este programa ilustra a manipulação de bits usando instruções do MIPS.
#	A função dele é contar quantas palavras de um vetor (Vetor) possuem os
#	bits 5-8 simultaneamente iguais a 1, escrevendo o número de tais palavras
#	em uma variável (ct_5_8_em1)
#

        .text   
        .globl	main            
        
main:	li	 $t0,0x01E0		# $t0 armazena a máscara
						# para testar se bits 5-8=1111
					# em binário a máscara é:
					#	0000 0000 0000 0000 0000 0001 1110 0000
					# em hexa a máscara é:
					#0x       0    0    1    0    0    1    E    0     
	la	$t1,Vetor		# $t1 contém ponteiro
						# para próximo elemento do vetor
	la	$t2,tamvet		# $t2 contém número
	lw	$t2,0($t2)			# de elementos ainda não tratados
	add	$t3,$zero,$zero		# $t3 é contador interno de elementos
						# com bits 5-8=1111		
loop:	beq	$t2,$zero,fim		# Testa se fim do tratamento (quando $t2=0)
	lw	$t4,0($t1)		# Lê próximo elemento do Vetor
	and	$t4,$t0,$t4		# Aplica a máscara
	bne	$t4,$t0,nao_achei	# Se não achou 4 bits em 1, salta
	addiu	$t3,$t3,1		# Se achou, incrementa contador e continua
nao_achei:
	addi	$t1,$t1,4		# Aponta para próximo elemento do Vetor
	addi	$t2,$t2,-1		# Decrementa o número elementos a tratar
	j	loop			# Vai mais uma volta do laço

fim:	la	$t5,ct_5_8_em1		# Ao final, escreve na memória o 
	sw	$t3,0($t5)			# valor do contador, que está em $t3
	
	li	$v0,10
	syscall				# E termina o programa
		
		.data
Vetor:			.word	1 35 899 2024 32767 0xccfffeaa -325
tamvet:			.word	7
ct_5_8_em1:		.word	0
       


