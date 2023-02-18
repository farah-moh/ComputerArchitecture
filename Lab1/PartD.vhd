library IEEE;
use IEEE.std_logic_1164.all;

entity PartD is 
port  (
    A :    in std_logic_vector(15 downto 0); 
    sel :     in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :     out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end entity;

Architecture partDDesign of PartD is
begin

-- F conditions
F <= '0'&A(15 downto 1)     when sel = "00"
else A(0)&A(15 downto 1)    when sel = "01"
else Cin&A(15 downto 1)     when sel = "10"
else A(15)&A(15 downto 1)   when sel = "11";

-- Cout conditions
Cout <= '0' when sel = "11"
else A(0);

end partDDesign;
