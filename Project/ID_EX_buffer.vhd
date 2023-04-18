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
 controlSignals:                 IN std_logic_vector(7 DOWNTO 0);

 RS1dataOut, RS2dataOut:         OUT  std_logic_vector(15 DOWNTO 0);
 opcode:                         OUT  std_logic_vector(4 DOWNTO 0);
 isImmediate:                    OUT  std_logic; 
 RD,RS1,RS2:                     OUT  std_logic_vector(2 DOWNTO 0);
 immediateOut:                   OUT  std_logic_vector(15 DOWNTO 0);
 PCout:                          OUT  std_logic_vector(15 DOWNTO 0);
 controlSignalsOut:              OUT  std_logic_vector(7 DOWNTO 0)
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

signal bufferInput:                   std_logic_vector(87 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(87 DOWNTO 0);

-- rs1data(16) - rs2data(16) - instruction(16) - immediate(16) - PC(16) - control signals(8)

BEGIN
    
    bufferr:         my_nDFF generic map(88) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <= RS1data&RS2data&instruction&immediate&PC&controlSignals;

    RS1dataOut          <= bufferOutput(87 downto 72);
    RS2dataOut          <= bufferOutput(71 downto 56); 
    opcode              <= bufferOutput(55 downto 51);             
    isImmediate         <= bufferOutput(50);               
    RD                  <= bufferOutput(49 downto 47);
    RS1                 <= bufferOutput(46 downto 44);
    RS2                 <= bufferOutput(43 downto 41);     
    immediateOut        <= bufferOutput(39 downto 24);              
    PCout               <= bufferOutput(23 downto 8);
    controlSignalsOut   <= bufferOutput(7 downto 0);
    
END ID_EX_bufferDesign;



