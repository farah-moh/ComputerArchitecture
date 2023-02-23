LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder16bit IS
    PORT(
        A :    in std_logic_vector(15 downto 0); 
        B :    in std_logic_vector(15 downto 0);
        Cin:   in std_logic;
        Cout : out std_logic;
        F :    out std_logic_vector(15 downto 0)
    );
END adder16bit;

ARCHITECTURE arch_adder16bit OF adder16bit is
    
    component my_nadder IS
    generic (n: integer := 4);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
    END component;
    
    component select_adder IS
    generic (n: integer := 4);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
    END component;

    signal temp: std_logic_vector(3 downto 0);

    begin
    
        ripAdd: my_nadder generic map(4) port map(A(3 downto 0),B(3 downto 0),Cin,F(3 downto 0),temp(0));
        fx1: select_adder generic map(4) port map(A(7 downto 4),B(7 downto 4),temp(0),F(7 downto 4),temp(1));
        fx2: select_adder generic map(4) port map(A(11 downto 8),B(11 downto 8),temp(1),F(11 downto 8),temp(2));
        fx3: select_adder generic map(4) port map(A(15 downto 12),B(15 downto 12),temp(2),F(15 downto 12),Cout);
        

END arch_adder16bit;