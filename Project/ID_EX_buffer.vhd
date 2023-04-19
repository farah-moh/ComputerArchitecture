LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY ID_EX_buffer IS
PORT( 
 clk, reset :                    IN  std_logic; 
 RS1data, RS2data:               IN  std_logic_vector(15 DOWNTO 0);
 instruction,immediate:          IN std_logic_vector(15 DOWNTO 0);
 PC:                             IN std_logic_vector(15 DOWNTO 0);
 regWrite,pcSrc,memRead,memWrite,memToReg,inPort,outPort,spInc,spDec:        IN std_logic;


 RS1dataOut, RS2dataOut:         OUT  std_logic_vector(15 DOWNTO 0);
 opcode:                         OUT  std_logic_vector(4 DOWNTO 0);
 isImmediate:                    OUT  std_logic; 
 RD,RS1,RS2:                     OUT  std_logic_vector(2 DOWNTO 0);
 immediateOut:                   OUT  std_logic_vector(15 DOWNTO 0);
 PCout:                          OUT  std_logic_vector(15 DOWNTO 0);
 regWriteOut,pcSrcOut,memReadOut,memWriteOut,memToRegOut,inPortOut,outPortOut,spIncOut,spDecOut:        OUT std_logic
);
END ID_EX_buffer;

ARCHITECTURE ID_EX_bufferDesign OF ID_EX_buffer IS

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

signal bufferInput:                   std_logic_vector(88 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(88 DOWNTO 0);

-- rs1data(16) - rs2data(16) - instruction(16) - immediate(16) - PC(16) - control signals(8)

BEGIN
    
    bufferr:         my_nDFF generic map(89) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <= RS1data&RS2data&instruction&immediate&PC&regWrite&pcSrc&memRead&memWrite&memToReg&inPort&outPort&spInc&spDec;

    RS1dataOut          <= bufferOutput(88 downto 73);
    RS2dataOut          <= bufferOutput(72 downto 57); 
    opcode              <= bufferOutput(56 downto 52);             
    isImmediate         <= bufferOutput(51);               
    RD                  <= bufferOutput(50 downto 48);
    RS1                 <= bufferOutput(47 downto 45);
    RS2                 <= bufferOutput(44 downto 42);     
    immediateOut        <= bufferOutput(40 downto 25);              
    PCout               <= bufferOutput(24 downto 9);
    regWriteOut         <= bufferOutput(8);
    pcSrcOut            <= bufferOutput(7);
    memReadOut          <= bufferOutput(6);
    memWriteOut         <= bufferOutput(5);
    memToRegOut         <= bufferOutput(4);
    inPortOut           <= bufferOutput(3);
    outPortOut          <= bufferOutput(2);
    spIncOut            <= bufferOutput(1);
    spDecOut            <= bufferOutput(0);
    
END ID_EX_bufferDesign;



