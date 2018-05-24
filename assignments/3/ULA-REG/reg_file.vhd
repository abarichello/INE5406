LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_file IS
	PORT (clk                           : IN std_logic;
		i_we3                           : IN std_logic;
		i_rAddr1, i_rAddr2, i_wAddr3    : std_logic_vector(4 DOWNTO 0);
		i_wData3                        : IN SIGNED (31 DOWNTO 0);
		o_rReg1, o_rReg2                : OUT SIGNED (31 DOWNTO 0));
END;

ARCHITECTURE behave OF reg_file IS
	TYPE reg_array IS ARRAY(31 DOWNTO 0) OF SIGNED (31 DOWNTO 0);
	SIGNAL mem : reg_array;

	--attribute ramstyle : string;
	--attribute ramstyle of mem : signal is "logic";

BEGIN
	PROCESS(clk) BEGIN
	IF (rising_edge(clk)) THEN
		IF (i_we3 = '1') THEN
			mem(conv_integer(i_wAddr3)) <= i_wData3;
		END IF;
	END IF;
END PROCESS;

PROCESS(i_rAddr1, i_rAddr2)
BEGIN
    IF (conv_integer(i_rAddr1) = 0) THEN
	    o_rReg1 <= (OTHERS => '0');
    ELSE
    	o_rReg1 <= mem(conv_integer(i_rAddr1));
    END IF;

    IF (conv_integer(i_rAddr2) = 0) THEN
    	o_rReg2 <= (OTHERS => '0');
    ELSE
    	o_rReg2 <= mem(conv_integer(i_rAddr2));
    END IF;
END PROCESS;
END behave;
