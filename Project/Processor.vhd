LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


entity Processor is
PORT  (
    clk, reset, enable:    	IN std_logic;
    INPort:             	IN std_logic_vector(15 DOWNTO 0);
    OUTPort:           	    OUT std_logic_vector(15 DOWNTO 0)
);
end entity;


Architecture Processor_design of Processor is
    --####################FETCH STAGE#####################
    signal instruction_IF, immediate_IF, PC_IF: std_logic_vector(15 DOWNTO 0);
    --##################FETCH/DECODE BUFFER###############
    signal RS1_IF_ID_buff, RS2_IF_ID_buff : std_logic_vector(2 DOWNTO 0);
    signal instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff : std_logic_vector(15 DOWNTO 0);
    --####################DECODE STAGE#####################
    signal RS1Data_ID, RS2Data_ID: std_logic_vector(15 DOWNTO 0);
    signal regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID: std_logic;
    --##################DECODE/EXECUTE BUFFER##############
    signal RS1Data_ID_EX_buff, RS2Data_ID_EX_buff: std_logic_vector(15 DOWNTO 0);
    signal opcode_ID_EX_buff:       std_logic_vector(4 DOWNTO 0);
    signal isImmediate_ID_EX_buff:  std_logic; 
    signal RD_ID_EX_buff, RS1_ID_EX_buff, RS2_ID_EX_buff:   std_logic_vector(2 DOWNTO 0);
    signal immediateOut_ID_EX_buff: std_logic_vector(15 DOWNTO 0);
    signal PCout_ID_EX_buff:        std_logic_vector(15 DOWNTO 0);
    signal regwrite_ID_EX_buff, pcSrc_ID_EX_buff, memread_ID_EX_buff, memWrite_ID_EX_buff, memToReg_ID_EX_buff, inPort_ID_EX_buff, outPort_ID_EX_buff, spInc_ID_EX_buff, spDec_ID_EX_buff: std_logic;

    --####################EXECUTE STAGE####################
    signal execOutput_EX, MuxOut_EX: std_logic_vector(15 DOWNTO 0);
    signal flags_EX: std_logic_vector(2 DOWNTO 0);
    --##################EXECUTE/MEMORY BUFFER##############
    signal RD_EX_MEM1_buff: std_logic_vector(2 DOWNTO 0);
    signal RS1dataOut_EX_MEM1_buff, RS2dataOut_EX_MEM1_buff, ALUresultOut_EX_MEM1_buff: std_logic_vector(15 DOWNTO 0);
    signal PCout_EX_MEM1_buff: std_logic_vector(15 DOWNTO 0);
    signal regWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, memWriteOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, outPortOut_EX_MEM1_buff, spIncOut_EX_MEM1_buff, spDecOut_EX_MEM1_buff: std_logic;

    --####################MEMORY1 STAGE#####################
    signal DataOut_MEM1 : std_logic_vector(15 DOWNTO 0);
    signal AddressOut_MEM1 : std_logic_vector(9 DOWNTO 0);
    --####################MEMORY STAGE#####################
    signal trashOut_MEM, memDataOut_MEM, ALUoutput_MEM, RS1Data_MEM: std_logic_vector(15 DOWNTO 0);
    signal RD_MEM: std_logic_vector(2 DOWNTO 0);
    signal regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM: std_logic;
    -- signal memZero: std_logic_vector(15 DOWNTO 0);
    --##################MEMORY/WRITEBACK BUFFER############
    signal regWriteOut_WB: std_logic;
    signal writeBackData_WB: std_logic_vector(15 DOWNTO 0);
    signal RD_WB: std_logic_vector(2 DOWNTO 0);
    --####################WRITEBACK STAGE##################



BEGIN

    fetchStagee: entity work.fetchStage port map(clk, reset, instruction_IF, immediate_IF, PC_IF);
    IF_ID_bufferr: entity work.IF_ID_buffer port map(clk, reset, instruction_IF, immediate_IF, PC_IF, RS1_IF_ID_buff, RS2_IF_ID_buff, instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff);
    --Not completed yet
    decodeStagee: entity work.decodingStage port map(clk, reset, RS1_IF_ID_buff, RS2_IF_ID_buff , RD_WB, regWriteOut_WB, writeBackData_WB, instruction_IF_ID_buff
                                                    , RS1Data_ID, RS2Data_ID, regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID);

    ID_EX_bufferr: entity work.ID_EX_buffer port map(clk, reset, RS1Data_ID, RS2Data_ID, instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff, regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID
                                                    , RS1Data_ID_EX_buff, RS2Data_ID_EX_buff, opcode_ID_EX_buff, isImmediate_ID_EX_buff, RD_ID_EX_buff, RS1_ID_EX_buff, RS2_ID_EX_buff, immediateOut_ID_EX_buff, PCout_ID_EX_buff
                                                    , regwrite_ID_EX_buff, pcSrc_ID_EX_buff, memread_ID_EX_buff, memWrite_ID_EX_buff, memToReg_ID_EX_buff, inPort_ID_EX_buff, outPort_ID_EX_buff, spInc_ID_EX_buff, spDec_ID_EX_buff);

    executeStagee: entity work.executionStage port map(clk, reset, RS1Data_ID_EX_buff, RS2Data_ID_EX_buff, immediateOut_ID_EX_buff, opcode_ID_EX_buff, isImmediate_ID_EX_buff, execOutput_EX, MuxOut_EX, flags_EX);

    EX_MEM1_bufferr: entity work.EX_MEM1_buffer port map(clk, reset, RD_ID_EX_buff, RS1Data_ID_EX_buff, MuxOut_EX, execOutput_EX, PCout_ID_EX_buff, regwrite_ID_EX_buff, memread_ID_EX_buff, memWrite_ID_EX_buff, memToReg_ID_EX_buff, inPort_ID_EX_buff
                                                    , outPort_ID_EX_buff, spInc_ID_EX_buff, spDec_ID_EX_buff, RD_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff, RS2dataOut_EX_MEM1_buff, ALUresultOut_EX_MEM1_buff, PCout_EX_MEM1_buff
                                                    , regWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, memWriteOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, outPortOut_EX_MEM1_buff, spIncOut_EX_MEM1_buff, spDecOut_EX_MEM1_buff);

    mem1Stagee: entity work.mem1Stage port map (clk, reset, spIncOut_EX_MEM1_buff, spDecOut_EX_MEM1_buff, memWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff, RS2dataOut_EX_MEM1_buff, DataOut_MEM1, AddressOut_MEM1);

    memoryStagee: entity work.memoryStage port map(clk, reset, RD_EX_MEM1_buff, AddressOut_MEM1, memReadOut_EX_MEM1_buff, AddressOut_MEM1, memWriteOut_EX_MEM1_buff, DataOut_MEM1, ALUresultOut_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff,trashOut_MEM, memDataOut_MEM
                                                    , RD_MEM, ALUoutput_MEM, RS1Data_MEM, regWriteOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, outPortOut_EX_MEM1_buff, regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM);

    writeBackStagee: entity work.WriteBackStage port map(regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM, RD_MEM, ALUoutput_MEM, memDataOut_MEM, INPort, RS1Data_MEM, regWriteOut_WB, writeBackData_WB, OUTPort, RD_WB);
    
END Processor_design;

