LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY registrador IS
PORT 	(  
			i: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			load, clear: IN STD_LOGIC;
         q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END registrador;

ARCHITECTURE arq_regs OF registrador IS
BEGIN
    PROCESS(i, load, clear)
    BEGIN
			IF (clear='1') THEN
				 q <= "0000000000000000";
			ELSIF (load='1') THEN
				 q <= i;
			END IF;
    END PROCESS;
END arq_regs;