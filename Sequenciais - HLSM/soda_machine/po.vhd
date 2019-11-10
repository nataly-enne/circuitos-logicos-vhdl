-- código do slide --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY po IS
	PORT( 
		clock, tot_ld, tot_clr : IN STD_LOGIC;
		s, a: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		tot_lt_s: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE behavior OF po IS
	
	SIGNAL tot_saida: STD_LOGIC_VECTOR (7 DOWNTO 0) := A;
	
	BEGIN
		
		PROCESS (clock, tot_ld, tot_clr, tot_saida)
		
		VARIABLE tot_soma: STD_LOGIC_VECTOR (7 DOWNTO 0);
		
		BEGIN
			IF (clock'event AND clock = '1') THEN
				IF (tot_ld = '1') THEN
					tot_soma := tot_saida + a;
					tot_saida <= tot_soma;
				END IF;
				IF (tot_clr = '1') THEN
					tot_saida <= "00000000";
				END IF;
			END IF;
			IF (tot_saida >= s) THEN
				tot_lt_s <= '0';
			ELSE
				tot_lt_s <= '1';
			END IF;
		END PROCESS;
END behavior;