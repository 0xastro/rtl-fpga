--------------------------------------------------------------------------------
-- Title       : Nbits register
-- Project     : VHDL paractice
--------------------------------------------------------------------------------
-- File        : reg.vhd
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

entity reg is
  generic (Nbit : positive := 8);
  port (
    clk     : in  std_ulogic;
    rst     : in  std_ulogic;
    d       : in  std_ulogic_vector(Nbit-1 downto 0);
    q       : out std_ulogic_vector(Nbit-1 downto 0)
  );
end reg;

architecture rtl of reg is
begin

  reg_p: process(clk,rst)
  begin
    if rst='1' then
      q <= (others => '0');
    elsif (clk='1' and clk'event) then
      q <= d;
    end if;
  end process reg_p;
    
end rtl;