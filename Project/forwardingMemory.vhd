LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY forwardingMemory IS
PORT( 
    RS1, RS2:                                          IN std_logic_vector(2 DOWNTO 0);
    RS1Data, RS2Data:                                  IN std_logic_vector(15 DOWNTO 0);

    --from MEM2/WB we need Rd, RegWrite signal and Write back data
    RD_MEM2_WB:                                        IN std_logic_vector(2 DOWNTO 0);
    regwrite_MEM2_WB:                                  IN std_logic;
    WBData_MEM2_WB:                                    IN std_logic_vector(15 DOWNTO 0);

    RS1DataOut, RS2DataOut:                            OUT std_logic_vector(15 DOWNTO 0)
 );
END forwardingMemory;

ARCHITECTURE forwardingMemoryDesign OF forwardingMemory IS
BEGIN
    PROCESS (RS1, RS2, RS1Data, RS2Data, RD_MEM2_WB, regwrite_MEM2_WB ,WBData_MEM2_WB) 
    BEGIN

        IF regwrite_MEM2_WB = '1'and RD_MEM2_WB = RS1 THEN
            RS1DataOut <= WBData_MEM2_WB;
        ELSE
            RS1DataOut <= RS1Data;
        END IF;

        IF regwrite_MEM2_WB = '1'and RD_MEM2_WB = RS2 THEN
            RS2DataOut <= WBData_MEM2_WB;
        ELSE
            RS2DataOut <= RS2Data;
        END IF;

    END PROCESS;
END forwardingMemoryDesign;


