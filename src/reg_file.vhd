library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port(
        clk: in STD_LOGIC;
        reg_write: in STD_LOGIC;
        read_register_1: in STD_LOGIC_VECTOR(4 downto 0);
        read_register_2: in STD_LOGIC_VECTOR(4 downto 0);
        write_register: in STD_LOGIC_VECTOR(4 downto 0);
        write_data: in STD_LOGIC_VECTOR(31 downto 0);
        read_data_1: out STD_LOGIC_VECTOR(31 downto 0);
        read_data_2: out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegisterFile;

architecture behavioral of RegisterFile is
    type memory_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal mem: memory_array;

    begin
        process(clk) is
            variable INITIALIZED: boolean := false;
            
            if not INITIALIZED then
                mem <= (others => x"00000000");
                INITIALIZED := true;
            else
                if rising_edge(clk) then
                    if reg_write = '1' then
                        mem(to_integer(unsigned(write_register))) <= write_data;
                    end if;
                    read_data_1 <= mem(to_integer(unsigned(read_register_1)));
                    read_data_2 <= mem(to_integer(unsigned(read_register_2)));
                end if;
            end if;
        end process;
        

end behavioral;
