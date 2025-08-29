-- This module just replicates your top inputs and outputs, and registers them, in order to
-- impose timing restrictions on them, so that if you synthetise it, you will get a timing
-- report 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Xilinx devices library:
--library unisim;
--use unisim.VComponents.all;

library work;
use work.frankenstein_pkg.all;
use work.dut_interface_pkg.all;

entity dut_wrapper is
  port(
    clk           : in  std_logic;
    rst           : in  std_logic;
    input         : in  dut_in_t;
    output        : out dut_out_t
	);
end entity;

architecture Behavioural of dut_wrapper is

  signal input_s  : dut_in_t;
  signal output_s : dut_out_t;

begin

  dut_inst: entity work.dut
  port map(
    clk       => clk,
    rst       => rst,
    input     => input_s,
    output    => output_s
  );

  process(clk)
  begin
    if rising_edge(clk) then
      input_s <= input;
      output  <= output_s;
    end if;
  end process;

end architecture;
