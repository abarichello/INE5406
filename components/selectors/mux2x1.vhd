LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2x1 IS
GENERIC (n: INTEGER := 8);
PORT (sel  : IN STD_LOGIC;
      w, x : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      m    : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END mux2x1;

ARCHITECTURE bhv OF mux2x1 IS
BEGIN
    m <= w WHEN sel = '0' ELSE x;
end bhv;
