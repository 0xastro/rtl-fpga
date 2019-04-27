entity ddfs_lut_4096 is 
    port(    
        -- lut address (N:=12)
        address : in std_logic_vector(11 downto 0);
        -- lut output (M:=6)
		dds_out : out std_logic_vector(5 downto 0)
		);
end ddfs_lut_4096;


architecture beh of ddfs_lut_4096 is

 

-- LUT address converted to integer to be used ad array index
signal lut_address_index : integer range 0 to 4095; 
	
-- its better to use -T to indicate this is a type signal
TYPE LUT_T is array (natural range <> ) of integer;
-- Look up table cells
constant ddfs_lut : LUT_T := ( 0,
                               1,
                               2,
                               --
	);
    
-- OR std_logic vector
TYPE LUT_T is array (natural range <> ) of std_logic_vector (5 downto 0);
constant ddfs_lut : LUT_T := ( 00000,
                               00001,
                               00010,
                               --
	);
-- we use type conversion ieee.numeric_std.all
-- lookup table index/address (unsinged int)
-- Converting the lut address into an integer to be usable as array index
-- lut_address_index defined as signals 

-- It's not recommended to do it in one step; since the simulator may miss behave in Range
-- Checking for the integer
lut_address_index <= ddfs_lut (to_integer(unsigned(address)));
-- Selecting the lut cell depending on the index lut_address_index
dds_out <= std_logic_vector(to_unsigned(ddfs_lut(lut_address_index),6));


-- so It's better/more safe to do the casting in two steps
lut_address_index <= to_integer(address);
dds_out <= ddfs_lut(lut_address_index);

end beh;
