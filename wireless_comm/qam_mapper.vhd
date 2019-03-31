-- To be built
---------------------------------------------------------
-- QAM MAPPER
---------------------------------------------------------
-- we want to have one single change of bits from one symbol to the other;
-- thus, using fixed point number[gray code] representation {00, 01, 11, 10} to represent {1+1j, -1+1j, -1-1j, 1-1j} 
-- Constellation	|	Symbols
-- {00}			|	{+1+J}
-- {01}			|	{-1+J}
-- {10}			|	{+1-J}
-- {11}			|	{-1-J}
---------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY qam_mapper is
	port (
		data_in		: in std_logic_vectror (1 downto 0);
		I_symbols	: out std_logic_vector (1 downto 0);
		Q_symbols	: out std_logic_vector (1 downto 0)
	);
	

END qam_mapper;

ARCHITECTURE Behaviourl of qam_mapper is
	-- define array for both I and Q parts (4 constellation points)
	-- Constellation Size; to be generic however the modulation order
	constant const_size : integer := 4
	-- Constellation Type
	type constellation is array (0 to 3) of signed (1 downto 0);
	-- I array
	-- to_signed: Converts an INTEGER to a SIGNED vector of the specified SIZE.
	constant I_data	: constellation := (
		to_signed(1,2);
		to_signed(-1,2);
		to_signed(1,2);
		to_signed(-1,2)
		);
	-- Q array
	constant Q_data	: constellation := (
		to_signed(1,2);
		to_signed(1,2);
		to_signed(-1,2);
		to_signed(-1,2)
		);

end Behaviourl;
