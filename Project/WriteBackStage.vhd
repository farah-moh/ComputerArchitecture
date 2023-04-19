LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY writeBackStage IS
    GENERIC (m: integer:= 16);
    PORT (

        regWrite, MemToReg: IN STD_LOGIC;
        RD: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALUOutput: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        MemOutput: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        regWriteOut: OUT STD_LOGIC;
        writeBackData: OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        RDOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END writeBackStage;

architecture MyWriteBackStage of writeBackStage is
    BEGIN
        writeBackData <= ALUOutput when MemToReg = '0' else MemOutput;
        regWriteOut <= regWrite;
        RDOut <= RD;
    END MyWriteBackStage;
