LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY comparator IS
    GENERIC (n: INTEGER := 8);
    PORT (a, b                    : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
          equals, greater, lesser : OUT STD_LOGIC);
END comparator;

ARCHITECTURE bhv OF comparator IS
BEGIN
    equals  <= '1' WHEN a = b ELSE '0';
    greater <= '1' WHEN a > b ELSE '0';
    lesser  <= '1' WHEN a < b ELSE '0';
END bhv;
