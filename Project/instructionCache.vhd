LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY instructionCache IS
    GENERIC (m: integer:= 16);
    PORT (
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(9 DOWNTO 0);
        instruction :       OUT std_logic_vector(m-1 DOWNTO 0); 
        immediate :         OUT std_logic_vector(m-1 DOWNTO 0);
        memZero :           OUT std_logic_vector(m-1 DOWNTO 0);
        memOne :           OUT std_logic_vector(m-1 DOWNTO 0)

    );
END ENTITY instructionCache;

ARCHITECTURE instructionCache_design OF instructionCache  IS 
    TYPE ram_type IS ARRAY(0 TO 2**10 - 1) OF std_logic_vector(m-1 DOWNTO 0);
    
    SIGNAL ram : ram_type ;
    
BEGIN
    
    -- PROCESS (rst)
    -- BEGIN
    --     IF rst = '1' THEN
    --         loop1: FOR i IN 2 TO 2**10-1 LOOP
    --             ram(i) <= (OTHERS => '0');
    --         END LOOP;
    --     END IF;     
    -- END PROCESS;

    memZero <= ram(0);
    memOne <= ram(1);
    instruction  <= ram(to_integer(unsigned(readAddress)));
    immediate    <= ram(to_integer(unsigned(readAddress))+1);

END instructionCache_design;