library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    port (
        i_clk   : in  std_logic;
        i_rstb  : in  std_logic;
        i_data  : in  std_logic_vector(1 downto 0);
        o_data  : out std_logic_vector(1 downto 0)
    );
end shift_register;

-- Each register is declared as a signal variable
architecture rtl_signal of shift_register is
    -- remeber that signals used inside process are usualy synthesized to flip-flops so they need a clock cycle for assignment
    -- but signals used outside of sequential region (out od process) behaving like a wire and immediately assign the value;
    -- Variables inside the process behave like signals outside of a process

    signal r0_data : std_logic_vector(1 downto 0);
    signal r1_data : std_logic_vector(1 downto 0);
    signal r2_data : std_logic_vector(1 downto 0);
    signal r3_data : std_logic_vector(1 downto 0);

begin
    -- o_data contains the data which is shifted out of the register, here it is the last value in the third FF.
    o_data <= r3_data;
    p_sreg : process(i_clk, i_rstb)
            begin
                if (i_rstb = '0') then
                    r0_data <= (others => '0');
                    r1_data <= (others => '0');
                    r2_data <= (others => '0');
                    r3_data <= (others => '0');
                elsif (rising_edge(i_clk)) then
                    -- signals assigment order is not important
                    r0_data <= i_data;
                    r1_data <= r0_data;
                    r2_data <= r1_data;
                    r3_data <= r2_data;
                end if;
            end process p_sreg;
end rtl_signal;

architecture rtl_variable of shift_register is
begin
    p_sreg : process(i_clk, i_rstb)
    variable v_0_data : std_logic_vector(1 downto 0);
    variable v_1_data : std_logic_vector(1 downto 0);
    variable v_2_data : std_logic_vector(1 downto 0);
    begin
        if (i_rstb = '0') then
            v_0_data := (others => '0');
            v_1_data := (others => '0');
            v_2_data := (others => '0');
            o_data   <= (others => '0');
        elsif(rising_edge(i_clk)) then
            o_data    <= v_2_data;
            v_2_data  := v_1_data;
            v_1__data := v_0_data;
            v_0_data  := i_data;
        end if;
    end process p_sreg;
end rtl_variable;

architecture behavioral of shif_register is
    type t_sreg is array(0 to 3) of std_logic_vector(1 downto 0);
    signal r_data : t_sreg;
begin
    -- 1) The last cell of the register is sent out to the output signal
    -- It should happen before a new shift to avoid rewriting the cell without reading it.
    o_data <= r_data(r_data'length-1); -- r_data(index). Index of an array = length of array - 1, as array is inedxed from zero.

    p_sreg: process(i_clk, i_rstb)
    begin
        if (i_rstb = '0') then
            r_data <= (others=>(others=>'0'))
            elsif (rising_edge(i_clk)) then
                r_data(0) <= i_data; -- 2) Put the input data into the first FF (first cell of the register), then shift the others
                for idx in 1 to r_data'length-1 loop
                    r_data(i) <= r_data(idx-1) -- 3) Shifting
                end loop;
        end if;
    end process p_sreg;
end behavioral;

architecture concat_behavioral of shift_register is
    type t_sreg is array(0 to 3) of std_logic_vector(1 downto 0);
    signal r_data : t_sreg;
begin
    o_data <= r_data(r_data'length-1); -- send last cell to output
    p_sreg : process(i_clk, i_rstb)
    begin
        if (i_rstb = '0') then
            r_data <= (others => (others => '0'));
        elsif (rising_edge(i_clk)) then
            r_data <= i_data & r_data(0 to r_data'length - 2);  -- Concatenating new input data on the begining of the register and discarding the last cell.
        end if;

    end process p_sreg;
end concat_behavioral;
