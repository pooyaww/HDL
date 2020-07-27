library ieee;
use ieee.std_logic_1164.all;

-- Implementing delay-line as shift register.
-- atucally same as shift register but naming it a delay line and adding parametric bitwidth and depth.
entity delay_line_by_shift_reg is
    generic(
        G_WIDTH : integer := 8;
        G_DEPTH : integer := 24
    );

    port (
        i_clk  : in  std_logic;
        i_rstb : in  std_logic;
        i_d    : in  std_logic_vector(G_WIDTH - 1 downto 0);
        o_q    : out std_logic_vector(G_WIDTH - 1 downto 0);
    );
end delay_line_by_shift_reg;

architecture behavioral of delay_line_by_shift_reg is
    type t_q_pipe is array(0 to G_DEPTH - 1) of std_logic_vector(G_WIDTH - 1 downto 0);
    signal q_pipe : t_q_pipe;
begin
    process_pipe : process(i_clk, i_rstb)
    begin
        if (i_rstb = '0') then
            q_pipe <= (others => (others => '0'));
        elsif (rising_edge(i_clk)) then
            q_pipe <= i_d&q_pipe(0 to q_pipe'length - 2);
        end if;
    end process process_pipe;

    o_q <= q_pipe(q_pipe'length - 1);

end behavioral;


-- Removing the reset signal "i_rstb" the synthesizers will implement the shift-register in a dedicated FPGA logic resources
architecture opt_behavioral of delay_line_by_shift_reg is
    type t_q_pipe is array(0 to G_DEPTH - 1) of std_logic_vector(G_WIDTH - 1 downto 0);
    signal q_pipe : t_q_pipe;
begin
    process_pipe : process(i_clk)
    begin
        if (rising_edge(i_clk)) then
            q_pipe <= i_d&q_pipe(0 to q_pipe'length - 2);
        end if;
    end process process_pipe;

    o_q <= q_pipe(q_pipe'length - 1);

end opt_behavioral;

-- Implementation of Digital Delay Line via Intel FIFO IP (practical if long delays needed)

architecture fifo_based of delay_line_by_shift_reg is
-- Fifo component
-- signals
begin

end fifo_based;
