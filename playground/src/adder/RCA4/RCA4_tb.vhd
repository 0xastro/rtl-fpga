-----------------------------------
-- 4 Bit Ripple Carry Adder
-----------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity RCA4_tb is
end RCA4_tb;

architecture data_flow of RCA4_tb is

  component RCA4
    port (
      A,B     : in  std_logic_vector(3 downto 0);
      cin     : in  std_logic;
      s       : out std_logic_vector(3 downto 0);
      cout    : out std_logic
    );
  end component;

  signal A,B    : std_logic_vector(3 downto 0);
  signal cin    : std_logic;

begin

  dut: RCA4
  port map (
    A     => a    ,
    B     => b    ,
    cin   => cin  ,
    s     => open ,
    cout  => open
  );


  stim_proc: process
  begin
    A   <= "0000";
    B   <= "0000";
    cin <= '0';

    wait for 100 ns;
    ----------------------------------------------- 
    -- Since this is a 4-Bit Ripple Carry Adder
    -- We have 2pow(4):= 16 test vecotors
    -- It's not good to create the test vectors using loop but its better than manually define them
    ----------------------------------------------- 
    -- generate 16 test vectors considering cin:=0;
    
    for i in 0 to 15 loop
      A   <= std_logic_vector(TO_SIGNED(i,4));
      for j in 0 to 15 loop
        B   <= std_logic_vector(TO_SIGNED(j,4));
        wait for 100 ns;
      end loop;
    end loop;

    cin <= '1';
    -- generate 16 test vectors considering cin:=1;
    for i in 0 to 15 loop
      a   <= std_logic_vector(TO_SIGNED(i,4));
      for j in 0 to 15 loop
        b   <= std_logic_vector(TO_SIGNED(j,4));
        wait for 100 ns;
      end loop;
    end loop;

    wait;
  end process stim_proc;

end data_flow;
