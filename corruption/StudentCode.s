
.segment 20000
### NOP -> lda  reg, $0
### and -> ldah reg, $34304

StudentCode:

### change the value at $24(sp), point it to myText
	ldau r10, $myText
	stw r10, $24(sp)

### load NOP
	lda r10, $0
	ldah r10, $34304

### load return location
	ldw r11, $0(sp)

### store NOP at loc of memcpy call
	stw r10, $56(r11)
	
	ret

.segment 200000
myText:		.string
"\nAgent Smith Rules! Professor Smith was here.
	One way to prevent stack smashing is to forgo the Von Neumann architecture. Contain all data
within a non-exectuable buffer. If the program cannot execute code injected, the only problem is
data integrity. You may also, and should, do proper bounds checking on all arrays, just dont read in
past the size of the array. This is good practice to prevent buffer overflow attacks, but also to
prevent a segmentation fault. Buffer overflows result from a lack of type safety in C, so a natural
way to combat this is by using a type safe language, like Java, for any security sensitive operations.
Lastly, you could check the integrity of your pointers; both arrays and return addresses on the 
stack. Pointer integrity checking doesn't stop an attacker from performing a buffer overflow, 
but rather, prevents your code from ever running it by flagging any tampered pointers and refusing 
to use them.
	All information above was referenced from Crispin Cowan, Perry Wagle, Calton Pu, Steve Beattie,
	and Jonathan Walpole via section 3 of Buffer Overflows: Attacks and Defenses for the Vulnerability
	of the Decade out of Oregon Graduate Institute of Science & Technology."