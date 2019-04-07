library ieee;
use ieee.std_logic_1164.ALL;
---------------------------------------------------------------------------------------------
-- FullAdder TESTBENCH Implementation
---------------------------------------------------------------------------------------------
entity FA is
end FA;

architecture data_flow of FA is 

-- Define Component of UUT;
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
--Instantiate (UUT)
  uut: FA port map (
    A =>A,
    B =>B,
    cin=>cin,
    s =>s,
    cout=>cout);
 -- Stimulus process
stim_proc: process
begin
  -- hold reset state
  wait for 100 ns;
  -- insert stimulus
  A <= '1';
  B <= '0';
  cin <= '0';
  wait for 10 ns;

  A <= '0';
  B <= '1';
  cin <= '0';
  wait for 10 ns;

  A <= '1';
  B <= '1';
  cin <= '0';
  wait for 10 ns;

  A <= '0';
  B <= '0';
  cin <= '1';
  wait for 10 ns;

  A <= '1';
  B <= '0';
  cin <= '1';
  wait for 10 ns;

  A <= '0';
  B <= '1';
  cin <= '1';
  wait for 10 ns;

  A <= '1';
  B <= '1';
  cin <= '1';
  wait for 10 ns;

  end process;
end data_flow;
