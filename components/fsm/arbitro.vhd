LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY arbitro IS
	PORT ( clk, reset : IN STD_LOGIC;
			 r          : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			 c          : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END arbitro;

ARCHITECTURE bhv OF arbitro IS
	TYPE STATES_E IS (E0, E1, E2, E3);
	SIGNAL cs, ns : STATES_E; -- CS: current state NS: next state
	SIGNAL x		  : STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	BEGIN
		P1: PROCESS(clk, x)
		BEGIN
			IF reset = '0' then
				cs <= E0;
			ELSIF clk'EVENT AND clk = '1' THEn
				cs <= ns;
			END IF;
		END PROCESS;
		
		P2: PROCESS(cs, x)
		BEGIN
			CASE CS IS
				WHEN E0 =>
					IF x = "000" THEN
						NS <= E0;
					ELSIF x(2) = '1' THEN
						NS <= E1;
					ELSIF x(2) = '0' AND x(1) = '1' THEN
						NS <= E2;
					ELSIF x = "001" THEN
						NS <= E3;
					END IF;
					
				WHEN E1 =>
					IF x(2) = '0' THEN
						NS <= E0;
					ELSE
						NS <= E1;
					END IF;
					
				WHEN E2 =>
					IF x(1) = '0' THEN
						NS <= E0;
					ELSE
						NS <= E2;
					END IF;
					
				WHEN E3 =>
					IF x(0) = '0' THEN
						NS <= E0;
					ELSE
						NS <= E3;
					END IF;
			END CASE;
		END PROCESS;
		
		P3: PROCESS(CS) -- OUTPUTS
		BEGIN
			CASE CS IS
				WHEN E0 =>
					c <= "000";
				WHEN E1 =>
					c <= "100";
				WHEN E2 =>
					c <= "010";
				WHEN E3 =>
					c <= "001";
			END CASE;
		END PROCESS;
END bhv;
		