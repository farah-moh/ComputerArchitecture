LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY regFileMem IS
    GENERIC (m: integer:= 16);
    PORT (
        clk:                IN std_logic;
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(1 DOWNTO 0);
        writeAddress :    	IN std_logic_vector(1 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writePort :         IN std_logic_vector(m-1 DOWNTO 0);
        readPort :          OUT std_logic_vector(m-1 DOWNTO 0) 
    );
END ENTITY regFileMem;

ARCHITECTURE regFileMemDesign OF regFileMem  IS 
    TYPE ram_type IS ARRAY(0 TO 3) OF std_logic_vector(m-1 DOWNTO 0);
    
    SIGNAL ram : ram_type ;

BEGIN
    
    PROCESS (clk,rst)
    BEGIN
        IF rst = '1' THEN
            loop1: FOR i IN 0 TO 3 LOOP
                ram(i) <= (OTHERS => '0');
            END LOOP;
            
        ELSIF rising_edge(clk) THEN
            IF writeEnable = '1' THEN
                ram(to_integer(unsigned(writeAddress))) <= writePort;
            END IF;
        END IF;
    END PROCESS;

    readPort <= ram(to_integer(unsigned(readAddress)));

END regFileMemDesign;

-- ASK ?!!
-- 1) Why is the readPort outside the process ?
-- 2) What if i want to have a component inside while still using arrays ?
-- 3) Warning meta value detected beacuse of to_integer