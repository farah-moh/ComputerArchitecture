LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder16bit IS
    GENERIC (bits: integer := 16);
    PORT(
        A :    IN std_logic_vector(bits-1 DOWNTO 0); 
        B :    IN std_logic_vector(bits-1 DOWNTO 0);
        Cin:   IN std_logic;
        Cout : OUT std_logic;
        F :    OUT std_logic_vector(bits-1 DOWNTO 0)
    );
END adder16bit;

ARCHITECTURE arch_adder16bit OF adder16bit is
    
    COMPONENT my_nadder IS
    GENERIC (n: integer := 1);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
    END component;
    
    component select_adder IS
    generic (n: integer := 1);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
    END component;

    signal temp: std_logic_vector(bits-1 downto 0);

    begin
    
        ripAdd: my_nadder generic map(1) port map(A(0 downto 0),B(0 downto 0),Cin,F(0 downto 0),temp(0));

        loop1: for i in 1 to bits-1 generate
            fx:select_adder generic map(1) port map(A(i downto i),B(i downto i),temp(i-1),F(i downto i),temp(i));
        end generate;
        Cout <= temp(bits-1);
        -- fx1: select_adder generic map(4) port map(A(7 downto 4),B(7 downto 4),temp(0),F(7 downto 4),temp(1));
        -- fx2: select_adder generic map(4) port map(A(11 downto 8),B(11 downto 8),temp(1),F(11 downto 8),temp(2));
        -- fx3: select_adder generic map(4) port map(A(15 downto 12),B(15 downto 12),temp(2),F(15 downto 12),Cout);

END arch_adder16bit;