LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY memoryStage IS           -- memory with its 2 buffers
GENERIC ( n : integer := 16);   -- n is the number of bits in the memory
PORT( 
    clk, rst :                      IN  std_logic; 
    bufferEnable :                  IN  std_logic;
    readAddress :    	            IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable :                    IN std_logic;
    writeAddress :    	            IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable :                   IN std_logic;
    writeData :                     IN std_logic_vector(n-1 DOWNTO 0);
    delayedMemoryOutput :           OUT std_logic_vector(n-1 DOWNTO 0);     -- the data that has been read from the memory, and delayed one cycle
    bufferOutput :                  OUT std_logic_vector(n-1 DOWNTO 0);     -- the data from the second buffer

    -- control signals for the WB (we only need to propagate them here)
    MemToReg_in :                     IN std_logic;
    INN_in :                          IN std_logic;
    OUTT_in :                         IN std_logic;
    MemToReg_out :                    OUT std_logic;
    INN_out :                         OUT std_logic;
    OUTT_out :                        OUT std_logic
);
END memoryStage;

ARCHITECTURE memoryStageDesign OF memoryStage IS

COMPONENT my_nDFF IS            -- buffer
GENERIC ( n : integer := 16);
PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

COMPONENT dataMem IS
GENERIC ( n : integer := 16);
PORT( 
    clk:                IN std_logic;
    rst :               IN std_logic;
    readAddress :       IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable :        IN std_logic;
    writeAddress :      IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable :       IN std_logic;
    writeData :         IN std_logic_vector(n-1 DOWNTO 0);
    readData :          OUT std_logic_vector(n-1 DOWNTO 0)      -- the data that has been read
    

);
END COMPONENT;

-- signal secondALUoperand:                    std_logic_vector(15 DOWNTO 0);
-- signal ALUoutput:                           std_logic_vector(15 DOWNTO 0);
-- signal zeroSignal,negSignal,carrySignal:    std_logic;
-- signal controlFlags:                        std_logic_vector(2 DOWNTO 0);
signal dataMemOutput:                          std_logic_vector(n-1 DOWNTO 0);
signal bufferedData:                           std_logic_vector(n-1+3 DOWNTO 0);
signal MemOutput_ControlSignals:               std_logic_vector(n-1+3 DOWNTO 0);
signal BufferedMemOutput_ControlSignals:       std_logic_vector(n-1+3 DOWNTO 0);

BEGIN

    dataMemory: dataMem GENERIC MAP(n) PORT MAP(clk, rst, readAddress, readEnable, writeAddress, writeEnable, writeData, dataMemOutput);
    

    -- We need to buffer the data from the memory, so that it is delayed by one cycle       (n bits)
    -- and also the control signals for the WB stage                                        (3 bits)
    -- so, 16+1+1+1 = 19 bits (or n + 3)
    MemOutput_ControlSignals <= dataMemOutput & MemToReg_in & INN_in & OUTT_in;
    buffer_Mem1_Mem2: my_nDFF GENERIC MAP(n+3) PORT MAP(clk, rst, MemOutput_ControlSignals, bufferedData, bufferEnable);             -- the first buffer (delays mem by one cycle)
    -- bufferedData <= delayedMemoryOutput;
    delayedMemoryOutput <= bufferedData(n-1+3 DOWNTO 3);        -- can be full forwarded (as 2 cycles have passed since the data entered memory stage) (We are at the end of the 2nd cycle here)
    buffer_Mem2_WB: my_nDFF GENERIC MAP(n+3) PORT MAP(clk, rst, bufferedData, BufferedMemOutput_ControlSignals, bufferEnable);                -- the second buffer 
    bufferOutput <= BufferedMemOutput_ControlSignals(n-1+3 DOWNTO 3);
    
    -- Now, we output the control signals for the WB stage
    MemToReg_out <= BufferedMemOutput_ControlSignals(2);
    INN_out <= BufferedMemOutput_ControlSignals(1);
    OUTT_out <= BufferedMemOutput_ControlSignals(0);


END memoryStageDesign;

