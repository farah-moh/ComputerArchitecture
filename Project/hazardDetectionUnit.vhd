LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

ENTITY hazardDetectionUnit IS
PORT( 
    instruction :                                  IN std_logic_vector(15 DOWNTO 0);
    RS1 :                                          IN std_logic_vector(2 DOWNTO 0);
    RS2 :                                          IN std_logic_vector(2 DOWNTO 0);
    RD_ID_EX:                                      IN std_logic_vector(2 DOWNTO 0);
    regwrite_ID_EX, memread_ID_EX:                 IN std_logic;
    RD_EX_MEM1:                                    IN std_logic_vector(2 DOWNTO 0);
    regwrite_EX_MEM1, memread_EX_MEM1:             IN std_logic;
    stall:                                         OUT std_logic
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
    BEGIN
        -- Get the type of instruction
        instType := TYPES'val(to_integer(unsigned(instruction(15 DOWNTO 14)))); 
        -- Data hazards when current instruction is R-Type -> stall when load use case is detected
        IF instType = RTYPE THEN
            IF ((RD_ID_EX = RS1 or RD_ID_EX = RS2) and regwrite_ID_EX = '1' and memread_ID_EX = '1') THEN
                stall <= '1';
            ELSIF ((RD_EX_MEM1 = RS1 or RD_EX_MEM1 = RS2) and regwrite_EX_MEM1 = '1' and memread_EX_MEM1 = '1') THEN
                stall <= '1';
            ELSE
                stall <= '0';
            END IF;
        ELSE
            stall <= '0';
        END IF;
    END PROCESS;
END hazardDetectionUnitDesign;