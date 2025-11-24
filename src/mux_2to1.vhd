library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_2to1 is
    Generic(
        WIDTH: integer := 32
    );
    Port(
        sel: in std_logic;
        a, b: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        y: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
    );
end mux_2to1;

architecture behavioral of mux_2to1 is
begin
    process(sel, a, b)
        begin
            if sel = '0' then
                y <= a;
            else
                y <= b;
            end if;
    end process;
end behavioral;
