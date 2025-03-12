# Data da última alteração: 22/09/2020
# Comentário: Programa que demonstra o uso de funções/subrotinas,
#	sem aninhamento de chamadas, em linguagem de montagem do
#	MIPS.
#	
# Convenções seguidas:
#	1) Todos os argumentos (parâmetros) da subrotina são passados
#	via registradores reservados para tal (no MIPS, $a0 a $a3)
#	2) O retorno do resultado de execução da função se dá via
#	registradores reservados para tal (no MIPS, $v0 e $v1)
#	3) Entra-se na função usando a instrução jal e retorna-se
#	da função usando a instrução jr	$ra.

# Código fonte C equivalente ao implementado em linguagem de montagem:
#	main ()
#	{
#		int var_a=10;
#		int var_b=20;
#		int var_c=0;
#		
#		var_c = var_c+func(var_a,var_b);
#		var_c = var_c+func(var_c,var_b);
#	}
#	int func (int a, int b) {return (a+b);}
#
#	Convenções: os argumentos e o valor de retorno
#	da função func são passados por valor através de
#	registradores do MIPS. Especificamente, $a0 contém
#	o valor do argumento a, $a1 o valor do argumento b
#	e $v0 contém o valor de retorno da função
#		
	.text
	.globl	main
main:	#	c = c+func(a,b);
	la	$t0,var_a
	lw	$a0,0($t0)		# $a0 é inicializado com valor de var_a
	la	$t1,var_b
	lw	$a1,0($t1)		# $a1 é inicializado com valor de var_b
# Como argumentos estão definidos, pode-se chamar func 
	jal	func		# pula para func, guarda
				# endereço da próxima instrução no registrador $ra
# No retorno de func, $v0 contém o resultado desta chamada, var_a+var_b=30.
# Agora, realiza-se a soma de var_c com valor retornado
	la	$t2,var_c
	lw	$t3,0($t2)		# $t3 contém valor inicial de var_c, 0
	addu	$t3,$t3,$v0	# var_c <-- 0+30 = 30
	sw	$t3,0($t2)		# escreve novo valor de var_c de
				# volta na memória 
# Agora, prepara-se a segunda chamada
#	c = c+func(c,b);
	move	$a0,$t3		# pseudo que copia valor de 
				# var_c para $a0, argumento de nova chamada
	la	$t1,var_b
	lw	$a1,0($t1)		# $a1 é inicializado com valor de var_b
				# Note-se: o valor de var_b já
				# estava em $a1, mas quem "garante" que
				# a chamada da  rotina não alterou ele?
				# Assim, repete-se a leitura de var_b, por segurança
	jal	func		# segunda chamada
# No retorno de func, $v0 contém o resultado desta chamada, 50.
	la	$t2,var_c		# por segurança, de novo, lê-se o valor de var_c da memória
				# pois não se "sabe" se $t2 e/ou $t3 não foram
				# alterados pela chamada de func.
	lw	$t3,0($t2)		# $t3 contém valor atual de var_c, que é 30
	addu	$t3,$t3,$v0	# faz var_c <-- 30+50=80
	sw	$t3,0($t2)		# e escreve o novo valor em var_c (na memória, claro!)
		
	li	$v0,10		# prepara fim do programa
	syscall			# fim do programa
#
#	Função func
func:	addu	$v0,$a0,$a1	# soma argumentos e
	jr	$ra		# volta para quem chamou

	.data
var_a:	.word	10
var_b:	.word	20
var_c:	.word	0