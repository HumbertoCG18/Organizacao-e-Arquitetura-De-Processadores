# MIPS assembly language example: Manipulating arrays
# Function: This program takes two unidimensional vectors (V1 and V2) with a same
#		size and computes a third vector V3 containing only the elements
#		that appear in both vectors at any place within each.
#
#   The pseudocode for this program is
#
#  comums=0;
#  for(i=0; i<size ; i++)	
#	// external loop, loop1
#	// selects next pivot element of V1 to test
#	{
#	flag=0;
#	for(j=0; j<size ; j++)  // first internal loop, loop2
#	// test if some element of V2 is equal to V1 pivot
#		if( V1[i] == V2[j]
#			{ flag=1;	// If and when finds, break the loop
#			break;
#			}
#	if(flag)
#		for(j=0; j<comums ; j++) // second internal loop, loop3
#		// Verifies that newly found is not already in V3 
#             		if( V1[i] == V3[j]
#                			{ flag=0;	// If found it already there, do not insert
#                  			  break;	// and get out of here
#				}
#	if(flag)
#          	V3[ comums++ ] = V1[i];	// New commom element found not yet in V3 
#					// Insert it in V3				
#	}
#
	.text                   
	.globl  main            
main:
	la	$s1,V1			# generates pointer to V1 in $s1
	la	$t7,size
	lw	$t7,0($t7)			# $t7 initially contains size the number of
						# of elements to process in each source vector
loop1: blez	$t7,fim			# tests end of external loop
	xor	$t9,$t9, $t9		# else sets flag to 0 in $t9
	lw	$t0,0($s1)			# loads $t0 with next element of V1
# loop2 preparation, to traverse V2	#######
	la	$s2,V2			# generates pointer to V2 in $s2                       
 	la	$t2,size			# 
	lw	$t2,0($t2)			# $t2 now contains the number of elements
						# to process in V2,initially identical to size                                                  
loop2:blez	$t2,endloop2		# tests end of first internal loop
	lw	$t1,0($s2)			# loads $t1 with next element of V2
	beq	$t0,$t1,setflag		# if found the same element in V1 and V2, go set flag
						# and break the loop
	addiu	$s2,$s2,4			# else, go to next element of V2, incrementing
	addiu	$t2,$t2,-1			#	the V2 pointer and decrementing counter
	j	loop2				# 	and go back to start of loop2, test end of vector
# Lines below set and/or test the value of flag	#######
setflag:	
	li	$t9,1 			# When here, set flag
endloop2:
	beq	$t9,$zero,nextV1		# if flag is 0, go to next iteration
# loop3 preparation, to traverse V3	#######
	la	$s2,V3			# generates pointer to start of V3 in $s2
	la	$t2,comuns			# 
	lw	$t2,0($t2)			# reads current number of common elements    
loop3:	blez	$t2,endl3		# if no common elements exist so far, end this loop 
	lw	$t1,0($s2)			# else, read next element of V3
	beq	$t0,$t1, rstflag		#	if element already in V3, reset flag and end loop
	addiu	$s2,$s2, 4			# 	else	increment pointer to next V3 element,
	addiu	$t2,$t2, -1			#		decrement V3 element counter
	j	loop3				#		and continue looking at V3 elements
# Lines below reset and/or test the value of flag	#######
rstflag:	li	$t9,0			# reset the flag
endl3:	beq	$t9,$zero,nextV1	# if flag is 0 there is nothing to do, prepare the next 
						# iteration of the external loop (loop1)
# Whenever here, we have found a new element to add to V3 and we add it! #######
	la	$s2,V3			# $s2 receives a pointer to V3
	la	$s5,comuns			# $s5 receives a pointer to comuns
	lw	$t2,0($s5)			# $t2 receives the current value of comuns
 	addu	$t1,$t2,$t2			# multiply comuns by 2
	addu	$t1,$t1,$t1			# trasforms number of elements in displacement
	addu	$t1,$s2,$t1			# gets pointer to position in V3 where to put new element
	sw	$t0,0($t1)			# writes new element in $t0 to right position in V3
	addiu	$t2,$t2,1			# increment number of common elements
	sw	$t2,0($s5)			# and write it to comuns
# Preparation for the next iteration of the external loop (loop1)                   
nextV1:
	addiu	$s1,$s1,4			# increments pointer of vector V1 to next element
	addiu	$t7,$t7,-1			# decrements counter of elements to process in V1
	j	loop1
# End of work, return from program
fim:	li	$v0,10
	syscall

	.data                   
V1:	.word	0x12 0xff 0x3 0x12 0x878
V2:	.word	0x12 0x3 0x12 0x4  0x5
V3:	.word	0x0  0x0  0x0 0X0  0x0   
size:	.word	5     
comuns:
	.word	0
