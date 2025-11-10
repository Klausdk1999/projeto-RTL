library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mdc_control is
  port (
    i_CLK      : in  std_logic;
    i_RSTn     : in  std_logic;
    i_GO       : in  std_logic;
    i_X_eq_Y   : in  std_logic;
    i_X_lt_Y   : in  std_logic;
    -- control outputs to datapath
    o_Rx_ld     : out std_logic;
    o_Ry_ld     : out std_logic;
    o_Rx_clr    : out std_logic;
    o_Ry_clr    : out std_logic;
    o_Rx_sub_ld : out std_logic;
    o_Ry_sub_ld : out std_logic;
    -- top outputs
    o_RDY       : out std_logic
  );
end entity mdc_control;

architecture rtl of mdc_control is

  type t_state is (s_IDLE, s_LOAD, s_CHECK, s_SUB_Y, s_SUB_X, s_DONE);
  signal s_CUR : t_state := s_IDLE;
  signal s_NXT : t_state;

  -- outputs as registered or combinational? We'll generate as combinational from state
  signal v_Rx_ld, v_Ry_ld, v_Rx_clr, v_Ry_clr, v_Rx_sub_ld, v_Ry_sub_ld, v_RDY : std_logic;

begin

  -- state register
  p_state : process (i_RSTn, i_CLK)
  begin
    if i_RSTn = '0' then
      s_CUR <= s_IDLE;
    elsif rising_edge(i_CLK) then
      s_CUR <= s_NXT;
    end if;
  end process p_state;

  -- next-state and output logic (combinational)
  p_comb : process (s_CUR, i_GO, i_X_eq_Y, i_X_lt_Y)
  begin
    -- default outputs
    v_Rx_ld      <= '0';
    v_Ry_ld      <= '0';
    v_Rx_clr     <= '0';
    v_Ry_clr     <= '0';
    v_Rx_sub_ld  <= '0';
    v_Ry_sub_ld  <= '0';
    v_RDY        <= '0';
    s_NXT        <= s_CUR;

    case s_CUR is
      when s_IDLE =>
        v_RDY <= '1';
        -- wait for go
        if i_GO = '1' then
          s_NXT <= s_LOAD;
        else
          s_NXT <= s_IDLE;
        end if;

      when s_LOAD =>
        v_Rx_ld <= '1';
        v_Ry_ld <= '1';
        s_NXT <= s_CHECK;

      when s_CHECK =>
        -- if equal -> done
        if i_X_eq_Y = '1' then
          s_NXT <= s_DONE;
        else
          if i_X_lt_Y = '1' then
            s_NXT <= s_SUB_Y;
          else
            s_NXT <= s_SUB_X;
          end if;
        end if;

      when s_SUB_Y =>
        v_Ry_sub_ld <= '1';
        s_NXT <= s_CHECK;

      when s_SUB_X =>
        v_Rx_sub_ld <= '1';
        s_NXT <= s_CHECK;

      when s_DONE =>
        v_RDY <= '1';
        -- wait go to drop before idling again
        if i_GO = '0' then
          s_NXT <= s_IDLE;
        else
          s_NXT <= s_DONE;
        end if;

      when others =>
        s_NXT <= s_IDLE;
    end case;
  end process p_comb;

  -- connect internal control signals to outputs
  o_Rx_ld     <= v_Rx_ld;
  o_Ry_ld     <= v_Ry_ld;
  o_Rx_clr    <= v_Rx_clr;
  o_Ry_clr    <= v_Ry_clr;
  o_Rx_sub_ld <= v_Rx_sub_ld;
  o_Ry_sub_ld <= v_Ry_sub_ld;
  o_RDY       <= v_RDY;

end architecture rtl;
