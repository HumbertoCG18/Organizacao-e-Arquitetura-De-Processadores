.data
    n: .word 10  # Valor inicial de n
    result: .word 0  # Variável para armazenar o resultado

.text
.globl main

main:
    lw $a0, n  # Carrega o valor de n em $a0
    jal div2  # Chama a função div2
    sw $v0, result  # Armazena o resultado em 'result'
    li $v0, 10  # Código de saída do sistema
    syscall  # Encerra o programa

div2:
    # Salva os registradores na pilha
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    # Verifica se a < 2
    li $t0, 2
    blt $a0, $t0, return_zero

    # Verifica se a == 2
    beq $a0, $t0, return_one

    # Caso a > 2, continua a recursão
    sub $a0, $a0, $t0  # Subtrai 2 de a
    jal div2  # Chamada recursiva

    # Adiciona 1 ao resultado da chamada recursiva
    addi $v0, $v0, 1

    # Restaura os registradores da pilha
    lw $ra, 4($sp)
    lw $a0, 0($sp)
    addi $sp, $sp, 8

    jr $ra  # Retorna para o chamador

return_zero:
    li $v0, 0  # Retorna 0
    j restore_and_return

return_one:
    li $v0, 1  # Retorna 1

restore_and_return:
    # Restaura os registradores da pilha
    lw $ra, 4($sp)
    lw $a0, 0($sp)
    addi $sp, $sp, 8

    jr $ra  # Retorna para o chamador