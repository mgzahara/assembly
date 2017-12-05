.init _main			# denotes where to begin executing
.segment 32768

#-3920 + 7088x - 3860x^2 + 745x^3 - 50x^4 + x^5


_main:
### load up coeffs ###
	lda r22, $-3920		#const
	lda r23, $7088		#x   coeff
	lda r24, $-3860		#x^2 coeff
	lda r25, $745		#x^3 coeff
	lda r26, $-50		#x^4 coeff

### load starting info ###
	lda     r10, $1		#start at 1, also the X value each time
	lda     r11, $41	#while less than 41
	lda     r12, $1		#Increment
	
	lda 	r28, $38527
    ldah 	r28, $152			#largest  int allowed to have 2 tabs (9,999,999)

	lda		r29, $16959
	ldah	r29, $15			
	sub 	r29, r0, r29	 	#smallest int allowed to have 2 tabs (-999,999)


    lda     r50, $title	#prepare title
    call    _printstr	#print title for output


top:
	beq     r10, r11, end	# Jump out if done, pre-test loop

### calc polynomial values ###
	mov r14, r10		#hold value of x
	mul	r15, r10, r10	#r15 = x^2
	mul	r16, r15, r10	#r16 = x^3
	mul	r17, r15, r15	#r17 = x^4
	mul r18, r17, r10	#r18 = x^5


### add coeffs ###
	mul r17, r17, r26	#r17 is now 50x^4
	mul r16, r16, r25	#r16 is now 745x^3
	mul r15, r15, r24	#r15 is now 3860x^2
	mul r14, r14, r23	#r14 is now 7088x


### make total ###
	mov r19, r18		#hold x^5
	add r19, r19, r17	#add -50x^4
	add r19, r19, r16	#add 745x^3
	add r19, r19, r15	#add -3860x^2
	add r19, r19, r14	#add 7088x
	add r19, r19, r22	#add -3920


### calc 4x ###
	mov r20, r10
	mul r20, r20, $4


### print output ###
print:
	mov r59, r10
	call	_printint
	lda r50, $tab1
	call 	_printstr

	mov r59, r20
	call	_printint
	lda r50, $tab1
	call 	_printstr

	mov r59, r19
	call	_printint

	bgt	r19, r28, oneTab	#branch if output is "too big"
	blt r19, r29, oneTab	#branch if output is "too small"

	lda r50, $tab2
	call 	_printstr

afterTabs:

### determine equalality to 4x ###
	beq r20, r19, equal
	
	lda r50, $notGood
	call 	_printstr

afterEqual:
	lda r50, $newl
	call	_printstr


### maintainence for loop ###
	add     r10, r10, r12	# Increment the counter
	jmp     top				# jump back to loop test

### end of loop ###


equal:
	lda r50, $good
	call 	_printstr
	jmp		afterEqual

oneTab:
	lda r50, $tab1
	call	_printstr
	jmp 	afterTabs


end:
	exit

newl: .string "\n"
tab1:    .string "\t"
tab2: 	 .string "\t\t"
title:   .string "x\t4x\tOut\t\tDetermination\n---------------------------------------------\n"
good:	.string "Equal"
notGood: .string "Not Equal"