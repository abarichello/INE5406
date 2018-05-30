LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_control IS
	PORT (
		ulaop      : IN std_logic_vector (1 DOWNTO 0);
		funct      : IN std_logic_vector (5 DOWNTO 0);
		ulacontrol : OUT std_logic_vector (2 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE behavior OF ula_control IS
BEGIN
-- ?
END behavior;
