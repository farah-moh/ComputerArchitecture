LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY modo IS
    GENERIC (bits: integer := 32);
    PORT(
        A :    IN std_logic_vector(bits-1 DOWNTO 0); 
        B :    IN std_logic_vector(bits-1 DOWNTO 0);
        F :    OUT std_logic_vector(bits-1 DOWNTO 0)
    );
END modo;

ARCHITECTURE mod_design OF modo is
    begin

    F <= std_logic_vector(unsigned(A) mod unsigned(B));
        
END mod_design;
