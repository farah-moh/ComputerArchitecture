LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;


ENTITY ALU IS
PORT( 
 A,B:                           IN std_logic_vector(15 DOWNTO 0);
 ALUOp:                         IN std_logic_vector(2 DOWNTO 0);
 ALUOut:                        OUT std_logic_vector(15 DOWNTO 0);
 zeroFlag,negFlag,carryFlag:    OUT std_logic
);
END ALU;

ARCHITECTURE ALUDesign OF ALU IS

TYPE OPERATIONS IS
    (NOTT,INC,DEC,MOV,ADD,SUB,ANDD,ORR);
BEGIN
    -- The immediate signal is passed through the buffers
    PROCESS (A,B,ALUOp) 
        variable operation: OPERATIONS;
        variable result: std_logic_vector(16 DOWNTO 0);
    BEGIN
        operation := OPERATIONS'val(to_integer(unsigned(ALUOp)));
        IF operation = NOTT THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= (NOT A);
            result := (NOT ('0'&A));
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);

        ELSIF operation = INC THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A+1;
            result := (('0'&A) + 1);
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);
            carryFlag <= result(16);

        ELSIF operation = DEC THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A-1;
            result := (('0'&A) - 1);
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);
            carryFlag <= result(16);

        ELSIF (operation = ADD)  THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A+B;
            result := (('0'&A)+('0'&B));
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);
            carryFlag <= result(16);

        ELSIF operation = SUB THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A-B;
            result := (('0'&A)-('0'&B));
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);
            carryFlag <= result(16);

        ELSIF operation = ANDD THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A AND B;
            result := (('0'&A)AND('0'&B));
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);

        ELSIF operation = ORR THEN
            zeroFlag <= '0';
            negFlag <= '0';
            ALUOut <= A OR B;
            result := (('0'&A)OR('0'&B));
            if(result(15 downto 0) = std_logic_vector(to_signed(0,16))) then
                zeroFlag <= '1';
            end if;
            negFlag <= result(15);

        ELSE
            ALUOut <= (others => '0');
        END IF;
    END PROCESS;
END ALUDesign;
