library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_MIPS_CPU is
end tb_MIPS_CPU;

architecture sim of tb_MIPS_CPU is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';

    -- Clock = 10 ns
    constant PERIOD : time := 10 ns;

begin

    -- DUT
    DUT: entity work.MIPS_CPU
        port map(
            clk => clk,
            reset => reset
        );

    -- Clock generator
    clk_process : process
    begin
        clk <= '0';
        wait for PERIOD/2;
        clk <= '1';
        wait for PERIOD/2;
    end process;

    -- Reset
    stim_proc: process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        wait for 200 ns;
        wait;
    end process;

end sim;
