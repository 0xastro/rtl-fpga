library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity FA_4bit_tb is
end FA_4bit_tb;


architecture data_flow of FA_2bit_tb is

  component FA_4bit
    port (
      A,B     : in  std_logic_vector(3 downto 0);
      cin     : in  std_logic;
      s       : out std_logic_vector(3 downto 0);
      cout    : out std_logic
    );
  end component;

  signal A,B        : std_logic_vector(3 downto 0);
  signal cin        : std_logic;

begin
  ----------------------------------------------------------------
  -- Design Under Test > FA_4bit :Start mapping ports to test
  ----------------------------------------------------------------
  dut: FA_4bit
  port map (
    A     => A    ,
    B     => B    ,
    cin   => cin  ,
    s     => open ,
    cout  => open);

  ----------------------------------------------------------------
  -- Start Testing process:Initialize test vectors 2power4=16
  ----------------------------------------------------------------
  stim_proc: process
  begin
  -- Initialization of Input Logic Vectors
    -- Apply Test Vectors
    -- First for @cin := 0;
    cin <= '0';
    wait for 100 ns;

    -- For each @FA > (4)
    for i in 0 to 15 loop
      A   <= std_logic_vector(to_UNSIGNED(i,4)); -- Apply i to A so A=0001; A=0010
      for j in 0 to 20 loop
        B   <= std_logic_vector(to_UNSIGNED(j,4));
        wait for 100 ns;
      end loop;
    end loop;

    -- Now for @cin := 1;
    cin <= '1';
    for i in 0 to 15 loop
      A   <= std_logic_vector(to_UNSIGNED(i,4));
      for j in 0 to 15 loop
        B   <= std_logic_vector(to_UNSIGNED(j,4));
        wait for 100 ns;
      end loop;
    end loop;

    wait; -- to hult the system  after 200 ns simulation
  end process stim_proc;

end data_flow;
