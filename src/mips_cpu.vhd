library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS_CPU is
    Port(
        clk: in std_logic;
        reset: in std_logic;

        pc_out: out std_logic_vector(31 downto 0);
        reg_t2: out std_logic_vector(31 downto 0); -- $t2 = reg 10
        reg_t3: out std_logic_vector(31 downto 0); -- $t3 = reg 11
        reg_t4: out std_logic_vector(31 downto 0); -- $t4 = reg 12
        mem0_out: out std_logic_vector(31 downto 0)  -- memory[0]
    );
end MIPS_CPU;

architecture behavioral of MIPS_CPU is
    -- Signal declaration
    signal instr: STD_LOGIC_VECTOR(31 downto 0);
    signal new_PC: STD_LOGIC_VECTOR(31 downto 0);
    signal PC_plus_1: STD_LOGIC_VECTOR(31 downto 0);
    signal branch_address: STD_LOGIC_VECTOR(31 downto 0);

    signal PCSrc_out: STD_LOGIC_VECTOR(31 downto 0);
    signal SignExt_out: STD_LOGIC_VECTOR(31 downto 0);
    signal MemtoReg_out: STD_LOGIC_VECTOR(31 downto 0);
    signal RegWrite: STD_LOGIC;
    signal RegDst: STD_LOGIC;
    signal WriteReg_in: STD_LOGIC_VECTOR(4 downto 0);

    signal ALU_A_in: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUSrc_Reg_in: STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_B_in: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp: STD_LOGIC_VECTOR(1 downto 0);
    signal ALUCtrl: STD_LOGIC_VECTOR(2 downto 0);
    signal ALUSrc: STD_LOGIC;
    signal ALU_out: STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_zero: STD_LOGIC;

    signal MemtoReg: STD_LOGIC;
    signal DataMem_out: STD_LOGIC_VECTOR(31 downto 0);
    signal MemRead: STD_LOGIC;
    signal MemWrite: STD_LOGIC;
    signal Branch: STD_LOGIC;

    -- Entity instantiation
    begin
        PC_plus_1 <= std_logic_vector(unsigned(new_PC) + 1);
        branch_address <= std_logic_vector(signed(PC_plus_1) + signed(SignExt_out));


        -- Memory units (InstructionMemory, RegisterFile, DataMemory)
        InstructionMemory: entity work.InstructionMemory
            port map(
                clk => clk,
                read_addr => new_PC,
                instr => instr
            );
        
        RegisterFile: entity work.RegisterFile
            port map(
                clk => clk,
                reg_write => RegWrite,
                read_register_1 => instr(25 downto 21), --rs
                read_register_2 => instr(20 downto 16), --rt
                write_register => WriteReg_in,
                write_data => MemtoReg_out,
                read_data_1 => ALU_A_in,
                read_data_2 => ALUSrc_Reg_in
            );
        
        DataMemory: entity work.DataMemory
            port map(
                clk => clk,
                mem_write => MemWrite,
                mem_read => MemRead,
                addr => ALU_out,
                write_data => ALUSrc_Reg_in,
                read_data => DataMem_out
            );
        
        ControlUnit: entity work.ControlUnit
            port map(
                opcode => instr(31 downto 26),
                RegDst => RegDst,
                RegWrite => RegWrite,
                ALUSrc => ALUSrc,
                MemRead => MemRead,
                MemWrite => MemWrite,
                MemtoReg => MemtoReg,
                Branch => Branch,
                ALUOp => ALUOp
            );

        ALUControl: entity work.ALUControl
            port map(
                ALUOp => ALUOp,
                funct => instr(5 downto 0),
                ALUCtrl => ALUCtrl
            );


        -- ALU
        ALU: entity work.ALU
            port map(
                clk => clk,
                op => ALUCtrl,
                A => ALU_A_in,
                B => ALU_B_in,
                result => ALU_out,
                zero => ALU_zero
            );
        -- PC, SignExtension
        PC: entity work.PC
            port map(
                clk => clk,
                reset => reset,
                input => PCSrc_out,
                output => new_PC
            );

        SignExtension: entity work.SignExtension
            port map(
                input => instr(15 downto 0),
                output => SignExt_out
            );
        -- Muxes
        ALUSrc_mux: entity work.mux_2to1
            generic map(
                WIDTH => 32
            )
            port map (
                sel => ALUSrc,
                a => ALUSrc_Reg_in,
                b => SignExt_out,
                y => ALU_B_in
            );
        
        MemtoReg_mux: entity work.mux_2to1
            generic map(
                WIDTH => 32
            )
            port map(
                sel => MemtoReg,
                a => DataMem_out,
                b => ALU_out,
                y => MemtoReg_out
            );

        RegDst_mux: entity work.mux_2to1
            generic map(
                WIDTH => 5
            )
            port map(
                sel => RegDst,
                a => instr(20 downto 16),
                b => instr(15 downto 11),
                y => WriteReg_in
            );
    
        PCSrc_mux: entity work.mux_2to1
            generic map(
                WIDTH => 32
            )
            port map(
                sel => (ALU_zero and Branch),
                a => PC_plus_1,
                b => branch_address,
                y => PCSrc_out
            );
        
        reg_t2 <= (others => '0');
        reg_t3 <= (others => '0');
        reg_t4 <= (others => '0');
        --mem0_out <= DataMem_out when (ALU_out = (others => '0')) else DataMem_out;
        mem0_out <= DataMem_out;


end behavioral;
