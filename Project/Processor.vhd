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
    signal InPortData_IF_ID_buff, instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff : std_logic_vector(15 DOWNTO 0);
     --####################HAZARD DETECTION UNIT#####################
    signal stall: std_logic;
    --####################DECODE STAGE#####################
    signal RS1Data_ID, RS2Data_ID: std_logic_vector(15 DOWNTO 0);
    signal regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID: std_logic;
    --##################DECODE/EXECUTE BUFFER##############
    signal RS1Data_ID_EX_buff, RS2Data_ID_EX_buff: std_logic_vector(15 DOWNTO 0);
    signal opcode_ID_EX_buff:       std_logic_vector(4 DOWNTO 0);
    signal isImmediate_ID_EX_buff:  std_logic; 
    signal RD_ID_EX_buff, RS1_ID_EX_buff, RS2_ID_EX_buff:   std_logic_vector(2 DOWNTO 0);
    signal InPortData_ID_EX_buff, immediateOut_ID_EX_buff: std_logic_vector(15 DOWNTO 0);
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

    --##################MEMORY1/MEMORY2 BUFFER##############
    signal regWriteOut_MEM1_MEM2_buff, memToRegOut_MEM1_MEM2_buff, inPortOut_MEM1_MEM2_buff, outPortOut_MEM1_MEM2_buff: std_logic;
    signal RD_MEM1_MEM2_buff: std_logic_vector(2 DOWNTO 0);
    signal ALUoutput_MEM1_MEM2_buff, RS1DataOut_MEM1_MEM2_buff, writeDataOut_MEM1_MEM2_buff: std_logic_vector(15 DOWNTO 0);
    signal writeEnableOut_MEM1_MEM2_buff, readEnableOut_MEM1_MEM2_buff: std_logic;
    signal writeAddressOut_MEM1_MEM2_buff, readAddressOut_MEM1_MEM2_buff: std_logic_vector(9 DOWNTO 0);
    --####################MEMORY2 STAGE#####################
    signal DataOut_MEM2 : std_logic_vector(15 DOWNTO 0);
    --##################MEMORY1/MEMORY2 BUFFER##############
    signal regWriteOut_MEM2_WB_buff, memToRegOut_MEM2_WB_buff, inPortOut_MEM2_WB_buff, outPortOut_MEM2_WB_buff: std_logic;
    signal RD_MEM2_WB_buff: std_logic_vector(2 DOWNTO 0);
    signal ALUoutput_MEM2_WB_buff, RS1DataOut_MEM2_WB_buff, writeDataOut_MEM2_WB_buff: std_logic_vector(15 DOWNTO 0);
    signal writeEnableOut_MEM2_WB_buff, readEnableOut_MEM2_WB_buff: std_logic;
    signal writeAddressOut_MEM2_WB_buff, readAddressOut_MEM2_WB_buff: std_logic_vector(9 DOWNTO 0);

    --####################MEMORY STAGE#####################
    -- signal trashOut_MEM, memDataOut_MEM, ALUoutput_MEM, RS1Data_MEM: std_logic_vector(15 DOWNTO 0);
    -- signal RD_MEM: std_logic_vector(2 DOWNTO 0);
    -- signal regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM: std_logic;
    -- -- signal memZero: std_logic_vector(15 DOWNTO 0);
    --##################MEMORY/WRITEBACK BUFFER############
    signal regWriteOut_WB: std_logic;
    signal writeBackData_WB: std_logic_vector(15 DOWNTO 0);
    signal RD_WB: std_logic_vector(2 DOWNTO 0);
    --####################WRITEBACK STAGE##################



BEGIN

    fetchStagee: entity work.fetchStage port map(clk, reset,not stall, instruction_IF, immediate_IF, PC_IF);
    IF_ID_bufferr: entity work.IF_ID_buffer port map(clk, reset, INPort, instruction_IF, immediate_IF, PC_IF,InPortData_IF_ID_buff, RS1_IF_ID_buff, RS2_IF_ID_buff, instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff);
    --Not completed yet
    HazardDetection: entity work.hazardDetectionUnit port map(instruction_IF_ID_buff,RS1_IF_ID_buff,RS2_IF_ID_buff,RD_ID_EX_buff,regwrite_ID_EX_buff, memread_ID_EX_buff,RD_EX_MEM1_buff,regWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff,stall);
    decodeStagee: entity work.decodingStage port map(clk, stall, reset, RS1_IF_ID_buff, RS2_IF_ID_buff , RD_WB, regWriteOut_WB, writeBackData_WB, instruction_IF_ID_buff
                                                    , RS1Data_ID, RS2Data_ID, regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID);
                                                    
    ID_EX_bufferr: entity work.ID_EX_buffer port map(clk, reset, InPortData_IF_ID_buff, RS1Data_ID, RS2Data_ID, instruction_IF_ID_buff, immediate_IF_ID_buff, PC_IF_ID_buff, regwrite_ID, pcSrc_ID, memread_ID, memWrite_ID, memToReg_ID, inPort_ID, outPort_ID, spInc_ID, spDec_ID
                                                    , InPortData_ID_EX_buff, RS1Data_ID_EX_buff, RS2Data_ID_EX_buff, opcode_ID_EX_buff, isImmediate_ID_EX_buff, RD_ID_EX_buff, RS1_ID_EX_buff, RS2_ID_EX_buff, immediateOut_ID_EX_buff, PCout_ID_EX_buff
                                                    , regwrite_ID_EX_buff, pcSrc_ID_EX_buff, memread_ID_EX_buff, memWrite_ID_EX_buff, memToReg_ID_EX_buff, inPort_ID_EX_buff, outPort_ID_EX_buff, spInc_ID_EX_buff, spDec_ID_EX_buff);

    executeStagee: entity work.executionStage port map(clk, reset, InPortData_ID_EX_buff, RS1Data_ID_EX_buff, RS2Data_ID_EX_buff, immediateOut_ID_EX_buff, opcode_ID_EX_buff, isImmediate_ID_EX_buff,inPort_ID_EX_buff, execOutput_EX, MuxOut_EX, flags_EX);

    EX_MEM1_bufferr: entity work.EX_MEM1_buffer port map(clk, reset, RD_ID_EX_buff, RS1Data_ID_EX_buff, MuxOut_EX, execOutput_EX, PCout_ID_EX_buff, regwrite_ID_EX_buff, memread_ID_EX_buff, memWrite_ID_EX_buff, memToReg_ID_EX_buff, inPort_ID_EX_buff
                                                    , outPort_ID_EX_buff, spInc_ID_EX_buff, spDec_ID_EX_buff, RD_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff, RS2dataOut_EX_MEM1_buff, ALUresultOut_EX_MEM1_buff, PCout_EX_MEM1_buff
                                                    , regWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, memWriteOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, outPortOut_EX_MEM1_buff, spIncOut_EX_MEM1_buff, spDecOut_EX_MEM1_buff);

    mem1Stagee: entity work.mem1Stage port map (clk, reset, spIncOut_EX_MEM1_buff, spDecOut_EX_MEM1_buff, memWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff, RS2dataOut_EX_MEM1_buff, DataOut_MEM1, AddressOut_MEM1);

    
    
    
    MEM1_MEM2_bufferr: entity work.MEM1_MEM2_buffer port map (clk, reset, outPortOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, regWriteOut_EX_MEM1_buff, RD_EX_MEM1_buff, ALUresultOut_EX_MEM1_buff, RS1dataOut_EX_MEM1_buff, DataOut_MEM1
                                                    , memWriteOut_EX_MEM1_buff, memReadOut_EX_MEM1_buff, AddressOut_MEM1, AddressOut_MEM1, outPortOut_MEM1_MEM2_buff, inPortOut_MEM1_MEM2_buff, memToRegOut_MEM1_MEM2_buff, regWriteOut_MEM1_MEM2_buff
                                                    , RD_MEM1_MEM2_buff, ALUoutput_MEM1_MEM2_buff, RS1DataOut_MEM1_MEM2_buff, writeDataOut_MEM1_MEM2_buff, writeEnableOut_MEM1_MEM2_buff, readEnableOut_MEM1_MEM2_buff, writeAddressOut_MEM1_MEM2_buff, readAddressOut_MEM1_MEM2_buff);


    mem2Stagee: entity work.mem2Stage port map(clk, reset, readAddressOut_MEM1_MEM2_buff, readEnableOut_MEM1_MEM2_buff, writeAddressOut_MEM1_MEM2_buff, writeEnableOut_MEM1_MEM2_buff, writeDataOut_MEM1_MEM2_buff, DataOut_MEM2);

    MEM2_WB_bufferr: entity work.MEM2_WB_buffer port map (clk, reset, outPortOut_MEM1_MEM2_buff, inPortOut_MEM1_MEM2_buff, memToRegOut_MEM1_MEM2_buff, regWriteOut_MEM1_MEM2_buff, RD_MEM1_MEM2_buff, ALUoutput_MEM1_MEM2_buff, RS1DataOut_MEM1_MEM2_buff, DataOut_MEM2
                                                    , writeEnableOut_MEM1_MEM2_buff, readEnableOut_MEM1_MEM2_buff, writeAddressOut_MEM1_MEM2_buff, readAddressOut_MEM1_MEM2_buff, outPortOut_MEM2_WB_buff, inPortOut_MEM2_WB_buff, memToRegOut_MEM2_WB_buff, regWriteOut_MEM2_WB_buff
                                                    , RD_MEM2_WB_buff, ALUoutput_MEM2_WB_buff, RS1DataOut_MEM2_WB_buff, writeDataOut_MEM2_WB_buff, writeEnableOut_MEM2_WB_buff, readEnableOut_MEM2_WB_buff, writeAddressOut_MEM2_WB_buff, readAddressOut_MEM2_WB_buff);

    -- memoryStagee: entity work.memoryStage port map(clk, reset, RD_EX_MEM1_buff, AddressOut_MEM1, memReadOut_EX_MEM1_buff, AddressOut_MEM1, memWriteOut_EX_MEM1_buff, DataOut_MEM1, ALUresultOut_EX_MEM1_buff, RS1dataOut_EX_MEM1_bufftrashOut_MEM, memDataOut_MEM
    --                                                 , RD_MEM, ALUoutput_MEM, RS1Data_MEM, regWriteOut_EX_MEM1_buff, memToRegOut_EX_MEM1_buff, inPortOut_EX_MEM1_buff, outPortOut_EX_MEM1_buff, regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM);

    -- writeBackStagee: entity work.WriteBackStage port map(regWriteOut_MEM, memToRegOut_MEM, inPortOut_MEM, outPortOut_MEM, RD_MEM, ALUoutput_MEM, memDataOut_MEM, RS1Data_MEM, regWriteOut_WB, writeBackData_WB, OUTPort, RD_WB);
    writeBackStagee: entity work.WriteBackStage port map(regWriteOut_MEM2_WB_buff, memToRegOut_MEM2_WB_buff, inPortOut_MEM2_WB_buff, outPortOut_MEM2_WB_buff, RD_MEM2_WB_buff, ALUoutput_MEM2_WB_buff, writeDataOut_MEM2_WB_buff, RS1DataOut_MEM2_WB_buff, regWriteOut_WB, writeBackData_WB, OUTPort, RD_WB);
    
END Processor_design;

