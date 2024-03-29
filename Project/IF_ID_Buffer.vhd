LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY IF_ID_Buffer IS
PORT( 
    clk, reset :                    IN  std_logic; 
    InPortDataIN:                   IN  std_logic_vector(15 DOWNTO 0);
    instruction,immediate:          IN  std_logic_vector(15 DOWNTO 0);
    PC:                             IN  std_logic_vector(15 DOWNTO 0);

    InPortDataOUT:                  OUT std_logic_vector(15 DOWNTO 0);
    RS1,RS2:                        OUT std_logic_vector(2 DOWNTO 0);
    instructionOut,immediateOut:    OUT std_logic_vector(15 DOWNTO 0);
    PCout:                          OUT std_logic_vector(15 DOWNTO 0);
    InterruptIn:                    IN  std_logic;
    InterruptOut:                   OUT std_logic
);
END IF_ID_Buffer;

ARCHITECTURE IF_ID_bufferDesign OF IF_ID_Buffer IS

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

signal bufferInput:                   std_logic_vector(64 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(64 DOWNTO 0);

--instruction(16) - immediate(16) - PC(16)

BEGIN
    
    bufferr:         my_nDFF generic map(65) port map (clk,reset,bufferInput,bufferOutput,'1');

    bufferInput <= InterruptIn & InPortDataIN & instruction & immediate & PC;
    -- 47->42 opcode, 41->39 RD, 38->36 RS1, 35->33 RS2, 31->16 immediate, 15->0 PC

    InterruptOut    <= bufferOutput(64);
    InPortDataOUT   <= bufferOutput(63 DOWNTO 48);
    instructionOut  <= bufferOutput(47 DOWNTO 32);
    immediateOut    <= bufferOutput(31 DOWNTO 16);
    pcOut           <= bufferOutput(15 DOWNTO 0);
    RS1             <= bufferOutput(38 DOWNTO 36);
    RS2             <= bufferOutput(35 DOWNTO 33);
END IF_ID_bufferDesign;




