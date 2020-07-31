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
        i_data_ena   : in std_logic_vector (G_NBIT-1 downto 0);
        -- output
        o_data_valid : out std_logic_vector;
        o_data       : out std_logic_vector (G_NBIT-1 downto 0);
end moving_average;

architecture behavioral of moving_average is
    type t_moving_average is array (0 to 2**G_AVG_LEN_LOG) of std_logic_vector (G_NBIT downto 0);
