LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY adder IS
GENERIC (n: INTEGER := 8);
PORT (a, b : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      s    : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END adder;

ARCHITECTURE bhv OF adder IS
BEGIN
    s <= a + b;
END bhv;