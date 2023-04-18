LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY regFileMem IS
    GENERIC (m: integer:= 16);
    PORT (
        clk:                IN std_logic;
        rst :               IN std_logic;
        RS1 :               IN std_logic_vector(2 DOWNTO 0);
        RS2 :               IN std_logic_vector(2 DOWNTO 0);
        RD :    	        IN std_logic_vector(2 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writeData :         IN std_logic_vector(m-1 DOWNTO 0);
        RS1Data :           OUT std_logic_vector(m-1 DOWNTO 0);
        RS2Data :           OUT std_logic_vector(m-1 DOWNTO 0) 
    );
END ENTITY regFileMem;

ARCHITECTURE regFileMemDesign OF regFileMem  IS 
    TYPE ram_type IS ARRAY(0 TO 7) OF std_logic_vector(m-1 DOWNTO 0);
    
    SIGNAL ram : ram_type ;

BEGIN
    
    PROCESS (clk,rst)
    BEGIN
        IF rst = '1' THEN
            loop1: FOR i IN 0 TO 7 LOOP
                ram(i) <= (OTHERS => '0');
            END LOOP;
            
        ELSIF rising_edge(clk) THEN
            IF writeEnable = '1' THEN
                ram(to_integer(unsigned(RD))) <= writeData;
            END IF;
        END IF;
    END PROCESS;

    RS1Data <= ram(to_integer(unsigned(RS1)));
    RS2Data <= ram(to_integer(unsigned(RS2)));

END regFileMemDesign;
