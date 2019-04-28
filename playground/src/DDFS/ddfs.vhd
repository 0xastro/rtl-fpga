library IEEE;
use IEEE.std_logic_1164.all;


entity ddfs is 

						port( -- input frequency word
								fw         : in std_logic_vector(11 downto 0);
                        -- clock of the system 
								clk        : in std_logic;
                        -- Asynchronous active - high reset
								a_rst_h    : in std_logic;
                        -- output waveform
								output     : out std_logic_vector(5 downto 0)
								);
end ddfs;


architecture struct of ddfs is

-------------------------------------------------------------------------------------
-- Internal signals
-------------------------------------------------------------------------------------
   -- Output of of the phase accumulator counter
	signal phase_out      : std_logic_vector(11 downto 0);
   -- Output of the LUT table
	signal lut_output     : std_logic_vector(5 downto 0);
   -- Output register for the output synchronization
	signal output_reg     : std_logic_vector(5 downto 0);

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
    
   component ddfs_lut_4096 is 
				port(
							address : in std_logic_vector(11 downto 0);
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
	   
   
		
      
		LUT_4096 : ddfs_lut_4096 port map(
												address => phase_out,
												dds_out => lut_output		
											);
   
		
      DDFS_OUTPUT_REG: process(a_rst_h,clk)
			begin
			if(a_rst_h ='1') then
				output_reg <= (others => '0');
			elsif(rising_edge(clk)) then
			   output_reg <= lut_output;
			end if;
			
		end process;
		
      -- Mapping the output
		output <= output_reg;
end struct;