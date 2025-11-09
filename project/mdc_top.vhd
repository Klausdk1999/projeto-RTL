library ieee;
use ieee.std_logic_1164.all;

entity mdc_top is
  port (
    i_clk  : in  std_logic;
    i_rstn : in  std_logic;
    i_go   : in  std_logic;
    i_x    : in  std_logic_vector(7 downto 0);
    i_y    : in  std_logic_vector(7 downto 0);
    o_d    : out std_logic_vector(7 downto 0);
    o_rdy  : out std_logic
  );
end entity mdc_top;

architecture rtl of mdc_top is
  signal w_ld_x   : std_logic;
  signal w_ld_y   : std_logic;
  signal w_sel_x  : std_logic;
  signal w_sel_y  : std_logic;
  signal w_x_eq_y : std_logic;
  signal w_x_lt_y : std_logic;
  signal w_result : std_logic_vector(7 downto 0);
begin

  u_datapath : entity work.mdc_datapath
    port map (
      i_clk    => i_clk,
      i_rstn   => i_rstn,
      i_x      => i_x,
      i_y      => i_y,
      i_ld_x   => w_ld_x,
      i_ld_y   => w_ld_y,
      i_sel_x  => w_sel_x,
      i_sel_y  => w_sel_y,
      o_x_eq_y => w_x_eq_y,
      o_x_lt_y => w_x_lt_y,
      o_result => w_result
    );

  u_control : entity work.mdc_control
    port map (
      i_clk    => i_clk,
      i_rstn   => i_rstn,
      i_go     => i_go,
      i_x_eq_y => w_x_eq_y,
      i_x_lt_y => w_x_lt_y,
      o_ld_x   => w_ld_x,
      o_ld_y   => w_ld_y,
      o_sel_x  => w_sel_x,
      o_sel_y  => w_sel_y,
      o_rdy    => o_rdy
    );

  o_d <= w_result;

end architecture rtl;

