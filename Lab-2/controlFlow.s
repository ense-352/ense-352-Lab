; Put your name and a title for the program here

;;; Directives
  PRESERVE8
  THUMB  
			
			
;;; Equates

INITIAL_MSP	EQU		0x20001000	; Initial Main Stack Pointer Value	Allocating 
								              ; 1000 bytes to the stack as it grows down.
			     
								    
; Vector Table Mapped to Address 0 at Reset
; Linker requires __Vectors to be exported

  AREA    RESET, DATA, READONLY
  EXPORT  __Vectors

__Vectors	DCD		INITIAL_MSP			; stack pointer value when stack is empty
        	DCD		Reset_Handler		; reset vector
	 		
  ALIGN

;The program
; Linker requires Reset_Handler

  AREA    MYCODE, CODE, READONLY



  ENTRY
  EXPORT	Reset_Handler

  ALIGN
			
Reset_Handler	PROC
                                

  MOV R0, #0x3355
  PUSH {R0}  			; Notice the stack at 0x200000FF8  (Contains R1 then LR ) Little endian
  MOV32 r0, #0xDEADBEEF
  PUSH {R0}
  POP {R4}

  MOV R0, #0x00
Loop

  ADD	R0, #1
  CMP	R0, #4
  BNE	Loop

Start

  MOV R0, #9	;; Just an extra line

  BL function1
	
  MOV R0, #9	;; Another extra line
		
  BL function2

  LDR		R0, = string1       ;Loading the address of string1 into the R0 address
		
  BL  vowelCount
		
  B Start
  ENDP         


  ALIGN
function1  PROC

	;; This is the guts of the subroutine
		
  BX LR

  ENDP



  ALIGN
function2	PROC  ;Using this PROC and ENDP like curly braces 
  PUSH 	{R1,LR}	  
  MOV   R1,#4
		
delay
  SUBS	R1, #1
  BNE	  delay

  POP {R1,PC}
  
  ENDP

  ALIGN
string1
	  DCB		"ENSE 352 is fun and I am learning ARM assembly!",0


;Input : R0  - This contains the address of the beginning of a char array

  ALIGN
vowelCount  PROC
  PUSH {R1}
  LDRB	R1,[R0]
		
		
  POP {R1}
  BX LR

  ENDP

  END
