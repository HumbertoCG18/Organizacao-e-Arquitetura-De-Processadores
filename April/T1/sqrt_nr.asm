.marco print_str(%str)
    li $v0, 4 
    la $a0, %str
    syscall
.end_macro 

.macro read_int(%reg)
    li $v0, 5 
    syscall 
    move %reg, $v0
.end_macro

.data 
msg_titulo:     .asciiz "Programa de Raiz Quadrada – Newton-Raphson\n"
msg_autores:    .asciiz "Desenvolvedores: Humberto Corrêa Gomes\n"
msg_prompt:     .asciiz "\nDigite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução\n"