LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

ENTITY ula IS
PORT 	(  
			a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			operacao: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END ula;

ARCHITECTURE arq_ula OF ula IS

BEGIN
	PROCESS(a, b, operacao)
	BEGIN		
		IF (operacao="0000" OR operacao="0001" OR operacao="1100" OR operacao="1110") THEN
			s <= a + b;
		ELSIF (operacao="0010" OR operacao="0011") THEN
			s <= a - b;
		ELSIF (operacao="0100") THEN
			s <= STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(a), 1));
		ELSIF (operacao="0101") THEN
			s <= STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(a), TO_INTEGER(UNSIGNED(b(5 DOWNTO 0)))));
		ELSIF (operacao="0110") THEN
			s <= STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(a), 1));
		ELSIF (operacao="0111") THEN
			s <= STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(a), TO_INTEGER(UNSIGNED(b(5 DOWNTO 0)))));
		ELSIF (operacao="1000") THEN
			s <= a AND b;
		ELSIF (operacao="1001") THEN
			s <= a NAND b;
		ELSIF (operacao="1010") THEN
			s <= a OR b;
		ELSIF (operacao="1011") THEN
			s <= a XOR b;
		END IF;
	END PROCESS;
END arq_ula;