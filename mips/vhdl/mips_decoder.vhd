LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mips_decoder IS
    PORT (
        instruction : IN std_logic_vector(5 DOWNTO 0);
        control     : OUT std_logic_vector(6 DOWNTO 0)
        -- 5 (to datapath without jump/branch) [sel_DVI(7), sel_DVC(6), sel_wAddr(5), sel_wData3(4), sel_mux2ula(3), regfile_we(2), ula_op(1 downto 0) ] 0
        -- 6 [write_mem(6)]
    );
END ENTITY;
ARCHITECTURE behavior OF mips_decoder IS

BEGIN
    PROCESS (ALL) BEGIN
    CASE instruction IS
        WHEN "000000" =>
            control(1 DOWNTO 0) <= "10"; -- ula_op
            control(2)          <= '1'; -- regfile_we
            control(3)          <= '0'; -- sel_mux2ula
            control(4)          <= '0'; -- sel_wData3
            control(5)          <= '1'; -- sel_wAddr
            --control(6)<= '0'; -- sel_DVC
            --control(7)<= '0'; -- sel_DVI
            --control(8)<= '0'; -- read_mem
            control(6) <= '0'; -- write_mem

        WHEN "100011" =>
            control(1 DOWNTO 0) <= "00"; -- ula_op
            control(2)          <= '1'; -- regfile_we
            control(3)          <= '1'; -- sel_mux2ula
            control(4)          <= '1'; -- sel_wData3
            control(5)          <= '0'; -- sel_wAddr
            --control(6)<= '0'; -- sel_DVC
            --control(7)<= '0'; -- sel_DVI
            --control(8)<= '1'; -- read_mem
            control(6) <= '0'; -- write_mem

        WHEN "101011" =>
            control(1 DOWNTO 0) <= "00"; -- ula_op
            control(2)          <= '0'; -- regfile_we
            control(3)          <= '1'; -- sel_mux2ula
            control(4)          <= '0'; -- sel_wData3
            control(5)          <= '0'; -- sel_wAddr
            --control(6)<= '0'; -- sel_DVC
            --control(7)<= '0'; -- sel_DVI
            --control(8)<= '0'; -- read_mem
            control(6) <= '1'; -- write_mem

            --when "000100" =>
            -- control(1 downto 0)<= "01"; -- ula_op
            -- control(2)<= '0'; -- regfile_we
            -- control(3)<= '0'; -- sel_mux2ula
            -- control(4)<= '0'; -- sel_wData3
            -- control(5)<= '0'; -- sel_wAddr
            -- --control(6)<= '1'; -- sel_DVC
            -- --control(7)<= '0'; -- sel_DVI
            -- --control(8)<= '0'; -- read_mem
            -- control(6)<= '0'; -- write_mem
            --when "000010" =>
            -- control(1 downto 0)<= "00"; -- ula_op
            -- control(2)<= '0'; -- regfile_we
            -- control(3)<= '0'; -- sel_mux2ula
            -- control(4)<= '0'; -- sel_wData3
            -- control(5)<= '0'; -- sel_wAddr
            -- --control(6)<= '0'; -- sel_DVC
            -- --control(7)<= '1'; -- sel_DVI
            -- --control(8)<= '0'; -- read_mem
            -- control(6)<= '0'; -- write_mem
        WHEN OTHERS =>
            control <= "0000000";
    END CASE;
END PROCESS;

END behavior;
