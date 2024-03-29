LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY PC IS
	PORT (clk, reset, enable : IN  std_logic;
          inc : IN std_logic_vector(15 DOWNTO 0);
          pcSel : IN std_logic;
          pcData : IN std_logic_vector(15 DOWNTO 0);
		  pc : OUT std_logic_vector(15 DOWNTO 0);
          memZero: IN std_logic_vector(15 DOWNTO 0)
        );
END PC;

ARCHITECTURE PC_design OF PC IS
BEGIN

    PROCESS (clk,reset,memZero)
    variable pcINC:std_logic_vector(15 downto 0);
    BEGIN
        IF reset = '1' THEN
            -- pc <= (others => '0');
            pc <= memZero;
            pcINC := (others => '0');
        -- Was rising
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                pcINC := std_logic_vector(unsigned(pc)+unsigned(inc));
                IF pcSel = '1' THEN
                    pc <= pcData;
                ELSE
                    pc <= pcINC;
                END IF;
            END IF;
        END IF;
    END PROCESS;
		
END PC_design;
