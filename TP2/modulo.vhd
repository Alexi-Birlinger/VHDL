--Description de l'entité;

entity compteur is
  port( h, rst, e, s: bit;
	cup: out bit);
end compteur;

architecture rtl of compteur is
  type defetat is (q0, q1, q2);
  signal etat, netat: defetat;

  begin
    process(h)
    begin
      if rst = '1' then etat <= q0;
      elsif h = '1' and h'event then etat <= netat;
      end if;
    end process;

    process(e, s, etat)
    begin
      cup <= '0';
      netat <= etat;
      case etat is
	when q0 => if e = '1' then
			if s = '1' then cup <= '1'; netat <= q2;
				   else netat <= q1;
			end if;
		   end if;
	when q1 => if e = '1' then
			if s = '1' then netat <= q0;
				   else netat <= q2;
			end if;
		   end if;
	when q2 => if e = '1' then
			if s = '1' then netat <= q1;
				   else cup <= '1'; netat <= q0;
			end if;
		   end if;
      end case;
    end process;
end rtl;