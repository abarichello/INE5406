LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY right_shifter IS
GENERIC (N: INTEGER := 8);
PORT (r: 		              IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		selection, serial, clk IN STD_LOGIC;
		q:                     BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END right_shifter;

ARCHITECTURE bhv OF right_shifter IS
	SIGNAL signalshift: STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN
	PROCESS(clk)
	BEGIN
		IF clk'EVENT AND clk = '1' THEN
			IF selection = '1' THEN
				q <= r;
			ELSE
				signalshift <= STD_LOGIC_VECTOR(ROTATE_RIGHT(UNSIGNED(signalshift)), 1);
			END IF;
	END PROCESS;
	q <= signalshift;
END bhv;