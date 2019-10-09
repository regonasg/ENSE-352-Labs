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


Reset_Handler ;We only have one line of actual application code

	LDR R1, = 0x0000FFFF;
	LDR R2, = 0x88880000;
	PUSH {R1};
	PUSH {R2};
	
	MOV R0, #0x76 ; Move the 8 bit Hex number 76
	LDR R1, = 0x00000001 ;
	LDR R2, = 0x00000002 ; 
	ADDS R3,R1,R2; 
	
	LDR R2, = 0xFFFFFFFF;
	ADDS R3,R2,R1; 
	
	PUSH {R1,R2,R3}
	LDR R1, = 0x2;
	ADDS R3,R1,R2;
	LDR R1, = 0x7FFFFFFF;
	LDR R2, = 0x7FFFFFFF;
	ADDS R3,R2,R1;
	
	B Reset_Handler;
	
	
	



	ALIGN

	END