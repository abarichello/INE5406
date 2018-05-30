LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_counter IS
	GENERIC (
		MIN_COUNT : NATURAL := 0;
		MAX_COUNT : NATURAL := 255
	);

	PORT (
		clk    : IN std_logic;
		reset  : IN std_logic;
		enable : IN std_logic;
		q      : OUT INTEGER RANGE MIN_COUNT TO MAX_COUNT
	);

END ENTITY;

ARCHITECTURE rtl OF pc_counter IS
BEGIN

END rtl;
