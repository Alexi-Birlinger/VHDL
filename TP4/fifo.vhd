library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fifo is
  generic ( N: natural; --Wide
	    D: natural); --Deep
  port( rst, H, Rw, enable: std_logic;
	dataIn: std_logic_vector(N-1 downto 0);
	full, empty: out std_logic;
	dataOut: out std_logic_vector(N-1 downto 0));
end fifo;

architecture rtl of fifo is
  type registre is array (2**D-1 downto 0) of std_logic;
  signal memoire: registre;
  signal mux: std_logic_vector(N-1 downto 0);
  signal Q: std_logic_vector(D downto 0);
  signal ud, ld: std_logic;
  begin
    ud <= enable and not(Rw);
    ld <= enable and Rw;
    Q <= (D downto 0 => '0') when rst = '1';
	 else (Q + 1) when (enable = '1' and ud = '0') and (H = '1' and H'event);
    	 else (Q - 1) when (enable = '1' and ud = '1') and (H = '1' and H'event);
	 else Q when enable = '0';
    memoire <= ;
    mux <= ;
    dataOut <= mux when Rw = '0';
    full <= ;
    empty <= ;