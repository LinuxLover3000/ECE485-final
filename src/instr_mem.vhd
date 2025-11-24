library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port(
        clk: in STD_LOGIC;
        read_addr: in STD_LOGIC_VECTOR(31 downto 0);
        instr: out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstructionMemory;

architecture behavioral of InstructionMemory is
    type memory_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal mem: memory_array := (   0  => x"34080005", -- ori $t0,$zero,5
                                    1  => x"34090003", -- ori $t1,$zero,3
                                    2  => x"01095020", -- add $t2,$t0,$t1
                                    3  => x"AC0A0000", -- sw $t2,0($zero)
                                    4  => x"8C0B0000", -- lw $t3,0($zero)
                                    5  => x"000B6042", -- srl $t4,$t3,1  (funct=0x02, shamt=1)
                                    6  => x"118A0002", -- bne $t4,$t2,2
                                    7  => x"340D00FF", -- ori $t5,$zero,0x00FF
                                    8  => x"01A87020", -- add $t6,$t5,$t0
                                    9  => x"00000000", -- nop
                                    others => x"00000000");

    begin
        instr <= mem(to_integer(unsigned(read_addr(7 downto 0))));

end behavioral;
