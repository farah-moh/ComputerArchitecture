LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY writeBackStage IS
    GENERIC (m: integer:= 16);
    PORT (
        regWrite, MemToReg, inPort,outPort: IN STD_LOGIC;
        RD: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALUOutput, MemOutput, RS1Data: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        regWriteOut: OUT STD_LOGIC;
        writeBackData,outPortoutput: OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        RDOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END writeBackStage;

architecture MyWriteBackStage of writeBackStage is
    BEGIN
        -- writeBackData <= InPortoutput when inPort = '1' and memToreg = '0' else
        --                  MemOutput when MemToReg = '1' and inPort = '0' else
        --                  ALUOutput;
        writeBackData <= MemOutput when MemToReg = '1' else --WILL BE TESTEDDDDD
                         ALUOutput;

        outPortoutput <= RS1Data when outPort = '1' else
                         (others => '0');
        regWriteOut <= regWrite;
        RDOut <= RD;
    END MyWriteBackStage;
