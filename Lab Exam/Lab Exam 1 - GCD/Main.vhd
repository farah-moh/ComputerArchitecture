LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY GCD IS
    PORT(
    A :    	IN std_logic_vector(31 DOWNTO 0);
    B :    	IN std_logic_vector(31 DOWNTO 0);
    clk,rst:    	IN std_logic;
    AOut :  OUT std_logic_vector(31 DOWNTO 0);
    BOut :  OUT std_logic_vector(31 DOWNTO 0);
    G :     OUT std_logic_vector(31 DOWNTO 0);
    V :     OUT std_logic
    );
END GCD;

ARCHITECTURE a_GCD OF GCD IS

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 32);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT my_modulu IS
    GENERIC (n : integer := 32);
	PORT (
    A :    	IN std_logic_vector(n-1 DOWNTO 0);
    B :    	IN std_logic_vector(n-1 DOWNTO 0); 
    M :     OUT std_logic_vector(n-1 DOWNTO 0) );
END COMPONENT;

signal AWrite:  std_logic_vector(31 DOWNTO 0);
signal BWrite:  std_logic_vector(31 DOWNTO 0);
signal Aread:   std_logic_vector(31 DOWNTO 0);
signal Bread:   std_logic_vector(31 DOWNTO 0);
signal ModRead: std_logic_vector(31 DOWNTO 0);

BEGIN
    AReg:   my_nDff generic map(32) port map(clk,rst,AWrite,Aread);
    BReg:   my_nDff generic map(32) port map(clk,rst,BWrite,Bread);
    Modulu: my_modulu generic map(32) port map(ARead,Bread,ModRead);

    PROCESS (clk,rst)
    BEGIN
        IF rst = '1' THEN
            G <= (OTHERS=>'0');
            AOut <= (OTHERS=>'0');
            BOut <= (OTHERS=>'0');
            V <= '0';
            AWrite <= A;
            BWrite <= B;
        ELSIF rising_edge(clk) THEN    
            IF NOT (to_integer(unsigned(ModRead)) = 0) THEN
                AOut <= Bread;
                BOut <= ModRead;
                AWrite <= Bread;
                BWrite <= ModRead;
                G <= Bread;
                V <= '0';
            ELSE
                V <= '1';
                AWrite <= A;
                BWrite <= B;
                G <= Bread;
            END IF;
        END IF;
    END PROCESS;
END a_GCD;