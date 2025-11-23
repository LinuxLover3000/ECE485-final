library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port(
        clk: in STD_LOGIC;
        read_addr in STD_LOGIC_VECTOR(31 downto 0);
        instr: out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstructionMemory;

architecture behavioral of InstructionMemory is
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
                if rising_edge(clk) then -- Performs a read on every clock cycle
                    instr <= mem(to_integer(unsigned(read_addr(7 downto 0))));
                end if;
            end if;
        end process;
        

end behavioral;
