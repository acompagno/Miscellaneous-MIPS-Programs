#Basic Bubble Sort Algorithm developed in MIPS
#Organizes an array of 10 integers in ascending order
#Created By Andre Compagno
		.data

array:		.space		10 #Allocate space for array
promptText:	.asciiz		"\nEnter Integers\n"
spaceText:	.asciiz		" "
	.text

main:
	la	$t9 , array
	li	$s7 , 9		#loop limit
	li	$s0 , 0 	#iterator 1
	li	$s1 , 10	#limit  1
	li	$s2 , 0		#count
	li	$t5 , 0		#print iterator
	li	$t6 , 10	#print limit

	#PRINT PROMPT TEXT
	la	$a0 , promptText
	li	$v0 , 4
	syscall
	inputLoop:
		
		#READ IN INTEGER
		li	$v0 , 5
		syscall
		
		#MOVE ARRAY TO DESIRED INDEX
		add	$s3 , $s0 , $s0
		add	$s3 , $s3 , $s3
		add	$s4 , $t9 , $s3
		
		#SAVE READ VALUE TO THE INDEX
		sw	$v0 , 0($s4)
		
		#CHECK FOR END OF LOOP
		beq	$s0 , $s7 , loopPrep
		
		#INCREMENT ITERATOR 
		addi	$s0 , $s0 , 1
		
		#GO BACK TO THE BEGINNING OF LOOP
		j inputLoop
		
	loopPrep:
		#addi	$s1 , $s1 , -1
		add	$s0 , $zero , $zero
			
	loop:
		beq 	$s0 , $s7 , loopExit
		
		#S3|5 - CURRENT INDEX , S4|6 - NEXT INDEX
		add	$s3 , $zero , $s0
		addi	$s4 , $s3 , 1
		
		#MULTIPLYING INDEXES BY 4 
		add	$s3 , $s3 , $s3		
		add	$s3 , $s3 , $s3
		add	$s4 , $s4 , $s4
		add	$s4 , $s4 , $s4
		
		#MOVING ARRAY TO DESIRED INDEX
		add	$s5 , $s3 , $t9
		add	$s6 , $s4 , $t9
		
		#LOADING VALUES FROM ARRAY 
		lw	$t1 , 0($s5)
		lw	$t2 , 0($s6)
		
		slt 	$t0 , $t1 , $t2 
		beq	$t0 , $zero , swap
		
		#INCREMENT ITERATOR BY 1
		addi	$s0 , $s0 , 1
		
		j loop
		
	loopExit:
		#INCREMENT COUNT BY 1
		addi	$s2 , $s2 , 1
		
		#SET ITERATOR BACK TO ZERO
		add	$s0 , $zero , $zero
		
		#DECREASE LIMIT OF LOOP BY ONE
		addi	$s7 , $s7 , -1
		
		#!(s1(limit) < #s2(count)) 
		beq	$s1 , $s2  , printLoop 
		j loop  
	swap:
		#!(s2(count) < #s1(limit))
		slt 	$t0 , $s2 , $s1 
		beq	$t0 , $zero , printLoop 
		
		#MOVING ARRAY TO DESIRED INDEX
		add	$s5 , $s3 , $t9
		add	$s6 , $s4 , $t9
		
		#SWAP NUMBERS
		sw	$t2 , 0($s5)
		sw	$t1 , 0($s6)
		
		#INCREMENT ITERATOR BY 1
		addi	$s0 , $s0 , 1
		
		#GO BACK TO LOOP
		j	loop	
	printLoop:
		beq 	$t5 , $t6 , exit
		
		add	$t4 , $t5 , $zero
		add	$t4 , $t4 , $t4
		add	$t4 , $t4 , $t4
		
		add	$t7 , $t9 , $t4
		
		li	$v0 , 1 
		lw	$a0 , 0($t7) 
		syscall
		
		addi	$t5 , $t5 , 1 
		
		#PRINT PROMPT TEXT
		la	$a0 , spaceText
		li	$v0 , 4
		syscall
		j	printLoop  		
exit:
	li	$v0 , 10					#System call 10 -> exit program	
	syscall 						#System Call
