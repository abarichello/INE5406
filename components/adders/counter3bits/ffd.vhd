LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ffd IS
PORT ( d, clk, clear : IN STD_LOGIC;
		 q, nq			: OUT STD_LOGIC);
END ffd;

ARCHITECTURE bhv OF ffd IS
BEGIN
	PROCESS(clk, clear)
	BEGIN
		IF clear = '1' THEN
			q <= '0';
			nq <= '1';
		ELSIF clk'EVENT AND clk='1' THEN
			q <= d;
			nq <= not d;
		END IF;
	END PROCESS;
END bhv;
