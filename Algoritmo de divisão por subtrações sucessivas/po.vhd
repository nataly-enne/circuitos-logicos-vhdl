LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY po IS
PORT	(	clk, po_inicio, po_carrega_a, po_carrega_b, po_opera: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			quociente, resto: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			parar: OUT STD_LOGIC
		);
END po;

ARCHITECTURE arq_po OF po IS

SIGNAL a, b, q, r: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
	PROCESS (clk, po_inicio, po_carrega_a, po_carrega_b, po_opera)
	BEGIN
		IF (clk'event AND clk='1') THEN
			IF (po_inicio='1') THEN
				a <= "0000000000000000";
				b <= "0000000000000000";
				q <= "0000000000000000";
				r <= "0000000000000000";
			ELSIF (po_carrega_a='1') THEN
				a <= entrada;
			ELSIF (po_carrega_b='1') THEN
				b <= entrada;
			ELSIF (po_opera='1' AND a>=b) THEN
				q <= q + "0000000000000001";
				a <= a - b;
				r <= a;
			END IF;
		END IF;
		
		IF (a<b) THEN
			parar <= '1';
			r <= a;
		ELSE
			parar <= '0';
		END IF;
		
		quociente <= q;
		resto <= r;
		
	END PROCESS;
END arq_po;