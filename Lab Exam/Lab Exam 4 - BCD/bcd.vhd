LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY bcd IS
    PORT(
    Clk,Rst:    	IN std_logic;
    A:              IN std_logic_vector(7 DOWNTO 0);
    V :     OUT std_logic;
    AOut :     OUT std_logic_vector(7 DOWNTO 0);
    F0,F1,F2: OUT std_logic_vector(3 downto 0)
    );
END bcd;

ARCHITECTURE a_bcd OF bcd IS

BEGIN
    PROCESS (Clk,Rst)
    VARIABLE result : std_logic_vector(7 DOWNTO 0) := (OTHERS=>'0');
    VARIABLE count : integer := 0;
    VARIABLE ok : integer := 0;
    BEGIN
        IF rst = '1' THEN
            generated <= '0';
            P <= (OTHERS=>'0');
            result := (OTHERS=>'0');
            count := 0;
            ok := 0;
        ELSIF rising_edge(clk) THEN    
            generated <= '0';
            IF (Valid = '1') THEN
                ok := 1;
                IF(count = 8) THEN
                    generated <= '1';
                    P <= result;
                    count := 0;
                    result := (OTHERS=>'0');
                ELSE
                    generated <= '0';
                END IF;
                result(count) := S;
                count := count + 1;
            ELSE
                IF (ok = 1) THEN
                    ok := 0;
                    IF (count > 0) THEN
                        generated <= '1';
                        P <= result;
                        result := (OTHERS=>'0');
                        count := 0;
                    ELSE
                        result := (OTHERS=>'0');
                        generated <= '0'; 
                    END IF;
                ELSE
                    count := 0;
                    result := (OTHERS=>'0');
                    generated <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
END a_bcd;
