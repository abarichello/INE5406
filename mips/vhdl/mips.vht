LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE std.env.ALL;

ENTITY mips_vhd_tst IS
END mips_vhd_tst;

ARCHITECTURE mips_arch OF mips_vhd_tst IS
	-- signals
	SIGNAL clk                 : std_logic;
	SIGNAL dbg_instruction     : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_mux2ula         : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_mux_wAddr       : std_logic_vector(4 DOWNTO 0);
	SIGNAL dbg_mux_wData3      : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_pc              : std_logic_vector(7 DOWNTO 0);
	SIGNAL dbg_reg1            : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_reg2            : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_signal_extender : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_reg_addr1       : std_logic_vector(4 DOWNTO 0);
	SIGNAL dbg_reg_addr2       : std_logic_vector(4 DOWNTO 0);
	SIGNAL dbg_ula_OpFunct     : std_logic_vector(7 DOWNTO 0);
	SIGNAL dbg_control         : std_logic_vector(6 DOWNTO 0);
	SIGNAL dbg_ula_result      : std_logic_vector(31 DOWNTO 0);
	SIGNAL dbg_zero            : std_logic;
	SIGNAL rst                 : std_logic;

	COMPONENT mips
		PORT (
			clk                 : IN std_logic;
			dbg_instruction     : OUT std_logic_vector(31 DOWNTO 0);
			dbg_mux2ula         : OUT std_logic_vector(31 DOWNTO 0);
			dbg_mux_wAddr       : OUT std_logic_vector(4 DOWNTO 0);
			dbg_mux_wData3      : OUT std_logic_vector(31 DOWNTO 0);
			dbg_pc              : OUT std_logic_vector(7 DOWNTO 0);
			dbg_reg1            : OUT std_logic_vector(31 DOWNTO 0);
			dbg_reg2            : OUT std_logic_vector(31 DOWNTO 0);
			dbg_signal_extender : OUT std_logic_vector(31 DOWNTO 0);
			dbg_reg_addr1       : OUT std_logic_vector(4 DOWNTO 0);
			dbg_reg_addr2       : OUT std_logic_vector(4 DOWNTO 0);
			dbg_ula_OpFunct     : OUT std_logic_vector(7 DOWNTO 0);
			dbg_control         : OUT std_logic_vector(6 DOWNTO 0);
			dbg_ula_result      : OUT std_logic_vector(31 DOWNTO 0);
			dbg_zero            : OUT std_logic;
			rst                 : IN std_logic
		);
	END COMPONENT;

	--constants
	CONSTANT PERIOD                                                : TIME := 100 ns;
	CONSTANT H_PERIOD                                              : TIME := 50 ns;
	CONSTANT Q_PERIOD                                              : TIME := 25 ns;

	--simulation signals
	FILE test_file_instruction, test_file_pc, test_file_dataResult : text;

	SIGNAL s_instruction                                           : std_logic_vector(31 DOWNTO 0);
	SIGNAL s_pc                                                    : std_logic_vector(7 DOWNTO 0);
	SIGNAL s_wData3                                                : std_logic_vector(31 DOWNTO 0);
BEGIN
	i1 : mips
	PORT MAP(
		-- list connections between master ports and signals
		clk                 => clk,
		dbg_instruction     => dbg_instruction,
		dbg_mux2ula         => dbg_mux2ula,
		dbg_mux_wAddr       => dbg_mux_wAddr,
		dbg_mux_wData3      => dbg_mux_wData3,
		dbg_pc              => dbg_pc,
		dbg_reg1            => dbg_reg1,
		dbg_reg2            => dbg_reg2,
		dbg_signal_extender => dbg_signal_extender,
		dbg_reg_addr1       => dbg_reg_addr1,
		dbg_reg_addr2       => dbg_reg_addr2,
		dbg_ula_OpFunct     => dbg_ula_OpFunct,
		dbg_control         => dbg_control,
		dbg_ula_result      => dbg_ula_result,
		dbg_zero            => dbg_zero,
		rst                 => rst
	);
	--init: process
	--begin
	--	rst <= '1';
	--	wait;
	--end process;

	--process
	--begin
	--	clk <= '0';
	--	wait for PERIOD/2;
	--	clk <= '1';
	--	wait for PERIOD/2;
	--end process;

	always : PROCESS
		VARIABLE v_line_inst, v_line_pc, v_line_data : line;
		VARIABLE v_instruction                       : std_logic_vector(31 DOWNTO 0);
		VARIABLE v_pc                                : std_logic_vector(7 DOWNTO 0);
		VARIABLE v_wData3                            : std_logic_vector(31 DOWNTO 0);
		VARIABLE idx_test                            : INTEGER;
	BEGIN
		file_open(test_file_instruction, "D:/aulas/SD/mips_monocycle/test_instruction.txt", read_mode);
		file_open(test_file_pc, "D:/aulas/SD/mips_monocycle/test_pc.txt", read_mode);
		file_open(test_file_dataResult, "D:/aulas/SD/mips_monocycle/teste_dataResult.txt", read_mode);

		idx_test := 0;
		--rst <= '1';
		WHILE NOT endfile(test_file_instruction) LOOP
			clk <= '1';
			WAIT FOR Q_PERIOD;
			readline(test_file_instruction, v_line_inst);
			read(v_line_inst, v_instruction);
			s_instruction <= v_instruction;

			readline(test_file_pc, v_line_pc);
			read(v_line_pc, v_pc);
			s_pc <= v_pc;
			WAIT FOR Q_PERIOD;
			clk <= '0';

			ASSERT (dbg_pc = s_pc)
			REPORT "PC is wrong. #TEST:" & INTEGER'image(idx_test) & " Read: " & INTEGER'image(to_integer(unsigned(dbg_pc))) & " Expected: " & INTEGER'image(to_integer(unsigned(s_pc)))
				SEVERITY ERROR;

			CASE v_instruction(31 DOWNTO 26) IS
				WHEN "000000" =>
					readline(test_file_dataResult, v_line_data);
					read(v_line_data, v_wData3);
					s_wData3 <= v_wData3;
					WAIT FOR Q_PERIOD;

					ASSERT (dbg_control = "0100110")
					REPORT "Control output is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_control))) & "; Expected: 0100110"
						SEVERITY ERROR;
					ASSERT (dbg_reg_addr1 = s_instruction(25 DOWNTO 21))
					REPORT "Address 1 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_reg_addr1))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(25 DOWNTO 21))))
						SEVERITY ERROR;
					ASSERT (dbg_reg_addr2 = s_instruction(20 DOWNTO 16))
					REPORT "Address 2 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_reg_addr2))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(20 DOWNTO 16))))
						SEVERITY ERROR;
					ASSERT (dbg_mux_wAddr = s_instruction(15 DOWNTO 11))
					REPORT "Address 3 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_mux_wAddr))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(15 DOWNTO 11))))
						SEVERITY ERROR;
					ASSERT (dbg_mux_wData3 = s_wData3)
					REPORT "Result to data input of reg file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(signed(dbg_mux_wData3))) & "; Expected: " & INTEGER'image(to_integer(signed(s_wData3)))
						SEVERITY ERROR;

				WHEN "100011" =>
					readline(test_file_dataResult, v_line_data);
					read(v_line_data, v_wData3);
					s_wData3 <= v_wData3;
					WAIT FOR Q_PERIOD;

					ASSERT (dbg_control = "0011100")
					REPORT "Control output is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_control))) & "; Expected: 0011100"
						SEVERITY ERROR;
					ASSERT (dbg_mux_wAddr = s_instruction(20 DOWNTO 16))
					REPORT "Address 3 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_mux_wAddr))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(20 DOWNTO 16))))
						SEVERITY ERROR;
					ASSERT (dbg_mux_wData3 = s_wData3)
					REPORT "Result to data input of reg file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(signed(dbg_mux_wData3))) & "; Expected: " & INTEGER'image(to_integer(signed(s_wData3)))
						SEVERITY ERROR;

				WHEN "101011" =>
					WAIT FOR Q_PERIOD;
					ASSERT (dbg_control = "1001000")
					REPORT "Control output is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_control))) & "; Expected: 1001000"
						SEVERITY ERROR;
					ASSERT (dbg_reg_addr1 = s_instruction(25 DOWNTO 21))
					REPORT "Address 1 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_reg_addr1))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(25 DOWNTO 21))))
						SEVERITY ERROR;
					ASSERT (dbg_reg_addr2 = s_instruction(20 DOWNTO 16))
					REPORT "Address 2 of data file is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_reg_addr2))) & "; Expected: " & INTEGER'image(to_integer(unsigned(s_instruction(20 DOWNTO 16))))
						SEVERITY ERROR;
					--when "000100" =>
					--	assert (dbg_control="0000001")
					--		report "Control output is wrong. #TEST: " & integer'image(idx_test) & "; Read: " & integer'image() & "; Expected: " & integer()
					--		severity ERROR;
					--when "000010" =>
					--	assert (dbg_control="0000000")
					--		report "Control output is wrong. #TEST: " & integer'image(idx_test) & "; Read: " & integer'image() & "; Expected: " & integer()
					--		severity ERROR;

				WHEN OTHERS =>
					WAIT FOR Q_PERIOD;
					ASSERT (dbg_control = "0000000")
					REPORT "Control output is wrong. #TEST: " & INTEGER'image(idx_test) & "; Read: " & INTEGER'image(to_integer(unsigned(dbg_control))) & "; Expected: 0000000"
						SEVERITY ERROR;
			END CASE;
			idx_test := idx_test + 1;

			WAIT FOR Q_PERIOD;
			--rst <= '0';
		END LOOP;

		file_close(test_file_instruction);
		file_close(test_file_pc);
		file_close(test_file_dataResult);

		ASSERT false
		REPORT "Test finished!"
			SEVERITY note;
		stop(0);
	END PROCESS always;
END mips_arch;
