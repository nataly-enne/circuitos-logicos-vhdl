LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY registrador IS
PORT 	(  
			i: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			clk, load: IN STD_LOGIC;
            q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END registrador;

ARCHITECTURE arq_regs OF registrador IS
BEGIN
    PROCESS(clk, i, load)
    BEGIN
        IF (clk'event AND clk='1' AND load='1') THEN
            q <= i;
        END IF;
    END PROCESS;
END arq_regs;