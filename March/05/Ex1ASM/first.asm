#O objetivo deste programa é mostrar o uso mais básico da linguagem
#	de montagem do MIPS, através de um programa trivial que soma dois
#	números quaisquer de 32 bits (A e B no programa) armazenados em 
#	memória e coloca o resultado em uma terceira posição de memória
#	(C no programa). 
#
#	Note-se que este programa extremamente simples já serve para 
#	demonstrar várias das idiossincrasias de arquiteturas RISC, das quais
#	o MIPS é um exemplo clássico. Entre estas, cita-se:
#
#	1) A obtenção do endereço de um dado em memória não pode ser
#	feita de forma simples por uma instrução. O montador MARS e outros
#	superam esta limitação provendo uma pseudo-instrução (la, abreviatura
#	de "load address") que será por ele traduzida, durante a geração do
#	código objeto, para instruções da arquitetura MIPS que desempenham
#	este papel (em geral uma sequência de duas instruções, lui e ori)
#
#	2) O uso de endereçamento base-deslocamento para fazer acesso a
#	qualquer dado em memória. Não existem instruções no MIPS que usem 
#	endereçamento direto para acesso a memória, sendo necessário partir
#	de um endereço base e especificar um deslocamento sobre este, que pode
#	obviamente simular endereçamento direto, se o deslocamento for 0.
#
#	3) O uso da instrução syscall (chamada do sistema) para retornar
#	do programa. syscall lê o conteúdo do registrador $v0 e,
#	dependendo do valor armazenado, realiza alguma função específica. 
#	O valor 10 carregado em $v0 é um código de serviço que dita
#	que o programa deve ser finalizado.
#

		.data
A:		.word	32
B:		.word	0xffab3400 
C:		.word	0


        .text   
        .globl	main            
        
main:	la		$t0,A		# Carrega endereço de A em $t0 - PSEUDO-INSTRUÇÃO
		lw		$t0,0($t0)	# Lê valor de A para $t0
		la		$t1,B		# Carrega endereço de B em $t1 - PSEUDO-INSTRUÇÃO
		lw		$t1,0($t1)	# Lê valor de B para $t1
		addu	$t0,$t0,$t1	# $t0 recebe A+B
		la		$t2,C		# Carrega endereço de C em $t2 - PSEUDO-INSTRUÇÃO
		sw		$t0,0($t2)	# C recebe A+B

		li		$v0,10		# Coloca o valor 10 no %v0, indicando o serviço fim de execução
		syscall				# Chamada do sistema para finalizar a execução em si
		
       


