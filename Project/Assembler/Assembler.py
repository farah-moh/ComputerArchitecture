ThreeOperands = {"ADD","SUB","AND","OR",} # OPCODE,RD,RS1,Rs2,0
Rd_Rs1 = {"NOT","INC","DEC","MOV","LDD"} # OPCODE,RD,RS1,Rs1,0
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
file2 = open('binaryCommands.do', 'w')
file2.write("")
file2.close()
file2 = open('binaryCommands.do', 'a')


def check_org(instruction):
        global org
        global file2
        file2.write(f"mem load -filltype value -filldata {{{instruction+' '}}} -fillradix hexadecimal /processor/fetchStagee/instructions/ram({org})\n")
        org+=1

def removeComments(Line):
    for char in Line:
        if char == "#":
            return Line[:Line.index(char)]
    return line

file1 = open('Commands.txt', 'r')
Lines = file1.readlines()
 

instructions = []
editedInstructions = []
# Strips the newline character
for line in Lines:
    line = line.strip()
    line = removeComments(line)

    if line == "":
        continue
    if line[0] == "#":
        continue
        
    instructions.append(line)

file1.close()
for instruction in instructions: #remove commas
    instruction = instruction.replace(",", " ")
    instruction = instruction.split(" ")
    editedInstructions.append(instruction)

removedSpacesInstr = []
for instruction in editedInstructions: #remove empty strings
    tempList = []
    for item in instruction:
        if item == "":
            continue
        item = item.upper()
        tempList.append(item)
    removedSpacesInstr.append(tempList)



org = 0
isImmidiate = False
instructionFlag = False

for instruction in removedSpacesInstr:
    temp = ""
    
    if instruction[0] in noOperands:
        temp += commands[instruction[0]]
        temp += "0000000000"
        instructionFlag = True
    elif instruction[0] in ThreeOperands:
        temp += commands[instruction[0]] 
        temp += operands[instruction[1]]
        temp += operands[instruction[2]]
        temp += operands[instruction[3]]
        temp += "0"
        instructionFlag = True
    elif instruction[0] in Rd_Rs1:
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        temp += operands[instruction[2]]
        temp += operands[instruction[2]]
        temp += "0"
        instructionFlag = True
    elif instruction[0] in Rd:
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        if instruction[0] == "IN" or instruction[0] == "POP" :
            temp += "0000000"
        else:
            temp += operands[instruction[1]]
            temp += operands[instruction[1]]
            temp += "0"
        instructionFlag = True

    elif instruction[0] in Rs1:
        temp += commands[instruction[0]]
        temp += "000"
        temp += operands[instruction[1]]
        temp += "0000"
        instructionFlag = True

    elif instruction[0] == "STD": #STD RS2,RS1
        temp += commands[instruction[0]] #opcode
        temp += "000" #RD
        temp += operands[instruction[2]]   #RS1
        temp += operands[instruction[1]]   #RS2
        temp += "0"
        instructionFlag = True

    elif instruction[0] == "IADD": #IADD RD,RS1, immediate
        isImmidiate = True
        temp += commands[instruction[0]] #opcode
        temp += operands[instruction[1]] #RD
        temp += operands[instruction[2]] #RS1
        temp += operands[instruction[2]] #RS1
        temp += "0"
        immediate = instruction[3]
        instructionFlag = True
 
    elif instruction[0] == "LDM": #LDM RD, immediate
        isImmidiate = True
        temp += commands[instruction[0]] #opcode
        temp += operands[instruction[1]] #RD
        temp += "0000000"
        immediate = instruction[2]
        instructionFlag = True

    if instruction[0] == ".ORG":
        org = int(instruction[1],16)
        continue
    elif instruction[0][0] in hexaToBinary and not instructionFlag:
        check_org(instruction[0])
    else:
        file2.write(f"mem load -filltype value -filldata {{{temp+' '}}} -fillradix binary /processor/fetchStagee/instructions/ram({org})\n")
        org += 1
        if isImmidiate:
            file2.write(f"mem load -filltype value -filldata {{{immediate+' '}}} -fillradix hexadecimal /processor/fetchStagee/instructions/ram({org})\n")
            org += 1
            isImmidiate = False
    instructionFlag = False
    
file2.close()
