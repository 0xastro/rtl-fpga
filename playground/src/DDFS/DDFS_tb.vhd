library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


    entity DDFS_tb is
       
    end DDFS_tb;
   
   architecture testbench of DDFS_tb is
   
    -----------------------------------------------------------------------------------------------------
	-- components declaration
	-----------------------------------------------------------------------------------------------------
   
         component ddfs is 

						port( -- input frequency word
								fw         : in std_logic_vector(11 downto 0);
                        -- clock of the system 
								clk        : in std_logic;
                        -- Asynchronous active - high reset
								a_rst_h    : in std_logic;
                        -- output waveform
								output     : out std_logic_vector(5 downto 0)
								);
		   end component;
   
	-----------------------------------------------------------------------------------------------------
	-- constants declaration
	-----------------------------------------------------------------------------------------------------
	   
      -- CLK period (f_CLK = 125 MHz)
	   constant T_CLK  : time := 8 ns;
      
      -- Maximum sine period
      constant T_max_period : time := 4096 * T_CLK;
      
		-- Simulation time
		constant T_sim  : time := 10 * T_max_period;
      
      -- Time before the reset release
      constant T_reset : time := 10 ns;

		
        -----------------------------------------------------------------------------------------------------
	-- signals declaration
	-----------------------------------------------------------------------------------------------------
	    
		-- clk signal (intialized to '0')
		signal clk_tb                 : std_logic := '0'; 
      -- Active high asynchronous reset (Active at t = 0)
      signal a_rst_h_tb             : std_logic := '1';
		-- signal to stop the simulation
		signal stop_simulation        : std_logic := '1';
		-- inputs frequency word
		signal fw_tb                  : std_logic_vector(11 downto 0);
		-- output signals (the declaration is useful to make it visible without observing the ddfs component)
		signal ddfs_out_tb            : std_logic_vector(5 downto 0);
		
	   
	   
   begin
   
      -- clk variation
	   clk_tb                 <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
      
      -- reset control
      a_rst_h_tb             <= '0' after T_reset;
		
		-- stopping the simulation after T_sim
		stop_simulation        <= '0' after T_sim;
		
		test_ddfs: ddfs
        
		    port map      ( -- input frequency word
								fw         => fw_tb,
                        -- clock of the system 
								clk        => clk_tb,
                        -- Asynchronous active - high reset
								a_rst_h    => a_rst_h_tb,
                        -- output waveform
								output     => ddfs_out_tb
								);
		
		input_process : process
		
		
		begin
		   
        
            fw_tb   <= (others => '0');
            wait until a_rst_h_tb = '0';
         
			   fw_tb  <= std_logic_vector(to_unsigned(1, 12));
            
            wait for 2 * T_max_period + T_reset;
            fw_tb  <= std_logic_vector(to_unsigned(2, 12));
            
            wait for 2 * T_max_period + T_reset;
            fw_tb  <= std_logic_vector(to_unsigned(512, 12));
            
			   wait for 2 * T_max_period + T_reset;
            fw_tb  <= std_logic_vector(to_unsigned(2047, 12));  -- Testing the Nyquist condition
            
            wait for 2 * T_max_period + T_reset;
            fw_tb  <= std_logic_vector(to_unsigned(2048, 12));  -- Testing the Nyquist condition
            
            wait until stop_simulation = '0';
		
		
		end process;
		
        
   end testbench;