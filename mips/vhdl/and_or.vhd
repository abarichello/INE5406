LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY and_or IS
    GENERIC (DATA_S : INTEGER := 32);
    PORT (
        a   : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
        b   : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
        sel : IN std_logic;
        s   : OUT std_logic_vector(DATA_S - 1 DOWNTO 0)
    );
END and_or;

ARCHITECTURE behavior OF and_or IS
BEGIN
    s <= (a OR b) WHEN sel = '1' ELSE
         (a AND b);
END behavior;
