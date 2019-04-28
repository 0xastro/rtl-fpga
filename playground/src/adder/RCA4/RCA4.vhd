--------------------------------------------------------------------------------
-- 4-bits Ripple Carry Adder
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity RCA4 is
  port (
    A       : in  std_logic_vector(3 downto 0);
    B       : in  std_logic_vector(3 downto 0);
    cin     : in  std_logic;
    s       : out std_logic_vector(3 downto 0);
    cout    : out std_logic);
end RCA4;

architecture struct of RCA4 is

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

  fa0: fa
  port map (
    A     => A(0),
    B     => B(0),
    cin   => cin,
    s     => s(0),
    cout  => c0
  );

  fa1: fa
  port map (
    A     => A(1)    ,
    B     => B(1)    ,
    cin   => c0     ,
    s     => s(1)    ,
    cout  => c1
  );

  fa2: fa
  port map (
    A     => A(2)    ,
    B     => B(2)    ,
    cin   => c1     ,
    s     => s(2)    ,
    cout  => c2
  );


  fa3: fa
  port map (
    A     => A(3)    ,
    B     => B(3)    ,
    cin   => c2     ,
    s     => s(3)    ,
    cout  => cout
  );

end struct;
