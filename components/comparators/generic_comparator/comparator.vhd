LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY comparator IS
GENERIC (N: INTEGER := 8);
PORT (A, B:                    IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		EQUALS, GREATER, LESSER: OUT STD_LOGIC);
END comparator;

ARCHITECTURE bhv OF comparator IS
BEGIN
	EQUALS  <= '1' WHEN A = B ELSE '0';
	GREATER <= '1' WHEN A > B ELSE '0';
	LESSER  <= '1' WHEN A < B ELSE '0';
END bhv;
