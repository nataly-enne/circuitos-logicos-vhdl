LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY display IS
PORT	(	
			entrada: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC
		);
END display;

ARCHITECTURE arq_display OF display IS

SIGNAL s: STD_LOGIC_VECTOR(0 TO 6);
	
BEGIN
	PROCESS(entrada)
	BEGIN
		IF (entrada="0000") THEN
			s <= "0000001";
		ELSIF (entrada="0001") THEN
			s <= "1001111";
		ELSIF (entrada="0010") THEN
			s <= "0010010";
		ELSIF (entrada="0011") THEN
			s <= "0000110";
		ELSIF (entrada="0100") THEN
			s <= "1001100";
		ELSIF (entrada="0101") THEN
			s <= "0100100";
		ELSIF (entrada="0110") THEN
			s <= "0100000";
		ELSIF (entrada="0111") THEN
			s <= "0001111";
		ELSIF (entrada="1000") THEN
			s <= "0000000";
		ELSIF (entrada="1001") THEN
			s <= "0000100";
		ELSIF (entrada="1010") THEN
			s <= "0001000";
		ELSIF (entrada="1011") THEN
			s <= "1100000";
		ELSIF (entrada="1100") THEN
			s <= "0110001";
		ELSIF (entrada="1101") THEN
			s <= "1000010";
		ELSIF (entrada="1110") THEN
			s <= "0110000";	
		ELSIF (entrada="1111") THEN
			s <= "0111000";
		ELSE
			s <= "1111111";
		END IF;
		
		a <= s(0);
		b <= s(1);
		c <= s(2);
		d <= s(3);
		e <= s(4);
		f <= s(5);
		g <= s(6);
		
	END PROCESS;
END arq_display;