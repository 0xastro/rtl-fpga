library ieee;
    use ieee.std_logic_1164.all;


    entity DFF_N is
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
			
    end DFF_N;
   architecture struct of DFF_N is
   
   
   begin
   
        ddf_n_proc: process(clk, rst_h)
		begin
			if(rst_h = '1') then
				q <= (others => '0');
			elsif(rising_edge(clk)) then
				q <= d;
			end if;
		end process;
   
   end struct;
    
