library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------
  -- Counter entity
  -- @brief
  -- N-Bit Accumlator: [Phase Accumlator ]
  -- counter.vhd is based on DFF (F-FlipFlop) and FA (FullAdder)
  -- d is the frequency word input to the counter (N-Bit Accumlator)
  -- q is the N-Bit output which is feeded back to the N-Bit FullAdder
-------------------------------------------------------------------

entity counter is
  generic( N : integer := 4);
  port(
    d         : in std_logic_vector(N-1 downto 0);
    q         : out std_logic_vector(N-1 downto 0);
    clk,rst,en: in std_logic);
end counter;



-------------------------------------------------------------------
  -- Counter architecture
  -- @brief
-- Define 2 signals to hold the output vector of both DFF and RCA
--    Interconnection 1: [Between FA and DFF]     @fa_out
--    Interconnection 2: [Between DFF and output] @dff_out
-- Define 2 components to describe the embedded modules DFF and RCA (FA)
-------------------------------------------------------------------

architecture struct of counter is

signal dff_out  : std_logic_vector(N-1 downto 0);
signal fa_out : std_logic_vector(N-1 downto 0);

-------------------------------------------------------------------
-- DFF and RCA Components declaration
-------------------------------------------------------------------

component DFF_N is
    generic( N : integer := 4);
    port(
        D           : in std_logic_vector(N-1 downto 0);
        clk, rst    : in std_logic;
        -- enable
        en          : in std_logic;
        Q           : out std_logic_vector(N-1 downto 0)
        );
end component;


component RCA_N is
    generic ( Nbit : positive := 4); -- positive(unsigned) or integer
    port (
        A,B : in  std_logic_vector(Nbit-1 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(Nbit-1 downto 0);
        cout: out std_logic);
end component;


   begin

  RCA_N_MAP :  RCA_N
      generic map(Nbit => N)
      port map(
       -- Input of the full-adder A, B and cin
        A     => d,       -- d is the frequency word (input of the counter)
        B     => dff_out, -- as dff_out is feeded back to the FA
        cin   => '0',
        s     => fa_out,
        cout  => open);

  DFF_N_MAP : DFF_N
      generic map(N => N)
      port map(
        d     => fa_out,
        clk   => clk,
        rst   => rst,
        en    => en,
        q     => dff_out);
  	    q <= dff_out;

end struct;
