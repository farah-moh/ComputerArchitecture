Library IEEE;
use IEEE.std_logic_1164.all;


entity Processor is
GENERIC (bits: integer := 16);
PORT  (
    clk,rst,enable:    	IN std_logic
);
end entity;


Architecture Processor_design of Processor is

COMPONENT PC IS
PORT (clk, reset, enable : IN  std_logic;
        pc : OUT std_logic_vector(5 DOWNTO 0)
    );
END COMPONENT;

COMPONENT instructionCache IS
    GENERIC (m: integer:= 16);
    PORT (
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(5 DOWNTO 0);
        readPort :          OUT std_logic_vector(m-1 DOWNTO 0) 
    );
END COMPONENT;

COMPONENT controller IS
PORT( 
 instruction : IN std_logic_vector(15 DOWNTO 0);
 writeEnable:  OUT std_logic;
 ALUOp:        OUT std_logic_vector(3 DOWNTO 0)
);
END COMPONENT;

signal outputPC: std_logic_vector(5 downto 0);
signal outputIC: std_logic_vector(15 downto 0);
signal writeEnable: std_logic;
signal ALUOp: std_logic_vector(3 DOWNTO 0);

BEGIN
    ProgramCounter: PC port map (clk,rst,enable,outputPC);
    Instruction: instructionCache port map (rst,outputPC,outputIC);
    Control: controller port map (outputIC,writeEnable,ALUOp);

END Processor_design;