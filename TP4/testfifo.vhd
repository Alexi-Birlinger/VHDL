library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
  component fifo is
    generic ( N: natural; --Wide
	      D: natural); --Deep
    port( rst, H, Rw, enable: std_logic;
	  dataIn: std_logic_vector(N-1 downto 0);
	  full, empty: out std_logic;
	  dataOut: out std_logic_vector(N-1 downto 0));
  end component;
  
  constant N: natural:= 8;
  constant D: natural:= 8;
  signal rst, H, Rw, enable, full, empty: std_logic;
  signal dateIn, dataOut: std_logic_vector(N-1 downto 0);
  for UUT: fifo use entity work.fifo(rtl);
  begin
    UUT: fifo generic map(N=>N, D=>D) port map( rst=>rst, H=>H, Rw=>Rw, enable=>enable, dataIn=>dataIn,
						full=>full, empty=>empty, dataOut=>dataOut);
    rst <= '1', '0' after 5 ns
    H <= not H after 20 ns
    Rw <= "00000010"; --2
    enable <= '1';
    dataIn <= "11100000", "00100000" after 45 ns, "00000100" after 75 ns,
	      "01000100" after 90 ns, "01010101" after 290 ns;
end bench;
