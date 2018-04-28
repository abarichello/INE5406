LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY less_than IS
GENERIC (n: INTEGER := 8);
PORT (a, b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      less : OUT STD_LOGIC);
END less_than;

ARCHITECTURE bhv OF less_than IS
BEGIN
    less <= '1' WHEN a < b ELSE '0';
END bhv;