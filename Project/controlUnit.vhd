LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY controlUnit IS
PORT( 
    clk:          IN std_logic;
    instruction : IN std_logic_vector(15 DOWNTO 0);
    stall:        IN std_logic;
    regWrite:     OUT std_logic;
    pcSrc:        OUT std_logic;
    memRead:      OUT std_logic;
    memWrite:     OUT std_logic;
    memToReg:     OUT std_logic;
    inPort:       OUT std_logic;
    outPort:      OUT std_logic;
    spInc:        OUT std_logic;
    spDec:        OUT std_logic;
    INTERRUPTsig: IN std_logic;
    NOPP:         OUT std_logic_vector(15 downto 0);
    counter:        OUT std_logic_vector(2 downto 0 )
 );
END controlUnit;

ARCHITECTURE controlUnitDesign OF controlUnit IS
TYPE TYPES IS
    (ADHOC,ITYPE,JTYPE,RTYPE);
TYPE ITypeInstructions IS
    (PUSH,POP,LDM,LDD,STD);
TYPE JTypeInstructions IS
    (JZ,JC,JMP,CALL,RET,RTI);
TYPE AdhocInstructions IS
    (NOP,SETCC,CLRCC,INN,OUTT);

signal sigcountersig: std_logic_vector(2 downto 0):="000";

BEGIN
    -- The immediate signal is passed through the buffers
    PROCESS(clk)
        variable countervar: std_logic_vector(2 downto 0):="000";
    BEGIN
        -- counting signals
        -- 0: invalid (mgash interrupt lesa)
        -- 1: Freeze PC and flush IF/ID     -- Done, bs bndaya3 cycle 3lshan lw counter = 4, bn3ml freeze still
        -- 2: Push PC                       -- DONE        
        -- 3: Push flag                     -- DONE
        -- 4: execute Interrupt Service Routine    -- DONE?
        IF rising_edge(clk) THEN
            if INTERRUPTsig = '1' then
                sigcountersig <= "001";       -- start counting
                countervar := "001";
            ELSif countervar = "000" then
            ELSE
                sigcountersig <= sigcountersig + 1;
                countervar := countervar + 1;
                if countervar = "101" then     -- reset counter
                    sigcountersig <= "000";
                    countervar := "000";
                ELSE
                end if;
            END IF;
        ELSE
        END IF;
    counter <= countervar;

    END PROCESS;
    
    PROCESS (instruction,stall, INTERRUPTsig, counter) 
        variable instType: TYPES;
        variable funcTypeI:  ITypeInstructions;
        variable funcTypeJ:  JTypeInstructions;
        variable funcTypeA:  AdhocInstructions;
    BEGIN
        instType := TYPES'val(to_integer(unsigned(instruction(15 DOWNTO 14))));
        regWrite<='0';
        pcSrc<='0';
        memRead<='0';
        memWrite<='0';
        memToReg<='0';
        inPort<='0';
        outPort<='0';
        spInc<='0';
        spDec<='0';
        NOPP <= (others=>'1');
        
        IF counter = "010" or counter = "011" THEN      -- interrupt has the highest priority
        -- IF counter = "011" THEN      -- interrupt has the highest priority
            -- counter = 2 or 3, we want to push flag and PC respectively
            memWrite <= '1';            
            spDec <= '1';

        ELSIF stall = '1' THEN
            NOPP <= (others=>'0');
        ELSIF instType = RTYPE THEN
            regWrite <= '1';

        ELSIF instType = ITYPE THEN
            funcTypeI := ITypeInstructions'val(to_integer(unsigned(instruction(13 DOWNTO 11))));

            IF funcTypeI = PUSH THEN
                memWrite <= '1';
                spDec <= '1';
            ELSIF funcTypeI = POP THEN
                regWrite <= '1';
                memRead <= '1';
                memToReg <= '1';
                spInc <= '1';
            ELSIF funcTypeI = LDM THEN
                regWrite <= '1';
            ELSIF funcTypeI = LDD THEN
                regWrite <= '1';
                memRead <= '1';
                memToReg <= '1';
            ELSIF funcTypeI = STD THEN
                memWrite <= '1';
            END IF;

        ELSIF instType = JTYPE THEN
            pcSrc <= '1';
            funcTypeJ := JTypeInstructions'val(to_integer(unsigned(instruction(13 DOWNTO 11))));

            IF funcTypeJ = CALL THEN
                memWrite <= '1';
                spDec <= '1';
            ELSIF funcTypeJ = RET OR funcTypeJ = RTI THEN
                memRead <= '1';
                spInc <= '1';
            
                -- IF funcTypeJ = RTI THEN
                --     -- 3ayzeen n-pop
                --     regWrite <= '1';
                --     memToReg <= '1';
                -- END IF;
            END IF;

        ELSIF instType = ADHOC THEN
            funcTypeA := AdhocInstructions'val(to_integer(unsigned(instruction(13 DOWNTO 11))));

            IF funcTypeA = INN  THEN
                inPort <= '1';
                regWrite <= '1';
            ELSIF funcTypeA = OUTT  THEN
                outPort <= '1';
            END IF;
            
        ELSE
            
        END IF;
    END PROCESS;

    
END controlUnitDesign;