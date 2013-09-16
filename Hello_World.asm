#Hello World program 
#Prints hello world using a loop
#Created By Andre Compagno
		.data 
helloWorld:	.asciiz		"Hello, World!"
newLine:	.asciiz 	"\n"
	.text 
main: 
	#PRINT HELLO WORLD WITH THE
	#li 	$v0, 4 
	#la 	$a0, helloWorld 
	#syscall
	
	#SET UP VALUES USED IN LOOPS 
	li 	$t0 , 0 	#Iterator
	li	$t1 , 13	#Loop limit
	
	#LOAD THE ADDRESS OF THE ARRAY 
	la	$t2 , helloWorld
	
	#PRINT HELLO WORLD WITH A LOOP
	loop:
		#IF $T0 == $T1 JUMP TO "EXIT"
		beq	$t0 , $t1 , exit
		
		#MOVE ARRAY TO CERTAIN INDEX AND STORE THE POINTER TO THAT INDEX IN $T4
		add	$t4 , $t2 , $t0
		
		#LOAD CHAR TO BE  PRINTED AND PRINT IT WITH SYSTEM CALL 11
		lb    	$a0 , 0($t4) 
		li    	$v0 , 11        			
		syscall  
		
		addi	$t0 , $t0 1
		
		j loop
exit:
	li	$v0 , 10					#System call 10 -> exit program	
	syscall 						#System Call
