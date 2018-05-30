LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY datapath IS
    GENERIC (DATA_S : INTEGER := 32; INSTRUCT_S : INTEGER := 26; ADDR_S : INTEGER := 5);
    PORT (
        dbg_mux_wAddr                                                                        : OUT std_logic_vector(ADDR_S - 1 DOWNTO 0);
        dbg_mux_wData3, dbg_mux2ula, dbg_ula_result, dbg_reg1, dbg_reg2, dbg_signal_extender : OUT std_logic_vector(DATA_S - 1 DOWNTO 0);
        dbg_zero                                                                             : OUT std_logic;
        dbg_reg_addr1, dbg_reg_addr2                                                         : OUT std_logic_vector(ADDR_S - 1 DOWNTO 0);
        dbg_ula_OpFunct                                                                      : OUT std_logic_vector(7 DOWNTO 0);

        clk, rst                                                                             : IN std_logic;
        i_instruction                                                                        : IN std_logic_vector(INSTRUCT_S - 1 DOWNTO 0);
        i_control                                                                            : IN std_logic_vector(5 DOWNTO 0);
        i_dataMem                                                                            : IN std_logic_vector(DATA_S - 1 DOWNTO 0);
        o_pc                                                                                 : OUT INTEGER RANGE 0 TO 255;
        o_ula_result                                                                         : OUT std_logic_vector(DATA_S - 1 DOWNTO 0);
		o_rReg1                                                                              : OUT std_logic_vector(DATA_S - 1 DOWNTO 0)
	);
END datapath;

ARCHITECTURE behavior OF datapath IS
    COMPONENT pc_counter IS
        GENERIC (MIN_COUNT : NATURAL := 0; MAX_COUNT : NATURAL := 255);
        PORT (
            clk    : IN std_logic;
            reset  : IN std_logic;
            enable : IN std_logic;
            q      : OUT INTEGER RANGE MIN_COUNT TO MAX_COUNT
        );
    END COMPONENT;

    COMPONENT reg_file IS
        GENERIC (DATA_S : INTEGER := 32; N_REGS : INTEGER := 32; ADDR_S : INTEGER := 5);
        PORT (
            clk                          : IN std_logic;
            i_we3                        : IN std_logic;
            i_rAddr1, i_rAddr2, i_wAddr3 : std_logic_vector(ADDR_S - 1 DOWNTO 0);
            i_wData3                     : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
            o_rReg1, o_rReg2             : OUT std_logic_vector (DATA_S - 1 DOWNTO 0)
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

    COMPONENT ula_wrapper IS
        GENERIC (DATA_S : INTEGER := 32);
        PORT (
            a      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
            b      : IN std_logic_vector (DATA_S - 1 DOWNTO 0);
            ulaop  : IN std_logic_vector (1 DOWNTO 0);
            funct  : IN std_logic_vector (5 DOWNTO 0);
            result : OUT std_logic_vector (DATA_S - 1 DOWNTO 0);
            zero   : OUT std_logic
        );
    END COMPONENT;

    COMPONENT signal_extender IS
        GENERIC (N_IN : INTEGER := 16; N_OUT : INTEGER := 32);
        PORT (
            in_value  : IN std_logic_vector(N_IN - 1 DOWNTO 0);
            out_value : OUT std_logic_vector(N_OUT - 1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
END behavior;
