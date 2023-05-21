LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DecodingStage IS
    PORT (
        clk:                IN std_logic;
        stall:              IN std_logic;
        rst :               IN std_logic;
        RS1 :               IN std_logic_vector(2 DOWNTO 0);
        RS2 :               IN std_logic_vector(2 DOWNTO 0);
        RD :    	        IN std_logic_vector(2 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writeData :         IN std_logic_vector(15 DOWNTO 0);
        Instruction:        IN std_logic_vector(15 DOWNTO 0);
        RS1Data :           OUT std_logic_vector(15 DOWNTO 0);
        RS2Data :           OUT std_logic_vector(15 DOWNTO 0);
        regWrite,pcSrc,memRead,memWrite,memToReg,inPort,outPort,spInc,spDec,pcSrc_jmpORcall:        OUT std_logic

    );
END ENTITY DecodingStage;

ARCHITECTURE decoding OF DecodingStage  IS 
--  signal RS1_or_RD : std_logic_vector(2 DOWNTO 0);
BEGIN

    -- RS1_or_RD <= RD when pcSrc = '1' and memRead = '0' else RS1;
    ControlU : entity work.ControlUnit port map(Instruction,stall,regWrite, pcSrc, memRead, memWrite, memToReg, inPort, outPort, spInc, spDec);
    regFile: entity work.RegFileMem port map(clk, rst, RS1, RS2, RD, writeEnable, writeData, RS1Data, RS2Data); -- RS1 and RS2 check themmm! 
    -- regFile: entity work.RegFileMem port map(clk, rst, RS1, RS2, RD, writeEnable, writeData, RS1Data, RS2Data);
    pcSrc_jmpORcall <=  '1' when (Instruction(15 downto 11) = "10010") else
                        '1' when (Instruction(15 downto 11) = "10011") else 
                        '0';
END decoding;
