LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY registrador IS
PORT	(  
			clk, load, clear: IN STD_LOGIC;
			i: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END registrador;

ARCHITECTURE arq_regs OF registrador IS
BEGIN
	PROCESS(clk, i, load, clear)
	BEGIN
		IF (clk'event AND clk='1') THEN
			IF (clear='1') THEN
				q <= "0000000000000000";
			ELSIF (load='1') THEN
				q <= i;
			END IF;
		ELSIF (clk'event AND clk='1') THEN
			IF (clear='1') THEN
				q <= "0000000000000000";
			ELSIF (load='1') THEN
				q <= i;
			END IF;
		END IF;
	END PROCESS;
END arq_regs;