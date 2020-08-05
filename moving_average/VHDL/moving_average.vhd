-- Remember signals in a process are evaluated sequentionally and assigned only at the end of the process
-- Remember that output signals should always be trigerred from a register
-- Remember that input output signals should be std_logic type
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moving_average is
    generic (
        G_NBIT        : integer := 8;
        G_AVG_LEN_LOG :integer := 2
    );
    port (
        i_clk        : in std_logic;
        i_rstb       : in std_logic;
        i_sync_reset : in std_logic;
        -- input
        i_data_ena   : in std_logic;
        i_data       : in std_logic_vector (G_NBIT-1 downto 0);
        -- output
        o_data_valid : out std_logic;
        o_data       : out std_logic_vector (G_NBIT-1 downto 0);
end moving_average;

architecture behavioral of moving_average is
    type t_moving_average is array (0 to 2**G_AVG_LEN_LOG) of std_logic_vector (G_NBIT downto 0);
    signal p_moving_average : t_moving_average;
    signal r_acc            : signed(G_NBIT+G_AVG_LEN_LOG-1 downto 0); -- average accumulator
    signal r_data_valid     : std_logic;

begin
    p_average : process(i_clk, i_rstb)
    begin
        -- all registers and output signals are assigned to zero
        if (i_rstb = '0') then
            r_acc            <= (others => '0');
            p_moving_average <= (others => (others => '0'));
            r_data_valid     <= '0';
            o_data_valid     <= '0';
            o_data           <= (others => '0');
        elsif (rising_edge(i_clk)) then
            r_data_valid <= i_data_ena;
            o_data_valid <= r_data_valid;
            if (i_sync_reset = '1') then
                r_acc <= (others => '0');
                p_moving_average <= (others => (others => '0'));
            elsif (i_data_ena = '1') then
                --shift
                p_moving_average <= signed(i_data)&p_moving_average(0 to p_moving_average'length-2);
                -- main computation
                r_acc <= r_acc + signed(i_data) - p_moving_average(p_moving_average'length-1);
            end if;
            -- divide by 2^G_AVG_LEN_LOG (removing G_AVG_LEN_LOG bit from LSB)
            o_data <= std_logic_vector(r_acc(G_NBIT + G_AVG_LEN_LOG - 1 downto G_AVG_LEN_LOG));
        end if;
    end process p_average;
end behavioral;
