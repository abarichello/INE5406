LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_wrapper IS
	GENERIC (DATA_S : INTEGER := 32);
	PORT (
		a      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
		b      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
		ulaop  : IN std_logic_vector (1 DOWNTO 0);
		funct  : IN std_logic_vector (5 DOWNTO 0);
		result : OUT std_logic_vector (DATA_S - 1 DOWNTO 0);
		zero   : OUT std_logic
	);
END ENTITY;
ARCHITECTURE behavior OF ula_wrapper IS

	SIGNAL s_ulacontrol : std_logic_vector (2 DOWNTO 0);

	COMPONENT ula_control IS
		PORT (
			ulaop      : IN std_logic_vector (1 DOWNTO 0);
			funct      : IN std_logic_vector (5 DOWNTO 0);
			ulacontrol : OUT std_logic_vector (2 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ula IS
		GENERIC (DATA_S : INTEGER := 32);
		PORT (
			a      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
			b      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
			sel    : IN std_logic_vector (2 DOWNTO 0);
			result : OUT std_logic_vector (DATA_S - 1 DOWNTO 0);
			zero   : OUT std_logic
		);
	END COMPONENT;

BEGIN

	ula_1 : ula
	GENERIC MAP(DATA_S => DATA_S)
	PORT MAP(a, b, s_ulacontrol, result, zero);
	ula_ctrl_1 : ula_control
	PORT MAP(ulaop, funct, s_ulacontrol);

END behavior;
