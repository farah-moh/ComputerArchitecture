
Library IEEE;
use IEEE.std_logic_1164.all;


entity ALU is
port  (
    A :     in std_logic_vector(15 downto 0); 
    B :     in std_logic_vector(15 downto 0); 
    sel :   in std_logic_vector (3 downto 0);
    Cin:    in std_logic;
    Cout :  out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end entity;


Architecture runningALU of ALU is

component PartA is 
port  (
    A :     in std_logic_vector(15 downto 0); 
    B :     in std_logic_vector(15 downto 0); 
    sel :   in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :  out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end component;

component PartB is 
port  (
    A :     in std_logic_vector(15 downto 0); 
    B :     in std_logic_vector(15 downto 0); 
    sel :   in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :  out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end component;

component PartC is 
port  (
    A :     in std_logic_vector(15 downto 0); 
    sel :   in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :  out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end component;

component PartD is 
port  (
    A :     in std_logic_vector(15 downto 0); 
    sel :   in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :  out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end component;

signal outputA: std_logic_vector(15 downto 0);
signal outputB: std_logic_vector(15 downto 0);
signal outputC: std_logic_vector(15 downto 0);
signal outputD: std_logic_vector(15 downto 0);
signal coutA:   std_logic;
signal coutB:   std_logic;
signal coutC:   std_logic;
signal coutD:   std_logic;

Begin
  UA: PartA port map (A,B,sel(1 downto 0),Cin,coutA,outputA);
  UB: PartB port map (A,B,sel(1 downto 0),Cin,coutB,outputB);
  UC: PartC port map (A,sel(1 downto 0),Cin,coutC,outputC);
  UD: PartD port map (A,sel(1 downto 0),Cin,coutD,outputD);

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


end runningALU;