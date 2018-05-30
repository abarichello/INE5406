# Implement the following C code:
# if (a != b) {
#   f = g + h;
# } else {
#   f = g - h;
# }
#
# a, b, f, g, h = $s0, $s1, $s2, $s3, $s4

main:
    # Read A
    li      $v0, 5          # load syscall read_int into $v0
    syscall                 # make the syscall
    move    $t0, $v0        # $t0 = A

    # Read B
    li      $v0, 5
    syscall
    move    $t1, $v0        # $t1 = B

    # Read G
    li      $v0, 5
    syscall
    move    $t2, $v0        # $t2 = G

    # Read H
    li      $v0, 5
    syscall
    move    $t3, $v0        # $t3 = H

    beq 	$t0, $t1, else	# goto else if A == B
    add 	$s0, $t2, $t3	# f = g + h (if A != B)
    j		exit			# end

else:
    sub		$s0, $t2, $t3	# f = g - h (if A == B)
    j		exit			# end

exit:
    # Print out $s0
    move    $a0, $s0        # move the number to print into $a0
    li      $v0, 1          # load syscall print_int into $v0
    syscall

    li 		$v0, 10			# load syscall exit code
    syscall					# return 0
