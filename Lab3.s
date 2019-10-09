;ARM1.s Source code for my first program on the ARM Cortex M3
;Function Modify some registers so we can observe the results in the debugger
;Author - Dave Duguid
;Modified August 2012 Trevor Douglas
; Directives
	PRESERVE8
	THUMB
		
; Vector Table Mapped to Address 0 at Reset, Linker requires __Vectors to be exported
	AREA RESET, DATA, READONLY
	EXPORT 	__Vectors


__Vectors DCD 0x20002000 ; stack pointer value when stack is empty
	DCD Reset_Handler ; reset vector
	
	ALIGN


;My program, Linker requires Reset_Handler and it must be exported
	AREA MYCODE, CODE, READONLY
	ENTRY

	EXPORT Reset_Handler
		
	ALIGN
Reset_Handler  PROC ;We only have one line of actual application code

	MOV R0, #3;
	
	
	
	
	;Calling factorial Subroutine.
	BL factorial
	
	;initializing R2 (the vowel counter)
	MOV R2, #0;
	;Store string1 to R0;
	LDR R0,=string1
	;Calling my vowelCount Subroutine for string1.
	BL vowelCount
	
	MOV R2,#0;
	;stroe string2 to R0;
	LDR R0,=string2
	;Calling vowelCount Subroutine for string2.
	BL vowelCount


	B Reset_Handler
	
	; This is the ENDP for my Reset Handler.
	ENDP

	; I should never end up here so  I can put my String data here.
string1
	DCB		"ENSE 352 is fun and I am learning ARM assembly!",0



	;Subroutine factorial
	;Input is R1 (number to calculate factorial)
	;Return value is R2
	ALIGN
factorial PROC
	MOV R1,R0
	SUB R1,R1,#1
	MUL R2,R1,R0
	
	;loop that substracts R1 with 1, mul R2 by R1 and compare R2 with 1 to see if the factorial is done.
factorial_loop
	SUB R1,#1
	MUL R2,R2,R1
	
	CMP R1,#1
	BNE factorial_loop
	
	BX LR
	ENDP
		
	;Subrouting vowelCount.
	;Input is R1 (the first byte of the string being incremented)
	ALIGN
vowelCount	PROC
	
	;the loop compare compares R1 with the vowels to see if it's a vowel
compare
	LDRB R1, [R0] ;taking the first byte of in memory and storing it in R1
	
	;Comparing R1 with lower case and upper case vowels and if it;s a vowel calls vowelcounter to store the number of vowels in the string
	CMP R1, #'A'
	BEQ vowelCounter
	CMP R1, #'E'
	BEQ vowelCounter
	CMP R1, #'I'
	BEQ vowelCounter
	CMP R1, #'O'
	BEQ vowelCounter
	CMP R1, #'U'
	BEQ vowelCounter
	CMP R1, #'a'
	BEQ vowelCounter
	CMP R1, #'e'
	BEQ vowelCounter
	CMP R1, #'i'
	BEQ vowelCounter
	CMP R1, #'o'
	BEQ vowelCounter
	CMP R1, #'u'
	BEQ vowelCounter

	;if it's not a vowel
	ADD R0,R0,#1
	CMP R1, #0
	BNE compare
	BEQ done
	
vowelCounter 
	
	ADD R2,R2,#1
	CMP R0, #0
	ADD R0,R0, #1
	BNE compare

done	
	BX LR
	
	ENDP
		

	
	


	;I should never end up here either.
string2
	DCB		"Yes I really love it!",0
		
	END