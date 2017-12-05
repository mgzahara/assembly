#########################################################
#       This program was written by Matt Zahara         #
#       to calculate all primes less than a given	#
#       number read from keyboard input			#
#########################################################

.init _main                     # denotes where to begin executing
.segment 32768

#r10 -> keyboard input
#r11 -> main loop counter
#r12 -> testPrime() stop con
#r13 -> testPrime() loop counter
#r14 -> mod result for checkFactor()
_main:
	lda r9, $1		#const 1
	ldf f9, floatOne	#const 1.0
	lda r11, $0		#start i at 0

	lda r50, $prompt	#prompt user for input
	call _printstr

	call _geti		#get user input

	mov r10, r2		#hold user input from r2

	lda r50, $primes	#separate output from keyboard input
	call _printstr

###inc main counter to 2 because 1 is not prime
	
### handle 2 prime status
	#then set main counter to 3

	
#for(int i = 1 | i <= n | i++)
mainTop:	

	add r11, r11, r9	#i++

	
#for(int j = 2 | j < i | j++)
testPrime:
###incriment j by 2 to cut out checking all even numbers
	
	beq r11, r9, afterTestPrime	#cannot check prime status of 1
	cvtif f59, r11	#convert main counter to float
	call _sqrt	#find square root of main counter
	cvtfi r12, f2	#stopping con is now square root of main counter

	mov r13, r9	#j = 1


testPrimeTop:	
	add r13, r13, r9	#j++
	beq r13, r11, foundPrime	#edge case of 2

#checkFactor.s
	
	mod r14, r11, r13	#r14 = r11 % r13 - if zero, r11 is NOT prime
#if the mod is ZERO, then main counter is NOT prime, jump to afterTestPrime
	beq r14, r0, afterTestPrime	#mod == 0 -> r11 is NOT prime

	bne r13, r12, testPrimeTop	#loop while possibleFactor < primeInQuestion
foundPrime:	

	mov r59, r11
	call _printint

	lda r50, $newl
	call _printstr

afterTestPrime:	
	bne r11, r10, mainTop	#while mainCounter != keyboardInput

end:
	exit
	

floatZero:	.float 0.0
floatOne:	.float 1.0
prompt:		.string "Please enter an integer.\n"
newl:		.string "\n"
foundP:	.string "\nfound a Prime!\n"
primes:	.string "\nprimes:\n-------\n"
