library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    Port(
        clk: in STD_LOGIC;
        mem_write: in STD_LOGIC;
        mem_read: in STD_LOGIC := '1'; -- Read always enabled
        addr: in STD_LOGIC_VECTOR(31 downto 0);
        write_data: in STD_LOGIC_VECTOR(31 downto 0);
        read_data: out STD_LOGIC_VECTOR(31 downto 0)
    );
end DataMemory;

architecture behavioral of DataMemory is
    type memory_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal mem: memory_array;

    begin
        process(clk) is
            variable INITIALIZED: boolean := false;
            
            if not INITIALIZED then
                mem <= (0 => x"",
                        1 => x"",
                        2 => x"",
                        3 => x"",
                        4 => x"",
                        5 => x"",
                        6 => x"",
                        7 => x"",
                        others => x"00000000");
                INITIALIZED := true;
            else
                if rising_edge(clk) then
                    if mem_write = '1' then
                        mem(to_integer(unsigned(addr(7 downto 0)))) <= write_data;
                    end if;
                    if mem_read = '1' then
                        read_data <= mem(to_integer(unsigned(addr(7 downto 0))));
                    end if;
                end if;
            end if;
        end process;
        

end behavioral;
