LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY FetchDecodeReg IS
    PORT( Clk,Rst : IN std_logic;
    cin : IN std_logic_vector(15 DOWNTO 0);
    cout : OUT std_logic_vector(15 DOWNTO 0);
    enable: IN std_logic);
END FetchDecodeReg;

ARCHITECTURE FetchDecodeReg_design OF FetchDecodeReg IS
BEGIN
    PROCESS (Clk,Rst)
    BEGIN
        IF Rst = '1' THEN
        cout <= (OTHERS=>'0');
        ELSIF rising_edge(Clk) THEN
            IF enable = '1' THEN
                cout <= cin;
            END IF;
        END IF;
    END PROCESS;
END FetchDecodeReg_design;
