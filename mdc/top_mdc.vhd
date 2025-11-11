library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_mdc is
  port (
    i_CLK  : in  std_logic;
    i_RSTn : in  std_logic;
    i_GO   : in  std_logic;
    i_X    : in  std_logic_vector(7 downto 0);
    i_Y    : in  std_logic_vector(7 downto 0);
    o_D    : out std_logic_vector(7 downto 0);
    o_RDY  : out std_logic
  );
end entity top_mdc;

architecture rtl of top_mdc is

  -- wires between control and datapath
  signal w_Rx_ld     : std_logic;
  signal w_Ry_ld     : std_logic;
  signal w_Rx_clr    : std_logic;
  signal w_Ry_clr    : std_logic;
  signal w_Rx_sub_ld : std_logic;
  signal w_Ry_sub_ld : std_logic;

  signal w_X_eq_Y    : std_logic; -- X equal Y
  signal w_X_lt_Y    : std_logic; -- X lower than Y
  signal w_D_out     : std_logic_vector(7 downto 0);

begin

  u_datapath : entity work.mdc_datapath
    port map (
      i_CLK       => i_CLK,
      i_RSTn      => i_RSTn,
      i_X         => i_X,
      i_Y         => i_Y,
      i_Rx_ld     => w_Rx_ld,
      i_Ry_ld     => w_Ry_ld,
      i_Rx_clr    => w_Rx_clr,
      i_Ry_clr    => w_Ry_clr,
      i_Rx_sub_ld => w_Rx_sub_ld,
      i_Ry_sub_ld => w_Ry_sub_ld,
      o_X_eq_Y    => w_X_eq_Y,
      o_X_lt_Y    => w_X_lt_Y,
      o_D_out     => w_D_out
    );

  u_control : entity work.mdc_control
    port map (
      i_CLK        => i_CLK,
      i_RSTn       => i_RSTn,
      i_GO         => i_GO,
      i_X_eq_Y     => w_X_eq_Y,
      i_X_lt_Y     => w_X_lt_Y,
      o_Rx_ld      => w_Rx_ld,
      o_Ry_ld      => w_Ry_ld,
      o_Rx_clr     => w_Rx_clr,
      o_Ry_clr     => w_Ry_clr,
      o_Rx_sub_ld  => w_Rx_sub_ld,
      o_Ry_sub_ld  => w_Ry_sub_ld,
      o_RDY        => o_RDY
    );

  o_D <= w_D_out;

end architecture rtl;
