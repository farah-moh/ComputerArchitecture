LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY controller IS
PORT( 
 instruction : IN std_logic_vector(15 DOWNTO 0);
 writeEnable:  OUT std_logic;
 ALUOp:        OUT std_logic_vector(3 DOWNTO 0)
);
END controller;

ARCHITECTURE controllerDesign OF controller IS
BEGIN
    PROCESS (instruction) 
        variable opCode:std_logic_vector(2 downto 0);
    BEGIN
        opCode := instruction(15 DOWNTO 13);
        IF opCode = "100" THEN
            writeEnable <= '1';
            ALUOp <= "0111";
        ELSIF opCode = "000" THEN
            writeEnable <= '1';
            ALUOp <= "1000";
        ELSE
            writeEnable <= '0';
            ALUOp <= "1011";
        END IF;
    END PROCESS;
END controllerDesign;
