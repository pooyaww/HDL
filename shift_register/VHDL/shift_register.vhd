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

    signal r0_data : std_logic_vector(1 downto 0);
    signal r1_data : std_logic_vector(1 downto 0);
    signal r2_data : std_logic_vector(1 downto 0);
    signal r3_data : std_logic_vector(1 downto 0);

    begin
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
