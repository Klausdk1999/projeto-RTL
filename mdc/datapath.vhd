library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdc_datapath is
  port (
    i_CLK       : in  std_logic;
    i_RSTn      : in  std_logic;
    -- data inputs
    i_X         : in  std_logic_vector(7 downto 0);
    i_Y         : in  std_logic_vector(7 downto 0);
    -- control
    i_Rx_ld     : in  std_logic; -- load r_X from i_X
    i_Ry_ld     : in  std_logic; -- load r_Y from i_Y
    i_Rx_clr    : in  std_logic;
    i_Ry_clr    : in  std_logic;
    i_Rx_sub_ld : in  std_logic; -- load r_X <= r_X - r_Y
    i_Ry_sub_ld : in  std_logic; -- load r_Y <= r_Y - r_X
    -- outputs / status
    o_X_eq_Y    : out std_logic;
    o_X_lt_Y    : out std_logic;
    o_D_out     : out std_logic_vector(7 downto 0)
  );
end entity mdc_datapath;

architecture rtl of mdc_datapath is

  signal r_X : std_logic_vector(7 downto 0);
  signal r_Y : std_logic_vector(7 downto 0);

  signal w_sub_x : unsigned(7 downto 0);
  signal w_sub_y : unsigned(7 downto 0);

begin

  -- combinational subtractors and comparators
  w_sub_x <= unsigned(r_X) - unsigned(r_Y);
  w_sub_y <= unsigned(r_Y) - unsigned(r_X);

  o_X_eq_Y <= '1' when r_X = r_Y else '0';
  o_X_lt_Y <= '1' when unsigned(r_X) < unsigned(r_Y) else '0';

  o_D_out <= r_X;

  -- registers with asynchronous active-low reset
  p_reg_x : process (i_RSTn, i_CLK)
  begin
    if i_RSTn = '0' then
      r_X <= (others => '0');
    elsif rising_edge(i_CLK) then
      if i_Rx_clr = '1' then
        r_X <= (others => '0');
      elsif i_Rx_ld = '1' then
        r_X <= i_X;
      elsif i_Rx_sub_ld = '1' then
        r_X <= std_logic_vector(w_sub_x);
      end if;
    end if;
  end process p_reg_x;

  p_reg_y : process (i_RSTn, i_CLK)
  begin
    if i_RSTn = '0' then
      r_Y <= (others => '0');
    elsif rising_edge(i_CLK) then
      if i_Ry_clr = '1' then
        r_Y <= (others => '0');
      elsif i_Ry_ld = '1' then
        r_Y <= i_Y;
      elsif i_Ry_sub_ld = '1' then
        r_Y <= std_logic_vector(w_sub_y);
      end if;
    end if;
  end process p_reg_y;

end architecture rtl;
