LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY counter3bits IS
PORT (clk, clear : IN STD_LOGIC;
		output	  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END counter3bits;

ARCHITECTURE bhv OF counter3bits IS
SIGNAL nq0, nq1, nq2: STD_LOGIC;

COMPONENT ffd
PORT ( d, clk, clear : IN STD_LOGIC;
		 q, nq			: OUT STD_LOGIC);
END COMPONENT;

BEGIN
	ff0: ffd PORT MAP(nq0, clk, clear, output(0), nq0);
	ff1: ffd PORT MAP(nq1, nq0, clear, output(1), nq1);
	ff2: ffd PORT MAP(nq2, nq1, clear, output(2), nq2);
END bhv;
