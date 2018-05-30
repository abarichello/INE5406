LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY signal_extender IS
	GENERIC (
		N_IN  : INTEGER := 16;
		N_OUT : INTEGER := 32);
	PORT (
		in_value  : IN std_logic_vector(N_IN - 1 DOWNTO 0);
		out_value : OUT std_logic_vector(N_OUT - 1 DOWNTO 0)
	);
END signal_extender;

ARCHITECTURE behavior OF signal_extender IS
BEGIN

END behavior;
