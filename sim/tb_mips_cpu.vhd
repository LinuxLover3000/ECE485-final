library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_MIPS_CPU is
end tb_MIPS_CPU;

architecture Behavioral of tb_MIPS_CPU is
    signal clk: std_logic := '0';
    signal reset: std_logic := '1';

    signal pc_out: std_logic_vector(31 downto 0);
    signal reg_t2: std_logic_vector(31 downto 0);
    signal reg_t3: std_logic_vector(31 downto 0);
    signal reg_t4: std_logic_vector(31 downto 0);
    signal mem0: std_logic_vector(31 downto 0);

    component MIPS_CPU_debug
        Port(
            clk: in  std_logic;
            reset: in  std_logic;
            pc_out: out std_logic_vector(31 downto 0);
            reg_t2: out std_logic_vector(31 downto 0);
            reg_t3: out std_logic_vector(31 downto 0);
            reg_t4: out std_logic_vector(31 downto 0);
            mem0_out: out std_logic_vector(31 downto 0)
        );
    end component;

begin
    -- instantiate DUT
    DUT : MIPS_CPU_debug
        port map(clk => clk, reset => reset,
                 pc_out => pc_out, reg_t2 => reg_t2, reg_t3 => reg_t3, reg_t4 => reg_t4, mem0_out => mem0);

    -- clock
    clk_process : process
    begin
        while now < 1 ms loop
            clk <= '0'; wait for 10 ns;
            clk <= '1'; wait for 10 ns;
        end loop;
        wait;
    end process;

    -- reset pulse and test sequence
    stim_proc: process
    begin
        -- initial reset
        reset <= '1';
        wait for 30 ns;
        reset <= '0';

        -- allow a few cycles to execute program (10-20 cycles)
        wait for 400 ns;

        -- now check results by printing PC and mem locations
        report "PC at time " & integer'image(to_integer(unsigned(pc_out)));
        report "Memory[0] = " & to_hstring(mem0);

        -- assertions (example checks)
        assert mem0 = x"00000008"
            report "SW/LW test failed: mem[0] != 8" severity error;

        -- done
        report "Simulation finished." severity note;
        wait;
    end process;
end Behavioral;
