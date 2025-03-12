# tolower_acent
#
#	Este programa transforma cada letra maiúscula da cadeia (texto)
#	na letra minúscula correspondente. Invertendo o sentido da troca, de 
#	minúsculas --> maiúsculas para maiúsculas --> minúsculas.
#	Esta versão em particular foi estendida para lidar corretamente
#	com caracteres acentuados da língua Portuguesa. 
#	Isto é obtido adicionando duas cadeias a empregar no algoritmo:
#		acentuados_mai - os caracteres maiúsculos acentuados da língua
#		acentuados_min - os caracteres minúsculos acentuados da língua
#	Também se gera a informação de tamanho destas cadeias (size_acent)
#	
#	O novo algoritmo funciona como antes, tentando detectar se cada caracter da 
#	cadeia de entrada (texto) está na faixa a tratar (maiúsculas de A=0x41 a
#	Z=0x7A). Se está, converte-se a letra para a minúscula correspondente.
#
#	Isto não funciona para letras acentuadas, pois estas correspondem a 
#	caracteres do ASCII estendido (ASCIIE). Os caracteres ASCII originais são 
#	128 (de 0x00 a 0x7F) e o conjunto de caracteres estendidos incluem estes,
#	mas também os 128 caracteres que vão de 0x80 a 0xFF. É nesta última faixa que
#	se encontram as letras acentuadas do Português. Infelizmente a codificação 
#	destes últimos 128 caracteres varia de país para país. Aqui no MARS, por 
#	exemplo os As com acento agudo têm códigos Á=0xC1 e á=0xE1
#
#	Assim, usando as cadeias de apoio acentuados_mai e acentuados_min, e quando
#	se descobre que a letra em análise possui código maior que o Z (0x5A), salta-se
#	para um laço que pesquisa se o código desta corresponde a uma das letras dentro
#	de acentuados_mai. Se sim, troca-se esta pela letra na mesma posição de 
#	acentuados_min (note-se que isto justifica a forma como as duas cadeias 
#	foram organizadas com as mesmas letras nas mesmas posições). Depois disto, 
#	volta-se a executar as instruções do laço principal.
#
#	Algumas observações importantes:
#	1) Note-se a troca do uso da instrução lb usada em toupper.asm pela instrução
#	lbu. Isto é feito devido a um problema que só ocorre ao lidar com caracteres 
#	ASCIIE, pois lb usa extensão de sinal, enquanto que lbu usa extensão de 0. 
#	Assim, ao carregar uma letra como Á (0xC1) em um registrador, isto produz o
#	valor 0xFFFFFFC1 e não 0x000000C1 no registrador. Isto acontece porque 0xC1
#	em binário é 11000001, ou seja, tem-se o bit mais significativo em 1 e o 
#	processo de extensão de sinal da instrução lb vai copiar este bit 24 vezes
#	à esquerda no registrador destino.
#	A instrução lbu, por outro lado, sempre copia 24 0s à esquerda, independente 
#	do valor dos bits do byte lido. Isto evita erros de comparação das letras.
#	No programa toupper.asm isto não ocorria, pois os caracteres ASCII 
#	básicos sempre têm o último bit à esquerda (bit 7) igual a 0.
#

	.data
texto:	.asciiz	"MamÃe me AmA, Tô certo Disto!\n" # cadeia a manipular
acentuados_mai:
	.asciiz	"ÁÉÍÓÚÂÊÔÀÃÕ"	# letras minúsculas acentuadas
acentuados_min:
	.asciiz	"áéíóúâêôàãõ"	# letras minúsculas acentuadas
size_acent:.word 12			# note que existem 11 caracteres acentuados, mas contabilizamos o NULL

	.text
	.globl	main
main:		
	la	$t0,texto		# $t0 é carregado com ponteiro para a cadeia
	la	$a0,texto		# Estas três linhas imprimem a 
	li	$v0,4		# cadeia antes do processamento 
	syscall
lacotoupper:
	lbu	$t1,0($t0)		# Lê próximo caracter da cadeia
	beq	$t1,$zero,fim	# Testa se é caracter NULL (fim da cadeia)
				# se sim, vai para o fim, acabou tratamento
	slti	$t2,$t1,0x5B	# Senão, testa se caracter tem código 
				# inferior ao caractere após o 'Z'
	beq	$t2,$zero,testa_acentuada
				# Se sim, ignora caracter, indo para rótulo
				# testa_acentuada
	slti	$t2,$t1,0x41	# Senão, testa se caracter tem código 
				# inferior a 'A'
	bne	$t2,$zero,naoehletramai
				# Se sim, ignora caracter, indo para rótulo
				# testa_acentuada 
	addiu	$t1,$t1,0x20	# Senão, ACHEI letra maiúscula. Transforma
				# em minúscula, somando 0x20 (ou seja,
				# somando 32 em decimal)
volta_loop_princ:
	sb	$t1,0($t0)		# Agora atualiza a cadeia em memória
				# escrevendo a minúscula gerada em $t1
				# sobre a maiúscula original
naoehletramai:
	addiu	$t0,$t0,1		# Atualiza ponteiro para próximo elemento 
				# da cadeia
	j	lacotoupper	# E volta para tratar este próximo
	
testa_acentuada:
	la	$t3,acentuados_mai	
				# gera ponteiro para letras maiúsculas acentuadas
	la	$t4,size_acent	# busca tamanho do vetor de acentuadas
	lw	$t4,0($t4)		# coloca tamanho em $t4
laco_acent:
	lbu	$t5,0($t3)		# busca letra acentuada de acentuados_mai para comparar
	beq	$t5,$zero,naoehletramai# testa se acabaram os caracteres testados em acentuados_mai
	bne	$t1,$t5,ainda_nao 	# senão, testa se o caracter atual de texto é o acentuado na mão. Senão, vai adiante 
	addu	$t3,$t3,$t4	# aqui, encontrou acentuado em texto, gera ponteiro para o minúsculo correspondente
	lbu	$t1,0($t3)		# busca o minúsculo correspondente e altera $t1 de mai para min
	j	volta_loop_princ	# e volta para o laço principal
ainda_nao:				# aqui não achou acentuado, mais ainda não testou todos
	addiu	$t3,$t3,1		# avança ponteiro para outro acentuado a testar em acentuados_mai
	j	laco_acent		# e volta para testar
		
fim:	la	$a0,texto		# Estas três linhas imprimem a 
	li	$v0,4		# cadeia depois do processamento 
	syscall
	li	$v0,10		# Syscall para finalizar o programa
	syscall