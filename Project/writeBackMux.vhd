LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY writeBackMux IS
    GENERIC (m: integer:= 16);
    PORT (
        MemToReg: IN STD_LOGIC;
        ALUOutput: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        MemOutput: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        writeBackData: OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)
    );
END writeBackMux;

architecture MyMux of writeBackMux is
    BEGIN
        writeBackData <= ALUOutput when MemToReg = '0' else MemOutput;
    END MyMux;
