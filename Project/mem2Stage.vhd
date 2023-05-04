
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY mem2Stage IS
GENERIC ( n : integer := 16);   -- n is the number of bits in the memory
PORT( 
    clk:               IN std_logic;
    rst:               IN std_logic;
    readAddress:       IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable:        IN std_logic;
    writeAddress:      IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable:       IN std_logic;
    writeData:         IN std_logic_vector(n-1 DOWNTO 0);
    dataMemOutput:     OUT std_logic_vector(n-1 DOWNTO 0)      -- the data that has been read

);
END mem2Stage;

ARCHITECTURE mem2StageDesign OF mem2Stage IS

COMPONENT dataMem IS
GENERIC ( n : integer := 16);
PORT( 
    clk:               IN std_logic;
    rst:               IN std_logic;
    readAddress:       IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable:        IN std_logic;
    writeAddress:      IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable:       IN std_logic;
    writeData:         IN std_logic_vector(n-1 DOWNTO 0);
    readData:          OUT std_logic_vector(n-1 DOWNTO 0)      -- the data that has been read
    -- Memzero :           OUT std_logic_vector(n-1 DOWNTO 0)       -- value of PC in case of reset
);
END COMPONENT;


BEGIN
    dataMemory: dataMem GENERIC MAP(n) PORT MAP(clk, rst, readAddress, readEnable, writeAddress, writeEnable, writeData, dataMemOutput);
END mem2StageDesign;