entity i2s_transmitter is
    Generic (
        mclk_sclk_ratio : integer := 4;  -- number of mclk periods per sclk period
        sclk_ws_ratio   : integer := 64; -- number of sclk periods per word select period
        d_width         : integer := 24  -- data width
            );
    Port (
           reset_n    : in  std_logic;                              -- asynchronous active low reset
           mclk       : in  std_logic;                              -- master clock
           sclk       : out std_logic;                              -- serial clock (or bit clock)
           ws         : out std_logic;                              -- word select (or left-right clock)
           sd_tx      : out std_logic                               -- serial data transmit
           sd_rx      : out std_logic_vector(d_width-1 downto 0);   -- serial data receive
           l_data_tx  : in  std_logic_vector(d_width-1 downto 0);   -- left channel data to trasmit
           r_data_tx  : in  std_logic_vector(d_width-1 downto 0);   -- right channel data to transmit
           l_data_rx  : out std_logic_vector(d_width-1 downto 0);   -- left channel data receive
           r_data_rx  : out std_logic_vector(d_width-1 downto 0);   -- right channle data received
        );
end i2s_transmitter;

architecture logic of i2s_transmitter is

begin

end logic;

