LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY shiftL IS
    PORT(
        A :    IN std_logic_vector(7 DOWNTO 0); 
        F :    OUT std_logic_vector(7 DOWNTO 0)
    );
END shiftL;

ARCHITECTURE shiftL_design OF shiftL is
    begin

    F <= A(6 downto 0) & '0';
        
END shiftL_design;

