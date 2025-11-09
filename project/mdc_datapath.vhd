library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdc_datapath is
  port (
    i_clk    : in  std_logic;
    i_rstn   : in  std_logic;
    i_x      : in  std_logic_vector(7 downto 0);
    i_y      : in  std_logic_vector(7 downto 0);
    i_ld_x   : in  std_logic;
    i_ld_y   : in  std_logic;
    i_sel_x  : in  std_logic;
    i_sel_y  : in  std_logic;
    o_x_eq_y : out std_logic;
    o_x_lt_y : out std_logic;
    o_result : out std_logic_vector(7 downto 0)
  );
end entity mdc_datapath;

architecture rtl of mdc_datapath is
  signal r_x      : std_logic_vector(7 downto 0);
  signal r_y      : std_logic_vector(7 downto 0);
  signal w_next_x : std_logic_vector(7 downto 0);
  signal w_next_y : std_logic_vector(7 downto 0);
  signal w_sub_xy : std_logic_vector(7 downto 0);
  signal w_sub_yx : std_logic_vector(7 downto 0);
begin

  w_sub_xy <= std_logic_vector(unsigned(r_x) - unsigned(r_y));
  w_sub_yx <= std_logic_vector(unsigned(r_y) - unsigned(r_x));

  with i_sel_x select
    w_next_x <= i_x      when '0',
                w_sub_xy when others;

  with i_sel_y select
    w_next_y <= i_y      when '0',
                w_sub_yx when others;

  p_registers : process(i_clk, i_rstn)
  begin
    if i_rstn = '0' then
      r_x <= (others => '0');
      r_y <= (others => '0');
    elsif rising_edge(i_clk) then
      if i_ld_x = '1' then
        r_x <= w_next_x;
      end if;
      if i_ld_y = '1' then
        r_y <= w_next_y;
      end if;
    end if;
  end process p_registers;

  o_x_eq_y <= '1' when r_x = r_y else '0';
  o_x_lt_y <= '1' when unsigned(r_x) < unsigned(r_y) else '0';
  o_result <= r_x;

end architecture rtl;

