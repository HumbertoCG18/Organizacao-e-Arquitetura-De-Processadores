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

.text 
.globl main

main: 
    # Carregar o tamanho do vetor (size) em $t0
    la  $t1, size               # Carrega endereço de size
    lw  $t0, 0($t1)             # Carregar o valor de size em $t0 (contador do loop)

    # Carregar os endereços base de V1, V2 e V3.
    la  $t1, V1                 # $t1 aponta para o primeiro elemento de V1          
    la  $t2, V2                 # $t2 aponta para o primeiro elemento de V2
    la  $t3, V3                 # $t3 aponta para o primeiro elemento de V3

    li  $t4, 0

