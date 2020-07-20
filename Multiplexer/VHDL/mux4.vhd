library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
    port (
           a1  : in std_logic_vector(2 downto 0);
           a2  : in std_logic_vector(2 downto 0);
           a3  : in std_logic_vector(2 downto 0);
           a4  : in std_logic_vector(2 downto 0);
           sel : in std_logic_vector(1 downto 0);
           b   : in std_logic_vector(2 downto 0)
       );
end mux4;

architecture sequential of mux4 is
    -- Nothing to declare
begin
    p_mux : process(a1, a2, a3, a4, sel)
    begin
        -- Both Statements and predicates can be different
        case sel is
            when "00"   => b <= a1;
            when "01"   => b <= a2;
            when "10"   => b <= a3;
            with others => b <= a4;
        end case;
    end process p_mux;
end sequential;

architecture concurrent of mux4 is
    -- Nothing to declare
begin
    -- Statement is fixed
    with sel select
        b <= a1 when "00",
             a2 when "01",
             a3 when "10",
             a4 when others;
end concurrent;

architecture concurrent_2 of mux4 is
    -- Nothing to declare
begin
    b <= a1 when (sel = "00") else
         a2 when (sel = "01") else
         a3 when (sel = "10") else
         a4;
end concurrent_2;

