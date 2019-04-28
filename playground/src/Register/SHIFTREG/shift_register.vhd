library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register is   -- entity declaration
       generic(N_bit : integer);  -- generic parameter modelling the generic number of bits of the shift register
	   port(
			d       : in std_logic;   --  Shift register input
			q       : out std_logic;  --  Shift register output
			clk     : in std_logic;   --  clk
	                a_rst_n : in std_logic    --  Asynchronous active low reset
	       );
end shift_register;

architecture bhv of shift_register is  -- architectural declaration (behavioral description)

signal d_in : std_logic_vector(N_bit - 1 downto 0);  -- internal signal used to map the internal registers

begin
	
	shift_reg_proc: process(clk,a_rst_n)  -- Process realizing a sequential network with asynchronous reset
		begin
		
			if(a_rst_n = '0') then    -- Asynchronous reset model
			   d_in <= (others => '0'); -- Use the keyword "others" to address all the N_bit bits. Watch out: do not omit the brackets
			
			elsif(rising_edge(clk)) then  -- Positive edge trigger D-flip-flop register modelling
			   d_in(0)                  <= d; -- Sampling the input d
			   d_in(N_bit - 1 downto 1) <= d_in(N_bit - 2 downto 0); -- Shifting the internal bits
			end if; 
	end process;  -- All the signals are updated at the same time after a delta delay of the variation of the one of the signals in the sensitivity list at the end of the process. 
                      -- So, it is the same to write the shift commands (din_(0) <= ... and din(N_bit - 1.... in the other order).


    q <= d_in(N_bit - 1); -- This is a short circuit between q and d_in(N_bit - 1).

end bhv;