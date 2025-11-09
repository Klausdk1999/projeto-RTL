library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdc_tb is
end entity mdc_tb;

architecture sim of mdc_tb is
  constant c_clk_period : time := 10 ns;

  signal w_clk  : std_logic := '0';
  signal w_rstn : std_logic := '0';
  signal w_go   : std_logic := '0';
  signal w_x    : std_logic_vector(7 downto 0) := (others => '0');
  signal w_y    : std_logic_vector(7 downto 0) := (others => '0');
  signal w_d    : std_logic_vector(7 downto 0);
  signal w_rdy  : std_logic;
begin

  u_dut : entity work.mdc_top
    port map (
      i_clk  => w_clk,
      i_rstn => w_rstn,
      i_go   => w_go,
      i_x    => w_x,
      i_y    => w_y,
      o_d    => w_d,
      o_rdy  => w_rdy
    );

  p_clk : process
  begin
    w_clk <= '0';
    wait for c_clk_period / 2;
    w_clk <= '1';
    wait for c_clk_period / 2;
  end process p_clk;

  p_stimulus : process
  begin
    w_rstn <= '0';
    wait for 3 * c_clk_period;
    w_rstn <= '1';
    wait for c_clk_period;

    w_x <= std_logic_vector(to_unsigned(108, 8));
    w_y <= std_logic_vector(to_unsigned(84, 8));
    wait for c_clk_period;
    w_go <= '1';
    wait for c_clk_period;
    w_go <= '0';

    wait until w_rdy = '1';
    wait for 2 * c_clk_period;

    w_x <= std_logic_vector(to_unsigned(27, 8));
    w_y <= std_logic_vector(to_unsigned(18, 8));
    wait for c_clk_period;
    w_go <= '1';
    wait for c_clk_period;
    w_go <= '0';

    wait for 60 * c_clk_period;
    wait;
  end process p_stimulus;

end architecture sim;

