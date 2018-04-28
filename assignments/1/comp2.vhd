LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comp2 IS
GENERIC (n: INTEGER := 16);
PORT (a_in  : IN SIGNED(n-1 DOWNTO 0);
        s_out : OUT SIGNED(N-1 DOWNTO 0));
END comp2;

ARCHITECTURE bhv OF comp2 IS
SIGNAL tmp : SIGNED(n-1 DOWNTO 0);

BEGIN
    tmp <= NOT a_in;
     s_out <= SIGNED(tmp + 1);
end bhv;