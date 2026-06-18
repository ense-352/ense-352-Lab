---
marp: true
theme: default
paginate: true
title: Introduction to ARM
author: Trevor Douglas
---

# 🚀 Lab 2 - Control Flow Statements  

The objective of this lab is to introduce the students to ARM assembly using control flow statements and instructions.
  
👨‍💻 
Trevor Douglas
SSE Lab Instructor

---
## Program Counter - R15

- The Program Counter is a register that contains the address of the current instruction.
- During normal logical flow the Program Counter increments according to the instructions implemented in order.
- After a branch or subroutine call the Program Counter will contain the “jumped to “ address.
- You are able to access this register from your code by using R15 or PC.


---
### The Stack

- Remember the stack pointer (R13) points to the top of stack.
- A typical stack is an area of computer memory with a fixed origin and a variable size. 
- A stack pointer, usually in the form of a hardware register, points to the most recently referenced location on the stack
- A stack is used to hold information as your program runs.  
 
 It is also used to:
 - Keep track of where you were during a branch or sub routine call.
 - Pass parameters to subroutines. 
 - Anything you would like saved.


---
### Push Operation
The two operations applicable to all stacks are:
- a push operation, in which a data item is placed at the location pointed to by the stack pointer, and the address in the stack pointer is adjusted by the size of the data item.  Push {R1},  or Push{R1,R2,R3}


#### Example
```assembly
    R0 = 0x11111111
    R1 = 0x22222222
    R2 = 0x33333333
    SP = 0x20001000   ; stack starts here (full descending stack)

    PUSH {R0, R1, R2} 
```


---
### Push Operation

#### Final Stack State
```assembly
    SP = 0x20000FF4

    Address         Value
    -------------------------
    0x20000FF4     0x33333333  (R2)
    0x20000FF8     0x22222222  (R1)
    0x20000FFC     0x11111111  (R0)
```
---
### Pull Operation

- a pop or pull operation: a data item at the current location pointed to by the stack pointer is removed, and the stack pointer is adjusted by the size of the data item. Pop {R1}, or Pop{R1,R2,R3}


```assembly
    POP {R0, R1, R2}

    R2 = 0x33333333
    R1 = 0x22222222
    R0 = 0x11111111


    SP = 0x20001000   ; stack back to the start
```

---

### Sample Stack
<table>
  <tr>
    <td> <img src="res/Stack.png"  alt="Stack" width = 364px height = 432px ></td>
  </tr>
</table>

---
### Looping example

```assembly

  MOV  R0, #0    ;initialize R0 as our counter

  ;Start of the loop
Start
  
  ; Stuff you may want to do in your loop

  
  ADD   R0, #1      ; Increment the counter
  CMP   R0, #16     ; How many times to loop
  BNE    Start      ; Loop back if not done


  ;What about checking R0 being zero or not zero using the Z flag:


  CBZ	R0, loopZero
  ;; or
  CBNZ	R0, loopNotZero

```

---
### Link Register R14 and Subroutines

The link register is used to store the return program counter  when a subroutine or function is called.  To Branch (or call) a subroutine using the Branch and update Link Register.

```assembly
  BL function   ; Branch to a subroutine and place the return address in the Link Register.
                ; The Link Register will contain the address of the code after the Branch
                ; instruction.



function        ; This is the label or name of the subroutine.

  BX LR         ; Branch back to the Link Register address.
```

---
### Another alternative to a subroutine call

```assembly

  ALIGN   ; Make sure we are on a 32 bit boundary

Delay	PROC            ; Delay is the name of the subroutine
  
  push	{R1,LR}   	  ; Push R1 and LR onto the stack
  MOV 	R1,#4         ; Initialize a counter

delay_loop            ; This is a loop ... NOT a SUBROUTINE
  
  subs	R1, #1        ; Decrement the counter
  bne	delay_loop
  
  pop	{R1,PC}	        ; I am dond, Pop off the stack into R1 and PC 
                      ; (PC will get the LR)
      
  ENDP                ; End the procedure

```
---
### My favorite way to call and write subroutines

``` assembly

  ; Setup any registers you want as inputs into the subroutine
  ;Call the routine like this
  BL  Delay

  ; Put the name of the subroutine here
  ; Indicate any inputs you are using
  ALIGN

Delay	PROC           ; Delay is the name of the subroutine.
  
  PUSH R1            ; I am using R1 so I should push it to the stack.  
  MOV 	R1,#4

delay_loop
  SUBS	R1, #1
  BNE	delay_loop
  
  POP R1
  BX  LR	
      
  ENDP

```
---

### Creating C Strings

This type of format will construct a C string and null terminate.  This means you can tell when the string ends.

``` assembly

String1                         ; This is the label of the string in memory.
  DCB	"ENSE 352 is fun!!!“,0    ; Dedicate some data nad NULL terminate.

```

Place this String Directive somewhere in your code that your PC will not address. In order to  access this string we can load the memory address where it is stored like so:

``` assembly
  LDR		R0, = String1   ;R0 now contains the address for the string

```
---
### Memory Access Instructions

_op{type}{cond} Rt, [Rn {, #offset}]_ ; Immediate offset

- ‘op’ is either LDR (load register) or STR (store register)
- ‘type’ is one of the following:
- B: Unsigned byte, zero extends to 32 bits on loads
- SB: Signed byte, sign extends to 32 bits (LDR only)
- H: Unsigned halfword, zero extends to 32 bits on loads
- SH: Signed halfword, sign extends to 32 bits (LDR only)
- ‘cond’ is an optional condition code (see Conditional execution on page 58)
- ‘Rt’ is the register to load or store
- ‘Rn’ is the register on which the memory address is based‘offset’ is an offset from Rn. If offset is omitted, the address is the contents of Rn

---
### Memory Access Example

How to transfer on byte of data from memory into a register.

``` assembly 
String1
  DCB	"ENSE 352 is fun!!!“,0   ;  This 0 indicates null terminate

  ;In order to  access this string we can load the memory address where it is stored like so:

  LDR		R0, = String1

  ;R0 now contains the address for the string

  LDRB		R1,[R0]   ;This will load one byte of data ... An 'E' !

```
---
### Ascii Code

Remember that when you are looking at characters or a string, they are represented by ASCII Code. So an ‘a’ is represented by 97 decimal or hexadecimal 0x61.

<table>
  <tr>
    <td> <img src="res/AsciiTable.png"  alt="Ascii" width = 508px height = 451px ></td>
  </tr>
</table>

---
### Memory Access Example
So if we wanted to check if a certain character was in a register

``` assembly
  CMP		R1, #’a’
  BEQ 		vowelDetected

```
And

``` assembly

  CMP		R1, #0x61
  BEQ		vowelDetected

```

Are equivalent.

---

