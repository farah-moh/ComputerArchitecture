LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY EX_MEM1_buffer IS
PORT( 
 clk, reset :                                   IN  std_logic; 
 RDreg:                                         IN  std_logic_vector(2 DOWNTO 0);
 RS1data, RS2data, ALUresult:                   IN  std_logic_vector(15 DOWNTO 0);
 PC:                                            IN std_logic_vector(15 DOWNTO 0);
 regWrite,memRead,memWrite,memToReg,inPort,outPort,spInc,spDec:        IN std_logic;

 RDregOut:                                      OUT  std_logic_vector(2 DOWNTO 0);
 RS1dataOut, RS2dataOut,ALUresultOut:           OUT  std_logic_vector(15 DOWNTO 0);
 PCout:                                         OUT  std_logic_vector(15 DOWNTO 0);
 regWriteOut,memReadOut,memWriteOut,memToRegOut,inPortOut,outPortOut,spIncOut,spDecOut:        OUT std_logic
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

signal bufferInput:                   std_logic_vector(74 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(74 DOWNTO 0);

-- RDaddress(3) - rs1data(16) - rs2data(16) - ALUoutput(16) - PC(16) - control signals(8)

BEGIN
    
    bufferr:         my_nDFF generic map(75) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <= RDreg&RS1data&RS2data&ALUresult&PC&regWrite&memRead&memWrite&memToReg&inPort&outPort&spInc&spDec;

    RDregOut            <= bufferOutput(74 downto 72);
    RS1dataOut          <= bufferOutput(71 downto 56); 
    RS2dataOut          <= bufferOutput(55 downto 40);
    ALUresultOut        <= bufferOutput(39 downto 24);                          
    PCout               <= bufferOutput(23 downto 8);
    regWriteOut         <= bufferOutput(7);
    memReadOut          <= bufferOutput(6);
    memWriteOut         <= bufferOutput(5);
    memToRegOut         <= bufferOutput(4);
    inPortOut           <= bufferOutput(3);
    outPortOut          <= bufferOutput(2);
    spIncOut            <= bufferOutput(1);
    spDecOut            <= bufferOutput(0);
    
END EX_MEM1_bufferDesign;




