--------------------------------------------------------------------------------
-- N-bits (Generic) Ripple Carry Adder: RCA_N.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity RCA_N is
    generic ( Nbit : positive := 4); -- positive(unsigned) or integer
    port (
        A,B : in  std_logic_vector(Nbit-1 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(Nbit-1 downto 0);
        cout: out std_logic);
end RCA_N;


architecture structure of RCA_N is
-- Define a component to describe the desgin relation in FA.vhd to be used here in
-- RCA_N.vhd generic ripple carry adder
    component FA
        port (
            A     : in  std_logic;
            B     : in  std_logic;
            cin   : in  std_logic;
            s     : out std_logic;
            cout  : out std_logic);
  end component;

  -- In 4-RCA we used to create 3 signals for each carry propagate from each flip flip
  -- signal c0,c1,c2 : std_logic;
  -- since, here it's a N-RCA so we create a vector 
  signal c : std_ulogic_vector(Nbit downto 0);

begin

rca_n_proc : for i in 0 to Nbit-1 generate

    fa_i: FA port map (
        A     => A(i),
        B     => B(i),
        --
        cin   => cin,
        s     => s(i),
        cout  => c(i)
        );
    end generate rca_n_proc;

end structure;
