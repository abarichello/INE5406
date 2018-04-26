LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY total_register IS
GENERIC (n: INTEGER := 8);
PORT (clk, reset, load : IN STD_LOGIC;
      d                : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      q                : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END total_register;

ARCHITECTURE bhv OF total_register IS
BEGIN
    PROCESS(clk)
    BEGIN
        IF (reset = '0') THEN
            q <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            IF (load = '1') THEN
                q <= d;
            END IF;
        END IF;
    END PROCESS;
END bhv;