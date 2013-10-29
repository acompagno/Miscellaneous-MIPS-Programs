#Stack Example Program
#Populates a stack and then prints its contents 
#Created By Andre Compagno
	.text
main:
	li	$t0 , 0						#loop iterator
	li	$t1 , 10					#loop limit
	addi	$s0 , $sp , 0					#saves starting point of the stack to $s0
	addi	$sp , $sp , -4					#prep stack pointer
	loopPopulateStack:				#populates the stack with the integers 0-9
		sw	$t0 , 0($sp)				#saves a value to the current spot in the 
		addi	$t0 , $t0 , 1				#increment $t0 by 1
		beq	$t1 , $t0 , loopPrintStackData		#if $t0 == $t1 loop is done
		addi	$sp , $sp , -4 				#allocate more space in the stack
		j	loopPopulateStack			#jump back to begining of the loop
	loopPrintStackData:				#prints the contents of the stack
		beq	$s0 , $sp , exit			#if the stack is empty terminate the loop
		li	$v0 , 1					#load 1 into $v0 (System call 1 -> print integer)
		lw	$a0 , 0($sp)				#load value from the stack 	
		syscall						#system call
		jal	printNewLine				#jump and link to printNewLine 
		addi	$sp , $sp , 4 				#remove memory from the stack
		j loopPrintStackData				#jump back to beginning of the loop 
exit:							#exit program
	li	$v0 , 10					#load 1 into $v0 (System call 10 -> exit program)
	syscall							#system call
printNewLine:						#simply prints a newline character
	li	$v0 , 11					#load 11 into $v0 (System call 11 -> print character)
	li	$a0 , 10					#load 10 into $a0 (10 = newline character )
	syscall							#system call
	jr	$ra						#jump back to code 