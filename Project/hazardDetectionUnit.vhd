LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

ENTITY hazardDetectionUnit IS
PORT( 
    instruction :                                               IN std_logic_vector(15 DOWNTO 0);
    RS1 :                                                       IN std_logic_vector(2 DOWNTO 0);
    RS2 :                                                       IN std_logic_vector(2 DOWNTO 0);
    memread_me, memwrite_me:                                    IN std_logic;
    RD_ID_EX:                                                   IN std_logic_vector(2 DOWNTO 0);
    regwrite_ID_EX, memread_ID_EX,memwrite_ID_EX:               IN std_logic;
    RD_EX_MEM1:                                                 IN std_logic_vector(2 DOWNTO 0);
    regwrite_EX_MEM1, memread_EX_MEM1,memwrite_EX_MEM1:         IN std_logic;
    RD_MEM1_MEM2:                                               IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM1_MEM2, memread_MEM1_MEM2,memwrite_MEM1_MEM2:   IN std_logic;
    stall:                                                      OUT std_logic
 );
END hazardDetectionUnit;

ARCHITECTURE hazardDetectionUnitDesign OF hazardDetectionUnit IS
TYPE TYPES IS
    (ADHOC,ITYPE,JTYPE,RTYPE);
TYPE ITypeInstructions IS
    (PUSH,POP,LDM,LDD,STD);
TYPE JTypeInstructions IS
    (JZ,JC,JMP,CALL,RET,RTI);
TYPE AdhocInstructions IS
    (NOP,SETCC,CLRCC,INN,OUTT);

BEGIN
    PROCESS (instruction,RD_ID_EX,RD_EX_MEM1,regwrite_ID_EX,regwrite_EX_MEM1,memread_ID_EX,memread_EX_MEM1) 
        variable instType: TYPES;
        variable opcode: std_logic_vector(4 DOWNTO 0);
    BEGIN
        -- Get the type of instruction
        instType := TYPES'val(to_integer(unsigned(instruction(15 DOWNTO 14)))); 
        opcode := instruction(15 DOWNTO 11);
        stall <= '0';
        -- Data hazards -> stall when load use case is detected
        -- instructions that might stall TWICE (will be handled by execute forwarding) -> all R-type - JZ - JC
        -- instructions that only stall ONCE (will be handled by memory forwarding)  -> STD - LDD - PUSH - OUT - MOV
        -- instructions that possibly stall three times -> JMP - CALL
        -- out will stall at most once, and will be handled in memory data forwarding
        -- jz: 10000, jc: 10001
        -- std: 01100, ldd: 01011, push: 01000, out: 00100
        -- mov: 11011 , jmp: 10010 , call: 10011

        -- #################### DATA HAZARDS [LOAD USE CASE] ####################
        -- in case of POSSIBLY 3 stalls
        IF (opcode = "10010" or opcode ="10011") THEN
            IF ((RD_ID_EX = RS1 or RD_ID_EX = RS2) and regwrite_ID_EX = '1' and memread_ID_EX = '1') THEN
                stall <= '1';
                -- in case of a store, we only need to stall once if previous instruction is a load, otherwise proper forwarding will get the correct values
            ELSIF ((RD_EX_MEM1 = RS1 or RD_EX_MEM1 = RS2) and regwrite_EX_MEM1 = '1' and memread_EX_MEM1 = '1') THEN
                stall <= '1';
            ELSIF ((RD_MEM1_MEM2 = RS1 or RD_MEM1_MEM2 = RS2) and regwrite_MEM1_MEM2 = '1' and memread_MEM1_MEM2 = '1') THEN
                stall <= '1';
            ELSE
                stall <= '0';
            END IF;
        -- in case of POSSIBLY 2 stalls
        ELSIF (instType = RTYPE or opcode = "10000" or opcode = "10001")  THEN
            IF ((RD_ID_EX = RS1 or RD_ID_EX = RS2) and regwrite_ID_EX = '1' and memread_ID_EX = '1') THEN
                stall <= '1';
            -- in case of a store, we only need to stall once if previous instruction is a load, otherwise proper forwarding will get the correct values
            ELSIF ((RD_EX_MEM1 = RS1 or RD_EX_MEM1 = RS2) and regwrite_EX_MEM1 = '1' and memread_EX_MEM1 = '1') THEN
                stall <= '1';
            ELSE
                stall <= '0';
            END IF;
        -- in case of a memory operation or an OUT or a MOV, we only need to stall once if previous instruction is a load, otherwise proper forwarding will get the correct values
        ELSIF (opcode = "01100" or opcode = "01011" or opcode = "01000" or opcode ="00100" or opcode ="11011")  THEN
            IF ((RD_ID_EX = RS1 or RD_ID_EX = RS2) and regwrite_ID_EX = '1' and memread_ID_EX = '1') THEN
                stall <= '1';
            ELSE
                stall <= '0';
            END IF;
        ELSE 
            stall <= '0';
        END IF;

        -- #################### STRUCTURAL HAZARDS ####################
        -- only one possible stall EVER, if I am a memory instruction and the one right before me is also a memory instruction
        IF ((memread_me = '1' or memwrite_me ='1') and(memread_ID_EX='1' or memwrite_ID_EX='1'))  THEN
            stall <= '1';
        ELSE 
            stall <= '0';
        END IF;
    END PROCESS;
END hazardDetectionUnitDesign;
