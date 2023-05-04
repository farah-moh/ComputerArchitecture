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
BEGIN
    -- The immediate signal is passed through the buffers
    PROCESS (opcode,zeroFlag,negFlag,carryFlag) 
    variable flagSig: std_logic_vector(2 DOWNTO 0):="000";
    BEGIN
        IF opcode(4 downto 3) = "11" THEN    -- ALU
            flagSig := (carryFlag & negFlag & zeroFlag);
        ELSIF opcode = "00001" THEN         -- SETC
            flagSig(2) := '1';
        ELSIF opcode = "00010" THEN         --CLRC
            flagSig(2) := '0';
        ELSIF opcode = "10000" THEN         --JZ
            flagSig(0) := '0';
        ELSIF opcode = "10001" THEN         --JC
            flagSig(2) := '0';
        ELSE
        END IF;
        flags <= flagSig;
    END PROCESS;
END flagControlUnitDesign;
