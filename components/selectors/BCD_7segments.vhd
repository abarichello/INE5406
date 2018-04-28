LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BCD_7segments IS
PORT (bcd_in        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        f_out         : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END BCD_7segments;

ARCHITECTURE bhv OF BCD_7segments IS
BEGIN
    f_out <= "0000001" when bcd_in = "0000" else	--0
                "1001111" when	bcd_in = "0001" else  --1
                "0010010" when bcd_in = "0010" else  --2
                "0000110" when	bcd_in = "0011" else  --3
                "1001100" when bcd_in = "0100" else	--4
                "0100100" when	bcd_in = "0101" else  --5
                "0100000" when bcd_in = "0110" else  --6
                "0001111" when bcd_in = "0111" else  --7
                "0000000" when bcd_in = "1000" else  --8
                "0000100";
END bhv;
