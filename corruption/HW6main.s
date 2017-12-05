

.init _main

.segment 32768		# Start of code

_main:
					# 0 - Index
					# 4 - Terminator
					# 8 - Location of buffer
					# 12 - Random Value
					

	# Some init stuff for my variables
	sub	sp, sp, $16
	lda	r10, $3
	stw	r10, $0(sp)
	
	lda	r10, $243
	stw	r10, $4(sp)

	lda	r10, $1

	lda	r60, $65536
	call	_randomMod
	stw	r2, $12(sp)
	add	r20, r2, r60		# r20 = 65536 + rand(65536)
	stw	r20, $8(sp)
	lda	r20, $0


	ldw	r40, $8(sp)
	call	memcpy
	
	sub	sp, sp, $12
	stw	r10, $0(sp)
	stw	r20, $4(sp)
	stw	r60, $8(sp)
	lda	r60, $0		
	call	StudentCode
	ldw	r10, $0(sp)
	ldw	r20, $4(sp)
	ldw	r60, $8(sp)
	add	sp, sp, $12


	# Run my loop
	ldw	r11, $0(sp)
	ldw	r12, $4(sp)
maintop:
	mov	r59, r10
	call	_printint
	lda	r50, $nl
	call 	_printstr
	mul	r10, r10, r11
	ble	r10, r12, maintop


	ldw	r40, $8(sp)
	call	memcpy


	ldw	r50, $8(sp)
	call	_printstr

	call 	control

	add	sp, sp, $16
	exit


###########################################################################
#
# Code and code addresses below this point are subject to change without
# notice or warning.  Well, lets be honest.  What is really going to happen
# is that I'm going to grade your StudentCode.s with a different version of
# this file than what I am providing you with.  Of course, if you did the 
# assignment correctly, then that shouldn't matter.  If you took shortcuts...
#
############################################################################
.segment 48000		# Note to students, these two locations WILL change
memcpy: 
	lda r50, $debug
	call _printstr

	lda	r41, $49000
memtop:
	ldw	r45, $0(r41)
	stw	r45, $0(r40)
	add	r40, r40, $1
	add	r41, r41, $1
	bne	r45, $0, memtop
	lda	r40, $0
	lda	r41, $0
	ret
	


control:
	lda	r50, $nl
	call	_printstr

	lda	r50, $nl
	call 	_printstr

	lda	r50, $msg
	call	_printstr

	lda 	r50, $line
	call	_printstr

	lda	r50, $text
	call 	_printstr

	lda 	r50, $line
	call	_printstr

	ret
	

.segment 49000		# This location could change! Too bad for you
text:	
			# This string might even change!  It's kinda lame.
			# Of course, the first print that you do shouldn't be
			# this anyways! (But the control better still show what
			# it is supposed to!)
.string	"Hello World\nIf any of this shows up on your screen in the first test then you are out\nof luck!  Here are a bunch more bits of text that you will have to deal with.\nTyping is a lot of fun, isn't it?  Computers are great.\nLook another line of stuff that you can't see.\nEven more here.\nLife is so hard, isn't it?\nSo, I guess I will stop typing now so that I can get on with writing the rest\nof this assignment up.  Enjoy!\n"

msg:
.string	"Original comment block for testing purposes:\n"
nl:
.string "\n"
line:
.string "---------------------------------------------\n"
debug:
.string "\n memcpy called \n"
.segment 65536
.space 65536
