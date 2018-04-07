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
SIGNAL locala, localb, sum: SIGNED(16 DOWNTO 0); -- One bit more than input
SIGNAL localflow: STD_LOGIC;
SIGNAL sumout: SIGNED(16 DOWNTO 0);

BEGIN
	locala <= RESIZE((a), 17);
	localb <= RESIZE((b), 17);
	sum <= locala + localb;
	--overflow occurs when bit 16 is not equal to sign bit 15
	localflow <= '1' when sum(15) /= sum(4);
	sumout <= SIGNED(sum);
	overflow <= localflow;
	s <= sumout(16)&sum(14 DOWNTO 0); 
END bhv;
