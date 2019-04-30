library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY mapping_tb is
END mapping_tb;

ARCHITECTURE Behavioral of mapping_tb is

	--Define the clock as 100 MHz
	constant clk_period : time :=10 ns;
	--Define a signal called clk
	signal clk : std_logic;
	signal rst : std_logic;
	signal twobitcount : unsigned(1 downto 0);
	signal tx_bits : std_logic_vector(1 downto 0); 


component qam_mapper is
        port (
                data_in         : in std_logic_vector (1 downto 0);
                I_symbols       : out std_logic_vector (1 downto 0);
                Q_symbols       : out std_logic_vector (1 downto 0)
        );
end component;


begin
-----------------------------------------------------------------------
-- PROCESSES: Clock and Reset Generation
-----------------------------------------------------------------------
	-- This process is (while(1)) repeasts forever 
	clk_gen : process 
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	reset_gen : process
	begin
		rst <= '1'; -- reset is active at the begining of the simulation
		wait for 2*clk_period;
		rst <= '0';
		wait; -- uncoditional wait
	end process;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- PROCESSE: TWO bit COUNTER
-- synch counter to be assinged to data_in
-----------------------------------------------------------------------
	-- clk and rst are passed the sensitivity list
	count_proc : process(clk, rst)
	begin
		if (rst = '1') then
			twobitcount <= (others => '0'); -- means all bits in the counter will be set to 0
		elsif (rising_edge(clk)) then
			twobitcount <= twobitcount + 1; -- increment the counter for each rising edge of the clk
		end if;
	end process;
-----------------------------------------------------------------------
	tx_bits <= std_logic_vector(twobitcount);
		
-----------------------------------------------------------------------
-- PROCESSE: QAM Transmitter bit COUNTER
-----------------------------------------------------------------------
	
	-- create a label qam_mapper_i to qam_mapper
	-- qam_mapper the developed module, which is in the work library (default lib)
	qam_mapper_i :  qam_mapper
		-- mapping to signals 
		port map (
			data_in		=> tx_bits,
			I_symbols	=> open,
			Q_symbols	=> open
		);

end Behavioral;
