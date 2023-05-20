LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY forwardingDecode IS
PORT( 
    instruction :                          IN std_logic_vector(15 DOWNTO 0);
    RS1:                                   IN std_logic_vector(2 DOWNTO 0);
    RS1Data:                               IN std_logic_vector(15 DOWNTO 0);

    -- for each subsequent buffer, we need Rd, RegWrite signal and Write back data
    RD_EX_MEM1:                            IN std_logic_vector(2 DOWNTO 0);
    regwrite_EX_MEM1:                      IN std_logic;
    WBData_EX_MEM1:                        IN std_logic_vector(15 DOWNTO 0);

    RD_MEM1_MEM2:                          IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM1_MEM2:                    IN std_logic;
    WBData_MEM1_MEM2:                      IN std_logic_vector(15 DOWNTO 0);

    RD_MEM2_WB:                            IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM2_WB:                      IN std_logic;
    WBData_MEM2_WB:                        IN std_logic_vector(15 DOWNTO 0);

    RS1DataOut:                OUT std_logic_vector(15 DOWNTO 0)
 );
END forwardingDecode;

ARCHITECTURE forwardingDecodeDesign OF forwardingDecode IS
BEGIN
    PROCESS (RS1, RS1Data, RD_EX_MEM1, regwrite_EX_MEM1, RD_MEM1_MEM2, regwrite_MEM1_MEM2, RD_MEM2_WB, regwrite_MEM2_WB,WBData_EX_MEM1,WBData_MEM1_MEM2,WBData_MEM2_WB) 
        variable opcode: std_logic_vector(4 DOWNTO 0);
    BEGIN
        -- mov: 11011 , jmp: 10010 , call: 10011
        opcode := instruction(15 DOWNTO 11);
        IF opcode = "11011" OR opcode = "10010" OR opcode = "10011" THEN
            IF regwrite_EX_MEM1 = '1' and RD_EX_MEM1 = RS1 THEN
                RS1DataOut <= WBData_EX_MEM1;
            ELSIF regwrite_MEM1_MEM2 = '1'and RD_MEM1_MEM2 = RS1 THEN
                RS1DataOut <= WBData_MEM1_MEM2;
            ELSIF regwrite_MEM2_WB = '1'and RD_MEM2_WB = RS1 THEN
                RS1DataOut <= WBData_MEM2_WB;
            ELSE
                RS1DataOut <= RS1Data;
            END IF;
        ELSE
            RS1DataOut <= RS1Data;
        END IF;
    END PROCESS;
END forwardingDecodeDesign;


