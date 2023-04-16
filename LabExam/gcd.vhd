LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY gcd IS
    GENERIC (bits: integer := 32);
    PORT(
        rst:       IN std_logic;
        clk :      IN std_logic;
        A :        IN std_logic_vector(bits-1 DOWNTO 0); 
        B :        IN std_logic_vector(bits-1 DOWNTO 0);
        G :        OUT std_logic_vector(bits-1 DOWNTO 0);
        A_out :    OUT std_logic_vector(bits-1 DOWNTO 0);
        B_out :    OUT std_logic_vector(bits-1 DOWNTO 0);
        V:         OUT std_logic
    );
END gcd;

ARCHITECTURE gcd_design OF gcd is
    
    COMPONENT modo IS
    GENERIC (bits: integer := 32);
    PORT(
        A :    IN std_logic_vector(bits-1 DOWNTO 0); 
        B :    IN std_logic_vector(bits-1 DOWNTO 0);
        F :    OUT std_logic_vector(bits-1 DOWNTO 0)
    );
    END COMPONENT;

    signal modOut: std_logic_vector(bits-1 downto 0);
    signal tempX:  std_logic_vector(bits-1 downto 0);
    signal tempY:  std_logic_vector(bits-1 downto 0);
    signal tempR:  std_logic_vector(bits-1 downto 0);

    BEGIN
        
        -- tempX <= A_out;
        -- tempY <= B_out;
        modo1: modo generic map(32) port map(tempX,tempY,modOut);
        
        PROCESS (clk,rst,tempR,modOut)
        BEGIN
            IF falling_edge(clk) THEN
                if modOut > ("00000000000000000000000000000000") THEN
                    tempR <= modOut;
                END IF;
            END IF;
            
            IF rst = '1' THEN
                G <= (OTHERS=>'0');
                A_out <= (OTHERS=>'0');
                B_out <= (OTHERS=>'0');
                V <= '0';
                tempX <= A;
                tempY <= B;
                tempR <= modOut;
            ELSIF rising_edge(clk) THEN
                if modOut > ("00000000000000000000000000000000") THEN
                    tempR <= modOut;
                    tempX <= tempY;
                    tempY <= tempR;
                ELSE
                    G <= tempY;
                    V <= '1';
                END IF;
            END IF; 
        END PROCESS;

END gcd_design;
