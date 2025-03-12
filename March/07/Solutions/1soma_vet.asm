# MIPS assembly language example: Manipulating arrays
# Function: This program adds the corresponding elements of two same size 
#		unidimensional vectors, V1 and V2 and writes the sum of 
#		these elements to a third vector V3 of the same size as
#		the two other vectors
#
	.text				# Add what follows to the text segment of the program
	.globl	main		# Declare the label main to be a global one
main:
	la	$t0,V1		# get pointer to first vector V1
	la	$t1,V2		# get pointer to second vector V2
	la	$t2,V3		# get pointer to destination vector V3
	la	$t3,size		# get address of size
	lw	$t3,0($t3)		# now $t1 contains the size of the array

loop:	blez	$t3,end		# if size is/becomes 0, then jump to end of processing
	lw	$t4,0($t0)		# else get next V1 element value
	lw	$t5,0($t1) 		# 	get next V2 element value	
	addu	$t4,$t4,$t5 	# 	add two values
	sw	$t4,0($t2)		# 	write sum to corresponding position in V3
	addiu	$t0,$t0,4		# 	update V1 pointer to next element
	addiu	$t1,$t1,4		# 	update V2 pointer to next element
	addiu	$t2,$t2,4		#	update V3 pointer to next element
	addiu	$t3,$t3,-1		#	decrement counter of elements
	j	loop			# 	and continue execution
	
# now, return from main
end:	li	$v0,10
	syscall			# end the program

	.data			
V1:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V2:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V3:	.word	0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
size:	.word	11	
	


