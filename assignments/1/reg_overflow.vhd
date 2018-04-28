LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY reg_overflow IS
PORT (clk : IN STD_LOGIC;
      d   : IN STD_LOGIC;
      q   : OUT STD_LOGIC);
END reg_overflow;

ARCHITECTURE bhv OF reg_overflow IS
BEGIN
    PROCESS(clk)
    BEGIN
        IF (RISING_EDGE(clk)) THEN
                q <= d;
        END IF;
    END PROCESS;
END bhv;