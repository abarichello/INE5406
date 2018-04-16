# Transform the following C operation to MIPS Assembly
# f = (g + h) - (i + j)

main:   add $t0, $s1, $s2 # g + h
        add $t1, $s3, $s4 # i + j
        sub $s0, $t0, $t1
