LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY MEM1_MEM2_buffer IS
PORT( 
    clk, rst :                                                  IN  std_logic; 
    OUTT_in, INN_in, MemToReg_in, regWrite_in, pcSrc_in:        IN  std_logic;
    RD:                                                         IN  std_logic_vector(2 DOWNTO 0);
    ALUoutput, RS1Data, writeData:                              IN  std_logic_vector(15 DOWNTO 0);
    writeEnable, readEnable:                                    IN  std_logic;
    writeAddress, readAddress:                                  IN  std_logic_vector(9 DOWNTO 0);

    OUTT_out, INN_out, MemToReg_out, regWrite_out, pcSrc_out:   OUT  std_logic;
    RDOut:                                                      OUT  std_logic_vector(2 DOWNTO 0);
    ALUoutputOUT, RS1DataOut, writeDataOut:                     OUT  std_logic_vector(15 DOWNTO 0);
    writeEnableOut, readEnableOut:                              OUT  std_logic;
    writeAddressOut, readAddressOut:                            OUT  std_logic_vector(9 DOWNTO 0)

);
END MEM1_MEM2_buffer;

ARCHITECTURE MEM1_MEM2_bufferDesign OF MEM1_MEM2_buffer IS

COMPONENT my_nDFF IS            -- buffer
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

signal bufferInput:                   std_logic_vector(77 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(77 DOWNTO 0);

-- 77 bits

BEGIN
    
    bufferInput <= readAddress & readEnable & writeAddress & writeEnable & writeData & RS1Data & ALUoutput & RD & pcSrc_in & regWrite_in & MemToReg_in & INN_in & OUTT_in;
    buffer_Mem1_Mem2: my_nDFF GENERIC MAP(78) PORT MAP(clk, rst, bufferInput, bufferOutput, '1');             -- the first buffer (delays mem by one cycle)

    OUTT_out            <= bufferOutput(0);                 -- 1 bit
    INN_out             <= bufferOutput(1);                 -- 1 bit
    MemToReg_out        <= bufferOutput(2);                 -- 1 bit
    regWrite_out        <= bufferOutput(3);                 -- 1 bit
    pcSrc_out           <= bufferOutput(4);                 -- 1 bit
    RDOut               <= bufferOutput(7 DOWNTO 5);        -- 3 bits
    ALUoutputOUT        <= bufferOutput(23 DOWNTO 8);       -- 16 bits
    RS1DataOut          <= bufferOutput(39 DOWNTO 24);      -- 16 bits
    writeDataOut        <= bufferOutput(55 DOWNTO 40);      -- 16 bits
    writeEnableOut      <= bufferOutput(56);                -- 1 bit
    writeAddressOut     <= bufferOutput(66 DOWNTO 57);      -- 10 bits
    readEnableOut       <= bufferOutput(67);                -- 1 bit
    readAddressOut      <= bufferOutput(77 DOWNTO 68);      -- 10 bits

    
    
END MEM1_MEM2_bufferDesign;




