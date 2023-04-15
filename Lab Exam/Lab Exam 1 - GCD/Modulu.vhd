LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY my_modulu IS
    GENERIC (n : integer := 32);
	PORT (
    A :    	IN std_logic_vector(n-1 DOWNTO 0);
    B :    	IN std_logic_vector(n-1 DOWNTO 0); 
    M :     OUT std_logic_vector(n-1 DOWNTO 0) );
END my_modulu;

ARCHITECTURE a_my_modulu OF my_modulu IS
	BEGIN
			M <= std_logic_vector(unsigned(A) MOD unsigned(B));
		
END a_my_modulu;
