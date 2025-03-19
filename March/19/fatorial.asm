# fatorial (recursivo)
#
# Programa que calcula o fatorial de um número inteiro sem sinal.
#	* Chama a função fact, que faz todo o trabalho.
#	* fact é uma função recursiva. Ela retorna o resultado de
#	seu processamento no registrador de valor, $v0.
#	* A pilha, apontada pelo registrador $sp, é usada para
#	armazenar os endereços de retorno e para armazenar o parâmetro
#	da chamada.
#
# main()
# {
#		int num=10;
#		int result=0;
#		result = fact(num);
# }
#
# int fact (int n)
# {
#		if(n<=1)
#		return 1;
#		return (n * fact (n - 1));
# }
#
	.data
num:	.word 	12		# Número cujo fatorial se quer calcular
result:	.word 	0		# variável para guardar o fact(num)

	.text
	.globl	main

main:	la	$t0,num
	lw	$t0,0($t0)		# $a0 contém o número cujo fatorial deve ser calculado 
	addiu	$sp,$sp,-8		# Aloca espaço na pilha para 2 palavras (8 bytes)
	sw	$t0,4($sp)		# Coloca o parâmetro único abaixo do topo da pilha
	sw	$ra,0($sp)		# Salva o valor de $ra no topo da pilha (end de retorno para o SO)
	jal	fact		# Chama a função recursiva fact(num)
				# RESULTADO do fatorial deve retornar em $v0 
	lw	$ra,0($sp)		# Recupera o endereço de retorno para o SO (inexistente ao usar o MARS)
	addiu	$sp,$sp, 8		# Desaloca a pilha, ela não é mais necessária
	la	$t0,result		# escreve resultado na variável
	sw	$v0,0($t0)		# result
				# The program has finished. Exit.
	li 	$v0, 10		# 10 in $v0 is the code for the system call exit
	syscall			# Exit!

#	
# Função fact (calcula o fatorial, recursiva)	
fact:	lw	$a0,4($sp)		# recupera o valor do parâmetro formal n da pilha
	sltiu	$t0,$a0,2		# $t0=1 se num<2 - note-se o teste unsigned (considerando num como um Natural)
	beq	$t0,$zero,rec	# Se num>=2 ($t0=0), recorre
	addiu	$v0,$zero,1	# Senão, caso especial: retorna-se 1 se fact(1 ou 0)
ret:	jr	$ra		# RETORNA por aqui da folha da recursão.

rec:	addiu	$a0,$a0,-1		# Se não está na folha da recursão, decrementa n para recorrer
	addiu 	$sp,$sp,-8		# Aloca 8 bytes na pilha
	sw	$ra,0($sp)		# Salva o endereço de retorno na pilha
	sw	$a0,4($sp)		# Salva n-1 na pilha
	jal	fact		# chama fact(num-1), RECURSIVAMENTE
	lw	$a0,4($sp)		# Na volta da recursão, recupera num-1
	lw	$ra,0($sp)		# Recupera endereço de retorno 
	addiu	$sp,$sp,8		# Desaloca o espaço de pilha
	addiu	$a0,$a0,1		# Gera num a partir de num-1
	multu	$v0,$a0		# Multiplica valor retornado por fact(num-1) (em $v0) por num (em $a0)
				# Lembrar que resultado da multiplicação vai para os
				# 	registradores hi e lo. Aqui, despreza-se parte alta
	mflo	$v0		# Assume-se que hi=0 e usa-se apenas lo como resultado
				# Assim, $v0 e lo contêm fact(num)
	jr	$ra		# Retorna a quem chamou