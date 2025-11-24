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
        output <= (31 downto 16 => input(15)) & input;

end behavioral;
