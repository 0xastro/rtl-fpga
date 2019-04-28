--------------------------------------------------------------------------------
-- 4-bits Ripple Carry Adder: 4RCA
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity FA_4bit is
  port (
    A,B         : in  std_logic_vector(3 downto 0);
    cin         : in  std_logic;
    s           : out std_logic_vector(3 downto 0);
    cout        : out std_logic);
end FA_4bit;

architecture struct of FA_4bit is

-- Define a component to describe the desgin relation in FA.vhd
  component FA
    port (
      A     : in  std_logic;
      B     : in  std_logic;
      cin   : in  std_logic;
      s     : out std_logic;
      cout  : out std_logic);
  end component;

  signal c0,c1,c2 : std_logic;

begin

  fa0: FA port map (
    A     => A(0),
    B     => B(0),
    --
    cin   => cin,
    s     => s(0),
    cout  => c0);

  fa1: FA port map (
    A     => A(1),
    B     => B(1),
    --
    cin   => c0,
    s     => s(1),
    cout  => c1);

  fa2: FA port map (
    A     => A(2),
    B     => B(2),
    --
    cin   => c1,
    s     => s(2),
    cout  => c2);


  fa3: FA
  port map (
    A     => A(3),
    B     => B(3),
    --
    cin   => c2,
    s     => s(3),
    cout  => cout);

end struct;
