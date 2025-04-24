.marco print_string(%label)
    li $v0, 4 
    la $a0, %label
.end_macro

.macro print_int
    li $v0, 1 
    move $a0, %reg 
    syscall 
.end_macro

main:
    addi $sp, $sp, -4
    sw $ra 0($sp)

    print_string(titulo)
    print_string(autores)

    print_string(prompt)

    li $s0, 30
    li $s1, 190 

    move $a0, $s0
    move $a1, $s1
    jal sqrt_nr
    move $a2, $v0 

    print_string(result1)
    print_string($s0)
    print_string(virgula)
    print_int($s1)
    print_string(result2)
    print_int($s2)
    print_string(newLine)

    $print_string(encerrar)

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    li $v0, 10 
    syscall

sqrt_nr:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    
