entity test0 is
end test0;

architecture bench of test0 is
  component compteur is
    port( h, rst, e, s: bit;
	  cup: out bit);
  end component;
  
  signal h, rst, e, s, cup: bit;
  for UUT: compteur use entity work.compteur(rtl);
  begin
    UUT: compteur port map(h=>h, rst=>rst, e=>e, s=>s, cup=>cup);
    rst <= '0';
    h <= not h after 10 ns;
    e <= '1' after 11 ns, '0' after 41 ns, '1' after 51 ns, '0' after 61 ns;
    s <= '1' after 11 ns, '0' after 21 ns, '1' after 41 ns, '0' after 61 ns;
end bench;

entity test1 is
end test1;

architecture bench of test1 is
  component compteur is
    port( h, rst, e, s: bit;
	  cup: out bit);
  end component;
  
  signal h, rst, e, s, cup: bit;
  for UUT: compteur use entity work.compteur(rtl);
  begin
    UUT: compteur port map(h=>h, rst=>rst, e=>e, s=>s, cup=>cup);
    rst <= '0';
    h <= not h after 10 ns;
    e <= '1' after 9 ns, '0' after 39 ns, '1' after 49 ns, '0' after 59 ns;
    s <= '1' after 9 ns, '0' after 29 ns, '1' after 39 ns, '0' after 59 ns;
end bench;