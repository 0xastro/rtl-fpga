library ieee;
use ieee.std_logic_1164.ALL;
-------------------------------
-- HalfAdder Implementation
-- Testbench is Included under the name HalfAdder_beh_tb
-------------------------------
entity HalfAdder is
	port (
		i_a, i_b	: in	std_logic;
		o_sum, o_carry	: out	std_logic);
end HalfAdder;


architecture Beh of HalfAdder is -- architecture name
	begin
		comb_p: process(i_a,i_b)
			begin
				if (i_a and i_b) = '1' then
					o_carry <= '1';
				else
					o_carry <= '0';
				end if;
			end process
		s <= a xor b;
end Beh;
  
