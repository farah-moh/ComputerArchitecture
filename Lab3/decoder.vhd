LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY decoder IS
PORT( 
 d : IN std_logic_vector(1 DOWNTO 0);
 writeEn: IN std_logic;
 q : OUT std_logic_vector(3 DOWNTO 0)
);
END decoder;

ARCHITECTURE decoderDesign OF decoder IS
BEGIN
    PROCESS (d,writeEn) BEGIN
        IF writeEn = '1' THEN
            IF d = "00" THEN
                q <= "0001";
            ELSIF d = "01" THEN
                q <= "0010";
            ELSIF d = "10" THEN
                q <= "0100";
            ELSIF d = "11" THEN
                q <= "1000";
            ELSE
                q <= (others => '0');
                
            END IF;
        else
            q <= (others => '0');
        END IF;
    END PROCESS;
END decoderDesign;