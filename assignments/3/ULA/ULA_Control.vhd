LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ULA_Control IS
	PORT(ulaOp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		ulaControl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END entity;

ARCHITECTURE estrutura OF ULA_Control IS

BEGIN
	PROCESS(all) BEGIN
		CASE ulaOp IS
			WHEN "00" =>
				ulaControl <= "010";
			WHEN "01" =>
				ulaControl <= "110";
			WHEN "10" =>
				CASE funct IS
					WHEN "100000" =>
						ulaControl <= "010";
					WHEN "100010" =>
						ulaControl <= "110";
					WHEN "100100" =>
						ulaControl <= "000";
					WHEN "100101" =>
						ulaControl <= "001";
					WHEN "101010" =>
						ulaControl <= "111";
					WHEN OTHERS =>
						ulaControl <= "111";
				END CASE;
			WHEN OTHERS =>
				ulaControl <= "111";
		END CASE;
	END PROCESS;
END estrutura;
