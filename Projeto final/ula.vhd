LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY ula IS
PORT 	(  
			a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			operacao: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END ula;

ARCHITECTURE arq_ula OF ula IS	
BEGIN
	PROCESS(a, b, seletor)
	BEGIN
		IF operacao="000" THEN
			s <= a + b;
		ELSIF operacao="001" THEN
			s <= a - b;
		ELSIF operacao="010" THEN
			s <= a(15 DOWNTO 1) & b;
		ELSIF operacao="011" THEN
			s <= b & a(14 DOWNTO 0);
		ELSIF operacao="100" THEN
			s <= a AND b;
		ELSIF operacao="101" THEN
			s <= a NAND b;
		ELSIF operacao="110" THEN
			s <= a OR b;
		ELSIF operacao="111" THEN
			s <= a XOR b;
		END IF;
	END PROCESS;
END arq_ula;