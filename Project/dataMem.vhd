library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity dataMem is
Generic (n: integer := 16);         -- data size is 2 bytes
port(
    clk:                IN std_logic;
    rst :               IN std_logic;
    readAddress :    	IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable :        IN std_logic;
    writeAddress :    	IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable :       IN std_logic;
    writeData :         IN std_logic_vector(n-1 DOWNTO 0);
    readData :          OUT std_logic_vector(n-1 DOWNTO 0)      -- the data that has been read
    -- Memzero :           OUT std_logic_vector(n-1 DOWNTO 0)       -- value of PC in case of reset
);
end entity;



architecture dataMemDesign of dataMem is
TYPE ram_type IS ARRAY(0 TO 2**10-1) of std_logic_vector(n-1 DOWNTO 0);			-- 1024 registers of 16 bits
    signal ram : ram_type;

begin

    PROCESS (clk,rst)
    BEGIN
        -- IF rst = '1' THEN            -- Mem doesnt have reset
        --     -- we can do it like this
        --     -- loop1: FOR i IN 0 TO 2**10-1 LOOP
        --     --     ram(i) <= (OTHERS => '0');
        --     -- END LOOP;

        --     -- or this
        --     -- ram <= (others=>x"0000");

        --     -- or preferably this
        --     ram <= (others=>(others=>'0'));
            
        -- ELSIF rising_edge(clk) THEN
        IF rising_edge(clk) and writeEnable = '1' THEN
                ram(to_integer(unsigned(writeAddress))) <= writeData;
            ELSE
            -- END IF;
        END IF;
    END PROCESS;

    -- Memzero <= ram(0);      -- value of PC in case of reset
    readData <= ram(to_integer(unsigned((readAddress)))) WHEN readEnable = '1'
    ELSE (OTHERS => '0');   -- synthesizable? Latch?
    
end dataMemDesign;
