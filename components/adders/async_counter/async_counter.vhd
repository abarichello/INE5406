LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY async_counter is
PORT (r                : IN INTEGER RANGE 0 TO 15;
      clk, clear, load : IN STD_LOGIC;
      q                : BUFFER INTEGER RANGE 0 TO 15);
END async_counter;

ARCHITECTURE bhv OF async_counter IS
BEGIN
    PROCESS(clk, clear)
    BEGIN
        IF clear = '0' THEN
            q <= 0;
        ELSIF (clk'EVENT and clk = '1') THEN
            IF load = '1' THEN
                q <= r;
            ELSE
                q <= q + 1;
            END IF;
        END IF;
    END PROCESS;
END bhv;
