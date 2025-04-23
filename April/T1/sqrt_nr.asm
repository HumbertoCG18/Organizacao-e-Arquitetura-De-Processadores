# Programa de Raiz Quadrada - Newton-Raphson Recursivo

# Macros
.macro print_string(%label)
    li $v0, 4
    la $a0, %label
    syscall
.end_macro

.macro print_int(%reg)
    li $v0, 1
    move $a0, %reg
    syscall
.end_macro

# Dados
.data
titulo:     .asciiz "Programa de Raiz Quadrada --- Newton & Raphson\n"
autores:    .asciiz "Desenvolvedores: Humberto Correa Gomes\n"
prompt:     .asciiz "\nDigite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao\n"
prompt_x:   .asciiz "Digite o valor de x: "
prompt_i:   .asciiz "Digite o numero de iteracoes i: "
encerrar:   .asciiz "Programa encerrado.\n"
result1:    .asciiz "sqrt("
virgula:    .asciiz ", "
result2:    .asciiz ") = "
newline:    .asciiz "\n"

# Código
.text
.globl main

main:
    # Prólogo
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Mensagens iniciais
    print_string(titulo)
    print_string(autores)
    
loop_principal:
    # Prompt principal
    print_string(prompt)
    
    # Leitura de x
    print_string(prompt_x)
    li $v0, 5           # Syscall para leitura de inteiro
    syscall
    move $s0, $v0       # Move valor lido para $s0 (x)
    
    # Verifica se deve encerrar
    bltz $s0, encerrar_programa
    
    # Leitura de i
    print_string(prompt_i)
    li $v0, 5           # Syscall para leitura de inteiro
    syscall
    move $s1, $v0       # Move valor lido para $s1 (i)
    
    # Verifica se deve encerrar
    bltz $s1, encerrar_programa
    
    # Chama a função sqrt_nr
    move $a0, $s0       # x
    move $a1, $s1       # i
    jal sqrt_nr
    move $s2, $v0       # Salva resultado em $s2
    
    # Exibe resultado
    print_string(result1)
    print_int($s0)      # x
    print_string(virgula)
    print_int($s1)      # i
    print_string(result2)
    print_int($s2)      # resultado
    print_string(newline)
    
    j loop_principal
    
encerrar_programa:
    print_string(encerrar)
    
    # Epílogo
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    # Encerra programa
    li $v0, 10
    syscall

# Função sqrt_nr(x, i)
# Parâmetros: 
#   $a0 = x (número para calcular a raiz)
#   $a1 = i (número de iterações)
# Retorno: 
#   $v0 = resultado da aproximação
sqrt_nr:
    # Salva registradores na pilha
    addi $sp, $sp, -16
    sw $ra, 12($sp)     # Endereço de retorno
    sw $s0, 8($sp)      # Para armazenar x
    sw $s1, 4($sp)      # Para armazenar i
    sw $s2, 0($sp)      # Para armazenar resultado anterior
    
    # Copia argumentos para registradores salvos
    move $s0, $a0       # s0 = x
    move $s1, $a1       # s1 = i
    
    # Verifica caso base (i = 0)
    beqz $s1, caso_base
    
    # Caso recursivo: chama sqrt_nr(x, i-1)
    move $a0, $s0
    addi $a1, $s1, -1
    jal sqrt_nr
    
    # Salva resultado da chamada recursiva
    move $s2, $v0       # s2 = sqrt_nr(x, i-1)
    
    # Calcula x / sqrt_nr(x, i-1)
    div $s0, $s2        # x / sqrt_nr(x, i-1)
    mflo $t0            # t0 = quociente da divisão
    
    # Calcula (sqrt_nr(x, i-1) + x/sqrt_nr(x, i-1))
    add $t1, $s2, $t0
    
    # Divide por 2: resultado / 2
    srl $v0, $t1, 1     # Shift right logical = divisão por 2
    
    j fim_funcao
    
caso_base:
    # Retorna 1 para i = 0
    li $v0, 1
    
fim_funcao:
    # Restaura registradores da pilha
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    
    # Retorna
    jr $ra