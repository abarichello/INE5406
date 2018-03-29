LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ULA IS
GENERIC (n: INTEGER := 16);
PORT (SW       : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		a_in     : IN SIGNED(n-1 DOWNTO 0);
		b_in     : IN SIGNED(n-1  DOWNTO 0);
		clk      : IN STD_LOGIC;
		sel      : IN STD_LOGIC;
		overflow : OUT STD_LOGIC;
		s_out    : OUT SIGNED(n-1  DOWNTO 0));
END ULA;

ARCHITECTURE bhv OF ULA IS

COMPONENT register_a
GENERIC (n: INTEGER := 16);
PORT (clk : IN STD_LOGIC;
      d   : IN SIGNED(n-1 DOWNTO 0);
      q   : OUT SIGNED(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT register_b
GENERIC (n: INTEGER := 16);
PORT (clk     : IN STD_LOGIC;
      d       : IN SIGNED(n-1 DOWNTO 0);
      q       : OUT SIGNED(n-1 DOWNTO 0);
		sel_out : OUT SIGNED(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT comp2
GENERIC (n: INTEGER := 16);
PORT (a_in  : IN SIGNED(n-1 DOWNTO 0);
		s_out : OUT SIGNED(N-1 DOWNTO 0));
END COMPONENT;

COMPONENT mux2x1
GENERIC (n: INTEGER := 16);
PORT (sel  : IN STD_LOGIC;
      w, x : IN SIGNED(n-1 DOWNTO 0);
	   m    : OUT SIGNED(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT adder
PORT (a, b     : IN  SIGNED(n-1 DOWNTO 0);
      overflow : OUT STD_LOGIC;
		s        : OUT SIGNED(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT reg_overflow IS
PORT (clk : IN STD_LOGIC;
      d   : IN STD_LOGIC;
      q   : OUT STD_LOGIC);
END COMPONENT;

SIGNAL regA_to_adder : SIGNED(n-1 DOWNTO 0);
SIGNAL regB_to_sel   : SIGNED(n-1 DOWNTO 0);
SIGNAL regB_to_comp2 : SIGNED(n-1 DOWNTO 0);
SIGNAL comp2_to_sel  : SIGNED(n-1 DOWNTO 0);
SIGNAL sel_to_adder  : SIGNED(n-1 DOWNTO 0);
SIGNAL adder_to_mux  : SIGNED(n-1 DOWNTO 0);
SIGNAL mux_to_regA   : SIGNED(n-1 DOWNTO 0);
SIGNAL adder_to_of   : STD_LOGIC;

BEGIN
	L0:
		register_a PORT MAP(
			clk, mux_to_regA, regA_to_adder
			);
	
	L1:
		register_b PORT MAP(
			clk, b_in, regB_to_comp2, regB_to_sel
		);
		
	L2:
		comp2 PORT MAP(
			regB_to_comp2, comp2_to_sel
		);
	
	L3:
		mux2x1 PORT MAP(
			sel, comp2_to_sel, regB_to_sel, sel_to_adder
		);
	
	L4:
		adder PORT MAP(
			regA_to_adder, sel_to_adder, adder_to_of, s_out
		);
	
	L5:
		mux2x1 PORT MAP(
			SW(0), a_in, adder_to_mux, mux_to_regA
		);
		
	L6:
		reg_overflow PORT MAP(
			clk, adder_to_of, overflow
		);

END bhv;