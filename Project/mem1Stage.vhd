LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY mem1Stage IS
PORT( 
    clk, reset :                           IN  std_logic; 
    spInc, spDec:                          IN std_logic;        -- sp increment or decrement according to push or pop
    -- sp_in:                                 IN std_logic_vector(15 DOWNTO 0);
    writeEnable:                           IN std_logic;        -- write enable signal
    readEnable:                            IN std_logic;        -- read enable signal
    -- will take interrupt input as well in the next phase

    -- write: RS2, SP ------- Read: Rs1, SP
    -- we can just call them address in general, instead of read/write address
    -- Read adress is either SP, or Rs1Data
    Rs1Data:                             IN std_logic_vector(15 DOWNTO 0);
    -- Write address is either SP, or Rs2Data
    Rs2Data:                             IN std_logic_vector(15 DOWNTO 0);

    

    -- WBData:                          IN std_logic_vector(15 DOWNTO 0)           -- data from WB stage 
    -- WBData will be used in the next phase (hazards)
    Data:                                OUT std_logic_vector(15 DOWNTO 0);        -- data to be written to the address (if write enable is 1)
    Address:                             OUT std_logic_vector(9 DOWNTO 0);         -- address that will be given to the memory

    pcSrc:                               IN std_logic;                           
    PC:                                  IN std_logic_vector(15 DOWNTO 0);
    InterruptSignal:                     IN std_logic                             
    
);
END mem1Stage;

ARCHITECTURE mem1StageDesign OF mem1Stage IS

COMPONENT SP IS
	PORT (clk, reset : IN  std_logic;
          inc : IN std_logic_vector(1 DOWNTO 0);            -- inc value (1 or -1)
        --   sp_in : IN std_logic_vector(15 DOWNTO 0);         -- sp before inc
		  sp : OUT std_logic_vector(15 DOWNTO 0) 
        );
END COMPONENT;


signal inc:                                 std_logic_vector(1 DOWNTO 0);
-- signal sp_in:                               std_logic_vector(15 DOWNTO 0);
signal sp_out:                              std_logic_vector(15 DOWNTO 0);
signal PCresult:                            std_logic_vector(15 DOWNTO 0);

BEGIN
    
    
    inc <= "01" when spInc = '1' else "11" when spDec = '1' else "00";
    -- inc = 1 when spInc = '1' else -1 when spDec = '1' else 0;

    sp_component: SP port map(clk,reset,inc,sp_out);

    -- sp_out w RS1Data w RS2Data hy5osho 3la mux, el output bta3o howa el address
    Address <= sp_out(9 downto 0) when InterruptSignal = '1' else       -- msh mot2aked mn dyh brdo awy, bs azon sa7 3lshan y-save el makan
               sp_out(9 downto 0) when spInc = '1' else
               sp_out(9 downto 0) + 1 when spDec = '1' else
               Rs1Data(9 downto 0) when readEnable = '1' else
               Rs2Data(9 downto 0) when writeEnable = '1' else
               (others => '0');

    -- Rs1Data w EX/MEM1.PC + 1 hy5osho 3la mux, wl output howa el data
    -- wl interrupts hteb2a PC bs badal PC + 1
    -- bs dh next phase, for now hya Rs1Data 3la tool
    
    -- yenfa3 a3ml + 1 3ady kda wala lazem gowa process?
    Data <= PC when InterruptSignal = '1' else              -- Check on interrupt first, as it has highest priority
            -- saves PC, 3lshan lama yrg3 yrg3 3la el instruction elly et3mlha interrupt (y3ny yrg3 y3mlha fetch tany)
            PC + 1 when spDec = '1' and pcSrc = '1' else
            Rs1Data; --when spDec = '1' else    
            --(others => '0');
    -- Data <= Rs1Data;
    

END mem1StageDesign;


