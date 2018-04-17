LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_b IS
GENERIC (n: INTEGER := 16);
PORT (clk     : IN STD_LOGIC;
      d       : IN SIGNED(n-1 DOWNTO 0);
      q       : OUT SIGNED(n-1 DOWNTO 0);
		sel_out : OUT SIGNED(n-1 DOWNTO 0));
END register_b;

ARCHITECTURE bhv OF register_b IS
BEGIN
    PROCESS(clk)
    BEGIN
        IF (RISING_EDGE(clk)) THEN
				q <= d;
        END IF;
    END PROCESS;
END bhv;