LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo IS
GENERIC (n: INTEGER := 8);
PORT (clk, total_c, total_r : IN STD_LOGIC;
		s, a 						 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		less 						 : OUT STD_LOGIC);
END bo;

ARCHITECTURE bhv OF bo IS
	
	COMPONENT total_register IS
	PORT (clk, reset, load : IN STD_LOGIC;
			d                : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			q                : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT adder IS
	PORT (a, b : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			s    : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT less_than IS
	PORT (a, b  : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			less  : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL sum, total: STD_LOGIC_VECTOR (n-1 DOWNTO 0);

	BEGIN
	reg: total_register PORT MAP (clk, total_c, total_r, sum, total);
	som: adder PORT MAP (total, a, sum);
	men: less_than PORT MAP (total, s, less);
	
END bhv;