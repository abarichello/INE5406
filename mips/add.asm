# Transform the following C operation to MIPS Assembly
# f = (g + h) - (i + j)

main:
	# Read A
	li      $v0, 5          # load syscall read_int into $v0
	syscall                 # make the syscall
	move    $t0, $v0        # move the number read into $t0

	# Read B
	li      $v0, 5
	syscall
	move    $t1, $v0

	# Read C
	li      $v0, 5
	syscall
	move    $t2, $v0

	# Read D
	li      $v0, 5
	syscall
	move    $t3, $v0

	add     $t4, $t0, $t1   # $t4 = g + h
	add     $t5, $t2, $t3   # $t5 = i + j
	sub     $s0, $t4, $t5   # f = $t4 - $t5

	# Print out $s0
	move    $a0, $s0        # move the number to print into $a0
	li      $v0, 1          # load syscall print_int into $v0
	syscall

	li      $v0, 10         # syscall code 10 is for exit
	syscall
