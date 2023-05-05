LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY forwardingExecute IS
PORT( 
    RS1, RS2:                                          IN std_logic_vector(2 DOWNTO 0);
    RS1Data, RS2Data:                                  IN std_logic_vector(15 DOWNTO 0);

    -- for each subsequent buffer, we need Rd, RegWrite signal and Write back data
    RD_EX_MEM1:                                        IN std_logic_vector(2 DOWNTO 0);
    regwrite_EX_MEM1:                                  IN std_logic;
    WBData_EX_MEM1:                                    IN std_logic_vector(15 DOWNTO 0);

    RD_MEM1_MEM2:                                      IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM1_MEM2:                                IN std_logic;
    WBData_MEM1_MEM2:                                  IN std_logic_vector(15 DOWNTO 0);

    RD_MEM2_WB:                                        IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM2_WB:                                  IN std_logic;
    WBData_MEM2_WB:                                    IN std_logic_vector(15 DOWNTO 0);

    RS1DataOut, RS2DataOut:                            OUT std_logic_vector(15 DOWNTO 0)
 );
END forwardingExecute;

ARCHITECTURE forwardingExecuteDesign OF forwardingExecute IS
BEGIN
    PROCESS (RS1, RS2, RS1Data, RS2Data, RD_EX_MEM1, regwrite_EX_MEM1, RD_MEM1_MEM2, regwrite_MEM1_MEM2, RD_MEM2_WB, regwrite_MEM2_WB,WBData_EX_MEM1,WBData_MEM1_MEM2,WBData_MEM2_WB) 
    BEGIN

        IF regwrite_EX_MEM1 = '1' and RD_EX_MEM1 = RS1 THEN
            RS1DataOut <= WBData_EX_MEM1;
        ELSIF regwrite_MEM1_MEM2 = '1'and RD_MEM1_MEM2 = RS1 THEN
            RS1DataOut <= WBData_MEM1_MEM2;
        ELSIF regwrite_MEM2_WB = '1'and RD_MEM2_WB = RS1 THEN
            RS1DataOut <= WBData_MEM2_WB;
        ELSE
            RS1DataOut <= RS1Data;
        END IF;

        IF regwrite_EX_MEM1 = '1' and RD_EX_MEM1 = RS2 THEN
            RS2DataOut <= WBData_EX_MEM1;
        ELSIF regwrite_MEM1_MEM2 = '1'and RD_MEM1_MEM2 = RS2 THEN
            RS2DataOut <= WBData_MEM1_MEM2;
        ELSIF regwrite_MEM2_WB = '1'and RD_MEM2_WB = RS2 THEN
            RS2DataOut <= WBData_MEM2_WB;
        ELSE
            RS2DataOut <= RS2Data;
        END IF;

    END PROCESS;
END forwardingExecuteDesign;

