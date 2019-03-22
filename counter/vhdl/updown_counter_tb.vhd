library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Testbench for updown counter
entity tb_counter is
end tb_counter;

architecture Behavioral of tb_counter is
    component UPDOWN_COUNTER
        Port ( clk    : in  std_logic; -- clock input
               reset  : in  std_logic; -- reset input
               up_down: in  std_logic; -- up or down
               counter: out std_logic_vector(3 downto 0) -- output 4-bit counter
           );
    end component;
    -- defining signals acording to the entity of the component
    signal reset, clk, up_down : std_logic;
    signal counter : std_logic_vector(3 downto 0);
begin
    dut: UPDOWN_COUNTER port map (clk     => clk,
                                  reset   => reset,
                                  up_down => up_down,
                                  counter => counter
                              );
    clock_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process
    stim_proc: process
    begin
        reset   <= '1';
        up_down <= '0';
        wait for 20 ns;
        reset   <= '0';
        wait for 300 ns;
        up_down <= '1';
        wait;
    end process;
end Behavioral;
