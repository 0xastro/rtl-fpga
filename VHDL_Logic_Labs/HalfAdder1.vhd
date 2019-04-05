```VHDL
-------------------------------
-- HalfAdder Implementation
-------------------------------
entity HalfAdder is
	port (
		a	: in std_logic;
		b	: in STD_LOGIC;	
		co	: out std_logic;
		s	: out std_logic
		);
end HalfAdder;

architecture Beh of HalfAdder is -- architecture name
	begin
		comb_p: process(a,b)
			begin
				if (a and b) = '1' then
					co <= '1';
				else
					co <= '0';
				end if;
			end process
		s <= a xor b;
	end Beh;
  
```
