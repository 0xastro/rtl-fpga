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
  signal reset         : std_logic := '1';
  signal D             : std_logic := '0';
  signal Q             : std_logic;
  constant clk_period  : time := 100 ns;

begin

  dut: DFF
  port map (
    clk     => clk    ,
    rst     => rst    ,
    D       => D      ,
    Q       => open
  );

  clk_process :process
  begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
  end process;


  -- Define Test Vectors
  stim_proc: process
  begin
    rst     <= '1';
    D       <= '0';
    wait for 100 ns;
    rst     <= '1';
    D       <= '1';
    wait for 100 ns;
    rst     <= '0';
    D       <= '1';
    wait for 100 ns;
    rst     <= '0';
    D       <= '0';
    wait;
  end process stim_proc;

end beh;
