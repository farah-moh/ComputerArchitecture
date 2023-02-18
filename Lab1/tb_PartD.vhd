
Library IEEE;
use IEEE.std_logic_1164.all;


entity tb_PartD is
end entity;


Architecture testingPartD of tb_PartD is

component PartD is 
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

  U1: PartD port map (test_A,test_sel,test_Cin,test_Cout,test_F);
process
begin

-- test case 1:
test_A      <= x"000F";
test_sel    <= "00";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0007" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 2:
test_A      <= x"0F0F";
test_sel    <= "01";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"8787" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


-- test case 3:
test_A      <= x"0F0F";
test_sel    <= "10";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"0787" and test_Cout='1')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 4:
test_A      <= x"F000";
test_sel    <= "11";
test_Cin    <= '0';

wait for 10 ns;

assert (test_F=x"F800" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;

-- test case 5:
test_A      <= x"0F00";
test_sel    <= "10";
test_Cin    <= '1';

wait for 10 ns;

assert (test_F=x"8780" and test_Cout='0')
    report "Failed Case: " & to_hstring(test_A) &" "& to_hstring(test_sel) &" "& std_logic'image(test_Cin) & " output: " & to_hstring(test_F)  severity error;


wait for 10 ns;
report "Done";
wait;



end process;



end testingPartD;