LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY demux1x4 IS
PORT (a_in, b_in, c_in, d_in : IN STD_LOGIC;
		sel                    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_out                  : OUT STD_LOGIC);
END demux1x4;

ARCHITECTURE bhv OF demux1x4 IS
BEGIN
	PROCESS (a_in, b_in, c_in, d_in, sel) IS
	BEGIN
		IF sel = "00" THEN
			s_out <= a_in;
		ELSIF sel = "01" THEN
			s_out <= b_in;
		ELSIF sel = "10" THEN
			s_out <= c_in;
		ELSE
			s_out <= d_in;
		END IF;
	END PROCESS;
END bhv;
