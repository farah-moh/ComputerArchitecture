library IEEE;
use IEEE.std_logic_1164.all;

entity PartC is 
port  (
    A :    in std_logic_vector(15 downto 0); 
    sel :     in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :     out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end entity;

Architecture partCDesign of PartC is
begin

-- F conditions
F <= A(14 downto 0)&'0'     when sel = "00"
else A(14 downto 0)&A(15)    when sel = "01"
else A(14 downto 0)&Cin     when sel = "10"
else (others => '0')        when sel = "11";

-- Cout conditions
Cout <= '0' when sel = "11"
else A(15);

end partCDesign;
