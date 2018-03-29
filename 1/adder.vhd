LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_signed.all;

ENTITY adder IS
PORT (a, b     : IN  SIGNED(15 DOWNTO 0);
      overflow : OUT STD_LOGIC;
		s        : OUT SIGNED(15 DOWNTO 0));
END adder;

ARCHITECTURE bhv OF adder IS
SIGNAL sum: SIGNED(16 DOWNTO 0);

BEGIN
	PROCESS(sum)
	BEGIN
		IF sum(16) = '1' THEN
			overflow <= '1';
		ELSE
			overflow <= '0';
			s <= a + b;
		END IF;
	END PROCESS;
END bhv;