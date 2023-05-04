LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY MEM2_WB_buffer IS
PORT( 
    clk, rst :                                     IN  std_logic; 
    OUTT_in, INN_in, MemToReg_in, regWrite_in:     IN  std_logic;
    RD:                                            IN  std_logic_vector(2 DOWNTO 0);
    ALUoutput, RS1Data, writeData:                 IN  std_logic_vector(15 DOWNTO 0);
    writeEnable, readEnable:                       IN  std_logic;
    writeAddress, readAddress:                     IN  std_logic_vector(9 DOWNTO 0);

    OUTT_out, INN_out, MemToReg_out, regWrite_out: OUT  std_logic;
    RDOut:                                         OUT  std_logic_vector(2 DOWNTO 0);
    ALUoutputOUT, RS1DataOut, writeDataOut:        OUT  std_logic_vector(15 DOWNTO 0);
    -- MEM2_WB_buffer_Output:                         OUT  std_logic_vector(15 DOWNTO 0);      -- el Write back data (btb2a either el ALUoutput aw el writeDataOut)
    writeEnableOut, readEnableOut:                 OUT  std_logic;
    writeAddressOut, readAddressOut:               OUT  std_logic_vector(9 DOWNTO 0)

);
END MEM2_WB_buffer;

ARCHITECTURE MEM2_WB_bufferDesign OF MEM2_WB_buffer IS

COMPONENT my_nDFF IS            -- buffer
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

signal bufferInput:                   std_logic_vector(76 DOWNTO 0);
signal bufferOutput:                  std_logic_vector(76 DOWNTO 0);

-- 77 bits

BEGIN
    
    bufferInput <= readAddress & readEnable & writeAddress & writeEnable & writeData & RS1Data & ALUoutput & RD & regWrite_in & MemToReg_in & INN_in & OUTT_in;
    buffer_Mem1_Mem2: my_nDFF GENERIC MAP(77) PORT MAP(clk, rst, bufferInput, bufferOutput, '1');             -- the second buffer

    OUTT_out            <= bufferOutput(0);                 -- 1 bit
    MemToReg_out        <= bufferOutput(2);                 -- 1 bit
    INN_out             <= bufferOutput(1);                 -- 1 bit
    regWrite_out        <= bufferOutput(3);                 -- 1 bit
    RDOut               <= bufferOutput(6 DOWNTO 4);        -- 3 bits
    ALUoutputOUT        <= bufferOutput(22 DOWNTO 7);       -- 16 bits          -- either dh
    RS1DataOut          <= bufferOutput(38 DOWNTO 23);      -- 16 bits
    writeDataOut        <= bufferOutput(54 DOWNTO 39);      -- 16 bits          -- or dh
    writeEnableOut      <= bufferOutput(55);                -- 1 bit
    writeAddressOut     <= bufferOutput(65 DOWNTO 56);      -- 10 bits
    readEnableOut       <= bufferOutput(66);                -- 1 bit
    readAddressOut      <= bufferOutput(76 DOWNTO 67);      -- 10 bits

    -- 5aly el output either ALU output aw writeDataOut
    -- if readmem = 1 and regwrite = 1, LDD aw pop, yb2a writeback elly 2areto mn el memory, 8eir kda hyb2a el ALU
    -- actually kfaya check 3la mem to reg, l2n dh = 1 fy 7alet el LDD wl POP bs
    -- MEM2_WB_buffer_Output <= writeDataOut when (MemToReg_out = '1') else ALUoutputOUT;
    -- This is done in the WB stage, no need to handle it here
    
END MEM2_WB_bufferDesign;





