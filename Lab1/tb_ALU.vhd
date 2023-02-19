Library IEEE;
use IEEE.std_logic_1164.all;


entity tb_ALU is
end entity;


Architecture testingALU of tb_ALU is

component ALU is 
port  (
    A :    in std_logic_vector(15 downto 0); 
    B:     in std_logic_vector(15 downto 0); 
    sel :  in std_logic_vector (3 downto 0);
    Cin:   in std_logic;
    Cout : out std_logic;
    F :    out std_logic_vector(15 downto 0)
);
end component;

Signal test_A:      std_logic_vector(15 downto 0);
Signal test_B:      std_logic_vector(15 downto 0);
Signal test_sel:    std_logic_vector (3 downto 0);
Signal test_Cin:    std_logic;
Signal test_Cout:   std_logic;
Signal test_F:      std_logic_vector(15 downto 0);

Begin

  U1: ALU port map (test_A,test_B,test_sel,test_Cin,test_Cout,test_F);
process
begin

test_Cin    <= '0';

-- test case 1:
test_A      <= x"F000";
test_B      <= x"00B0";
test_sel    <= "0100";

wait for 10 ns;

assert (test_F=x"F0B0")
    report "Failed Case: " & to_hstring(test_A) &" " & to_hstring(test_B) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 2:
test_A      <= x"F000";
test_B      <= x"000B";
test_sel    <= "0101";

wait for 10 ns;

assert (test_F=x"0000")
    report "Failed Case: " & to_hstring(test_A) &" " & to_hstring(test_B) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 3:
test_A      <= x"F000";
test_B      <= x"B000";
test_sel    <= "0110";

wait for 10 ns;

assert (test_F=x"0FFF")
    report "Failed Case: " & to_hstring(test_A) &" " & to_hstring(test_B) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 4:
test_A      <= x"F000";
test_B      <= x"0000";
test_sel    <= "0111";

wait for 10 ns;

assert (test_F=x"0FFF")
    report "Failed Case: " & to_hstring(test_A) &" " & to_hstring(test_B) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


wait for 10 ns;

-- test case 5:
test_A      <= x"A00A";
test_sel    <= "1000";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"4014" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 6:
test_A      <= x"000A";
test_sel    <= "1000";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0014" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


-- test case 7:
test_A      <= x"B00C";
test_sel    <= "1001";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"6019" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 8:
test_A      <= x"000C";
test_sel    <= "1001";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0018" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 9:
test_A      <= x"A00A";
test_sel    <= "1010";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"4014" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 10:
test_A      <= x"A00A";
test_sel    <= "1010";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"4015" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 11:
test_A      <= x"A00A";
test_sel    <= "1011";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"0000" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


wait for 10 ns;

-- test case 12:
test_A      <= x"000F";
test_sel    <= "1100";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0007" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 13:
test_A      <= x"0F0F";
test_sel    <= "1101";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"8787" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


-- test case 14:
test_A      <= x"0F0F";
test_sel    <= "1110";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0787" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 15:
test_A      <= x"F000";
test_sel    <= "1111";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"F800" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 16:
test_A      <= x"0F00";
test_sel    <= "1110";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"8780" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


wait for 10 ns;

report "Done";
wait;



end process;



end testingALU;
