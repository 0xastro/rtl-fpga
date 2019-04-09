--------------------------------------------------------------------------------
-- generic FlipFlop
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
  generic( N : integer :=8);
  port(
  D           : in std_logic_vector(N-1 downto 0);
  clk, rst    : in std_logic;
  Q           : out std_logic_vector(N-1 downto 0)
  );
end DFF_N;

--------------------------------------------------------------------------------
-- architecture structural
--------------------------------------------------------------------------------
architecture beh of DFF_N is
begin

  -- Here, the process is sensitive to the RST and CLK signals,
  -- Asynchronous reset
  i_dff_n: process(clk,rst)
  begin
    if rst='1' then
      Q <= (others => '0');
    elsif (clk='1' and clk'event) then -- for the rising edge trigger the output
      Q <= D;
    end if;
  end process i_dff_n;

end beh;
