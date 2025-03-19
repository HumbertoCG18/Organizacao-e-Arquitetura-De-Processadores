# Subrotinas aninhadas
#
# Comentário: Trata-se de uma implementação em linguagem de montagem do
#	MIPS do programa C abaixo. Serve como exemplo de estruturação de
#	programas em linguagem de montagem do MIPS para dar suporte a
#	chamadas aninhadas de subrotina.
#
# Convenções seguidas:
#	1) Todos os argumentos (parâmetros) das subrotinas envolvidas
#	são passados via pilha apontada pelo registrador $sp.
#	2) No topo da pilha sempre encontra-se salvo o endereço de
#	retorno para quem chamou a entidade que alocou espaço por último
#	nesta.
#	3) O retorno de resultados de execução de funções sempre será 
#	colocado na posição imediatamente abaixo do topo da pilha,
#	sobrescrevendo o primeiro argumento que a função/programa 
#	recebeu.
#
# Código fonte C equivalente ao implementado em linguagem de montagem:
#    main()
#    {
#		int var_a=0x00AA0000;
#		int var_b=0x0000BB00;
#		int var_c=0x000000CC;
#		int var_x=0;
#
#		var_x = soma3(var_a,var_b,var_c);
#    }
#
#    int soma3(int x, int y, int z)
#    {
#      return(soma(z,soma(x,y)));
#    }
#
#    int soma(int x1, int x2)
#    {
#      return(x1+x2);
#    }
#
	.text   
	.globl	main		# Declara rótulo main como ponto de entrada
main:   
	la	$t1, var_a		# inicializa as variáveis
	lw	$t1, 0($t1)	# $t1 contém valor de var_a
	la	$t2, var_b
	lw	$t2, 0($t2)	# $t2 contém valor de var_b
	la	$t3, var_c
	lw	$t3, 0($t3)	# $t3 contém valor de var_c
	addiu	$sp,$sp,-16	# aloca 4 posições de 4 bytes na pilha
	sw	$t3,12($sp)	# empilha valor de var_c (no fundo da pilha alocada)
	sw	$t2, 8($sp)	# empilha valor de var_b
	sw	$t1, 4($sp)	# empilha valor de var_a
	sw	$ra, 0($sp)	# empilha o endereço de retorno par ao SO (topo da pilha alocada)
	jal	soma3		# pula para subrotina soma3, guardando em $ra o endereço da linha abaixo
	lw	$ra,0($sp)		# ao voltar de soma3, recupera endereço de retorno da pilha
	lw	$v1,4($sp)		# resultado da soma3 é recuperado da pilha e colocado em $v1
	addiu	$sp,$sp,16		# libera as 4 posições alocadas, ou seja, desaloca a pilha do programa 
	la	$t0,var_x		# recupera endereço de var_x
	sw	$v1,0($t0)		# escreve resultado de soma3 em var_x (na memória)	
	# Acabou o programa. 
end:	li	$v0,10		# Chamada do sistema para sair do programa
	syscall			# Sai do programa!

#
#    int soma3(int x, int y, int z)
#    {
#      return(soma(z,soma(x,y)));
#    }
#
soma3:	lw	$t0, 4($sp)
	lw	$t1, 8($sp)	# lê na pilha de quem chamou dois parâmetros
	addiu	$sp,$sp,-12	# aloca 3 posições na pilha
	sw	$t1, 8($sp)	# empilha y (fundo da pilha alocada)
	sw	$t0, 4($sp)	# empilha x
	sw	$ra, 0($sp)	# empilha o endereço de retorno para quem chamou (topo da pilha alocada)
	jal	soma		# vai executar subrotina soma (chamada soma(x, y)),
				# tendo guardado em $ra o endereço da linha abaixo
	lw	$ra,0($sp)		# ao voltar, recupera endereço de retorno para quem chamou soma3 da pilha
	lw	$t0,4($sp)		# *** resultado de soma(x, y) é recuperado da pilha
	addiu	$sp,$sp,12		# libera as 3 posições alocadas para a pilha
	lw	$t1, 12($sp)	# ***  pega o terceiro parâmetro passado por quem chamou soma3
	addiu	$sp,$sp,-12	# aloca 3 posições de 4 bytes na pilha (de novo)
	sw	$t0,8($sp)		# empilha resultado de soma(x, y) (fundo da pilha alocada)
	sw	$t1,4($sp)		# empilha z
	sw	$ra,0($sp)		# empilha o endereço de retorno para quem chamou (topo da pilha alocada)
	jal	soma		# pula para subrotina soma (chamada soma(z, soma(x, y))),
				# guardando em $ra o endereço da linha abaixo
	lw	$ra,0($sp)		# ao voltar, recupera endereço de retorno da pilha
	lw	$t0,4($sp)		# *** resultado de soma(z, soma(x, y)) é recuperado da pilha
	addiu	$sp,$sp,12		# libera as 3 posições de 4 bytes alocadas (desaloca a pilha de soma3)
	sw	$t0,4($sp)		# coloca resposta na pilha e
	jr	$ra		# fim da subrotina soma3

#
#    int soma(int x1, int x2)
#    {
#      return(x1+x2);
#    }
#
soma:	lw	$t7,4($sp)
	lw	$t8,8($sp)		# lê da pilha de quem chamou os dois parâmetros x1 e x2
	addu	$t7,$t7,$t8	# faz a soma
	sw	$t7,4($sp) 	# coloca resposta na pilha de quem chamou
	jr	$ra		# e volta. Notar que esta subrotina, por ser folha, não aloca nem desaloca
        				# nada na pilha, mas usa a pilha para interagir com quem a chamou
	.data                   
var_a:	.word	0x00AA0000      
var_b:	.word	0x0000BB00           
var_c:	.word	0x000000CC           
var_x:	.word	0