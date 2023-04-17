library IEEE;
use ieee.std_logic_1164.all;


entity ControlUnit_TB is 
end entity;

Architecture tb of ControlUnit_TB is
  
component controlUnit is
  port(
    instruction : IN std_logic_vector(15 DOWNTO 0);
    regWrite:     OUT std_logic;
    PCSrc:        OUT std_logic;
    memRead:      OUT std_logic;
    memWrite:     OUT std_logic;
    memToReg:     OUT std_logic;
    inPort:       OUT std_logic;
    outPort:      OUT std_logic;
    setC:         OUT std_logic;
    clrC:         OUT std_logic;
    spInc:        OUT std_logic;
    spDec:        OUT std_logic
  );
end component;

Signal instructionTest: std_logic_vector(15 DOWNTO 0);
Signal testregWrite,testPCSrc,testmemRead,testmemWrite,testmemToReg,testinPort,testoutPort,testsetC,testclrC,testspInc,testspDec: std_logic;

begin
  U1: controlUnit port map (instructionTest,testregWrite,testPCSrc,testmemRead,testmemWrite,testmemToReg,testinPort,testoutPort,testsetC,testclrC,testspInc,testspDec);
process
  begin
    testPCSrc<='0';
    --NOT
    instructionTest<="1100000000000000";
    assert(testregWrite='1')
    report "Failed case INC"
    severity error;
    wait for 10 ns;

    --INC
    instructionTest<="1100100000000000";
    assert(testregWrite='1')
    report "Failed case INC"
    severity error;
    wait for 10 ns;

    --DEC
    instructionTest<="1101000000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --MOV
    instructionTest<="1101100000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;
    
    --ADD
    instructionTest<="1110000000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --SUB
    instructionTest<="1110100000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --AND
    instructionTest<="1111000000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --OR
    instructionTest<="1111100000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --PUSH
    instructionTest<="0100000000000000";
    assert(testmemWrite='1' and testSpDec='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --POP
    instructionTest<="0100100000000000";
    assert(testregWrite='1' and testmemRead='1' and testmemToReg='1' and testSpInc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --LDM
    instructionTest<="0101000000000000";
    assert(testregWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --LDD
    instructionTest<="0101100000000000";
    assert(testregWrite='1' and testmemRead='1' and testmemToReg='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --STD
    instructionTest<="0110000000000000";
    assert(testmemWrite='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --JZ
    instructionTest<="1000000000000000";
    assert(testPcSrc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --JC
    instructionTest<="1000100000000000";
    assert(testPcSrc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --JMP
    instructionTest<="1001000000000000";
    assert(testPcSrc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --CALL
    instructionTest<="1001100000000000";
    assert(testPcSrc='1' and testmemWrite='1' and testSpDec='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --RET
    instructionTest<="1010000000000000";
    assert(testPcSrc='1' and testmemRead='1' and testSpInc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --RTI
    instructionTest<="1010100000000000";
    assert(testPcSrc='1' and testmemRead='1' and testSpInc='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --NOP
    instructionTest<="0000000000000000";
    wait for 10 ns;

    --SETC
    instructionTest<="0000100000000000";
    assert(testsetC='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --CLRC
    instructionTest<="0001000000000000";
    assert(testClrC='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --IN
    instructionTest<="0001100000000000";
    assert(testinPort='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;

    --OUT
    instructionTest<="0010000000000000";
    assert(testoutPort='1')
    report "Failed case DEC"
    severity error;
    wait for 10 ns;


  wait;
end process;

end tb;
