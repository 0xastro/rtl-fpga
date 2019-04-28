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

  -- In 4-RCA we used to create 3 signals for each carry propagate from each Adder
  -- But since we will define the interconnection PLUS input and output so we have 5 signals
  -- signal c0,c1,c2,c3,c4 : std_logic;
  -- since, here it's a N-RCA so we create a vector
  -- 3 signals for the interconnection between FA modules
  -- PLUS input and output [in->FA0->FA1->FA2->FA3->]
  signal c : std_ulogic_vector(Nbit downto 0);

begin

    -- Input carry mapping
    c(0) <= cin;
    -- Output carry mapping
    cout  <= c(Nbit);
rca_n_proc : for i in 0 to Nbit-1 generate

    fa_i: FA port map (
        A     => A(i),
        B     => B(i),
        --
        cin   => c(i),
        s     => s(i),
        cout  => c(i+1)
        );
    end generate rca_n_proc;

end structure;
