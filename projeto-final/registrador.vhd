LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY registrador IS
PORT	(  
			clk, load, clear: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END registrador;

ARCHITECTURE arq_regs OF registrador IS
BEGIN
	PROCESS(clk, entrada, load, clear)
	BEGIN		
		IF (clk'event AND clk='1') THEN -- escreve na borda de subida
			IF (clear='1') THEN
				saida <= "0000000000000000";
			ELSIF (load='1') THEN
				saida <= entrada;
			END IF;
		END IF;
	END PROCESS;
END arq_regs;