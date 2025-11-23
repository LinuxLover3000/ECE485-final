library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtension is
    Port(
        clk: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(15 downto 0);
        output: out STD_LOGIC_VECTOR(31 downto 0)
    );
end SignExtension;

architecture behavioral of SignExtension is
    signal extended_value: STD_LOGIC_VECTOR(31 downto 0);
    begin
        process(clk)
            variable sign_bit: STD_LOGIC := input(15);
            begin
                if rising_edge(clk) then
                    extended_value <= ( 15 downto 0 => input(15 downto 0),
                                        31 downto 16 => (others => sign_bit));
                    output <= extended_value;
                end if;
        end process;

end behavioral;
