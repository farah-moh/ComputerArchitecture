LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DecodingStage IS
    GENERIC (m: integer:= 16);
    PORT (
        clk:                IN std_logic;
        stall:              IN std_logic;
        rst :               IN std_logic;
        RS1 :               IN std_logic_vector(2 DOWNTO 0);
        RS2 :               IN std_logic_vector(2 DOWNTO 0);
        RD :    	        IN std_logic_vector(2 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writeData :         IN std_logic_vector(m-1 DOWNTO 0);
        Instruction:        IN std_logic_vector(m-1 DOWNTO 0);
        RS1Data :           OUT std_logic_vector(m-1 DOWNTO 0);
        RS2Data :           OUT std_logic_vector(m-1 DOWNTO 0);
        regWrite,pcSrc,memRead,memWrite,memToReg,inPort,outPort,spInc,spDec:        OUT std_logic

    );
END ENTITY DecodingStage;

ARCHITECTURE decoding OF DecodingStage  IS 

BEGIN
    ControlU : entity work.ControlUnit port map(Instruction,stall,regWrite, pcSrc, memRead, memWrite, memToReg, inPort, outPort, spInc, spDec);
    regFile: entity work.RegFileMem port map(clk, rst, Instruction(6 downto 4), Instruction(3 downto 1), RD, writeEnable, writeData, RS1Data, RS2Data);
    -- regFile: entity work.RegFileMem port map(clk, rst, RS1, RS2, RD, writeEnable, writeData, RS1Data, RS2Data);

END decoding;
