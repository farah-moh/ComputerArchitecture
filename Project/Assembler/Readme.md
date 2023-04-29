# Assembler comments
## How to run 
1. Put the files in python environment.
2. Navigate to the directory where "Assembler.py" is found.
3. Make sure that Commands.txt exists in the same directory.
4. Write the following command in the terminal. 

``` 
$ python Assembler.py
```
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
