#########################################################
#	This program was written by Matt Zahara		#
#	for the estimation of the irrational		#
#	constant e using limit notation			#
#########################################################

.init _main                     # denotes where to begin executing
.segment 32768

#(1 + (1 / x)) ^ x

#f12 is main loop counter
#f13 is e
#f14 is "function" input
#f15 is reserved for "function" counter
#f16 is reserved for "fucntion" calc
#f17 is reserved for "function" total
#f18 is const 100,000.0


	
_main:

	lda r9, $1		#set const 1 int
	ldf f9,  floatOne	#set const 1 float
#	mov r10, r0		#set coutner to zero
	ldf f12, floatZero	#set outer counter to zero
	ldf f13, e		#set const e with 5 decimal places
	ldf f18, V		#set const 100,000.0

top:	
#	lda r50, $colon
#	call _printstr

	addf f12, f12, f9	#counter++
#	movf f59, f12		#print x for this iteration
#	call _printfloat

#	lda r50, $colon
#	call _printstr

	movf f14, f12		#set input for "function"
	jmp callCalc		#"call function"
return:
	#at this point, f17 will hold the approximation of e for this iteration

#	movf f59, f17		#print approximation for this iteration
#	call _printfloat

#	lda r50, $newl
#	call _printstr
	
trunc:	
###truncation

	mulf f17, f17, f18
	cvtfi r17, f17
	cvtif f17, r17
	divf f17, f17, f18

	eqf f15, f17, f13	#test truncated approx
	jzf f15, top		#not good enough, try again

	movf f59, f17
	call _printfloat

	lda r50, $newl
	call _printstr
	
	cvtfi r10, f12

	mov r59, r10		#prepare print of iterations
	call _printint

	lda r50, $itr
	call _printstr

end:
	exit


###########################
#	"function"	  #
###########################

callCalc:
	
#f14 half of comparison for pre-test loop - main counter -> input
#f15 is the other - local counter
#intermidiate calculations should be done within f16
#f17 us running total cor current loop

### 1/x
	divf f16, f9, f14	#f16 = 1 / x
### 1 + (1 / x)
	addf f16, f9, f16	#f16 = 1 + (1 / x)
### total thus far
	movf f17, f16		#f17 = f16 -> efectively running the loop once
### inner counter
	movf f15, f9		#inner counter = 1

localTop:	
	eqf f21, f14, f15	#check if we have run the loop the desired amount of times
	jnzf f21, return	#they are equal, we are done


	mulf f17, f17, f16	#increase exponent by 1
	addf f15, f15, f9	#counter++

	jmp localTop

	
	
error1:	.string "\ninner loop error\n"
error2:	.string "\nouter loop error\n"
itr:	.string " iteration(s)\n"
floatOne:	.float 1.0
floatZero:	.float 0.0
V:	.float 100000.0
e:	.float 2.71828
stop:	.float 11.0
floatHuge:	.float 10.0
intHuge:	.int 10
colon:	.string " : "
newl:	.string "\n"
bar:	.string "----------------------\n"
head1:	.string "start of OUTER loop\n"
head2:	.string "start of INNER loop\n"