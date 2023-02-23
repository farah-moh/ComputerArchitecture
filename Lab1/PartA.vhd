library IEEE;
use IEEE.std_logic_1164.all;

entity PartA is 
port  (
    A :    	in std_logic_vector(15 downto 0);
    B :    	in std_logic_vector(15 downto 0); 
    sel :       in std_logic_vector (1 downto 0);
    Cin :       in std_logic;
    Cout :      out std_logic;
    F :         out std_logic_vector(15 downto 0)
);
end entity;

Architecture partADesign of PartA is

component adder16bit IS
PORT(
    A :    in std_logic_vector(15 downto 0); 
    B :    in std_logic_vector(15 downto 0);
    Cin:   in std_logic;
    Cout : out std_logic;
    F :    out std_logic_vector(15 downto 0)
);
END component;

signal sigB: std_logic_vector(15 downto 0);
signal sum: std_logic_vector(15 downto 0);
signal sigCout: std_logic;

begin

-- B conditions
sigB <= (others=>'0')  when sel = "00"
else B                 when sel = "01"
else not(B)            when sel = "10"
else (others=>'1');

add16: adder16bit port map(A,sigB,Cin,sigCout,sum);

F <= B when sel&Cin = "111"
else sum;

Cout <= '0' when sel&Cin = "111"
else sigCout;


end partADesign;
