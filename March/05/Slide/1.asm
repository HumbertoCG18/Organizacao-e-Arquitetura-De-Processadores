begin: 
        addi	$t0, $zero, 0			# $t0 <- 0
        addi	$t1, $zero, 0			# $t1 <- 0

loop: 
        slt     $t2, $a0, $t1           # Se (a0 < t1) t2 <- 1
                                        # Senão t2 <- 0
        bne     $t2, $zero, finish      # Se(t2 != 0) PC <- finish

                                        # Senão PC <- PC + 4
        add     $t0, $t0, $t1           # t0 <- t0 + t1
        addi    $t1, $t1, 2             # t1 <- t1 + 2
        j       loop                    # PC <- loop

finish: 
        add     $v0, $t0, $zero         # v0 <- t0 + 0

        