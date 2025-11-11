library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mdc is
end entity;

architecture sim of tb_mdc is

  signal i_CLK  : std_logic := '0';
  signal i_RSTn : std_logic := '0';
  signal i_GO   : std_logic := '0';
  signal i_X    : std_logic_vector(7 downto 0) := (others => '0');
  signal i_Y    : std_logic_vector(7 downto 0) := (others => '0');
  signal o_D    : std_logic_vector(7 downto 0);
  signal o_RDY  : std_logic;

  constant CLK_PERIOD : time := 10 ns;

begin

  -- instantiate DUT
  u_dut : entity work.top_mdc
    port map (
      i_CLK  => i_CLK,
      i_RSTn => i_RSTn,
      i_GO   => i_GO,
      i_X    => i_X,
      i_Y    => i_Y,
      o_D    => o_D,
      o_RDY  => o_RDY
    );

  -- clock generation
  p_clk : process
  begin
    while true loop
      i_CLK <= '0';
      wait for CLK_PERIOD/2;
      i_CLK <= '1';
      wait for CLK_PERIOD/2;
    end loop;
  end process p_clk;

  -- stimulus
  p_stim : process
  begin
    -- reset
    i_RSTn <= '0';
    wait for CLK_PERIOD;
    i_RSTn <= '1';

    -- Test vector 1: gcd(14, 21) = 7
    i_X <= std_logic_vector(to_unsigned(14,8));
    i_Y <= std_logic_vector(to_unsigned(21,8));
    wait for CLK_PERIOD;
    i_GO <= '1';
    wait for CLK_PERIOD;
    i_GO <= '0';

    -- wait until ready
    wait until o_RDY = '1';
    assert o_D = std_logic_vector(to_unsigned(7,8))
      report "Test1 FAILED: gcd(14,21) != 7" severity error;

    wait for 30 ns;

    -- Test vector 2: gcd(100, 25) = 25
    i_X <= std_logic_vector(to_unsigned(100,8));
    i_Y <= std_logic_vector(to_unsigned(25,8));
    wait for 20 ns;
    i_GO <= '1';
    wait for 10 ns;
    i_GO <= '0';

    wait until o_RDY = '1';
    assert o_D = std_logic_vector(to_unsigned(25,8))
      report "Test2 FAILED: gcd(100,25) != 25" severity error;

    wait for 50 ns;

    -- Test vector 3: equal inputs gcd(42,42)=42
    i_X <= std_logic_vector(to_unsigned(42,8));
    i_Y <= std_logic_vector(to_unsigned(42,8));
    wait for 20 ns;
    i_GO <= '1';
    wait for 10 ns;
    i_GO <= '0';
    wait until o_RDY = '1';
    assert o_D = std_logic_vector(to_unsigned(42,8))
      report "Test3 FAILED: gcd(42,42) != 42" severity error;

    wait for 50 ns;

    report "SIMULATION COMPLETE" severity note;
    wait;
  end process p_stim;

end architecture sim;
