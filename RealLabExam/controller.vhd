LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY controller IS
    PORT(
        Clk :      IN std_logic;
        Rst:       IN std_logic;
        Valid :    IN std_logic; 
        Choice :   IN std_logic_vector(2 downto 0);
        Action:    OUT std_logic_vector(1 downto 0);
        Floor:     OUT std_logic_vector(2 downto 0)
    );
END controller;

ARCHITECTURE controller_design OF controller is
    -- Components
    component my_nDFF IS
        GENERIC ( n : integer := 16);
        PORT( Clk,Rst : IN std_logic;
        d : IN std_logic_vector(n-1 DOWNTO 0);
        q : OUT std_logic_vector(n-1 DOWNTO 0);
        enable: IN std_logic);
    END component;


    -- Signals
    
    signal en: std_logic:='1';
    BEGIN

        -- LastVarBuff: my_nDff generic map(2) port map(clk,rst,Action,beforeLast,en);

        PROCESS (Clk,Rst)
        -- variables
        variable choiceBuff: std_logic_vector(8 downto 0);
        variable beforeLast: std_logic_vector(1 downto 0);
        variable target: integer;
        variable ok: integer:=1;
        variable allZero: integer:=0;

        BEGIN
            IF Rst = '1' THEN
                Floor <= (others => '0');
                Action <= (others => '0');
                choiceBuff := (others => '0');
                target := 0;
                ok := 1;
                allZero := 0;

            ELSIF rising_edge(Clk) THEN
                -- Checking on valid if it is valid we add the requested number to buffer
                if Valid = '1' then
                    choiceBuff(to_integer(unsigned(Choice))) := '1';
                end if;

                -- if the elevator is stationary then check on the choices buffer and see if any floor is chosen
                if Action = "00" then
                    loop1: FOR i IN 0 TO 7 LOOP
                        if choiceBuff(i) = '1' then
                            target := i;
                        end if;
                    END LOOP;
                    if NOT(target = to_integer(unsigned(Floor))) then
                        allZero := 1;
                    end if;
                -- if the elevator is moving upward then check on the nearest upward move
                elsif Action = "01" then
                    loop2: FOR i IN 0 TO 7 LOOP
                        if ok = 1 then
                            if choiceBuff(i) = '1'then
                                if i >= to_integer(unsigned(Floor)) then
                                    target := i;
                                    ok := 0;
                                end if;
                            end if;
                        end if;
                    END LOOP;
                    ok := 1;
                -- if the elevator is moving downward then check on the nearest downward move
                elsif Action = "10" then
                    loop3: FOR i IN 7 TO 0 LOOP
                        if choiceBuff(i) = '1' and ok = 1 then
                            if i <= to_integer(unsigned(Floor)) then
                                target := i;
                                ok := 0;
                            end if;
                        end if;
                    END LOOP;
                    ok := 1;
                
                -- if the elevator stopped to open door check the last state and check the buffer to make sure if there is a move to make
                elsif Action = "11" then
                    
                    if beforeLast = "01" then
                        loop4: FOR i IN 0 TO 7 LOOP
                            if ok = 1 then
                                if choiceBuff(i) = '1' then
                                    if i > to_integer(unsigned(Floor)) then
                                        target := i;
                                        ok := 0;
                                    end if;
                                end if;
                            end if;
                        END LOOP;
                        if ok = 1 then
                            loop7: FOR i IN to_integer(unsigned(Floor)) TO 0 LOOP
                                if choiceBuff(i) = '1' and ok = 1 then
                                        target := i;
                                        ok := 0;
                                end if;
                            END LOOP;
                            target := 2;

                        end if;
                        ok := 1;
                    elsif beforeLast = "10" then
                        loop5: FOR i IN 7 TO 0 LOOP
                            if choiceBuff(i) = '1' and ok = 1 then
                                if i < to_integer(unsigned(Floor)) then
                                    target := i;
                                    ok := 0;
                                end if;
                            end if;
                        END LOOP;
                        ok := 1;
                    end if;

                    if NOT(target = to_integer(unsigned(Floor))) then
                        allZero := 1;
                    end if;
                end if;

                                
                -- if allZero = 0 then
                    if target < to_integer(unsigned(Floor)) then
                        Floor <= std_logic_vector(unsigned(Floor) - 1);
                        Action <= "10";
                        beforeLast := "10";
                    elsif target > to_integer(unsigned(Floor)) then
                        Floor <= std_logic_vector(unsigned(Floor) + 1);
                        Action <= "01";
                        beforeLast := "01";
                    elsif target = to_integer(unsigned(Floor)) then
                        Action <= "11";
                    end if;
                -- else
                --     Action <= "00";
                --     allZero := 0;
                -- end if;


            END IF; 
        END PROCESS;

END controller_design;


