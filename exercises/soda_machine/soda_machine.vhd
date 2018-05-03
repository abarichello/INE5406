LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY soda_machine IS
GENERIC (n: INTEGER := 8);
PORT (clk, rst, c : IN STD_LOGIC;
      s, a 	      : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      d           : OUT STD_LOGIC);
END soda_machine;

ARCHITECTURE bhv OF soda_machine IS
    COMPONENT bc IS
    PORT (clk, rst, c, less   : IN STD_LOGIC;
          d, total_c, total_r : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT bo IS
    PORT (clk, total_c, total_r : IN STD_LOGIC;
          s, a 					: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
          less 					: OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL s_total_c, s_total_r, s_less, s_d : STD_LOGIC;

BEGIN
    L0: bc PORT MAP(clk, rst, c, s_less, s_d, s_total_c, s_total_r);
    L1: bo PORT MAP(clk, s_total_c, s_total_r, s, a, s_less);
    d <= s_d;
END bhv;