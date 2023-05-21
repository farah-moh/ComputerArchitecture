LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY fetchStage IS
PORT( 
 clk, reset, enable, pcSel:                           IN  std_logic; 
 pcData:                                              IN  std_logic_vector(15 DOWNTO 0);
 instruction,immediate,pcOut:           OUT std_logic_vector(15 DOWNTO 0);
 InterruptSignal:                                    IN std_logic;
 memOne:                               OUT std_logic_vector(15 DOWNTO 0)  
);
END fetchStage;

ARCHITECTURE fetchStageDesign OF fetchStage IS


COMPONENT instructionCache IS
    GENERIC (m: integer:= 16);
    PORT (
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(9 DOWNTO 0);
        instruction :       OUT std_logic_vector(m-1 DOWNTO 0); 
        immediate :         OUT std_logic_vector(m-1 DOWNTO 0);
        memZero:            OUT std_logic_vector(m-1 DOWNTO 0);
        memOne:            OUT std_logic_vector(m-1 DOWNTO 0)
    );
END COMPONENT;

signal pcOutput:                            std_logic_vector(15 DOWNTO 0);
signal increment:                           std_logic_vector(15 DOWNTO 0);
signal outInstruction:                      std_logic_vector(15 DOWNTO 0);
signal memZero:                            std_logic_vector(15 DOWNTO 0);
signal isImmediate:                         std_logic;

BEGIN
    
    pcc:            entity work.PC port map(clk, reset, enable, increment, pcSel, pcData, pcOutput, memZero);
    instructions:   instructionCache port map(reset, pcOutput(9 downto 0),outInstruction,immediate,memZero,memOne);
    isImmediate <= outInstruction(10);
    instruction <= (others => '0') when InterruptSignal = '1'           -- makes the instruction a NOP when interrupt is high
                    else outInstruction;
    increment <= x"0002" when isImmediate='1'
                         else x"0001";
    pcOut <= pcOutput;

END fetchStageDesign;
