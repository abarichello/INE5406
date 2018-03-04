LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY 1bitadder IS
    PORT (cin, a, b : IN STD_LOGIC;
            s, cout : OUT STD_LOGIC);
END 1bitadder;

ARCHITECTURE bhv OF 1bitadder IS
BEGIN
    s <= a XOR b XOR cin;
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END bhv;