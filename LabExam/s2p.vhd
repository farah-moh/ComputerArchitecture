LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY s2p IS
    PORT(
        Clk :      IN std_logic;
        Rst:       IN std_logic;
        Valid :    IN std_logic; 
        S :        IN std_logic;
        Generated: OUT std_logic;
        P:         OUT std_logic_vector(7 downto 0)
    );
END s2p;

ARCHITECTURE s2p_design OF s2p is
    BEGIN
        PROCESS (Clk,Rst)
        variable count : integer :=0;
        variable temp : std_logic_vector(7 downto 0) := (others => '0');
        variable ok : integer :=0;
        BEGIN
            IF Rst = '1' THEN
                count := 0;
                Generated <= '0';
                P <= (others => '0');
                temp := (others => '0');
                ok := 0;

            ELSIF rising_edge(Clk) THEN
                IF Valid = '1' THEN
                    ok := 1;
                    IF count = 8 THEN
                        Generated <= '1';
                        P <= temp;
                        temp := (others => '0'); 
                        count := 0;
                    else
                        IF count = 0 THEN
                            temp := (others => '0');
                        END IF;
                        Generated <= '0';
                    END IF;
                    temp(count) := S;
                    count := count + 1;
                ELSE
                    IF ok = 1 then
                        IF NOT(count = 0) then
                            Generated <= '1';
                            P <= temp;
                        else
                            Generated <= '0';
                        End if;
                        temp := (others => '0');
                        ok := 0;
                    else
                        Generated <= '0';
                        temp := (others => '0');
                    END IF;
                    count := 0;
                END IF;
            END IF; 
        END PROCESS;

END s2p_design;

