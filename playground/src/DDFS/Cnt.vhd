library ieee;
    use ieee.std_logic_1164.all;

    entity Counter is
	    generic( N : natural := 8);
		
        port( -- Input of counter
                d     : in std_logic_vector(N - 1 downto 0);
                -- Clk of the system
                clk   : in std_logic;
                -- Carry input 
                rst_h : in std_logic;
                -- Output of the full-adder
                q     : out std_logic_vector(N - 1 downto 0)
            );
			
    end Counter;
	
   architecture struct of Counter is
   
    --------------------------------------------------------------
	-- Signals declaration
	--------------------------------------------------------------
   
    -- Output of the DFF_N
    signal q_h : std_logic_vector(N - 1 downto 0);
	
	-- Output of the fullAdder_N
	signal fullAdder_out : std_logic_vector(N - 1 downto 0);
	
	--------------------------------------------------------------
	-- Components declaration
	--------------------------------------------------------------
	
	component DFF_N is
	    generic( N : natural := 8);
		
        port( -- Input of the register
                d     : in std_logic_vector(N - 1 downto 0);
                -- Clk of the system
                clk   : in std_logic;
                -- Carry input 
                rst_h : in std_logic;
                -- Output of the full-adder
                q     : out std_logic_vector(N - 1 downto 0)
            );
			
    end component;
	
	component fullAdder_N is
       generic (N : integer := 2);
	   
        port(-- Input of the full-adder
            a   : in std_logic_vector(N - 1 downto 0);
            -- Input of the full-adder
            b   : in  std_logic_vector(N - 1 downto 0);
            -- Carry input 
            c_i : in std_logic;
            -- Output of the full-adder
            o   : out  std_logic_vector(N - 1 downto 0);
            -- Carry output
            c_o : out std_logic
            );
	end component;
	
	
	
   begin
   
        FULL_ADDER_N_MAP :  fullAdder_N 
       generic map(N => N)
	   
        port map(-- Input of the full-adder
                 a   => d,
                 -- Input of the full-adder
                 b   => q_h,
                 -- Carry input 
                 c_i => '0',
                 -- Output of the full-adder
                 o   => fullAdder_out,
                 -- Carry output
                 c_o => open
            );
			
	    DFF_N_MAP : DFF_N 
		
		generic map(N => N)
		
		port map( -- Input of the register
                d     => fullAdder_out,
                -- Clk of the system
                clk   => clk,
                -- Carry input 
                rst_h => rst_h,
                -- Output of the full-adder
                q     => q_h
            );
		
		
	    -- Mapping the output
	    q <= q_h;
	   
   
   end struct;
    