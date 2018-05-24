LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top IS
    PORT(clk 						 : IN STD_LOGIC;
        load_en						 : IN STD_LOGIC;
        loadValue 					 : IN SIGNED(31 DOWNTO 0);
        i_we3 						 : IN STD_LOGIC;
        i_rAddr1, i_rAddr2, i_wAddr3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
        ulaOp 						 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        funct 						 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        read1 						 : OUT SIGNED(31 DOWNTO 0);
        read2 						 : OUT SIGNED(31 DOWNTO 0);
        written1 					 : OUT SIGNED(31 DOWNTO 0));
END entity;

ARCHITECTURE estrutura OF top IS
    COMPONENT reg_file IS
        PORT(clk                         : IN STD_LOGIC;
            i_we3                        : IN STD_LOGIC;
            i_rAddr1, i_rAddr2, i_wAddr3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_wData3 					 : IN SIGNED(31 DOWNTO 0);
            o_rReg1, o_rReg2 			 : OUT SIGNED(31 DOWNTO 0));
    END COMPONENT;

    COMPONENT ULA_Wrapper IS
        PORT(a 	  : IN SIGNED(31 DOWNTO 0);
            b     : IN SIGNED(31 DOWNTO 0);
            ulaOp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            s     : OUT SIGNED(31 DOWNTO 0));
    END COMPONENT;

    SIGNAL saiULA : OUT SIGNED(31 DOWNTO 0);

BEGIN
    i_wData3 <= loadValue WHEN load_en = '1' ELSE saiULA;
    ula_1: ULA_Wrapper PORT MAP(o_rReg1, o_rReg2, ulaOp, funct, saiULA);
    regFile_1: reg_file PORT MAP(clk, i_we3, i_rAddr1, i_rAddr2, i_wAddr3, i_wData3, o_rReg1, o_rReg2);

    read1 <= o_rReg1;
    read2 <= o_rReg2;
    written1 <= i_wData3;
END estrutura;
