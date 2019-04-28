--------------------------------------------------------------------------------
-- D-FlipFlop FlipFlop
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity DFF_tb is
end DFF_tb;

--------------------------------------------------------------------------------
-- architecture structural
--------------------------------------------------------------------------------
architecture beh of DFF_tb is

  component DFF
    port (
      D,clk, rst    : in  std_logic;
      Q             : out std_logic
    );
  end component DFF;

  signal clk           : std_logic := '0';
  signal rst           : std_logic := '1';
  signal clk_go        : std_logic;

  signal D             : std_logic;
  constant clk_period  : time := 100 ns;

begin

-- Define Clock process for testbench
  -- clk_process :process
  -- begin
  -- clk <= '0';
  -- wait for clk_period/2;
  -- clk <= '1';
  -- wait for clk_period/2;
  -- end process;
-- OR in one LINE
  clk <= not clk after clk_period/2 when clk_go='1' else '0';

  dut: DFF
  port map (
    clk     => clk    ,
    rst     => rst    ,
    D       => D      ,
    Q       => open
  );


  -- Define Test Vectors
  stim_proc: process
  begin
    rst     <= '1';
    D       <= '0';
    clk_go  <= '1';

    wait for 100 ns;
    rst     <= '0';
    wait until rising_edge(clk);
    D       <= '1';

    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    D       <= '0';

    wait until rising_edge(clk);
    wait until rising_edge(clk);
    D       <= '1';

    wait until rising_edge(clk);
    wait for 100 ns;
    rst     <= '1';
    wait for 100 ns;
    clk_go  <= '0';
    wait;

  end process stim_proc;

end beh;


-- Another way to define the testVector.
  -- Define Test Vectors
  --  rst     <= '1';
  --  D       <= '0';
  --  wait for 100 ns;
  --  rst     <= '1';
  --  D       <= '1';
  --  wait for 100 ns;
  --  rst     <= '0';
  --  D       <= '1';
  --  wait for 100 ns;
  --  rst     <= '0';
  --  D       <= '0';
  --  wait;
  -- end process stim_proc;
