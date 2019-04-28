library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------
  -- Counter Testbench
-------------------------------------------------------------------

entity counter_tb is
end counter_tb;

-------------------------------------------------------------------
  -- Counter architecture
-------------------------------------------------------------------

architecture struct of counter_tb is

-------------------------------------------------------------------
-- Testbench constants
-------------------------------------------------------------------
constant T_CLK   : time := 10 ns; -- Clock period
constant T_RESET : time := 25 ns; -- Period before the reset deassertion
constant N_TB	: natural := 3;	  -- Generic constant definition
-------------------------------------------------------------------
-- Testbench signals
-------------------------------------------------------------------
signal clk_tb : std_logic := '0'; -- clock signal, intialized to '0'
signal rst_tb  : std_logic := '0'; -- reset signal
signal d_tb    : std_logic_vector(N_TB-1 downto 0);        -- d signal to connect to the d port of the component
signal q_tb    : std_logic_vector(N_TB-1 downto 0);        -- q signal to connect to the q port of the component
signal en_tb	: std_logic := '1'; -- enable signal to connect to the en input port
signal end_sim : std_logic := '1'; -- signal to use to stop the simulation when there is nothing else to test



component counter is
  generic( N : integer := 4);
  port(
    d         : in std_logic_vector(N-1 downto 0);
    q         : out std_logic_vector(N-1 downto 0);
    clk,rst,en: in std_logic);
end component;


   begin
   clk_tb <= (not(clk_tb) and end_sim) after T_CLK / 2;
   rst_tb <= '1' after T_RESET;
  counter_map :  counter
      generic map(N => N_tb)
      port map(
       -- Input of the full-adder A, B and cin
        d     => d_tb,       -- d is the frequency word (input of the counter)
        clk   => clk_tb,
        rst   => rst_tb,
        en		=> en_tb,
        q     => open
        );
-------------------------------------------------------------------
-- Start Testing process
   -- process used to make the testbench signals change
   -- synchronously with the rising edge of the clock
-------------------------------------------------------------------

  counter_proc: process(clk_tb, rst_tb)
    -- variable used to count the clock cycle after the reset
    variable t : integer := 0;
    begin
      if(rst_tb = '0') then
        d_tb <= (others => '0');
        en_tb <= '1';
        t := 0;
      elsif(rising_edge(clk_tb)) then
      -- specifying the input d_tb and end_sim depending
      -- on the value of t ( and so on the number of the passed clock cycles).
        case(t) is
        -- count 1 by 1
        when 1 => d_tb <= "001"; 	-- not generic. If you change N_TB you have to fix the length of the test vector

        -- count 2 by 2
        when 8 => d_tb <= "010";	-- not generic. If you change N_TB you have to fix the length of the test vector

        -- add here more cases to test

        when 14 => end_sim <= '0'; -- This command stops the simulation when t = 10
        when others => null; -- Specifying that nothing happens in the other cases

        end case;
        t := t + 1; -- the variable is updated exactly here (try to move this statement before the "case(t) is" one and watch the difference in the simulation)
        end if;

        end process;


end struct;
