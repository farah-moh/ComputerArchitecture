LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY PC IS
	PORT (clk, reset, enable : IN  std_logic;
		  pc : OUT std_logic_vector(5 DOWNTO 0)
        );
END PC;

ARCHITECTURE PC_design OF PC IS
BEGIN

    PROCESS (clk,reset)
    variable pcINC:std_logic_vector(5 downto 0);
    BEGIN
        IF reset = '1' THEN
            pc <= (others => '0');
            pcINC := (others => '0');
            
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                pcINC := std_logic_vector(unsigned(pc)+1);
                pc <= pcINC;
            END IF;
        END IF;
    END PROCESS;
		
END PC_design;