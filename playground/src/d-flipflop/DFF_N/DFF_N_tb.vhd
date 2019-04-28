--------------------------------------------------------------------------------
-- generic D-FlipFlop FlipFlop
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DFF_N_tb is
end DFF_N_tb;

--------------------------------------------------------------------------------
-- architecture structural
--------------------------------------------------------------------------------
architecture beh of DFF_N_tb is

  component DFF_N
    generic( N : integer := 4);
    port(
        D           : in std_logic_vector(N-1 downto 0);
        clk, rst    : in std_logic;
        -- enable
        en          : in std_logic;
        Q           : out std_logic_vector(N-1 downto 0)
        );
  end component DFF_N;

  ----------------------------------------
    -- Testbench constant declaration
  ----------------------------------------
    -- Generic constant definition
    constant Nbit : integer := 4;
    -- signals for mapping the component variables to test variables (local copy)
    signal D_tb           : std_logic_vector(Nbit-1 downto 0);
    signal clk_tb         : std_logic;
    signal rst_tb         : std_logic;
    signal en_tb          : std_logic;
    constant clk_period  : time := 100 ns;
    signal clk_go        : std_logic;

  ----------------------------------------
    -- Start Port Mapping
    -- linking the gates with the testbench
    -- signals for the test
    -- DFF instantiation
  ----------------------------------------
begin
  clk_tb <= not clk_tb after clk_period/2 when clk_go='1' else '0';

  dut: DFF_N
  -- It is necessary to specify the number of bits (3 in this case).
  -- Try to change and watch the difference in the simulation.
  generic map(N => Nbit)
  port map (
    clk     => clk_tb    ,
    rst     => rst_tb    ,
    D       => D_tb      ,
    en      => en_tb     ,
    Q       => open
  );


  -- Define Test Vectors
  -- process used to make the testbench signals change synchronously with the rising edge of the clock

  stim_proc: process
  begin

    --D_tb <= (others => '0');
    rst_tb  <= '1';
    D_tb    <= "0000";
    clk_go  <= '1';
    en_tb   <='1';

    wait for 100 ns;
    rst_tb  <= '0';

    -----------------------------------------------
    -- Since this is a 4-Bit DFF
    -- We have 2pow(4):= 16 test vecotors for the
    -- input D_tb
    -----------------------------------------------
    --for i in 0 to 2**Nbit-1 loop
    -- D_tb   <= std_logic_vector(TO_SIGNED(i,Nbit));
    --  wait until rising_edge(clk_tb);
    --  wait for 100 ns;
    --end loop;


    wait until rising_edge(clk_tb);
    D_tb       <= "0010";

    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    D_tb       <= "0100";

    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    D_tb       <= "0110";


    wait until rising_edge(clk_tb);
    wait for 100 ns;
    rst_tb     <= '1';
    en_tb      <= '0';
    wait for 100 ns;
    clk_go  <= '0';
    wait;

    end process stim_proc;

end beh;
