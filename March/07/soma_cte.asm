###############################################################################################
# Exemplo de programa em linguagem de montagem do MIPS : Manipulando vetores
# Função: Este programa soma o valor de uma constante (const) a cada elemento do vetor array
###############################################################################################
        
        .text                   # Diretiva para o montador - adiciona o que vem abaixo
        			# 	à memória de programa do processador
        .globl  main            # Declare o rótulo main Como sendo global
        			# É o ponto a partir de onde se inicia a execução
main:
        la      $t0,array       # o registrador $t0 contém o endereço do vetor
        la      $t1,size        # obtém o endereço da posição da memória de dados onde se guarda
        			# o tamanho do vetor (size)
        lw      $t1,0($t1)      # o registrador $t1 contém o tamanho do vetor
        la      $t2,const       # obtém o endereço da constante const
        lw      $t2,0($t2)      # o registrador $t2 contém a constante a somar
loop:   blez    $t1,end         # se o tamanho chega a 0, fim do processamento
        lw      $t3,0($t0)      # obtém um elemento do vetor
        addu    $t3,$t3,$t2     # soma a constante
        sw      $t3,0($t0)      # atualiza o vetor
        addiu   $t0,$t0,4       # atualiza o apontador do vetor
        			# lembrar que 1 palavra no MIPS ocupa 4 bytes (4 endereços consecutivos) de memória
        addiu   $t1,$t1,-1      # decrementa o contador de tamanho do vetor
        j       loop            # continua a execução
        
        # Agora volta para o programa monitor
end:    li	$v0,10		# prepara chamada do sistema para finalizar programa
	syscall			# fim do programa

        .data                   # Diretiva para o montador - adiciona o que vem abaixo
        			# 	à memória de dados do processador
array:  .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20 # o vetor
                                # A diretiva .word carrega a lista de inteiros em posições successivas
                                # 	da memória de dados
size:   .word   11              # Variável que armazena o tamanho do vetor
const:  .word   0x100           # Constante a somar a cada elemento do vetor