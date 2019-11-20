LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pc IS
PORT	(	clk, bt, parar: IN STD_LOGIC;
			po_inicio, po_carrega_a, po_carrega_b, po_opera: OUT STD_LOGIC
		);
END pc;

ARCHITECTURE arq_pc OF pc IS

CONSTANT inicio: STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
CONSTANT carrega_a: STD_LOGIC_VECTOR (1 DOWNTO 0) := "01";
CONSTANT carrega_b: STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";
CONSTANT opera: STD_LOGIC_VECTOR (1 DOWNTO 0) := "11";
SIGNAL estado_atual: STD_LOGIC_VECTOR (1 DOWNTO 0) := inicio;

BEGIN
	PROCESS (clk, bt)
	BEGIN
		IF (clk'event AND clk='1') THEN
			IF (estado_atual=inicio AND bt='1') THEN
				estado_atual <= carrega_a;
			ELSIF (estado_atual=carrega_a AND bt='1') THEN
				estado_atual <= carrega_b;
			ELSIF (estado_atual=carrega_b) THEN
				estado_atual <= opera;
			ELSIF (estado_atual=opera AND parar='1') THEN
				estado_atual <= inicio;
			END IF;
		END IF;
		
		IF (estado_atual=inicio) THEN
			po_inicio <= '1';
			po_carrega_a <= '0';
			po_carrega_b <= '0';
			po_opera <= '0';
		ELSIF (estado_atual=carrega_a) THEN
			po_inicio <= '0';
			po_carrega_a <= '1';
			po_carrega_b <= '0';
			po_opera <= '0';
		ELSIF (estado_atual=carrega_b) THEN
			po_inicio <= '0';
			po_carrega_a <= '0';
			po_carrega_b <= '1';
			po_opera <= '0';
		ELSIF (estado_atual=opera) THEN
			po_inicio <= '0';
			po_carrega_a <= '0';
			po_carrega_b <= '0';
			po_opera <= '1';
		END IF;
	END PROCESS;
END arq_pc;