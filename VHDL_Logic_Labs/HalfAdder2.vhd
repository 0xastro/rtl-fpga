
``` VHDL
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

architecture Struct of  HalfAdder is -- architecture name
	-- component declaration
	component My_AND
		port (AND_in1:in std_logic AND_in2:in std_logic AND_out:out std_logic);
	end component;
	
	component My_XOR
		port (XOR_in1:in std_logic XOR_in2Lin std_logic XOR_out: out std_logic);
	end component;
	-- Component declaration to instantiate the entity its refers
	
	-- arch description
	begin
		i_AND: My_AND -- instance name/label "i_AND" of component "My_AND"
			port map (
				AND_in1 => a, --explicit association
				AND_in2 => b, --explicit association
				AND_out => co --explicit association
			);
			-- One instance of the component My_AND named i_AND. (possible to do i2_AND, i3_AND, i4_AND...)
		i_XOR: My_XOR -- instance name/label "i_XOR" of component "My_XOR" 
			port map (a, b, s); -- positional association 
			--HINT: positional association strongly discouraged
	end Struct;
	```
