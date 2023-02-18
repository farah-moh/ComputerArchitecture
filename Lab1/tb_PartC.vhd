Library IEEE;
use IEEE.std_logic_1164.all;


entity tb_PartC is
end entity;


Architecture testingPartC of tb_PartC is

component PartC is 
port  (
    A :    in std_logic_vector(15 downto 0); 
    sel :     in std_logic_vector (1 downto 0);
    Cin:    in std_logic;
    Cout :     out std_logic;
    F :     out std_logic_vector(15 downto 0)
);
end component;

Signal test_A:      std_logic_vector(15 downto 0);
Signal test_sel:    std_logic_vector (1 downto 0);
Signal test_Cin:    std_logic;
Signal test_Cout:   std_logic;
Signal test_F:      std_logic_vector(15 downto 0);

Begin

  U1: PartC port map (test_A,test_sel,test_Cin,test_Cout,test_F);
process
begin

-- test case 1:
test_A      <= x"A00A";
test_sel    <= "00";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"4014" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 2:
test_A      <= x"000A";
test_sel    <= "00";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0014" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


-- test case 3:
test_A      <= x"B00C";
test_sel    <= "01";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"6019" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 4:
test_A      <= x"000C";
test_sel    <= "01";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0018" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 5:
test_A      <= x"A00A";
test_sel    <= "10";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"4014" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

    -- test case 6:
test_A      <= x"A00A";
test_sel    <= "10";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"4015" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

    -- test case 7:
test_A      <= x"A00A";
test_sel    <= "11";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"0000" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


wait for 10 ns;
report "Done";
wait;



end process;



end testingPartC;
