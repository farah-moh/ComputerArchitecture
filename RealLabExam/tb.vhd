
library ieee;
use ieee.std_logic_1164.all;
	
use std.env.stop;


entity tb_elevator is
end entity;

Architecture tbs2p of tb_elevator is
component controller is
port (
clk,rst,valid: in std_logic;
choice: in std_logic_vector(2 downto 0);
action: out std_logic_vector(1 downto 0);
floor: inout std_logic_vector(2 downto 0));
end component;

signal clk,rst,valid:  std_logic;
signal choice:  std_logic_vector(2 downto 0);
signal action:  std_logic_vector(1 downto 0);
signal floor:  std_logic_vector(2 downto 0);
constant Tperiod : time := 10 ns;

function floorCheck(floor:std_logic_vector(2 downto 0);realfloor:std_logic_vector(2 downto 0);count: integer) return integer is
	variable c: integer;
begin
	c := count;
	if (floor /= realfloor) then
		report "Failed:  wrong floor" severity error;
		c := count +1;
	else
		report "Passed floor test" ;
	end if;
	return c;
end function;
function actionCheck(action:std_logic_vector(1 downto 0);realaction:std_logic_vector(1 downto 0);count: integer) return integer is
	variable c: integer;
begin
	c := count;
	if (action /= realaction) then
		report "Failed:  wrong action" severity error;
		c := count +1;
	else
		report "Passed action test" ;
	end if;
	return c;
end function;

begin 

U0: controller port map (clk,rst,valid,choice,action,floor);
process 
begin
clk  <= '1'; wait for Tperiod/2;
clk <= '0'; wait for Tperiod/2;

end process;

process
	variable count : integer := 0;
begin
  rst<='1';
  valid <='0';
  choice <="000";
  wait for Tperiod;
	report "1:Reset check";
	count := floorCheck(floor,"000",count);
	count := actionCheck(action,"00",count);
  
  rst<='0';
  valid <='1';
  choice <="101";
  wait for Tperiod;
	report "2:read action";
	count := floorCheck(floor,"000",count);
	count := actionCheck(action,"00",count);

  rst<='0';
  valid <='0';
  choice <="101";
  wait for Tperiod;
	report "3:move up action";
	count := floorCheck(floor,"001",count);
	count := actionCheck(action,"01",count);


  rst<='0';
  valid <='1';
  choice <="100";
  wait for Tperiod;
	report "4:move up action";
	count := floorCheck(floor,"010",count);
	count := actionCheck(action,"01",count);

  rst<='0';
  valid <='0';
  choice <="100";
  wait for Tperiod;
	report "5:move up action";
	count := floorCheck(floor,"011",count);
	count := actionCheck(action,"01",count);
  rst<='0';
  valid <='0';
  choice <="110";
  wait for Tperiod;
	report "6:move up action";
	count := floorCheck(floor,"100",count);
	count := actionCheck(action,"01",count);
  rst<='0';
  valid <='1';
  choice <="010";
  wait for Tperiod;
	report "7:open door";
	count := floorCheck(floor,"100",count);
	count := actionCheck(action,"11",count);

   valid <='0';
  choice <="010";
  wait for Tperiod;
	report "8:continue moving upwards";
	count := floorCheck(floor,"101",count);
	count := actionCheck(action,"01",count);

   valid <='0';
  choice <="010";
  wait for Tperiod;
	report "9:open door";
	count := floorCheck(floor,"101",count);
	count := actionCheck(action,"11",count);
  valid <='0';
  choice <="010";
  wait for Tperiod;
	report "10:move downwards";
	count := floorCheck(floor,"100",count);
	count := actionCheck(action,"10",count);

  valid <='1';
  choice <="110";
  wait for Tperiod;
	report "11:move downwards";
	count := floorCheck(floor,"011",count);
	count := actionCheck(action,"10",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "12:move downwards";
	count := floorCheck(floor,"010",count);
	count := actionCheck(action,"10",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "13:open door";
	count := floorCheck(floor,"010",count);
	count := actionCheck(action,"11",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "14:move upwards";
	count := floorCheck(floor,"011",count);
	count := actionCheck(action,"01",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "15:move up";
	count := floorCheck(floor,"100",count);
	count := actionCheck(action,"01",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "16:move up";
	count := floorCheck(floor,"101",count);
	count := actionCheck(action,"01",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "17:move up";
	count := floorCheck(floor,"110",count);
	count := actionCheck(action,"01",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "18:open";
	count := floorCheck(floor,"110",count);
	count := actionCheck(action,"11",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "19:idle";
	count := floorCheck(floor,"110",count);
	count := actionCheck(action,"00",count);
valid <='1';
  choice <="111";
  wait for Tperiod;
	report "20:move downwards";
	count := floorCheck(floor,"110",count);
	count := actionCheck(action,"00",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "21:move up";
	count := floorCheck(floor,"111",count);
	count := actionCheck(action,"01",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "22:open";
	count := floorCheck(floor,"111",count);
	count := actionCheck(action,"11",count);
valid <='0';
  choice <="010";
  wait for Tperiod;
	report "23:idle";
	count := floorCheck(floor,"111",count);
	count := actionCheck(action,"00",count);

report "Number of failed test cases:" & integer'image(count)  ;

stop;
end process;

end architecture;