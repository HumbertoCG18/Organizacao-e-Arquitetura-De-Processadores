###############################################################################################
#
# Especificação: Somar elemento a elemento os dois vetores V1 e V2 e colocar resultado 
#		no terceiro vetor, V3
#
###############################################################################################
        
	.data			

V1:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V2:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V3:	.word	0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 

size:	.word	11	

###############################################################################################
#
# Especificação: Desenvolver programa que realiza uma divisão do inteiro dividendo pelo
#		inteiro divisor, gerando os inteiros quociente e resto. Usar o algoritmo
#		de subtrações sucessivas que opera como especificado abaixo:
#
#   Exemplo de divisão de 10 por 3 usando subtrações sucessivas:
#   [Dividendo] [Divisor]  [Dividendo-Divisor]  Contador 
#      10           3               7               1 
#       7           3               4               2 
#       4           3               1               3 
#   dividendo    divisor          resto         quociente
#
###############################################################################################

		.data
        
dividendo:	.word	0xFAAA	# Base 10: 64170 
divisor:	.word	0x83	# Base 10: 131

quociente:	.word	0	# resposta deve ser: 489 (0x1E9)
resto:		.word	0	# resposta deve ser: 111 (0x6f)

############################################################################################### 
#
# Especificação: Desenvolver programa que computa os elementos comuns aos vetores de inteiros
#		V1 e V2. Os elementos comuns devem ser armazenados no vetor V3, que
#		inicialmente contém apenas 0s. Escolha o que fazer quando um mesmo
#		inteiro aparece duas ou mais vezes no mesmo vetor. Ao final do algoritmo
#		armazenar em comuns o número de elementos comuns encontrados.
#
# Algoritmo que computa um vetor contendo os elementos comuns a 2 vetores
# 	Em comums deve ir o número de elementos comuns
#	O valor size é igual para os três vetores
#
###############################################################################################

	.data                   

V1:	.word	0x12 0xff 0x3 0x14 0x878
V2:	.word	0x12 0x3 0x33 0x4  0x5
V3:	.word	0x0  0x0  0x0 0X0  0x0   

size:	.word	5     
comuns:	.word	0			# Neste caso resposta deve ser 2.