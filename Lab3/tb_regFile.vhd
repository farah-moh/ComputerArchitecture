Library IEEE;
USE IEEE.std_logic_1164.all;


ENTITY tb_regFile IS
END ENTITY;

ARCHITECTURE testingRegFile OF tb_regFile IS

    COMPONENT regFile IS 
    PORT  (
        clk:                IN std_logic;
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(1 DOWNTO 0);
        writeAddress :    	IN std_logic_vector(1 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writePort :         IN std_logic_vector(15 DOWNTO 0);
        readPort :          OUT std_logic_vector(15 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL test_clk:      std_logic;
    SIGNAL test_rst:      std_logic;
    SIGNAL test_readAddress:    std_logic_vector(1 DOWNTO 0);
    SIGNAL test_writeAddress:   std_logic_vector(1 DOWNTO 0);
    SIGNAL test_writeEnable:    std_logic;
    SIGNAL test_writePort:     std_logic_vector(15 DOWNTO 0);
    SIGNAL test_readPort:      std_logic_vector(15 DOWNTO 0);

    BEGIN
        U1: regFile port map (test_clk,test_rst,test_readAddress,test_writeAddress,test_writeEnable,test_writePort,test_readPort);
        
        PROCESS BEGIN
            test_clk <= '0';
            WAIT FOR 5 ns;
            test_clk <= '1';
            WAIT FOR 5 ns;
        END PROCESS;
        
        PROCESS BEGIN
            -- TEST CASE 0
            test_rst <= '1';
            test_writeEnable <= '1';
            WAIT FOR 10 ns;
            ASSERT (test_readPort=x"0000")
                REPORT "Failed Case0: " & to_hstring(test_readPort)   SEVERITY error;


            -- TEST CASE 1
            test_rst <= '0';
            test_writeEnable <= '1';
            test_writeAddress<= "00";
            test_writePort <= x"F00F";
            test_readAddress<= "00";
            WAIT FOR 10 ns;
            ASSERT (test_readPort=x"F00F")
                REPORT "Failed Case1: " & to_hstring(test_readPort)   SEVERITY error;

            -- TEST CASE 2
            -- test_rst <= '0';
            test_writeEnable <= '1';
            test_writeAddress<= "01";
            test_writePort <= x"1001";
            test_readAddress<= "00";
            WAIT FOR 10 ns;

            ASSERT (test_readPort=x"F00F")
                REPORT "Failed Case2: " & to_hstring(test_readPort)   SEVERITY error;

            
            REPORT "Done";
            WAIT;

        END PROCESS;

END testingRegFile;
