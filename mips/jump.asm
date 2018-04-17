# Implement the following C code:
# if (i != j) {
#   f = g + h;
# } else {
#   f = g - h;
# }
#
# f, g, h, i, j = $s0, $s1, $s2, $s3, $s4

main:
	beq 	$s3, $s4, else	# goto else if i == j
	add 	s0, $s1, $s2	# f = g + h (if i != j)
	j	EXIT		# end

else:	sub	$s0, $s1, $s2	# f = g - h (if i == j)


exit:	li 	$a0, 10		# load syscall exit code
	syscall			# return 0
