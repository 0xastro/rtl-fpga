--------------------------------------------------------------------------------
-- Title       : TestBench of Nbits register
-- Project     : VHDL paractice
--------------------------------------------------------------------------------
-- File        : tb_reg.vhd
-- Language    : VHDL
-- Author      : Luca Pilato (luca.pilato@for.unipi.it)
-- Company     : UNIPI-DII
-- Created     : Wed Mar 29 11:22:38 CEST 2017
--------------------------------------------------------------------------------
-- Update      :
--------------------------------------------------------------------------------
-- Description :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end tb;

architecture beh of tb is

  component reg
    generic (Nbit : positive := 8);
    port (
      clk     : in  std_ulogic;
      rst     : in  std_ulogic;
      d       : in  std_ulogic_vector(Nbit-1 downto 0);
      q       : out std_ulogic_vector(Nbit-1 downto 0)
    );
  end component reg;
  
  constant Nbit : positive := 8;
  
  signal clk    : std_ulogic := '0';
  signal rst    : std_ulogic;
  signal d      : std_ulogic_vector(Nbit-1 downto 0);

  constant clk_T      : time    := 100 ns;  
  signal   clk_go     : boolean := TRUE;
  signal   clk_count  : integer := 0;
  
  
begin
  
  rst  <= '1', '0' after 1 us;
  clk  <= not clk after clk_T/2 when clk_go=TRUE else clk;

  i_dut8: reg
  generic map (Nbit => Nbit)
  port map (
    clk     => clk    ,
    rst     => rst    ,
    d       => d      ,
    q       => open
  );
    

  clk_counter_p: process (clk, rst)
  begin
    if rst='0' and rising_edge(clk) then
      clk_count <= clk_count +1;
    end if;
  end process clk_counter_p;
    
    
  drive_p: process (clk_count)
  begin
    case clk_count is
      when 0  =>
        d  <= (others => '0');
      when 1  =>
        d  <= x"AA"; -- it works only with Nbit := 8
      when 4  =>
        d  <= x"12"; -- it works only with Nbit := 8
      when 12 =>
        d  <= x"FF"; -- it works only with Nbit := 8
      when 15 =>
        d  <= x"55";
        clk_go  <= FALSE; -- it stop the simulation
      when others => null;
    end case;     
  end process drive_p;
    
end beh;