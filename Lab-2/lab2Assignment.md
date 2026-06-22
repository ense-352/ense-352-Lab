# Lab-2 Assignment

## Procedure

As in Lab 1, accept your assignment, create a new project and put the project under revision control.

### Background
We have been introduced to a number of new assembly instructions:

- BL - Branch with Link (Call a subroutine) and store the return address in the LR 2. B - Branch
- BX LR - Return from a subroutine.
- PUSH Reg.. - Push multiple Registers to the stack
- POP Reg.. - Pop multiple Registers from the stack.
- LDR Rt, label - Load register from memory LDR, PC-relative


### Phase 1
- From last week, start a project.
- Load any three general purpose registers with 0x00001111 and 0x00002222 and 0x00003333. Push these values to the stack one at a time using the PUSH command. Observe the stackpointer as you do this. Is the stack pointer going up or down?
- Open a memory window under View ->. Open the location that the Stack Pointer is at. Look at the memory values and how they contrast to the register values.
- Pop these registers off the stack and observe the Stack Pointer.
- Repeat the process but use multiple PUSH and POP’s on one line.


### Phase2
Now continue to build your program that has the following features:
- Store an integer in a register.
- Create a subroutine that will calculate the factorial of this integer and store it in a register. After returning from this subroutine, demonstrate you have calculated the factorial by debugging and investigate the register.

### Phase3
Now continue to build your program that has the following features:
- Store two strings ”ENSE 352 is fun and I am learning ARM assembly!” and ”Yes I really love it!”
- Your program will count the vowels of these two strings and store that count in a register that is available in the main part of your program.
- Your program shall have a subroutine named countVowels.
- Your program shall count both upper case and lower case vowels as the same vowel.


### Submission
Make sure you have commited your latest solution and pushed it to your repository for grading.