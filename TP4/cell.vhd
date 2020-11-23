library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cell is
  port( Ci, Ai, Bi: std_logic;
	S: std_logic_vector(1 downto 0);
	Gi, Co: out std_logic);
end cell;

architecture dflow of cell is
  signal Fadd: std_logic_vector(1 downto 0);
  signal V: std_logic;
  begin
    V <= (S(1) and not(Bi)) or (S(0) and Bi);
    Fadd <= ('0' & Ai) + V + Ci;
    Gi <= Fadd(1);
    Co <= Fadd(0);  
end dflow;
