LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY fourbitsadder IS
PORT (a, b: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		s:    OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END fourbitsadder;

ARCHITECTURE bhv OF fourbitsadder IS
BEGIN
	s <= a + b;
END bhv;