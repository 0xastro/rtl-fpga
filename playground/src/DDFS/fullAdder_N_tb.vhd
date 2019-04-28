library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


    entity fullAdder_N_tb is
       
	end fullAdder_N_tb;
   
   architecture testbench of fullAdder_N_tb is
   
    -----------------------------------------------------------------------------------------------------
	-- components declaration
	-----------------------------------------------------------------------------------------------------
   
        component fullAdder_N is    --! component declaration
        
		    generic (N : integer := 8);
	   
            port(-- Input of the full-adder
                a    : in std_logic_vector(N - 1 downto 0);
                -- Input of the full-adder
                b    : in  std_logic_vector(N - 1 downto 0);
                -- Carry input 
                c_i  : in std_logic;
                -- Output of the full-adder
                o    : out  std_logic_vector(N - 1 downto 0);
                -- Carry output
                c_o  : out std_logic
                );
		end component;
   
	-----------------------------------------------------------------------------------------------------
	-- constants declaration
	-----------------------------------------------------------------------------------------------------
	    -- CLK period
	    constant T_CLK  : time := 100 ns;
		-- Simulation time
		constant T_sim  : time := 1000 ns;
		-- Number of bits of the fullAdder_N
		constant N_bit  : natural := 4;
		
    -----------------------------------------------------------------------------------------------------
	-- signals declaration
	-----------------------------------------------------------------------------------------------------
	    
		-- clk signal (intialized to '0')
		signal clk_tb                 : std_logic := '0'; 
		-- signal to stop the simulation
		signal stop_simulation        : std_logic := '1';
		-- inputs signals
		signal a_tb, b_tb             : std_logic_vector(N_bit - 1 downto 0);
		-- output signals (the declaration is useful to make it visible without observing the fullAdder_N signals
		signal o_tb                   : std_logic_vector(N_bit - 1 downto 0);
		
	   
	   
   begin
   
        -- clk variation
	    clk_tb                 <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
		
		-- stopping the simulation after T_sim
		stop_simulation        <= '0' after T_sim;
		
		test_fullAdder_N: fullAdder_N
        
		    generic map(N => N_bit)
	   
            port map(-- Input of the full-adder
                    a    => a_tb,
                    -- Input of the full-adder
                    b    => b_tb,
                    -- Carry input 
                    c_i  => '0',
                    -- Output of the full-adder
                    o    => o_tb,
                    -- Carry output
                    c_o => open -- I need to explore the fullAdder_N_tb signals to see it
                );
		
		input_process : process(clk_tb)
		
		    --! variable to control the number of clock cycles
			variable t : natural := 0;
			
		
		begin
		   
		    if(rising_edge(clk_tb) ) then
			 
			    case t is
				
				    when 0       => a_tb <= (N_bit - 1 downto 0 => '0'); -- all zeros
					                b_tb <= (others => '0');             -- another way to say "all zeros"
				
				    when 1       => a_tb <= std_logic_vector(to_unsigned(15, N_bit)); -- converting 1 using N_bit bits and using an unsigned representation
					
					
					when 2       => b_tb <= std_logic_vector(to_unsigned(15, N_bit)); -- overflow expected in o_tb
					
					when 3       => b_tb <= std_logic_vector(to_unsigned(1, N_bit));
					                a_tb <= std_logic_vector(to_unsigned(7, N_bit));
									 
				    when 4 to 7  => b_tb <= "0010";
					
					when others => null;
					
				end case;
			 
			 
			-- incrementing t
			t := t + 1;
			end if;
			 
		
		
		end process;
		
        
   end testbench;