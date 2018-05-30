LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
	GENERIC (DATA_S : INTEGER := 32);
	PORT (
		a      : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
		b      : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
		sel    : IN std_logic_vector(2 DOWNTO 0);
		result : BUFFER std_logic_vector(DATA_S - 1 DOWNTO 0);
		zero   : OUT std_logic
	);
END ula;

ARCHITECTURE estrutura OF ula IS
	SIGNAL s_sum_sub, s_and_or, s_mux, s_less : std_logic_vector(DATA_S - 1 DOWNTO 0);
	SIGNAL s_sum_sub_signed                   : signed(DATA_S - 1 DOWNTO 0);
	CONSTANT c_zeros                          : std_logic_vector(DATA_S - 1 DOWNTO 0) := (OTHERS => '0');

	COMPONENT sum_sub IS
		GENERIC (DATA_S : INTEGER := 32);
		PORT (
			a   : IN signed(DATA_S - 1 DOWNTO 0);
			b   : IN signed(DATA_S - 1 DOWNTO 0);
			sel : IN std_logic;
			s   : OUT signed(DATA_S - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT and_or IS
		GENERIC (DATA_S : INTEGER := 32);
		PORT (
			a   : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
			b   : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
			sel : IN std_logic;
			s   : OUT std_logic_vector(DATA_S - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2x1 IS
		GENERIC (N : INTEGER := 32);
		PORT (
			a   : IN std_logic_vector (N - 1 DOWNTO 0);
			b   : IN std_logic_vector (N - 1 DOWNTO 0);
			sel : IN std_logic;
			s   : OUT std_logic_vector (N - 1 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	ss0 : sum_sub GENERIC MAP(DATA_S => DATA_S) PORT MAP(signed(a), signed(b), sel(2), s_sum_sub_signed);
	s_sum_sub <= std_logic_vector(s_sum_sub_signed);
	ao0 : and_or GENERIC MAP(DATA_S => DATA_S) PORT MAP(a, b, sel(0), s_and_or);
	mu0 : mux2x1 GENERIC MAP(N      => DATA_S)PORT MAP(s_and_or, s_sum_sub, sel(1), s_mux);

	s_less(31 DOWNTO 1) <= (OTHERS  => '0');
	s_less(0)           <= s_mux(31);

	result              <= s_less WHEN sel = "111" ELSE s_mux;
	zero                <= '1' WHEN result = c_zeros ELSE '0';

END estrutura;
