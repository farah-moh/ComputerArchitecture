LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY my_shift IS
    GENERIC (n : integer := 2);
	PORT (
    A :    	IN std_logic_vector(n-1 DOWNTO 0);
    M :     OUT std_logic_vector(n-1 DOWNTO 0) );
END my_shift;

ARCHITECTURE a_my_shift OF my_shift IS
	BEGIN
			M <= (A(n-2 downto 0) & '0');
		
END a_my_shift;
