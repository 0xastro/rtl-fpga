library IEEE;
use IEEE.std_logic_1164.all;


entity ddfs_optimized is 

						port( -- input frequency word
								fw         : in std_logic_vector(11 downto 0);
                        -- clock of the system 
								clk        : in std_logic;
                        -- Asynchronous active - high reset
								a_rst_h    : in std_logic;
                        -- output waveform
								output     : out std_logic_vector(5 downto 0)
								);
end ddfs_optimized;


architecture struct of ddfs_optimized is

-------------------------------------------------------------------------------------
-- Internal signals
-------------------------------------------------------------------------------------
   -- Output of of the phase accumulator counter
	signal phase_out        : std_logic_vector(11 downto 0);
   -- Lut address
	signal lut_address      : std_logic_vector(9 downto 0);
   -- Output of the LUT table
	signal lut_output       : std_logic_vector(5 downto 0);
   -- Complemented output of the LUT
	signal lut_output_muxed : std_logic_vector(5 downto 0);
   -- Output register for the output synchronization
	signal output_reg       : std_logic_vector(5 downto 0);

-------------------------------------------------------------------------------------
-- Internal signals
-------------------------------------------------------------------------------------
   component Counter is
	    generic( N : natural := 8);
		
        port(   -- Input of counter
                d     : in std_logic_vector(N - 1 downto 0);
                -- Clk of the system
                clk   : in std_logic;
                -- Carry input 
                rst_h : in std_logic;
                -- Output of the full-adder
                q     : out std_logic_vector(N - 1 downto 0)
            );
			
    end component;
    
   component ddfs_lut_1024 is 
				port(
							address : in std_logic_vector(9 downto 0);
							dds_out : out std_logic_vector(5 downto 0)
							);
   end component;
	
	
	begin
	
		PHASE_ACCUMULATOR: Counter generic map (N => 12)
                                 port map(
                                           -- Input of counter
                                           d     => fw,
                                           -- Clk of the system
                                           clk   => clk,
                                           -- Carry input 
                                           rst_h => a_rst_h,
                                           -- Output of the full-adder
                                           q     => phase_out
   
                                         );
	   
      -- Selecting the lut output between lut_output and not(lut_output) depending on phase_out(11) (DDFS OUTPUT MULTIPLEXER)  
		lut_output_muxed <=  lut_output when (phase_out(11) = '0') else not(lut_output);
		
      
		LUT_1024 : ddfs_lut_1024 port map(
												address => lut_address,
												dds_out => lut_output		
											);
      -- Selecting the lut_address between phase_out(9 downto 0) and not(phase_out(9 downto 0))depending on phase_out(10) (ADDRESS MULTIPLEXER)                     
		lut_address <= phase_out(9 downto 0) when (phase_out(10) = '0') else not(phase_out(9 downto 0) );
		
      DDFS_OUTPUT_REG: process(a_rst_h,clk)
			begin
			if(a_rst_h ='1') then
				output_reg <= (others => '0');
			elsif(rising_edge(clk)) then
				output_reg <= lut_output_muxed;
			end if;
			
		end process;
		
      -- Mapping the output
		output <= output_reg;
end struct;