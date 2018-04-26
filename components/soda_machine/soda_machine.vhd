LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY soda_machine IS
GENERIC (n: INTEGER := 8);
PORT (rst, clk, c : IN STD_LOGIC;
		s, a 			: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		d 				: OUT STD_LOGIC);
END soda_machine;

ARCHITECTURE bhv OF soda_machine IS

	COMPONENT bc IS
	PORT (rst, clk, c, less   : IN STD_LOGIC;
			d, total_c, total_r : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT bo IS
	PORT (clk, total_c, total_r : IN STD_LOGIC;
			s, a 						 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			less 						 : OUT STD_LOGIC);
	END COMPONENT;

	SIGNAL total_c, total_r, less : STD_LOGIC;

BEGIN
	L0: bc PORT MAP(rst, clk, c, less, d, total_c, total_r);
	L1: bo PORT MAP(clk, total_c, total_r, s, a, less);
END bhv;