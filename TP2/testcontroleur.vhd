entity testcontroleur is
end testcontroleur;

architecture bench of testcontroleur is
  component controleur is
    port( h, rst, ready, read_write: bit;
	  oe, we: out bit);
  end component;
  
  signal h, rst, ready, read_write, oe, we: bit;
  for UUT: controleur use entity work.controleur(rtl);
  begin
    UUT: controleur port map(h=>h, rst=>rst, ready=>ready, read_write=>read_write, oe=>oe, we=>we);
    rst <= '0';
    h <= not h after 10 ns;
    ready <= '1' after 30 ns, '0' after 40 ns, '1' after 50 ns, '0' after 150 ns;
    read_write <= '1' after 14 ns, '0' after 28 ns, '1' after 42 ns, '0' after 56 ns;
end bench;