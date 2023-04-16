LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY multi IS
    PORT(
        rst:       IN std_logic;
        clk :      IN std_logic;
        en :       IN std_logic;
        A :        IN std_logic_vector(2 DOWNTO 0); 
        B :        IN std_logic_vector(2 DOWNTO 0);
        F :        OUT std_logic_vector(5 DOWNTO 0)
    );
END multi;

ARCHITECTURE multi_design OF multi is 
    BEGIN
        PROCESS (clk,rst)
            variable count: integer :=0;
            variable res: std_logic_vector(5 DOWNTO 0) := (others => '0');
            variable tempB: std_logic_vector(5 DOWNTO 0) := (others => '0');
            variable tempSll: std_logic_vector(5 DOWNTO 0) := (others => '0');
            
        BEGIN
            IF rst = '1' THEN
                F <= (others => '0');
                count := 0;
                res := (others => '0');
            ELSIF rising_edge(clk) and en = '1' THEN
                if count <= 2 then
                    tempSll(2 downto 0) := A;
                    tempB := (others => B(count));
                    res := std_logic_vector(((unsigned(tempSll) and unsigned(tempB)) sll count) + unsigned(res));
                    tempSll := (others => '0');
                    count := count + 1;
                end if;
                if count = 3 then
                    F <= res;
                    res := (others => '0');
                    count := 0;   
                end if; 
            END IF; 
        END PROCESS;

END multi_design;
