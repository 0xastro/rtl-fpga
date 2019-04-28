library ieee;
use ieee.std_logic_1164.ALL;
---------------------------------------------------------------------------------------------
-- FullAdder Implementation
-- Implementation of Full Adder using structural design pattern (gate_Level)
-- Testbench is Included under the name FA_tb
-- For Modularity this module is reused to create a Ripple Carry Adder RCA4
--          This is achieved by redefining the FA component in RCA4.vhd file
---------------------------------------------------------------------------------------------
entity FA is
  port (
    A, B, cin : in std_logic;
    s, cout   : out std_logic);
end FA;


architecture structure of FA is
begin
    s <= A XOR B XOR cin;
    cout <= (A AND B) OR (cin AND A) OR (cin AND B);

end structure;
