LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PartA IS 
GENERIC (bits: integer := 16);
PORT  (
    A :    	IN std_logic_vector(bits-1 DOWNTO 0);
    B :    	IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :       IN std_logic_vector (1 DOWNTO 0);
    Cin :       IN std_logic;
    Cout :      OUT std_logic;
    F :         OUT std_logic_vector(bits-1 DOWNTO 0)
);
end entity;

Architecture partADesign of PartA is

component adder16bit IS
GENERIC (bits: integer := 16);
PORT(
        A :    IN std_logic_vector(bits-1 DOWNTO 0); 
        B :    IN std_logic_vector(bits-1 DOWNTO 0);
        Cin:   IN std_logic;
        Cout : OUT std_logic;
        F :    OUT std_logic_vector(bits-1 DOWNTO 0)
);
END component;

signal sigB: std_logic_vector(bits-1 downto 0);
signal sum: std_logic_vector(bits-1 downto 0);
signal sigCout: std_logic;

begin

-- B conditions
sigB <= (others=>'0')  when sel = "00"
else B                 when sel = "01"
else not(B)            when sel = "10"
else (others=>'1');

add16: adder16bit generic map (bits) port map(A,sigB,Cin,sigCout,sum);

F <= B when sel&Cin = "111"
else sum;

Cout <= '0' when sel&Cin = "111"
else sigCout;


end partADesign;
