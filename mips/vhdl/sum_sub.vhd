LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sum_sub IS
	GENERIC (DATA_S : INTEGER := 32);
	PORT (
		a   : IN signed(DATA_S - 1 DOWNTO 0);
		b   : IN signed(DATA_S - 1 DOWNTO 0);
		sel : IN std_logic;
		s   : OUT signed(DATA_S - 1 DOWNTO 0)
	);
END sum_sub;

ARCHITECTURE behavior OF sum_sub IS

BEGIN

	s <= (a - b) WHEN sel = '1' ELSE
		(a + b);

END behavior;
