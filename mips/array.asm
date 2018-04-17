# A = Array of 100 words
# $s1 = g, $s2 = h
# $s3 = A[0]

# A[12] = h + A[8]

main:
        lw      $t0, 32 ($s3)   # $t0 = A[8]
        add     $t0, $s2, $t0   # h + A[8]
        sw      $t0, 48 ($s3)   # A[12] = h + A[8]

        li      $v0, 10         # load syscall exit code to $v0
        syscall
