-----------------------------------
-- N Bit Ripple Carry Adder
-----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity RCA_N_tb is
end RCA_N_tb;

architecture data_flow of RCA_N_tb is

  ----------------------------------------
    -- Component to test DUT
    -- HINT: Must be named as tested entity
  ----------------------------------------
  component RCA_N
    generic (Nbit : positive := 4);
    port (
      A,B     : in  std_logic_vector(Nbit-1 downto 0);
      cin     : in  std_logic;
      s       : out std_logic_vector(Nbit-1 downto 0);
      cout    : out std_logic
    );
  end component;

  ----------------------------------------
    -- Testbench constant declaration
  ----------------------------------------
    -- Generic constant definition
    constant Nbit : positive := 4;
    -- signals for mapping the component variables to test variables (local copy)
    signal A_tb, B_tb     : std_logic_vector(Nbit-1 downto 0);
    signal cin_tb         : std_logic;

  ----------------------------------------
    -- Start Port Mapping
    -- linking the gates with the testbench
    -- signals for the test
  ----------------------------------------
begin

  dut: RCA_N
    generic map (
        Nbit => Nbit
    )
    port map (
        A     => A_tb   ,
        B     => B_tb   ,
        cin   => cin_tb ,
        s     => open   , -- I can use signals or make it only open
        cout  => open  -- I can use signals or make it only open
    );

  ----------------------------------------
    -- Start Testing Process
  ----------------------------------------
  -- ******************************************************
  -- * Even if rippleCarryAdder is a pure combinational circuit
  -- * it is possible to use a clock signal within the tb
  -- * just for keep trace of the execution time of the
  -- * simulation and to provide input vectors to the DUT
  -- * It's not a good behavior to use a loop to define the
  -- * testvectors
  -- * but WHO CARES!!
  -- ******************************************************

  -- process used to make the testbench signals change synchronously with the rising edge of the clock

  stim_proc: process
  -- variable used to count the clock cycle after the reset
  begin

    --A_tb <= (others => '0');
    --B_tb <= (others => '0');
    A_tb <= "0000";
    B_tb <= "0000";
    cin_tb <= '0';

    wait for 100 ns;
    -----------------------------------------------
    -- Since this is a 4-Bit Ripple Carry Adder
    -- We have 2pow(4):= 16 test vecotors
    -- It's not good to create the test vectors using loop but its better than manually define them
    -----------------------------------------------
    -- generate 16 test vectors considering cin:=0;

    for i in 0 to 2**Nbit-1 loop
      A_tb   <= std_logic_vector(TO_SIGNED(i,Nbit));
      for j in 0 to 2**Nbit-1 loop
        B_tb   <= std_logic_vector(TO_SIGNED(j,Nbit));
        wait for 100 ns;
      end loop;
    end loop;

    cin_tb <= '1';
    -- generate 16 test vectors considering cin:=1;
    for i in 0 to 2**Nbit-1 loop
      A_tb   <= std_logic_vector(TO_SIGNED(i,Nbit));
      for j in 0 to 2**Nbit-1 loop
        B_tb   <= std_logic_vector(TO_SIGNED(j,Nbit));
        wait for 100 ns;
      end loop;
    end loop;

    wait;
    end process stim_proc;


end data_flow;
