LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY controller IS
    PORT(
    Clk,Rst,Valid:    	IN std_logic;
    Choice :    	in std_logic_vector(2 downto 0);
    Action :    	out std_logic_vector(1 downto 0);
    Floor :    	out std_logic_vector(2 downto 0)
    );
END controller;

ARCHITECTURE a_controller OF controller IS

BEGIN
    PROCESS (Clk,Rst)
    VARIABLE myFloor : integer := 0;
    VARIABLE myAction : std_logic_vector(1 DOWNTO 0) := (OTHERS=>'0');
    VARIABLE prevAction : std_logic_vector(1 DOWNTO 0) := (OTHERS=>'0');
    VARIABLE queue: std_logic_vector(7 DOWNTO 0) := (OTHERS=>'0');
    VARIABLE flag: integer := 0;
    BEGIN
        IF Rst = '1' THEN

            Floor <= (OTHERS=>'0');
            Action <= (OTHERS=>'0');
            myFloor := 0;
            myAction := (OTHERS=>'0');
            queue := (OTHERS=>'0');

        ELSIF rising_edge(clk) THEN
            IF (queue(myFloor) = '1') THEN
                -- myAction := "11";
                Action <= "11";
                queue(myFloor) := '0';
                flag := 1;
            ELSIF ((myAction = "01"))  then
                flag := 0;
                IF(to_integer(unsigned(queue(7 downto myFloor))) > 0) then
                    myFloor := myFloor + 1;
                ELSIF(to_integer(unsigned(queue(myFloor downto 0))) > 0) then
                    myFloor := myFloor - 1;
                    myAction := "10";
                else
                    myAction := "00";
                END IF;

            ELSIF ((myAction = "10"))  then
                flag := 0;
                IF(to_integer(unsigned(queue(myFloor downto 0))) > 0) then
                    myFloor := myFloor - 1;
                ELSIF(to_integer(unsigned(queue(7 downto myFloor))) > 0) then
                    myFloor := myFloor + 1;
                    myAction := "01";
                ELSE
                    myAction := "00";
                END IF;

            ELSIF ((myAction = "00"))  then
                flag := 0;
                IF(to_integer(unsigned(queue(myFloor downto 0))) > 0) then
                    myFloor := myFloor - 1;
                    myAction := "10";
                ELSIF(to_integer(unsigned(queue(7 downto myFloor))) > 0) then
                    myFloor := myFloor + 1;
                    myAction := "01";
                else
                    myAction := "00";
                END IF;
            END IF;
            Floor <= std_logic_vector(to_unsigned(myFloor,3));
            IF (flag = 0) THEN
                Action <= myAction;
            END IF;
            IF(Valid = '1') THEN
            queue(to_integer(unsigned(Choice))) := '1';
            END IF;
        END IF;
    END PROCESS;
END a_controller;

