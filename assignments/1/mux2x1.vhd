LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux2x1 IS
GENERIC (n: INTEGER := 16);
PORT (sel  : IN STD_LOGIC;
      w, x : IN SIGNED(n-1 DOWNTO 0);
       m    : OUT SIGNED(n-1 DOWNTO 0));
END mux2x1;

ARCHITECTURE bhv OF mux2x1 IS
BEGIN
    m <= w WHEN sel = '0' ELSE x;
end bhv;