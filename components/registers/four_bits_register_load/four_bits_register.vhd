LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY four_bits_register IS
GENERIC (N: INTEGER := 4);
PORT (clk, reset, load: IN STD_LOGIC;
		D:                IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		Q:                OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END four_bits_register;

ARCHITECTURE bhv OF four_bits_register IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF (reset = '0') THEN
			Q <= (OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			IF (load = '1') THEN
				Q <= D;
			END IF;
		END IF;
	END PROCESS;
END bhv;
