ThreeOperands = {"ADD","SUB","AND","OR",} # OPCODE,RD,RS1,Rs2,0
Rd_Rs1 = {"NOT","INC","DEC","MOV","LDD"} # OPCODE,RD,RS1,000,0
Rs1 = {"OUT","PUSH"} # OPCODE,000,RS1,000,0
Rd ={"IN","POP","JZ","JC","JMP","CALL"} # OPCODE,RD,000,000,0
noOperands = {"NOP", "SETC", "CLRC", "RET", "RTI"} # OPCODE,000,000,000,0

commands = {
"NOT":  "110000", #DONE
"INC":  "110010", #DONE
"DEC":  "110100", #DONE
"MOV":  "110110", #DONE
"ADD":  "111000", #DONE
"IADD": "111001", #DONE 
"SUB":  "111010", #DONE
"AND":  "111100", #DONE
"OR":   "111110", #DONE

"PUSH": "010000", #DONE
"POP":  "010010", #DONE
"LDM":  "010101", #DONE
"LDD":  "010110", #DONE
"STD":  "011000", #DONE

"JZ":   "100000", #DONE
"JC":   "100010", #DONE
"JMP":  "100100", #DONE
"CALL": "100110", #DONE
"RET":  "101000", #DONE
"RTI":  "101010", #DONE

"NOP":  "000000", #DONE
"SETC": "000010", #DONE
"CLRC": "000100", #DONE
"IN":   "000110", #DONE
"OUT":  "001000"  #DONE
}

operands = {
"R0":"000",
"R1":"001",
"R2":"010",
"R3":"011",
"R4":"100",
"R5":"101",
"R6":"110",
"R7":"111",
}

hexaToBinary = {
"0":"0000",
"1":"0001",
"2":"0010",
"3":"0011",
"4":"0100",
"5":"0101",
"6":"0110",
"7":"0111",
"8":"1000",
"9":"1001",
"A":"1010",
"B":"1011",
"C":"1100",
"D":"1101",
"E":"1110",
"F":"1111",
}

file1 = open('Commands.txt', 'r')
Lines = file1.readlines()
 

instructions = []
editedInstructions = []
# Strips the newline character
for line in Lines:
    instructions.append(line.strip())

file1.close()
for instruction in instructions: #remove commas
    instruction = instruction.replace(",", " ")
    instruction = instruction.split(" ")
    editedInstructions.append(instruction)

for instruction in editedInstructions: #remove empty strings
    for item in instruction:
        if item == "":
            instruction.remove(item)

BinaryInstructions = []
for instruction in editedInstructions:
    temp = ""
    if instruction[0] in noOperands:
        temp += commands[instruction[0]]
        temp += "0000000000"
        BinaryInstructions.append(temp)

    elif instruction[0] in ThreeOperands:
        temp += commands[instruction[0]] 
        temp += operands[instruction[1]]
        temp += operands[instruction[2]]
        temp += operands[instruction[3]]
        temp += "0"
        BinaryInstructions.append(temp)
    elif instruction[0] in Rd_Rs1:
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        temp += operands[instruction[2]]
        temp += "0000"
        BinaryInstructions.append(temp)
    elif instruction[0] in Rd:
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        temp += "0000000"
        BinaryInstructions.append(temp)
    elif instruction[0] in Rs1:
        temp += commands[instruction[0]]
        temp += "000"
        temp += operands[instruction[1]]
        temp += "0000"
        BinaryInstructions.append(temp)
    elif instruction[0] == "STD": #STD RS2,RS1
        temp += commands[instruction[0]] #opcode
        temp += "000" #RD
        temp += operands[instruction[2]]   #RS1
        temp += operands[instruction[1]]   #RS2
        temp += "0"
        BinaryInstructions.append(temp)
    elif instruction[0] == "IADD": #IADD RD,RS1, immediate
        temp += commands[instruction[0]] #opcode
        temp += operands[instruction[1]] #RD
        temp += operands[instruction[2]] #RS1
        temp += "0000"
        BinaryInstructions.append(temp)
        immediate = ""
        for char in instruction[3]:
            immediate+=hexaToBinary[char]
        BinaryInstructions.append(immediate)
 
    elif instruction[0] == "LDM": #LDM RD, immediate
        temp += commands[instruction[0]] #opcode
        temp += operands[instruction[1]] #RD
        temp += "0000000"
        BinaryInstructions.append(temp)
        immediate = ""
        for char in instruction[3]:
            immediate+=hexaToBinary[char]
        BinaryInstructions.append(immediate)

file1 = open('binaryCommands.txt', 'w')
#mem load -filltype value -filldata {1000010000010000} -fillradix binary /processor/Instruction/ram(0)
for i,instruction in enumerate(BinaryInstructions):
    file1.write(f"mem load -filltype value -filldata {{{instruction+' '}}} -fillradix binary /processor/fetchStagee/instructions/ram({i})\n")


file1.close()
