library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port(
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        input in STD_LOGIC_VECTOR(31 downto 0);
        output: out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC;

architecture behavioral of PC is
    begin
        process(clk, reset) is
            begin
                if reset = '1' then
                    output <= (others => '0');
                elsif rising_edge(clk) then
                    output <= input;
                end if;
        end process;
        

end behavioral;
