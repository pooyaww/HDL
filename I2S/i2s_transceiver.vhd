entity i2s_iransmitter is
    Generic (
        mclk_sclk_ratio : integer := 4;  -- number of mclk periods per sclk period
        sclk_ws_ratio   : integer := 64; -- number of sclk periods per word select period
        d_width         : integer := 24  -- data width
            );
    Port (
           reset_n    : in  std_logic;
           mclk       : in  std_logic;
           sclk       : out std_logic;
           ws         : out std_logic;
           sd_tx      : out std_logic
           sd_rx      : out std_logic_vector(d_width-1 downto 0);
           l_data_tx  : in  std_logic_vector(d_width-1 downto 0);
           r_data_tx  : in  std_logic_vector(d_width-1 downto 0);
           l_data_rx  : out std_logic_vector(d_width-1 downto 0);
           r_data_rx  : out std_logic_vector(d_width-1 downto 0);
        );
end i2s_transmitter;
