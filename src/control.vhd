library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port(
        opcode    : in std_logic_vector(5 downto 0);
        RegDst    : out std_logic;
        RegWrite  : out std_logic;
        ALUSrc    : out std_logic;
        MemRead   : out std_logic;
        MemWrite  : out std_logic;
        MemtoReg  : out std_logic;
        Branch    : out std_logic;
        ALUOp     : out std_logic_vector(1 downto 0)
    );
end ControlUnit;

architecture behavioral of ControlUnit is
begin
    process(opcode)
    begin
        case opcode is

            -- R-type (add, srl)
            when "000000" =>
                RegDst   <= '1';
                RegWrite <= '1';
                ALUSrc   <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                MemtoReg <= '0';
                Branch   <= '0';
                ALUOp    <= "10";

            -- ori
            when "001101" =>
                RegDst   <= '0';
                RegWrite <= '1';
                ALUSrc   <= '1';
                MemRead  <= '0';
                MemWrite <= '0';
                MemtoReg <= '0';
                Branch   <= '0';
                ALUOp    <= "11";

            -- lw
            when "100011" =>
                RegDst   <= '0';
                RegWrite <= '1';
                ALUSrc   <= '1';
                MemRead  <= '1';
                MemWrite <= '0';
                MemtoReg <= '1';
                Branch   <= '0';
                ALUOp    <= "00";

            -- sw
            when "101011" =>
                RegDst   <= '0';
                RegWrite <= '0';
                ALUSrc   <= '1';
                MemRead  <= '0';
                MemWrite <= '1';
                MemtoReg <= '0';
                Branch   <= '0';
                ALUOp    <= "00";

            -- bne
            when "000101" =>
                RegDst   <= '0';
                RegWrite <= '0';
                ALUSrc   <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                MemtoReg <= '0';
                Branch   <= '1';
                ALUOp    <= "01";

            when others =>
                RegDst   <= '0';
                RegWrite <= '0';
                ALUSrc   <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                MemtoReg <= '0';
                Branch   <= '0';
                ALUOp    <= "00";

        end case;
    end process;
end behavioral;
