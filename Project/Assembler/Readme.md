# Assembler comments
## How to run 
### Option 1
1. Put the files in python environment.
2. Navigate to the directory where "Assembler.py" is found.
3. Make sure that "Commands.txt" exists in the same directory.
4. Write the following command in the terminal. 

``` 
$ python Assembler.py
```
### Option 2
1. Run the "Assembler.exe" file
2. Make sure that "Commands.txt" exists in the same directory
---
## Output format
We export a .do file to be used in modelsim to force memory values.

---
## Used OPCodes
```json
"NOT":  "110000",
"INC":  "110010",
"DEC":  "110100",
"MOV":  "110110",
"ADD":  "111000",
"IADD": "111001", 
"SUB":  "111010",
"AND":  "111100",
"OR":   "111110",

"PUSH": "010000",
"POP":  "010010",
"LDM":  "010101",
"LDD":  "010110",
"STD":  "011000",

"JZ":   "100000",
"JC":   "100010",
"JMP":  "100100",
"CALL": "100110",
"RET":  "101000",
"RTI":  "101010",

"NOP":  "000000",
"SETC": "000010",
"CLRC": "000100",
"IN":   "000110",
"OUT":  "001000" 
```
## Used Operands
#### RD, RS1, RS2
```json
"R0":"000",
"R1":"001",
"R2":"010",
"R3":"011",
"R4":"100",
"R5":"101",
"R6":"110",
"R7":"111",
```

# Given testcase
```python
.org 0                        # means the next line is at address 0 (hex)
100                           # data value 100hex so memory content M[0]=100h
.org 1
20                            # data value 20hex so memory content M[1]=20h

.org 20
SETC                          # this instruction should be at address 20h
NOT R1,R2                     # this instruction should be at address 21h
INC R2,R3                     # this instruction should be at address 22h
IADD R3,R2,100                # this instruction should be at address 23h & 24h, 100 is hex format (256 decimal)
RTI                           # this instruction should be at address 25h

.org 100
IN R1                         # this instruction should be at address 100h
INC R1,R1                     # this instruction should be at address 101h
PUSH R1                       # this instruction should be at address 102h
POP R2                        # this instruction should be at address 103h
LDM R3, 30                    # this instruction should be at address 104h & 105h, 30 is 30h 
JMP  R3                       # this instruction should be at address 106h


.org 30
NOT  R4,R4                    # this instruction should be at address 30H
```