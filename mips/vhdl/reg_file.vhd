LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_file IS
	GENERIC (
		DATA_S : INTEGER := 32;
		N_REGS : INTEGER := 32;
		ADDR_S : INTEGER := 5);--ADDR_S = log2(N_REGS)
	PORT (
		clk                          : IN std_logic;
		i_we3                        : IN std_logic;
		i_rAddr1, i_rAddr2, i_wAddr3 : std_logic_vector(ADDR_S - 1 DOWNTO 0);
		i_wData3                     : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
		o_rReg1, o_rReg2             : OUT std_logic_vector (DATA_S - 1 DOWNTO 0)
	);
END;

ARCHITECTURE behave OF reg_file IS
	TYPE reg_array IS ARRAY(N_REGS - 1 DOWNTO 0) OF std_logic_vector (DATA_S - 1 DOWNTO 0);
	SIGNAL s_file : reg_array;
BEGIN
	--write
	PROCESS (clk) BEGIN
		IF (rising_edge(clk)) THEN
			IF (i_we3 = '1') THEN
				s_file(to_integer(unsigned((i_wAddr3)))) <= i_wData3;
			END IF;
		END IF;
	END PROCESS;

	--read
	PROCESS (ALL) BEGIN
		IF (to_integer(unsigned(i_rAddr1)) = 0) THEN
			o_rReg1 <= (OTHERS => '0');
		ELSE
			o_rReg1 <= s_file(to_integer(unsigned(i_rAddr1)));
		END IF;

		IF (to_integer(unsigned(i_rAddr2)) = 0) THEN
			o_rReg2 <= (OTHERS => '0');
		ELSE
			o_rReg2 <= s_file(to_integer(unsigned(i_rAddr2)));
		END IF;
	END PROCESS;
END;
