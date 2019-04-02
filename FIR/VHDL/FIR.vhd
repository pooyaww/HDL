-- symetrical filter
-- add packages
-- add integer to std function
Entity FIR is
    port (
             clk : in std_logic;
             rst : in std_logic;
             Xin : in std_logic_vector(15 downto 0);
             Yout: out std_logic_vector(15 downto 0)
         );
End FIR;

Architecture RTL of FIR is
    type TCoef is array (0 to 7) of integer;
    constant C : TCoef := (-75,133,-387,626,-865,1345,-2234,4234,16);
    signal   x : is array (0 to 15) of std_logic_vector(15 downto 0);
Begin
End RTL;
