library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.frankenstein_pkg.all;
use work.dut_interface_pkg.all;

entity dut_tb is
end dut_tb;

architecture Behavioral of dut_tb is
  constant clk_period  : time      := 5 ns;
  
  signal clk          : std_logic := '1';
  signal rst          : std_logic := '1';
  signal data_in      : dut_in_t := DUT_IN_NULL;
  signal data_out     : dut_out_t;


begin

  dut_inst : entity work.dut
  port map(
    clk     => clk,
    rst     => rst,
    input   => data_in,
    output  => data_out
  );


  clk   <= not  clk after (  clk_period / 2.0 );

  process
  begin
    rst <= '1';
    data_in <= DUT_IN_NULL;

    wait for ( clk_period * 2 );

    rst <= '0';

    wait for (clk_period*10);
    
    data_in <= (
      data => (2047 downto 0 => '0', others => '1'),
      sel  => to_unsigned(1024,12)
      );

    wait for (clk_period);
    
    data_in.sel <= to_unsigned(4095,12);

    wait;
    
  end process;

end Behavioral;

