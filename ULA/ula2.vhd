LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY ula2 IS
PORT 	(  
			a: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			seletor: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END ula2;

ARCHITECTURE arq OF ula2 IS

SIGNAL r0: std_logic_vector(15 downto 0);
SIGNAL r1: std_logic_vector(15 downto 0);
SIGNAL o: std_logic_vector(2 downto 0);
	
BEGIN
	PROCESS(a, seletor)
	BEGIN
		IF(seletor="00") THEN
			r0 <= a;
		ELSIF(seletor="01") THEN
			r1 <= a;
		ELSIF(seletor="10") THEN
			o <= a(2 DOWNTO 0);
		ELSIF(seletor="11") THEN
			s <= "1000000000000000";
		END IF;
		
		IF o="000" THEN
			s <= r0 + r1;
		ELSIF o="001" THEN
			s <= r0 - r1;
		ELSIF o="010" THEN
			s <= r0(15 DOWNTO 1) & '1';
		ELSIF o="011" THEN
			s <= '1' & r0(14 DOWNTO 0);
		ELSIF o="100" THEN
			s <= r0 AND r1;
		ELSIF o="101" THEN
			s <= r0 OR r1;
		ELSIF o="110" THEN
			s <= r0 XOR r1;
		ELSIF o="111" THEN
			s <= NOT r0;
		END IF;
	END PROCESS;
END arq;