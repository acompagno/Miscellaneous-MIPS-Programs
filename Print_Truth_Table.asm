#Truth Table Print developed in MIPS
#Calculates and prints out the truth table for a predefined boolean expression 
#Also keeps track of the number of minterms in the expression
#Created By Andre Compagno
	.data
A:		.word	0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1
B:		.word 	0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1
C:		.word	0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1
D:		.word	0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
text:		.asciiz	"The number of Minterms in F is: "
	.text
main:
	li	$t0 , 0					#iterator
	li	$t1 , 16				#loop limit
	li	$t2 , 0 				#minterm count
	la	$s0 , A					#a values address 
	la	$s1 , B					#b values address
	la	$s2 , C					#c values address
	la	$s3 , D					#d values address
	printFormat: 
		li	$v0 , 11			#system call 11 -> print char
		li	$a0 , 65			#load char 'A' to be printed
		syscall					#system call
		li	$a0 , 66			#load char 'B' to be printed
		syscall					#system call
		li	$a0 , 67			#load char 'C' to be printed
		syscall					#system call
		li	$a0 , 68			#load char 'D' to be printed
		syscall					#system call
		li	$a0 , 32			#load a space to be printed
		syscall					#system call
		li	$a0 , 70			#load char 'F' to be printed
		syscall					#system call
		li 	$a0 , 10			#load a newline character to be printed
		syscall					#system call
	loop:
		lw	$t4 , 0($s0)			#load a value 
		lw	$t5 , 0($s1)			#load b value 
		lw	$t6 , 0($s2)			#load c value 
		lw	$t7 , 0($s3) 			#load d value
		li	$v0 , 1				#system call 1 -> print int
		addi	$a0 , $t4 , 0			#load value of A to be printed
		syscall					#system call
		li	$v0 , 1				#system call 1 -> print int
		addi	$a0 , $t5 , 0			#load value of A to be printed
		syscall					#system call
		li	$v0 , 1				#system call 1 -> print int
		addi	$a0 , $t6 , 0			#load value of A to be printed
		syscall					#system call
		li	$v0 , 1				#system call 1 -> print int
		addi	$a0 , $t7 , 0			#load value of A to be printed
		syscall					#system call
		li 	$v0 , 11
		li	$a0 , 32			#load a space to be printed
		syscall					#system call
		jal	computeF			#compute F
		li	$v0 , 1				#system call 1 -> print int
		addi	$a0 , $s4 , 0			#load value of F to be printed
		syscall					#system call
		li	$v0 , 11			#system call 11 -> print char
		li	$a0 , 10			#load newline to be printed
		syscall					#system call
		addi	$s0 , $s0 , 4			#moves to the next value of a in the array 
		addi	$s1 , $s1 , 4			#moves to the next value of B in the array
		addi	$s2 , $s2 , 4			#moves to the next value of c in the array 
		addi	$s3 , $s3 , 4			#moves to the next value of d in the array 		
		addi	$t0 , $t0 , 1			#increments the iterator by 1
		bne	$t0 , $t1 , loop		#checks for the end of the loop
exit:
	li	$v0 , 4					#system call 4 -> print string
	la	$a0 , text				#load address to the text 
	syscall						#system call
	li	$v0 , 1					#system call 1 -> print int
	addi	$a0 , $t2 , 0				#set the number of minterms to be printed
	syscall						#system call
	li	$v0 , 10				#System call 10 -> exit program	
	syscall 					#System Call
computeF:
	and	$t8 , $t4 , $t5			#calclate first half of expression (A^B) 
	not 	$t7 , $t7			#not d
	and	$t9 , $t6 , $t7			#calculate 2nd half of expresson (C^D')
	xor	$s4 , $t8 , $t9			#calculate final value of boolean expression
	beq	$s4 ,  1  , incrementCount  	#checks if the current value is a minterm
	jr $ra					#go back into the loop
incrementCount:			
	addi	$t2 , $t2 , 1			#increments $t2 (number of minterms) by 1
	jr $ra					#go back into the loop