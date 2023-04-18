LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY EX_MEM1_buffer IS
PORT( 
 clk, reset :                                   IN  std_logic; 
 RS1data, RS2data, ALUresult:                   IN  std_logic_vector(15 DOWNTO 0);
 PC:                                            IN std_logic_vector(15 DOWNTO 0);
 controlSignals:                                IN std_logic_vector(7 DOWNTO 0);

 RS1dataOut, RS2dataOut,ALUresultOut:           OUT  std_logic_vector(15 DOWNTO 0);
 PCout:                                         OUT  std_logic_vector(15 DOWNTO 0);
 controlSignalsOut:                             OUT  std_logic_vector(7 DOWNTO 0)
);
END EX_MEM1_buffer;

ARCHITECTURE EX_MEM1_bufferDesign OF EX_MEM1_buffer IS

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

signal bufferInput:                   std_logic_vector(71 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(71 DOWNTO 0);

-- rs1data(16) - rs2data(16) - ALUoutput(16) - PC(16) - control signals(8)

BEGIN
    
    bufferr:         my_nDFF generic map(72) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <= RS1data&RS2data&ALUresult&PC&controlSignals;

    RS1dataOut          <= bufferOutput(71 downto 56); 
    RS2dataOut          <= bufferOutput(55 downto 40);
    ALUresultOut        <= bufferOutput(39 downto 24);                          
    PCout               <= bufferOutput(23 downto 8);
    controlSignalsOut   <= bufferOutput(7 downto 0);
    
END EX_MEM1_bufferDesign;




