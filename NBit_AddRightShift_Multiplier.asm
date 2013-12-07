#N-bit Add-and-Right-Shift Multiplier developed in MIPS
#Multiplies 2 N-bit numbers using a Add-and-Right-Shift Multiplier
#Displays each partial product of the process 
#Created By Andre Compagno
	.data
text:			.asciiz	"Iter\tProd_ten\tProd_two\n"
textN:			.asciiz "Enter the value of n: "
textMultiplicand:	.asciiz	"Enter the multiplicand: "
textMultiplier:		.asciiz	"Enter the multiplier: "
	.text
main:
	li	$t0 , 0						#iterator is set to 0
	li	$t2 , 0						#product is initalized to 0
	userInput:	
		li	$v0 , 4					#syscall 4 -> print string 
		la	$a0 , textN				#loads string textN to be printed
		syscall						#prints string prompting the user to input the value of n
		li	$v0 , 5					#syscall 5 -> read int
		syscall						#read the users input
		add 	$t1 , $zero , $v0			#save the input to $t1
		li	$v0 , 4					#syscall 4 -> print string 
		la	$a0 , textMultiplicand			#loads string textMultiplicand to be printed
		syscall						#prints string prompting the user to input the multiplicand
		li	$v0 , 5					#syscall 5 -> read int
		syscall						#read the users input
		add 	$s0 , $zero , $v0			#save the input to $s0
		sllv	$s2 , $s0 , $t1 			#shift the input by n this will be used later
		li	$v0 , 4					#syscall 4 -> print string 
		la	$a0 , textMultiplier			#loads string textMultiplier to be printed
		syscall						#prints string prompting the user to input the multiplier
		li	$v0 , 5					#syscall 5 -> read int
		syscall						#read the users input
		add 	$s1 , $zero , $v0			#save the input to $s1		
	printTitles:
		li	$v0 , 4					#syscall 4 -> print string 
		la	$a0 , text				#load string text to be printed
		syscall						#print the string
	multLoop:
		andi	$t3 , $s1 , 1				#get the lsb of the multiplier
		beq	$t3 , $zero , zero			#check if its 0
			one:				
				add	$t2 , $s2 , $t2		#if the lsb of the multiplier is 1 add the shifter multiplicand to the product
			zero:	
				srl 	$t2 , $t2 , 1		#shift the product to the right by 1
				srl	$s1 , $s1 , 1		#shift the multiplier to the right by 1
				addi	$t0 , $t0 , 1		#increment the iterator by 1
				jal 	printIO			#jump and link to printIO subroutine
				bne	$t0 , $t1 , multLoop	#check for end of loop, if its not jump back to the beginning		
exit:
	li	$v0 , 10 					#syscall 10 -> exit program
	syscall							#exit the program
printIO:		
	li	$v0 , 1						#syscall 1 -> print int
	add	$a0 , $t0 , $zero 				#load the iterator to be printed
	syscall 						#print the iterator
	li	$v0 , 11					#syscall 11 -> print char
	li	$a0 , 9 					#load a \t char to be printed
	syscall							#print the tab
	li	$v0 , 1						#syscall 1 -> print int
	add	$a0 , $t2 , $zero 				#load the current product to be printed
	syscall 						#print the current product
	li	$v0 , 11					#syscall 11 -> print char
	li	$a0 , 9 					#load a \t char to be printed
	syscall							#print the tab
	syscall							#print the tab
	printCrop:
		li	$v0 , 1					#syscall 1 -> print int
		sll	$t4 , $t1 , 1				#set t4 to n*2 our iterator 
		add	$t6 , $t2 , $zero			#set $t6 to the product being printed 
		printCropLoop:
			addi	$t4 , $t4 , -1			#decrement t4 by one 
			srlv 	$t5 , $t6 , $t4			#shift t6 by the current value of t4
			andi	$t5 , $t5 , 1 			#grab the lsb 
			add	$a0 , $t5 , $zero		#load the lsb to be printed 
			syscall					#
			bne	$t4 , $zero , printCropLoop
	li	$v0 , 11					#syscall 11 -> print char
	li	$a0 , 10 					#load a \n char to be printed
	syscall							#print the newline char
	jr	$ra						#jump back to main code