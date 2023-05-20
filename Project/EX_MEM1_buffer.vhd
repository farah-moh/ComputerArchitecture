LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY EX_MEM1_buffer IS
PORT( 
 clk, reset :                                   IN  std_logic; 
 RS1reg,RS2reg,RDreg:                           IN  std_logic_vector(2 DOWNTO 0);
 RS1data, RS2data, ALUresult:                   IN  std_logic_vector(15 DOWNTO 0);
 PC:                                            IN std_logic_vector(15 DOWNTO 0);
 regWrite,pcSrc,memRead,memWrite,memToReg,inPort,outPort,spInc,spDec:        IN std_logic;

 RS1regOut,RS2regOut,RDregOut:                  OUT  std_logic_vector(2 DOWNTO 0);
 RS1dataOut, RS2dataOut,ALUresultOut:           OUT  std_logic_vector(15 DOWNTO 0);
 PCout:                                         OUT  std_logic_vector(15 DOWNTO 0);
 regWriteOut,pcSrcOut,memReadOut,memWriteOut,memToRegOut,inPortOut,outPortOut,spIncOut,spDecOut:        OUT std_logic
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

signal bufferInput:                   std_logic_vector(81 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(81 DOWNTO 0);

-- RDaddress(3) - rs1data(16) - rs2data(16) - ALUoutput(16) - PC(16) - control signals(8)

BEGIN
    
    bufferr:         my_nDFF generic map(82) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <=  RS1reg & RS2reg & RDreg & RS1data & RS2data & ALUresult & PC & regWrite & pcSrc & memRead & memWrite & memToReg & inPort & outPort & spInc & spDec;

    RS1regOut           <= bufferOutput(81 downto 79);
    RS2regOut           <= bufferOutput(78 downto 76);
    RDregOut            <= bufferOutput(75 downto 73);
    RS1dataOut          <= bufferOutput(72 downto 57); 
    RS2dataOut          <= bufferOutput(56 downto 41);
    ALUresultOut        <= bufferOutput(40 downto 25);                          
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
    
END EX_MEM1_bufferDesign;




