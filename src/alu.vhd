library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port(
        clk: in STD_LOGIC;
        op: in STD_LOGIC_VECTOR(2 downto 0);
        A: in STD_LOGIC_VECTOR(31 downto 0);
        B: in STD_LOGIC_VECTOR(31 downto 0);
        result: out STD_LOGIC_VECTOR(31 downto 0);
        zero: out STD_LOGIC
    );
end ALU;

architecture behavioral of ALU is
    begin
        process(clk, op, A, B) is
            if rising_edge(clk) then
                case op is
                    when "000" | "001" | "010" => -- lw, sw, add
                        result <= std_logic_vector(signed(A) + signed(B));
                    --when "001" => -- sw
                    --    result <= std_logic_vector(signed(A) + signed(B));
                    --when "010" => -- add
                    --    result <= std_logic_vector(signed(A) + signed(B));
                    --when "011" => -- bne
                    --    result <= std_logic_vector(signed(A) - signed(B));
                    when "100" => -- ori
                        result <= A or B;
                    when "101" => -- srl
                        result <= A srl B;
                    when others =>
                        result <= (others => '0');
                end case;
                zero <= '1' when (unsigned(result) = 0) else '0';
            end if;
        end process;
        

end behavioral;
