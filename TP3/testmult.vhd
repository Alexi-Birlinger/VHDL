library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
  component mult is
    port( multiplieur, multiplicande: std_logic_vector(7 downto 0);
	  go, clk, rst: std_logic;
	  fin: out std_logic;
	  s: out std_logic_vector(15 downto 0));
  end component;
  
  signal go, clk, rst, fin: std_logic:= '0';
  signal multiplieur, multiplicande: std_logic_vector(7 downto 0);
  signal s: std_logic_vector(15 downto 0);
  for UUT: mult use entity work.mult(rtl);
  begin
    UUT: mult port map(clk=>clk, rst=>rst, go=>go, multiplieur=>multiplieur, multiplicande=>multiplicande, fin=>fin, s=>s);
    rst <= '1', '0' after 6 ns;
    multiplieur <= "00001111";
    multiplicande <= "00100001";
    clk <= not clk after 5 ns;
    go <= '1' after 6 ns, '0' after 16 ns;
end bench;
