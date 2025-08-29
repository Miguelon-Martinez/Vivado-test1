----------------------------------------------------
-- Interface Package
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.frankenstein_pkg.all;

package dut_interface_pkg is

  type dut_in_t is record
    data  : std_logic_vector(4095 downto 0);
    sel   : unsigned(11 downto 0);
  end record;
  
  constant DUT_IN_NULL : dut_in_t := (
    data  => (others => '0'),
    sel   => (others => '0')
  );
  
  type dut_out_t is record
    data  : std_logic;
  end record;

  constant DUT_OUT_NULL : dut_out_t := (
    data  => '0'
  );

end package;


----------------------------------------------------
-- Device Under Test Entity
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.frankenstein_pkg.all;
use work.dut_interface_pkg.all;

entity dut is
  port(
    clk     : in  std_logic;
    rst     : in  std_logic;
    input   : in  dut_in_t;
    output  : out dut_out_t
	);
end entity;

architecture Behavioural of dut is

begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        output <= DUT_OUT_NULL;
      else
        output.data <= input.data(to_integer(input.sel));
      end if; 
    end if;
  end process;

end architecture;
