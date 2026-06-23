---
marp: true
theme: default
paginate: true
title: Bit Masking
author: Trevor Douglas
---

# 🚀 Lab 3 - Bit Masking  

The objective of this lab is to introduce the students to bit manipulation and bit masking using the ARM instruction set.
  
👨‍💻 
Trevor Douglas
SSE Lab Instructor

---

## Bit Shifting

## Instructions

- **ASR** — arithmetic shift right
- **LSL** — logical shift left
- **LSR** — logical shift right
- **ROR** — rotate right
- **RRX** — rotate right with extend

**Flags affected:** N, Z

---

## Examples: Bit Shifting

```armasm
MOV R0, #1
LSL R0, R0, #3
```

Result:

```
00000001  ->  00001000
```

---
## Isolating Bits (Masking)

- Very important for embedded programming.
- Often referred to as **masking**.
- Affect only the bit you are interested in.
- Utilize the **AND** and **ORR** instructions.

---
## Example: Determine the state of bit 1 in R0

```armasm
AND R2, R0, #0x2.  ;This isolates bit 1 and clears all other bits.
CMP R2, #0x2.      ;Compare the register
BEQ bitIsSet       ;If true then that bit is set

;; if it is not equal the above statement will fail and will fall to this spot.

;; Somewhere later in the code
bitIsSet:

```

---
## Isolating Bits (Setting a Bit)

- Set a bit without affecting the other bits.
- Use the **ORR** instruction.

## Example: Set bit 1 in R0

```armasm
ORR R0, R0, #0x2
```

Result: bit 1 is forced to **1** while all other bits remain unchanged.

---

## Tip -  If you need to mask with a value larger than 8 bits, use a register:

```armasm
LDR R3, =0xFFFFFFFE  ;Load the mask value
AND R2, R0, R3
```
---

