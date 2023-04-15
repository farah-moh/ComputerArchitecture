LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY s2p IS
    PORT(
    Clk,Rst,Valid,S:    	IN std_logic;
    generated :     OUT std_logic;
    P :     OUT std_logic_vector(7 DOWNTO 0)
    );
END s2p;

ARCHITECTURE a_s2p OF s2p IS

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
END a_s2p;
