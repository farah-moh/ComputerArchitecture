library IEEE;
use IEEE.std_logic_1164.all;

ENTITY PartD IS 
GENERIC (bits: integer := 16);
PORT  (
    A :    IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :  IN std_logic_vector (1 DOWNTO 0);
    Cin:   IN std_logic;
    Cout : OUT std_logic;
    F :    OUT std_logic_vector(bits-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE partDDesign OF PartD IS
BEGIN

-- F conditions
F <= '0'&A(bits-1 downto 1)     when sel = "00"
else A(0)&A(bits-1 downto 1)    when sel = "01"
else Cin&A(bits-1 downto 1)     when sel = "10"
else A(bits-1)&A(bits-1 downto 1)   when sel = "11";

-- Cout conditions
Cout <= '0' when sel = "11"
else A(0);

end partDDesign;
