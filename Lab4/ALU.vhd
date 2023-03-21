Library IEEE;
use IEEE.std_logic_1164.all;


entity ALU is
GENERIC (bits: integer := 16);
PORT  (
    A :    	IN std_logic_vector(bits-1 DOWNTO 0);
    B :    	IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :   IN std_logic_vector (3 downto 0);
    Cin:    IN std_logic;
    Cout :  OUT std_logic;
    F :     OUT std_logic_vector(bits-1 DOWNTO 0)
);
end entity;


Architecture runningALU of ALU is

component PartA is 
GENERIC (bits: integer := 16);
PORT  (
    A :    	IN std_logic_vector(bits-1 DOWNTO 0);
    B :    	IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :       IN std_logic_vector (1 DOWNTO 0);
    Cin :       IN std_logic;
    Cout :      OUT std_logic;
    F :         OUT std_logic_vector(bits-1 DOWNTO 0)
);
end component;

COMPONENT PartB IS 
GENERIC (bits: integer := 16);
port  (
    A :    	in std_logic_vector(bits-1 downto 0);
    B :    	in std_logic_vector(bits-1 downto 0); 
    sel :       in std_logic_vector (1 downto 0);
    Cin :       in std_logic;
    Cout :      out std_logic;
    F :         out std_logic_vector(bits-1 downto 0)
);
END COMPONENT;

COMPONENT PartC IS 
GENERIC (bits: integer := 16);
PORT  (
    A :    IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :  IN std_logic_vector (1 DOWNTO 0);
    Cin:   IN std_logic;
    Cout : OUT std_logic;
    F :    OUT std_logic_vector(bits-1 DOWNTO 0)
);
END COMPONENT;

COMPONENT PartD IS 
GENERIC (bits: integer := 16);
PORT  (
    A :    IN std_logic_vector(bits-1 DOWNTO 0); 
    sel :  IN std_logic_vector (1 DOWNTO 0);
    Cin:   IN std_logic;
    Cout : OUT std_logic;
    F :    OUT std_logic_vector(bits-1 DOWNTO 0)
);
END COMPONENT;

signal outputA: std_logic_vector(bits-1 downto 0);
signal outputB: std_logic_vector(bits-1 downto 0);
signal outputC: std_logic_vector(bits-1 downto 0);
signal outputD: std_logic_vector(bits-1 downto 0);
signal coutA:   std_logic;
signal coutB:   std_logic;
signal coutC:   std_logic;
signal coutD:   std_logic;

BEGIN
    UA: PartA generic map(bits) port map (A,B,sel(1 downto 0),Cin,coutA,outputA);
    UB: PartB generic map(bits) port map (A,B,sel(1 downto 0),Cin,coutB,outputB);
    UC: PartC generic map(bits) port map (A,sel(1 downto 0),Cin,coutC,outputC);
    UD: PartD generic map(bits) port map (A,sel(1 downto 0),Cin,coutD,outputD);

    F <= outputB     when sel(3 downto 2) = "01"
    else outputC     when sel(3 downto 2) = "10"
    else outputD     when sel(3 downto 2) = "11"
    else outputA     when sel(3 downto 2) = "00"
    else x"0000";

    Cout <= coutB     when sel(3 downto 2) = "01"
    else    coutC     when sel(3 downto 2) = "10"
    else    coutD     when sel(3 downto 2) = "11"
    else    coutA     when sel(3 downto 2) = "00"
    else '0'; 


END runningALU;