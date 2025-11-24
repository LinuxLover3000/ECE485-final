library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port(
        ALUOp  : in std_logic_vector(1 downto 0);
        funct  : in std_logic_vector(5 downto 0);
        ALUCtrl: out std_logic_vector(2 downto 0)
    );
end ALUControl;

architecture behavioral of ALUControl is
begin
    process(ALUOp, funct)
    begin
        case ALUOp is

            when "00" =>  -- lw, sw
                ALUCtrl <= "000";  -- add

            when "01" =>  -- bne
                ALUCtrl <= "011";  -- subtract

            when "10" =>  -- R-type
                case funct is
                    when "100000" => ALUCtrl <= "000"; -- add
                    when "000010" => ALUCtrl <= "101"; -- srl
                    when others   => ALUCtrl <= "000";
                end case;

            when "11" =>  -- ori
                ALUCtrl <= "100";

            when others =>
                ALUCtrl <= "000";

        end case;
    end process;
end behavioral;
