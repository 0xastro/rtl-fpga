library ieee;
use ieee.std_logic_1164.ALL;

--TODO
-- To change data into std_ulogic

---------------------------------------------------------------------------------------------
-- FullAdder TESTBENCH Implementation
---------------------------------------------------------------------------------------------
entity FA_tb is
end FA_tb;

---------------------------------------------------------------------------------------------
-- Architecture for 1 bit Full Adder
---------------------------------------------------------------------------------------------
architecture data_flow of FA_tb is

  -- Define a Component of DUT(Design Under Test);
  component FA
  port(
    A, B, cin   : in std_logic;
    s, cout     : out std_logic);
  end component;


  -- Inputs
  signal A    : std_logic := '0';
  signal B    : std_logic := '0';
  signal cin  : std_logic := '0';

  -- Output
   signal s    : std_logic;
   signal cout : std_logic;


begin
  --Instantiate (DUT)
  dut: FA port map (
    A     => A,
    B     => B,
    cin   =>cin,
    s     =>s,
    cout  =>cout);

    -- Stimulus process
  stim_proc: process
  begin
    -- hold reset state
    wait for 100 ns;
    -- insert stimulus; Applying Drivers for all Test Vectors 2power(3) test cases
    A <= '1';
    B <= '0';
    cin <= '0';
    wait for 100 ns;

    A <= '0';
    B <= '1';
    cin <= '0';
    wait for 100 ns;

    A <= '1';
    B <= '1';
    cin <= '0';
    wait for 100 ns;

    A <= '0';
    B <= '0';
    cin <= '1';
    wait for 100 ns;

    A <= '1';
    B <= '0';
    cin <= '1';
    wait for 100 ns;

    A <= '0';
    B <= '1';
    cin <= '1';
    wait for 100 ns;

    A <= '1';
    B <= '1';
    cin <= '1';
    wait for 100 ns;

  end process stim_proc;

end data_flow;
