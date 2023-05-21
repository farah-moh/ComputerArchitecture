LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY controlUnit IS
PORT( 
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
 NOPP:          OUT std_logic_vector(15 downto 0)
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
BEGIN
    -- The immediate signal is passed through the buffers
    PROCESS (instruction,stall, INTERRUPTsig) 
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
        
        IF INTERRUPTsig = '1' THEN      -- interrupt has the highest priority
            memWrite <= '1';            -- msh mot2aked mn el 7eta dyh? bs most
                                        -- probably ah, 3lshan n3rf nktb el PC fl dataMemory[SP]
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