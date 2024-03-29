LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity regFile is 
port  (
    clk:                in std_logic;
    rst :               in std_logic;
    readAddress :    	in std_logic_vector(1 downto 0);
    writeAddress :    	in std_logic_vector(1 downto 0); 
    writeEnable :       in std_logic;
    writePort :         in std_logic_vector(15 downto 0);
    readPort :          out std_logic_vector(15 downto 0)
);
end entity;

Architecture regFileDesign of regFile is

    Component my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
    END component;

    Component decoder IS
    PORT( 
    d : IN std_logic_vector(1 DOWNTO 0);
    writeEn: IN std_logic;
    q : OUT std_logic_vector(3 DOWNTO 0)
    );
    END component;

    signal output0: std_logic_vector(15 downto 0);
    signal output1: std_logic_vector(15 downto 0);
    signal output2: std_logic_vector(15 downto 0);
    signal output3: std_logic_vector(15 downto 0);
    signal outDecode: std_logic_vector(3 downto 0);

begin
    
    decode: decoder port map(writeAddress,writeEnable,outDecode);
    rg0:  my_nDFF port map(clk,rst,writePort,output0,outDecode(0));
    rg1:  my_nDFF port map(clk,rst,writePort,output1,outDecode(1));
    rg2:  my_nDFF port map(clk,rst,writePort,output2,outDecode(2));
    rg3:  my_nDFF port map(clk,rst,writePort,output3,outDecode(3));
            
    readPort <= output0 when readAddress = "00"
            else output1 when readAddress = "01"
            else output2 when readAddress = "10"
            else output3 when readAddress = "11"
            else (others => '0');

end regFileDesign;
