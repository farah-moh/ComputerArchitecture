LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY bcd IS
    GENERIC (bits: integer := 8);
    PORT(
        rst:       IN std_logic;
        clk :      IN std_logic;
        A :        IN std_logic_vector(7 DOWNTO 0); 
        F1 :       OUT std_logic_vector(3 DOWNTO 0);
        F2 :       OUT std_logic_vector(3 DOWNTO 0);
        F3 :       OUT std_logic_vector(3 DOWNTO 0);
        A_out :    OUT std_logic_vector(7 DOWNTO 0);
        V:         OUT std_logic
    );
END bcd;

ARCHITECTURE bcd_design OF bcd is
    
    COMPONENT shiftl IS
    PORT(
        A :    IN std_logic_vector(7 DOWNTO 0); 
        F :    OUT std_logic_vector(7 DOWNTO 0)
    );
    END COMPONENT;

    signal temp: std_logic_vector(19 downto 0);
    signal shiftOut: std_logic_vector(19 downto 0);

    BEGIN
        shiftl1: shiftl port map(temp,shiftOut);
        
        PROCESS (clk,rst)
        BEGIN
            IF rst = '1' THEN
               F1 <= (others=>'0');
               F2 <= (others=>'0');
               F3 <= (others=>'0');
               A_out <= (others=>'0');
               V <= '0';
            ELSIF rising_edge(clk) THEN

            END IF; 
        END PROCESS;

END bcd_design;

