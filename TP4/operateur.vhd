library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity opArithmetique is
  generic(N: natural);
  port( Cin: std_logic;
	An, Bn: std_logic_vector(N-1 downto 0);
	S: std_logic_vector(1 downto 0);
	Gn: out std_logic_vector (N-1 downto 0);
	Cout: out std_logic);
end opArithmetique;

architecture dflow of opArithmetique is
  component cell is
    port( Ci, Ai, Bi: std_logic;
	  S: std_logic_vector(1 downto 0);
	  Gi, Co: out std_logic);
  end component;

  signal C: std_logic_vector(N-1 downto 0);
  begin
    C(0) <= Cin;
    f1:for i in Gn'range generate
      i1:if i < N-1 generate
	celli: cell port map(Ai=>An(i), Bi=>Bn(i), Ci=>C(i), S=>S, Gi=>Gn(i), Co=>C(i+1));
      end generate;
      i2:if i = N-1 generate
	cellN: cell port map(Ai=>An(i), Bi=>Bn(i), Ci=>C(i), S=>S, Gi=>Gn(i), Co=>open);
      end generate;
    end generate;
end dflow;