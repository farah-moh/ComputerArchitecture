LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY fetchStage IS
PORT( 
 clk, reset :                    IN  std_logic; 
 instruction,immediate:          OUT std_logic_vector(15 DOWNTO 0)
);
END fetchStage;

ARCHITECTURE fetchStageDesign OF fetchStage IS

COMPONENT PC IS
	PORT (clk, reset, enable : IN  std_logic;
          inc : IN std_logic_vector(15 DOWNTO 0);
		  pc : OUT std_logic_vector(15 DOWNTO 0)
        );
END COMPONENT;

COMPONENT instructionCache IS
    GENERIC (m: integer:= 16);
    PORT (
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(6 DOWNTO 0);
        instruction :       OUT std_logic_vector(m-1 DOWNTO 0); 
        immediate :         OUT std_logic_vector(m-1 DOWNTO 0)
    );
END COMPONENT;

signal pcOutput:                            std_logic_vector(15 DOWNTO 0);
signal increment:                           std_logic_vector(15 DOWNTO 0);
signal outInstruction:                      std_logic_vector(15 DOWNTO 0);
signal isImmediate:                         std_logic;

BEGIN
    
    pcc:            PC port map(clk,reset,'1',increment,pcOutput);
    instructions:   instructionCache port map(reset, pcOutput(7 downto 1),outInstruction,immediate);
    isImmediate <= outInstruction(10);
    instruction <= outInstruction;
    increment <= x"0002" when isImmediate='0'
                         else x"0004"; 

END fetchStageDesign;


