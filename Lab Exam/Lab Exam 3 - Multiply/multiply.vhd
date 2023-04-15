LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY multiply IS
GENERIC (n: integer := 3);
    PORT(
    Clk,Rst,Enable:    	IN std_logic;
    A,B :    	in std_logic_vector(n-1 downto 0);
    M :         out std_logic_vector(2*n-1 downto 0);
    Valid:      out std_logic
    );
END multiply;

ARCHITECTURE a_multiply OF multiply IS

BEGIN
    PROCESS (Clk,Rst)
    VARIABLE index : integer := 0;
    VARIABLE temp : std_logic_vector(2*n-1 DOWNTO 0) := (OTHERS=>'0');
    VARIABLE tempB : std_logic_vector(2*n-1 DOWNTO 0) := (OTHERS=>'0');
    BEGIN
        IF rst = '1' THEN
            M <= (OTHERS=>'0');
            index := 0;
            temp := (OTHERS=>'0');
            tempB := (OTHERS=>'0');
            Valid <= '0';
        ELSIF rising_edge(clk) THEN      
            IF(Enable = '1') THEN
                IF NOT (index = n) THEN
                    IF(B(index) = '1') THEN
                        tempB(n-1 downto 0) := A;
                    ELSE 
                        tempB := (OTHERS=>'0');
                    END IF;
                    temp := std_logic_vector((unsigned(tempB) SLL index) + unsigned(temp));
                    M <= temp;
                    index := index + 1;
                else
                    M <= temp;
                    Valid <= '1';
                END IF;
            END IF;
            END IF;
    END PROCESS;
END a_multiply;

