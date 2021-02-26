library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.al;

-- Cascading 7 XOR port where the output of the k-th port is the input of the (k+1) XOR port

entity parity_check is
    port (
        i_clk    : in std_logic;
        i_data   : in std_logic_vector(7 downto 0);
        o_parity : out std_logic
    );
end parity_check;

architecture rtl of parity_check is
    signal r_data : std_logic_vector(7 downto 0);

begin
    p_parity_check : process (i_clk)
        variable vparity : std_logic;
    begin
        if rising_edge(i_clk) then
            r_data <= i_data;
            vparity := '0';
            l_parity : for k in 0 to r_data'length - 1 loop
                vparity := vparity xor r_data(k);
            end loop l_parity;
            o_parity <= vparity;
        end if;
    end process p_parity_check
end rtl;
