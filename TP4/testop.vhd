library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
  component opArithmetique is
    generic(N: natural);
    port( Cin: std_logic;
	  An, Bn: std_logic_vector(N-1 downto 0);
	  S: std_logic_vector(1 downto 0);
	  Gn: out std_logic_vector (N-1 downto 0);
	  Cout: out std_logic);
  end component;
  
  constant N: natural:= 4;
  signal Cin, Cout: std_logic;
  signal An, Bn, Gn: std_logic_vector(N-1 downto 0);
  signal S: std_logic_vector(1 downto 0);
  for UUT: opArithmetique use entity work.opArithmetique(dflow);
  begin
    UUT: opArithmetique generic map(N=>N) port map(Cin=>Cin, An=>An, Bn=>Bn, S=>S, Gn=>Gn, Cout=>Cout);
    An <= "1001"; --9
    Bn <= "0010"; --2
    S <= "00", "01" after 20 ns, "11" after 40 ns, "10" after 60 ns, "00" after 80 ns;
    Cin <= '0', '1' after 60 ns;
end bench;
