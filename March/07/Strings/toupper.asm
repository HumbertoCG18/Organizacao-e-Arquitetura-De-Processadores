# 
# 
#	Este programa transforma todas as letras minúsculas 
# 	da cadeia (texto) na letra maiúscula correspondente.
#

		.data
texto:	.asciiz	"Mamae me ama!"	# cadeia a manipular

		.text
		.globl	main
main:	la		$t0,texto	# $t0 é carregado com ponteiro para a cadeia
 
		la		$a0,texto	# Estas três linhas imprimem a 
		li		$v0,4		# cadeia antes do processamento 
		syscall

lacotoupper:
		lb		$t1,0($t0)		# Lê próximo caracter da cadeia

		beq		$t1,$zero,fim	# Testa se é caracter NULL (fim da cadeia)
								# se sim, vai para o fim, acabou tratamento
		slti	$t2,$t1,0x7B	# Senão, testa se caracter tem código 
								# superior ao 'z'
		beq		$t2,$zero,naoehletramin
								# Se sim, ignora caracter, indo para rótulo
								# naoehletramin 
		slti	$t2,$t1,0x61	# Senão, testa se caracter tem código 
								# inferior a 'a'
		bne		$t2,$zero,naoehletramin
								# Se sim, ignora caracter, indo para rótulo
								# naoehletramin 
		addiu	$t1,$t1,-32		# Senão, ACHEI letra minúscula. Transforma
								# em maiúscula, subtraindo 0x20 (ou seja,
								# somando -32
		sb		$t1,0($t0)		# Agora atualiza a cadeia em memória
								# escrevendo a maiúscula gerada em $t1
								# sobre a minúscula original

naoehletramin:
		addiu	$t0,$t0,1		# Atualiza ponteiro para próximo elemento 
								# da cadeia
		j		lacotoupper		# E volta para tratar este próximo
fim:	
		la		$a0,texto	# Estas três linhas imprimem a 
		li		$v0,4		# cadeia depois do processamento 
		syscall

		li		$v0,10		# Syscall para finalizar o programa
		syscall