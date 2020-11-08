--Description de l'entité;

entity controleurb is
  port(	h, rst, ready, burst, read_write: bit;
	adr: out bit_vector(0 to 1);
	oe, we: out bit);
end controleurb;


--Description du comportement;

architecture rtl of controleurb is
  type defetat is (idle, decision, ewrite, read0, read1, read2, read3);
  signal etat, netat: defetat;
  begin
    process(h)
    begin
      if rst = '1' then
	etat <= idle;
      elsif h = '1' and h'event then
	etat <= netat;
      end if;
    end process;

    process(ready, burst, read_write, etat)
      begin
        oe <= '0'; we <= '0'; adr <= "00";
        netat <= etat;
        case etat is
	  when idle => if ready = '1' then
			 netat <= decision;
		       end if;
	  when decision => if read_write = '1' then
			 	netat <= read0;
			   else
				netat <= ewrite;
			   end if;
	  when ewrite => we <= '1'; if ready = '1' then
			   		netat <= idle;
			   	   end if;
	  when read0 => oe <= '1'; if ready = '1' then
					if burst = '1' then
			  		  netat <= read1;
					else
					  netat <= idle;
					end if;
			  	   end if;
	  when read1 => adr <= "01"; if ready = '1' then
					netat <= read2;
				     end if;
	  when read2 => adr <= "10"; if ready = '1' then
					netat <= read3;
				     end if;
	  when read3 => adr <= "11"; if ready = '1' then
					netat <= idle;
				     end if;
	end case;
    end process;
end rtl;
