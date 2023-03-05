library IEEE;
use IEEE.std_logic_1164.all;

ENTITY PartC IS
GENERIC (bits: integer := 16);
PORT  (
    A :    IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :  IN std_logic_vector (1 DOWNTO 0);
    Cin:   IN std_logic;
    Cout : OUT std_logic;
    F :    OUT std_logic_vector(bits-1 DOWNTO 0)
);
END ENTITY;

Architecture partCDesign of PartC is
begin

-- F conditions
F <= A(bits-2 downto 0)&'0'         when sel = "00"
else A(bits-2 downto 0)&A(bits-1)   when sel = "01"
else A(bits-2 downto 0)&Cin         when sel = "10"
else (others => '0')                when sel = "11";

-- Cout conditions
Cout <= '0' when sel = "11"
else A(bits-1);

end partCDesign;
