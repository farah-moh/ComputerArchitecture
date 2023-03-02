Library IEEE;
use IEEE.std_logic_1164.all;


entity tb_regFile is
end entity;

Architecture testingRegFile of tb_regFile is

    component regFile is 
    port  (
        clk:                in std_logic;
        rst :               in std_logic;
        readAddress :    	in std_logic_vector(1 downto 0);
        writeAddress :    	in std_logic_vector(1 downto 0); 
        writeEnable :       in std_logic;
        writePort :         in std_logic_vector(15 downto 0);
        readPort :          out std_logic_vector(15 downto 0)
    );
    end component;

    Signal test_clk:      std_logic;
    Signal test_rst:      std_logic;
    Signal test_readAddress:    std_logic_vector(1 downto 0);
    Signal test_writeAddress:   std_logic_vector(1 downto 0);
    Signal test_writeEnable:    std_logic;
    Signal test_writePort:     std_logic_vector(15 downto 0);
    Signal test_readPort:      std_logic_vector(15 downto 0);

    begin
        U1: regFile port map (test_clk,test_rst,test_readAddress,test_writeAddress,test_writeEnable,test_writePort,test_readPort);
        
        process begin
            test_clk <= '0';
            wait for 5 ns;
            test_clk <= '1';
            wait for 5 ns;
        end process;
        
        process begin
            -- TEST CASE 0
            test_rst <= '1';
            test_writeEnable <= '1';
            wait for 10 ns;
            assert (test_readPort=x"0000")
                report "Failed Case0: " & to_hstring(test_readPort)   severity error;


            -- TEST CASE 1
            test_rst <= '0';
            test_writeEnable <= '1';
            test_writeAddress<= "00";
            test_writePort <= x"F00F";
            test_readAddress<= "00";
            wait for 10 ns;
            assert (test_readPort=x"F00F")
                report "Failed Case1: " & to_hstring(test_readPort)   severity error;

            -- TEST CASE 2
            -- test_rst <= '0';
            test_writeEnable <= '1';
            test_writeAddress<= "01";
            test_writePort <= x"1001";
            test_readAddress<= "00";
            wait for 10 ns;

            assert (test_readPort=x"F00F")
                report "Failed Case2: " & to_hstring(test_readPort)   severity error;

            
            report "Done";
            wait;

        end process;

end testingRegFile;
