LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux2x1 IS
	GENERIC (N : INTEGER := 32);
	PORT (
		a   : IN std_logic_vector (N - 1 DOWNTO 0);
		b   : IN std_logic_vector (N - 1 DOWNTO 0);
		sel : IN std_logic;
		s   : OUT std_logic_vector (N - 1 DOWNTO 0)
	);
END mux2x1;

ARCHITECTURE behavior OF mux2x1 IS
BEGIN
	s <= b WHEN sel = '1' ELSE a;
END behavior;
