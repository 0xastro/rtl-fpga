-- To be built

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
