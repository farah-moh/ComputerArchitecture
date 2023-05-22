library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ControlHazardUnit is
port(
    memOne:                 IN std_logic_vector(15 downto 0);
    counter:                IN std_logic_vector(2 downto 0);
    PcSrcID:                IN std_logic;
    PcSrcEX:                IN std_logic;
    PcSrcMEM2_WB:           IN std_logic;
    RS1DataID:              IN std_logic_vector(15 downto 0);
    RS1DataEX:              IN std_logic_vector(15 downto 0);
    BufferOutputMEM2_Wb:    IN std_logic_vector(15 downto 0);
    PcSelect:               OUT std_logic;
    PcData:                 OUT std_logic_vector(15 downto 0);
    IF_ID_Flush:            OUT std_logic;
    ID_EX_Flush:            OUT std_logic;
    EX_MEM1_Flush:          OUT std_logic;
    MEM1_MEM2_Flush:        OUT std_logic;
    MEM2_WB_Flush:          OUT std_logic

);
end entity;



architecture MYControlHazardUnit of ControlHazardUnit is
begin
    -- Was -1
    PcData <=   memOne when counter = "100" else
                BufferOutputMEM2_Wb - 1  when PcSrcMEM2_WB = '1' else
                RS1DataEX - 1  when PcSrcEX = '1' else
                RS1DataID - 1  when PcSrcID = '1' else
                (others=>'0');
    


    PcSelect <= '1' when (counter = "100") else
                 (PcSrcID or PcSrcEX or PcSrcMEM2_WB) ;
    

    IF_ID_Flush <= '1' when (counter /= "000") else
        -- hn3ooz nzawed condition hena, lw CALL aw JMP unconditional, msh hn3ml flush awl mara
                    PcSrcID or PcSrcEX or PcSrcMEM2_WB;
    ID_EX_Flush <= PcSrcEX or PcSrcMEM2_WB;
    EX_MEM1_Flush <= PcSrcMEM2_WB;
    MEM1_MEM2_Flush <= PcSrcMEM2_WB;
    MEM2_WB_Flush <= PcSrcMEM2_WB;
    
 
    
end MYControlHazardUnit;
