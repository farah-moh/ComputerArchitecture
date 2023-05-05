LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY executionStage IS
PORT( 
 clk, reset : IN  std_logic; 
 INPortDataIN, RS1Data,RS2Data,immediate:      IN std_logic_vector(15 DOWNTO 0);
 opcode:                         IN std_logic_vector(4 DOWNTO 0);
 isImmediate:                    IN std_logic;
 inPort:                          IN std_logic;

 execOutput:                     OUT std_logic_vector(15 DOWNTO 0);
 MUXOutput:                      OUT std_logic_vector(15 DOWNTO 0);
 flags:                          OUT std_logic_vector(2 DOWNTO 0) -- 2: carry, 1: negative, 0: zero
);
END executionStage;

ARCHITECTURE executionStageDesign OF executionStage IS

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

COMPONENT flagControlUnit IS
PORT( 
 opcode:                         IN std_logic_vector(4 DOWNTO 0);
 zeroFlag,negFlag,carryFlag:     IN std_logic;
 flags:                          OUT std_logic_vector(2 DOWNTO 0) -- 2: carry, 1: negative, 0: zero
);
END COMPONENT;

COMPONENT ALU IS
PORT( 
 A,B:                           IN std_logic_vector(15 DOWNTO 0);
 ALUOp:                         IN std_logic_vector(2 DOWNTO 0);
 ALUOut:                        OUT std_logic_vector(15 DOWNTO 0);
 zeroFlag,negFlag,carryFlag:    OUT std_logic
);
END COMPONENT;

signal secondALUoperand:                    std_logic_vector(15 DOWNTO 0);
signal ALUoutput:                           std_logic_vector(15 DOWNTO 0);
signal zeroSignal,negSignal,carrySignal:    std_logic;
signal controlFlags:                        std_logic_vector(2 DOWNTO 0);

BEGIN
    
    secondALUoperand <= RS2Data when isImmediate = '0'
                                else immediate;

    MUXOutput<=secondALUoperand;

    ALUU:           ALU port map (RS1Data,secondALUoperand,opcode(2 DOWNTO 0),ALUoutput,zeroSignal,negSignal,carrySignal);
    flagControl:    flagControlUnit port map(opcode,zeroSignal,negSignal,carrySignal,controlFlags);
    flagRegister:   my_nDFF generic map(3) port map (clk,reset,controlFlags,flags,'1');

    execOutput <= ALUoutput when inPort = '0'
             else immediate when opcode = "01010" -- when LDM
             else RS1Data  when opcode = "11011" -- when MOV
             else INPortDataIN;
END executionStageDesign;

