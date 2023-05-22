LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY SP IS
	PORT (clk, reset : IN  std_logic;
          inc : IN std_logic_vector(2 DOWNTO 0);            -- inc value (2 or 1 or -1)
        --   sp_in : IN std_logic_vector(15 DOWNTO 0);         -- sp before inc
		  sp : OUT std_logic_vector(15 DOWNTO 0)            -- sp after inc
        );
END SP;

ARCHITECTURE SP_design OF SP IS
BEGIN

    PROCESS (clk,reset)
    variable spINC:std_logic_vector(15 downto 0);
    BEGIN
        IF reset = '1' THEN
            sp <= "0000001111111111";                           -- initial value of sp (1023)
            spINC := (others => '0');     
            
        ELSIF rising_edge(clk) THEN
            -- IF enable = '1' THEN
            spINC := std_logic_vector(signed(sp)+signed(inc));      -- made it signed, so that it would either add or subtract (+- 1) (extending the bits correctly)
            sp <= spINC;
            -- END IF;
        END IF;
    END PROCESS;
		
END SP_design;
