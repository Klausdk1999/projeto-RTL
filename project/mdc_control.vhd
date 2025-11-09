library ieee;
use ieee.std_logic_1164.all;

entity mdc_control is
  port (
    i_clk    : in  std_logic;
    i_rstn   : in  std_logic;
    i_go     : in  std_logic;
    i_x_eq_y : in  std_logic;
    i_x_lt_y : in  std_logic;
    o_ld_x   : out std_logic;
    o_ld_y   : out std_logic;
    o_sel_x  : out std_logic;
    o_sel_y  : out std_logic;
    o_rdy    : out std_logic
  );
end entity mdc_control;

architecture rtl of mdc_control is
  type t_state is (s_idle, s_load, s_compare, s_sub_x, s_sub_y, s_done);
  signal r_state      : t_state;
  signal w_next_state : t_state;

  signal w_ld_x  : std_logic;
  signal w_ld_y  : std_logic;
  signal w_sel_x : std_logic;
  signal w_sel_y : std_logic;
  signal w_rdy   : std_logic;
begin

  p_state_reg : process(i_clk, i_rstn)
  begin
    if i_rstn = '0' then
      r_state <= s_idle;
    elsif rising_edge(i_clk) then
      r_state <= w_next_state;
    end if;
  end process p_state_reg;

  p_state_next : process(r_state, i_go, i_x_eq_y, i_x_lt_y)
  begin
    w_next_state <= r_state;
    case r_state is
      when s_idle =>
        if i_go = '1' then
          w_next_state <= s_load;
        end if;

      when s_load =>
        w_next_state <= s_compare;

      when s_compare =>
        if i_x_eq_y = '1' then
          w_next_state <= s_done;
        elsif i_x_lt_y = '1' then
          w_next_state <= s_sub_y;
        else
          w_next_state <= s_sub_x;
        end if;

      when s_sub_x =>
        w_next_state <= s_compare;

      when s_sub_y =>
        w_next_state <= s_compare;

      when s_done =>
        if i_go = '0' then
          w_next_state <= s_idle;
        end if;
    end case;
  end process p_state_next;

  p_outputs : process(r_state)
  begin
    w_ld_x  <= '0';
    w_ld_y  <= '0';
    w_sel_x <= '0';
    w_sel_y <= '0';
    w_rdy   <= '0';

    case r_state is
      when s_idle =>
        w_rdy <= '1';

      when s_load =>
        w_ld_x <= '1';
        w_ld_y <= '1';

      when s_compare =>
        null;

      when s_sub_x =>
        w_ld_x  <= '1';
        w_sel_x <= '1';

      when s_sub_y =>
        w_ld_y  <= '1';
        w_sel_y <= '1';

      when s_done =>
        w_rdy <= '1';
    end case;
  end process p_outputs;

  o_ld_x  <= w_ld_x;
  o_ld_y  <= w_ld_y;
  o_sel_x <= w_sel_x;
  o_sel_y <= w_sel_y;
  o_rdy   <= w_rdy;

end architecture rtl;

