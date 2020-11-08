library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mult is
  port( multiplieur, multiplicande: std_logic_vector(7 downto 0);
	go, clk, rst: std_logic;
	fin: out std_logic;
	s: out std_logic_vector(15 downto 0));
end mult;


architecture rtl of mult is
  signal razc, ldqi, shiftdec, cout, ldc, lda, c, z, f: std_logic:= '0';
  signal A, E, Q: std_logic_vector(7 downto 0):= "00000000";
  signal I: std_logic_vector(7 downto 0); --Ne doit pas être mis à zéro pour ne pas mettre fin directement à 1
  signal add: std_logic_vector(8 downto 0):= "000000000";
  type defetat is (E0, E1, E2);
  signal etat, netat: defetat;
  begin
    c <= '0' when (ldc = '0' and razc = '1') and (clk = '1' and clk'event)
	 else cout when (ldc = '1' and razc = '0') and (clk = '1' and clk'event);
    add <= ('0' & A) + ('0' & multiplicande); --On initialise la retenue à 0
    cout <= add(8);
    A <= (c & A(7 downto 1)) when (lda = '0' and shiftdec = '1') and (clk = '1' and clk'event)
	 else E when (lda = '1' and shiftdec = '0') and (clk = '1' and clk'event);
    E <= add(7 downto 0) when ldqi = '0' else "00000000";
    Q <= (A(0) & Q(7 downto 1)) when (ldqi = '0' and shiftdec = '1') and (clk = '1' and clk'event)
	 else multiplieur when (ldqi = '1' and shiftdec = '0') and (clk = '1' and clk'event);
    I <= (I - 1) when (ldqi = '0' and shiftdec = '1') and (clk = '1' and clk'event)
	 else "00001000" when (ldqi = '1' and shiftdec = '0') and (clk = '1' and clk'event);
    z <= '1' when I = "00000000" else '0';

    s(15 downto 8) <= A;
    s(7 downto 1) <= Q(7 downto 1);
    s(0) <= Q(0);
    fin <= f;

    mem: process(clk, rst)
      begin
	if rst = '1' then
	  etat <= E0;
	elsif clk = '1' and clk'event then
	  etat <= netat;
	end if;
    end process;

    comb: process(go, Q(0), z, etat)
      begin
	netat <= etat;
	lda <= '0'; ldqi <= '0'; ldc <= '0';
	razc <= '0';
	shiftdec <= '0';
	case etat is
	  when E0 => if go = '1' then
			lda <= '1'; ldqi <= '1'; razc <= '1';
			netat <= E1;
		     end if;
	  when E1 => if z = '1' then
			f <= '1';
			netat <= E0;
		     else
			if Q(0) = '1' then
			  lda <= '1'; ldc <= '1';
			  netat <= E2;
			else
			  netat <= E2;
			end if;
		     end if;
	when E2 => shiftdec <= '1'; razc <= '1';
		   netat <= E1;
      end case;
    end process;
end rtl;
