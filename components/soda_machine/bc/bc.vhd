LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (rst, clk, c, less   : IN STD_LOGIC;
		d, total_c, total_r : OUT STD_LOGIC);
END bc;

ARCHITECTURE bhv OF bc IS
	TYPE state_t IS (START, AWAIT, SUM, UNLOCK);
	SIGNAL cs, ns: state_t; -- current state

	BEGIN
		P1: PROCESS (clk, rst) -- CLOCK
		BEGIN
			IF rst = '1' THEN
				cs <= START;
			ELSIF rising_edge(clk) THEN
				cs <= ns;
			END IF;
		END PROCESS;
	
		P2: PROCESS (cs, ns) -- STATE LOGIC
		BEGIN
			CASE cs IS
				WHEN START =>
					ns <= AWAIT;
				
				WHEN AWAIT =>
					IF c = '0' AND less = '0' THEN
						ns <= UNLOCK;
					ELSIF c = '0' AND less = '1' THEN
						ns <= AWAIT;
					ELSIF c = '1' THEN
						ns <= SUM;
					END IF;
				
				WHEN SUM =>
					ns <= AWAIT;
					
				WHEN UNLOCK =>
					ns <= START;
				
			END CASE;
		END PROCESS;
		
		P3: PROCESS(cs)  -- OUTPUT
		BEGIN
			CASE cs IS
				WHEN START =>
					total_r <= '1';
					total_c <= '0';
					d <= '0';
				
				WHEN AWAIT =>
					total_r <= '0';
					total_c <= '0';
					d <= '0';
					
				WHEN SUM =>
					total_r <= '0';
					total_c <= '1';
					d <= '0';
					
				WHEN UNLOCK =>
					total_r <= '0';
					total_c <= '0';
					d <= '1';
					
			END CASE;
		END PROCESS;
END bhv;