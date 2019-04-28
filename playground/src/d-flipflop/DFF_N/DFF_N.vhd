--------------------------------------------------------------------------------
-- generic  D-FlipFlop
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity DFF_N is
    generic( N : integer := 4);
    port(
        D           : in std_logic_vector(N-1 downto 0);
        clk, rst    : in std_logic;
        -- enable
        en          : in std_logic;
        Q           : out std_logic_vector(N-1 downto 0)
        );
end DFF_N;

--------------------------------------------------------------------------------
-- architecture structural
--------------------------------------------------------------------------------
architecture struct of DFF_N is
begin
  -- Here, the process is sensitive to the RST and CLK signals,
  -- Asynchronous reset
  dff_proc: process(clk,rst)
  begin
    if(rst = '0') then
      Q  <= (others => '0');
    elsif(rising_edge(clk)) then
      if(en = '1') then
          Q <= D;
      end if;
    end if;

  end process dff_proc;

end struct;
