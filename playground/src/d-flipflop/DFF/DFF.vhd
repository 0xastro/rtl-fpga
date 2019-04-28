--------------------------------------------------------------------------------
-- generic FlipFlop
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
  port(
    D, clk, rst   : in std_logic;
    Q             : out std_logic);
end DFF;

--------------------------------------------------------------------------------
-- architecture structural
--------------------------------------------------------------------------------
architecture beh of dff is
begin
  -- Here, the process is sensitive to the RST and CLK signals,
  -- Asynchronous reset
  i_dff: process(clk,rst)
  begin
    if rst='1' then
      Q <= '0';
    elsif (clk='1' and clk'event) then -- for the rising edge trigger the output
      Q <= D;
    end if;
  end process i_dff;

end beh;


--------------------------------------------------------------------------------
  -- NOTE
--------------------------------------------------------------------------------
--* If I use the Synchronous Reset; so everything will be sensitive to the clk
--* Therefore
--* process(clk)
--*begin
--*  if (clk='1' and clk'event)
--*    if rst='1' then
--*      Q <= '0';
--*    else
--*      Q <= D;
--*    end if;
--*  end if;
--* end process;
--------------------------------------------------------------------------------
