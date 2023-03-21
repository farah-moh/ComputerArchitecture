Library IEEE;
use IEEE.std_logic_1164.all;


entity Processor is
GENERIC (bits: integer := 16);
PORT  (
    clk,rst,enable:    	IN std_logic
);
end entity;


Architecture Processor_design of Processor is

COMPONENT PC IS
PORT (clk, reset, enable : IN  std_logic;
        pc : OUT std_logic_vector(5 DOWNTO 0)
    );
END COMPONENT;

COMPONENT instructionCache IS
    GENERIC (m: integer:= 16);
    PORT (
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(5 DOWNTO 0);
        readPort :          OUT std_logic_vector(m-1 DOWNTO 0) 
    );
END COMPONENT;

COMPONENT controller IS
PORT( 
 instruction : IN std_logic_vector(15 DOWNTO 0);
 writeEnable:  OUT std_logic;
 ALUOp:        OUT std_logic_vector(3 DOWNTO 0)
);
END COMPONENT;

COMPONENT my_nDFF IS
    GENERIC ( n : integer := 16);
    PORT( Clk,Rst : IN std_logic;
    d : IN std_logic_vector(n-1 DOWNTO 0);
    q : OUT std_logic_vector(n-1 DOWNTO 0);
    enable: IN std_logic);
END COMPONENT;

COMPONENT regFileMem IS
    GENERIC (m: integer:= 16);
    PORT (
        clk:                IN std_logic;
        rst :               IN std_logic;
        readAddress :    	IN std_logic_vector(1 DOWNTO 0);
        writeAddress :    	IN std_logic_vector(1 DOWNTO 0); 
        writeEnable :       IN std_logic;
        writePort :         IN std_logic_vector(m-1 DOWNTO 0);
        readPort :          OUT std_logic_vector(m-1 DOWNTO 0) 
    );
END COMPONENT;

COMPONENT ALU IS
    GENERIC (bits: integer := 16);
    PORT  (
        A :    	IN std_logic_vector(bits-1 DOWNTO 0);
        B :    	IN std_logic_vector(bits-1 DOWNTO 0); 
        sel :   IN std_logic_vector (3 DOWNTO 0);
        Cin:    IN std_logic;
        Cout :  OUT std_logic;
        F :     OUT std_logic_vector(bits-1 DOWNTO 0)
    );
END COMPONENT;

signal outputPC: std_logic_vector(5 DOWNTO 0);
signal outputIC: std_logic_vector(15 DOWNTO 0);
signal writeEnable: std_logic;
signal ALUOp: std_logic_vector(3 DOWNTO 0);
signal outputRegFile: std_logic_vector(15 DOWNTO 0);

signal outputALUCout: std_logic;
signal outputALUData: std_logic_vector(15 DOWNTO 0);


signal outputFetchDecodeReg: std_logic_vector(15 DOWNTO 0);

signal outputDecodeExecReg: std_logic_vector(23 DOWNTO 0);
signal inputDecodeExecReg: std_logic_vector(23 DOWNTO 0);

signal outputWriteBackReg: std_logic_vector(19 DOWNTO 0);
signal inputWriteBackReg: std_logic_vector(19 DOWNTO 0);

signal enableFetchReg: std_logic;
signal enableDecodeReg: std_logic;
signal enableWriteBack: std_logic;


BEGIN
    ProgramCounter: PC port map (clk,rst,enable,outputPC);

    Instruction: instructionCache port map (rst,outputPC,outputIC);
    
    FetchDecodeReg: my_nDff generic map(16) port map(clk,rst,outputIC,outputFetchDecodeReg,enableFetchReg);
    
    Control: controller port map (outputFetchDecodeReg,writeEnable,ALUOp);
    
    inputDecodeExecReg <=  (outputFetchDecodeReg(6 DOWNTO 4) & outputRegFile & ALUOp & writeEnable);
    DecodeExecuteReg: my_nDff generic map(24) port map(clk,rst,
                                                    inputDecodeExecReg
                                                    ,outputDecodeExecReg,enableDecodeReg);
    
    ArithmaticLU: ALU port map(outputDecodeExecReg(20 DOWNTO 5),(others => '0'),outputDecodeExecReg(4 DOWNTO 1)
                                ,'0',outputALUCout,outputALUData);
    
    inputWriteBackReg <= (outputDecodeExecReg(23 DOWNTO 21) & outputALUData & outputDecodeExecReg(0));
    WriteBackReg: my_nDff generic map(20) port map(clk,rst,inputWriteBackReg,outputWriteBackReg,enableWriteBack);
    
    RegisterFile: regFileMem port map (clk,rst,outputFetchDecodeReg(11 DOWNTO 10),
                                        outputWriteBackReg(18 DOWNTO 17),
                                        outputWriteBackReg(0),outputWriteBackReg(16 DOWNTO 1),outputRegFile);

END Processor_design;