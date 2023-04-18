LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY flagControlUnit IS
PORT( 
 opcode:                         IN std_logic_vector(4 DOWNTO 0);
 zeroFlag,negFlag,carryFlag:     IN std_logic;
 flags:                          OUT std_logic_vector(2 DOWNTO 0) -- 2: carry, 1: negative, 0: zero
);
END flagControlUnit;

ARCHITECTURE flagControlUnitDesign OF flagControlUnit IS

TYPE OPERATIONS IS
    (NOTT,INC,DEC,MOV,ADD,SUB,ANDD,ORR);
BEGIN
    -- The immediate signal is passed through the buffers
    PROCESS (opcode,zeroFlag,negFlag,carryFlag) 
        variable operation: OPERATIONS;
        variable result: std_logic_vector(16 DOWNTO 0);
    BEGIN
        IF opcode(4 downto 3) = "11" THEN    -- ALU
            flags <= (carryFlag & negFlag & zeroFlag);
        ELSIF opcode = "00001" THEN         -- SETC
            flags(2) <= '1';
        ELSIF opcode = "00010" THEN         --CLRC
            flags(2) <= '0';
        ELSIF opcode = "10000" THEN         --JZ
            flags(0) <= '0';
        ELSIF opcode = "10001" THEN         --JC
            flags(2) <= '0';
        ELSE
        END IF;
    END PROCESS;
END flagControlUnitDesign;
