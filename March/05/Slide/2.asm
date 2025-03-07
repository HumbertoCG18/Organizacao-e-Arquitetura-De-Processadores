.data
a: .word 4 
b: .word 7
maior: .space 4
.text
        .globl main

main:
        lw          $t0, a
        lw          $t1, b 
        bgt         $t0, $t1, a_Maior
b_Maior:
        sw          $t1, maior
        j           fim
a_Maior: 
        sw          $t0, maior
fim:
        j           fim 