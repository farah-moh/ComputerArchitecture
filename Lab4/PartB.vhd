library IEEE;
use IEEE.std_logic_1164.all;

entity PartB is 
GENERIC (bits: integer := 16);
port  (
    A :    	in std_logic_vector(bits-1 downto 0);
    B :    	in std_logic_vector(bits-1 downto 0); 
    sel :       in std_logic_vector (1 downto 0);
    Cin :       in std_logic;
    Cout :      out std_logic;
    F :         out std_logic_vector(bits-1 downto 0)
);
end entity;

Architecture partBDesign of PartB is
begin

-- F conditions
F <= (A or B)       when sel = "00"
else (A and B)      when sel = "01"
else (A nor B)      when sel = "10"
else not(A)         when sel = "11";

-- Cout conditions
Cout <= '0';

end partBDesign;