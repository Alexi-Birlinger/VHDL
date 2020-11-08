--Description de l'entité;

entity controleur is
  port(	h, rst, ready, read_write: bit;
	oe, we: out bit);
end controleur;


--Description du comportement;

architecture beh of controleur is
  type defetat is (idle, decision, eread, ewrite);
  signal etat: defetat;
  begin
    process(h, rst)
    begin
      if rst = '1' then etat <= idle;
      elsif h = '1' and h'event then
        oe <= '0'; we <= '0';
        case etat is
	  when idle => if ready = '1' then
			 etat <= decision;
			 end if;
	  when decision => if read_write = '1' then
			 	etat <= eread;
			   else
				etat <= ewrite;
			   end if;
	  when eread => oe <= '1'; if ready = '1' then
			  etat <= idle;
			  end if;
	  when ewrite => we <= '1'; if ready = '1' then
			   etat <= idle;
			   end if;
	end case;
      end if;
    end process;
end beh;


--Description du comportement;

architecture rtl of controleur is
  type defetat is (idle, decision, eread, ewrite);
  signal etat, netat: defetat;
  begin
    process(h, rst)
    begin
      if rst = '1' then
	etat <= idle;
      elsif h = '1' and h'event then
	etat <= netat;
      end if;
    end process;

    process(ready, read_write, etat)
      begin
        oe <= '0'; we <= '0';
        netat <= etat;
        case etat is
	  when idle => if ready = '1' then
			 netat <= decision;
		       end if;
	  when decision => if read_write = '1' then
			 	netat <= eread;
			   else
				netat <= ewrite;
			   end if;
	  when eread => oe <= '1'; if ready = '1' then
			  		netat <= idle;
			  	   end if;
	  when ewrite => we <= '1'; if ready = '1' then
			   		netat <= idle;
			   	   end if;
	end case;
    end process;
end rtl;