LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use std.env.all;                            

ENTITY top_vhd_tst IS
END top_vhd_tst;

ARCHITECTURE top_arch OF top_vhd_tst IS                                                  
SIGNAL clk : STD_LOGIC;
SIGNAL entA : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL entB : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL inicio : STD_LOGIC;
SIGNAL pronto : STD_LOGIC;
SIGNAL Reset : STD_LOGIC;
SIGNAL saida : STD_LOGIC_VECTOR(3 DOWNTO 0);

COMPONENT top
	PORT (
	clk : IN STD_LOGIC;
	entA : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	entB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	inicio : IN STD_LOGIC;
	pronto : OUT STD_LOGIC;
	Reset : IN STD_LOGIC;
	saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

--constants
	constant PERIOD : time := 50 ns;
	
	--simulation signals
	signal e_saida	:	STD_LOGIC_VECTOR(3 downto 0);
	file test_file: TEXT;
	signal idx_test : integer;
BEGIN
	i1 : top
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	entA => entA,
	entB => entB,
	inicio => inicio,
	pronto => pronto,
	Reset => Reset,
	saida => saida
	);
	
	process 
	BEGIN
		clk <= '1';
		wait for PERIOD/2;
		clk <= '0';
		wait for PERIOD/2;
	end process;                                                     
                                      
always : PROCESS
		variable v_line : line;

		variable v_entA : integer;
		variable v_entB : integer;
		variable v_saida : integer; 		
		variable v_skip : character;
		
	BEGIN                                                         
		file_open(test_file, "/home/usuario/mutiplicador/test.txt", read_mode);
		idx_test <= 0;
		while not endfile(test_file) loop
			-- set variables (first step) 
			-- read values
			readline(test_file, v_line);
			
			read(v_line, v_entA);
			read(v_line, v_skip);
			read(v_line, v_entB);
			read(v_line, v_skip);
			read(v_line, v_saida);
			
			wait for PERIOD/2;
			
			-- set signals
			entA <= std_logic_vector(to_unsigned(v_entA, 4));
			entB <= std_logic_vector(to_unsigned(v_entB, 4));
			e_saida <= std_logic_vector(to_unsigned(v_saida, 4));
			
			inicio <= '1';
			
			wait for PERIOD/2;
			
			-- process (second step)
			wait until pronto = '1'; -- wait until true condition
			--wait until clk = '1'; -- Resync simulation with clk period. Can be eliminated in simulation without delay. 
			
			-- verification (third step)
			ASSERT (saida = e_saida) -- if false issues report string
				REPORT "Output is wrong."
				SEVERITY ERROR;

			idx_test <= idx_test+1;
		end loop;
		file_close(test_file);
		ASSERT false
			REPORT  "Test finished!"
			SEVERITY note;
		stop(0);                                                  
	END PROCESS always;
												  
END top_arch;
