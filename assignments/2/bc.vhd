LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (reset, clk, inicio, zero   : IN STD_LOGIC;
      pronto, Cco, Dco, Cac, Rac : OUT STD_LOGIC);
END bc;

ARCHITECTURE bhv OF bc IS
   TYPE state_type IS (S0, S1, S2, S3);
   SIGNAL cs, ns: state_type;  -- current state/next state

BEGIN
    P1: PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            cs <= S0;
        ELSIF rising_edge(clk) THEN
            cs <= ns;
        END IF;
    END PROCESS;
            
    P2: PROCESS(cs, ns)
    BEGIN
        CASE cs IS
            WHEN S0 =>
                IF inicio = '0' THEN
                    ns <= S0;
                ELSE
                    ns <= S1;
                END IF;
            WHEN S1 =>
                IF zero = '0' THEN
                    ns <= S2;
                ELSE
                    ns <= S3;
                END IF;
            WHEN S2 =>
                ns <= S1;
            WHEN S3 =>
                ns <= S0;
            END CASE;
    END PROCESS;
    
    P3: PROCESS(cs)
    BEGIN
        CASE cs IS
            WHEN S0 =>
               pronto <= '1';
                Cco <= '1';
                Dco <= '0';
                Cac <= '0';
                Rac <= '1';
            WHEN S1 =>
                pronto <= '0';
                Cco <= '0';
                Dco <= '0';
                Cac <= '0';
                Rac <= '0';
            WHEN S2 =>
                pronto <= '0';
                Cco <= '0';
                Dco <= '1';
                Cac <= '1';
                Rac <= '0';
            WHEN S3 =>
                pronto <= '1';
                Cco <= '0';
                Dco <= '0';
                Cac <= '0';
                Rac <= '0';
        END CASE;
    END PROCESS;
END bhv;
