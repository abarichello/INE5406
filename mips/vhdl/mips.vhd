LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mips IS
	PORT (
		--debug s to check in testbench
		dbg_mux_wAddr                                                                                         : OUT std_logic_vector(4 DOWNTO 0);
		dbg_mux_wData3, dbg_mux2ula, dbg_ula_result, dbg_reg1, dbg_reg2, dbg_signal_extender, dbg_instruction : OUT std_logic_vector(31 DOWNTO 0);
		dbg_zero                                                                                              : OUT std_logic;
		dbg_pc                                                                                                : OUT INTEGER RANGE 0 TO 255;
		dbg_reg_addr1, dbg_reg_addr2                                                                          : OUT std_logic_vector(4 DOWNTO 0);
		dbg_ula_OpFunct                                                                                       : OUT std_logic_vector(7 DOWNTO 0);
		dbg_control                                                                                           : OUT std_logic_vector(6 DOWNTO 0);
		--project signals
		clk, rst                                                                                              : IN std_logic
	);
END ENTITY;

ARCHITECTURE behavior OF mips IS
	COMPONENT datapath IS
		GENERIC (
			DATA_S     : INTEGER := 32;
			INSTRUCT_S : INTEGER := 26;
			ADDR_S     : INTEGER := 5);
		PORT (
			--debug signals to check in testbench
			dbg_mux_wAddr                                                                        : OUT std_logic_vector(ADDR_S - 1 DOWNTO 0);
			dbg_mux_wData3, dbg_mux2ula, dbg_ula_result, dbg_reg1, dbg_reg2, dbg_signal_extender : OUT std_logic_vector(DATA_S - 1 DOWNTO 0);
			dbg_zero                                                                             : OUT std_logic;
			dbg_reg_addr1, dbg_reg_addr2                                                         : OUT std_logic_vector(ADDR_S - 1 DOWNTO 0);
			dbg_ula_OpFunct                                                                      : OUT std_logic_vector(7 DOWNTO 0);
			--project signals
			clk, rst                                                                             : IN std_logic;
			i_instruction                                                                        : IN std_logic_vector(INSTRUCT_S - 1 DOWNTO 0);
			i_control                                                                            : IN std_logic_vector(5 DOWNTO 0);
			i_dataMem                                                                            : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
			o_pc                                                                                 : OUT INTEGER RANGE 0 TO 255;
			o_ula_result                                                                         : OUT std_logic_vector(DATA_S - 1 DOWNTO 0);
			o_rReg1                                                                              : OUT std_logic_vector(DATA_S - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT data_memory_reg IS
		PORT (
			clk  : IN std_logic;
			we   : IN std_logic;
			addr : std_logic_vector(7 - 1 DOWNTO 0);
			data : IN std_logic_vector (32 - 1 DOWNTO 0);
			q    : OUT std_logic_vector (32 - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT instruction_memory_reg IS
		PORT (
			addr : std_logic_vector(7 - 1 DOWNTO 0);
			q    : OUT std_logic_vector (32 - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mips_decoder IS
		PORT (
			instruction : IN std_logic_vector(5 DOWNTO 0);
			control     : OUT std_logic_vector(6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL s_instruction : std_logic_vector(31 DOWNTO 0);
	SIGNAL s_control     : std_logic_vector(6 DOWNTO 0);
	SIGNAL s_pc          : INTEGER RANGE 0 TO 255;
	SIGNAL s_dataMem     : std_logic_vector(31 DOWNTO 0);
	SIGNAL s_rReg1       : std_logic_vector(31 DOWNTO 0);
	SIGNAL s_ula_result  : std_logic_vector(31 DOWNTO 0);
BEGIN

	dbg_pc          <= s_pc;
	dbg_instruction <= s_instruction;
	dbg_control     <= s_control;

	databath_b : datapath
	GENERIC MAP(DATA_S => 32, INSTRUCT_S => 26, ADDR_S => 5)
	PORT MAP (
		--debug signals to check in testbench
		dbg_mux_wAddr       => dbg_mux_wAddr,
		dbg_mux_wData3      => dbg_mux_wData3,
		dbg_mux2ula         => dbg_mux2ula,
		dbg_ula_result      => dbg_ula_result,
		dbg_reg1            => dbg_reg1,
		dbg_reg2            => dbg_reg2,
		dbg_signal_extender => dbg_signal_extender,
		dbg_zero            => dbg_zero,
		dbg_reg_addr1       => dbg_reg_addr1,
		dbg_reg_addr2       => dbg_reg_addr2,
		dbg_ula_OpFunct     => dbg_ula_OpFunct,

		--project signals
		clk                 => clk,
		rst                 => rst,
		i_instruction       => s_instruction(25 DOWNTO 0),
		i_control           => s_control(5 DOWNTO 0), -- 9 [sel_wAddr(8), sel_DVI(7), sel_DVC(6), read_mem(5), sel_wData3(4), sel_mux2ula(3), regfile_we(2), ula_op(1 downto 0) ] 0
		i_dataMem           => s_dataMem,
		o_pc                => s_pc,
		o_ula_result        => s_ula_result,
		o_rReg1             => s_rReg1
	);

	data_mem : data_memory_reg
	PORT MAP(
		clk  => clk,
		we   => s_control(6),
		addr => s_ula_result(6 DOWNTO 0),
		data => s_rReg1,
		q    => s_dataMem
	);

	inst_mem : instruction_memory_reg
	PORT MAP(
		addr => std_logic_vector(to_unsigned(s_pc, 7)),
		q    => s_instruction
	);

	decoder_i : mips_decoder
	PORT MAP
	(
		instruction => s_instruction(31 DOWNTO 26),
		control     => s_control
	);

END behavior;
