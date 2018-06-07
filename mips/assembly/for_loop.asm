# Simple for loop:
# for (int i = 0; i < x; i++) {
#    printf("%d", i);
# }

        li      $v0, 5          # load syscall read_int into $v0
        syscall
        move    $t0, $v0        # move number read (x) to $t0
        li      $t1, 0          # i for loop iteration

Loop:   beq     $t1, $t0, Exit  # break condition
        addi    $t1, $t1, 1     # increment i counter
        move    $a0, $t1        # load i into $a0 to be printed
        li      $v0, 1          # load syscall print_int to $v0
        syscall
        j       Loop

Exit:   li      $v0, 10         # load exit code to $v0
        syscall                 # end execution
