LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decodificador IS
PORT	(	
			entrada: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3)
		);
END decodificador;

ARCHITECTURE arq_decodificador OF decodificador IS

COMPONENT display IS
PORT	(	
			entrada: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC
		);
END COMPONENT;

BEGIN

	display1: display PORT MAP (entrada(3 DOWNTO 0), a(0), b(0), c(0), d(0), e(0), f(0), g(0));
	display2: display PORT MAP (entrada(7 DOWNTO 4), a(1), b(1), c(1), d(1), e(1), f(1), g(1));
	display3: display PORT MAP (entrada(11 DOWNTO 8), a(2), b(2), c(2), d(2), e(2), f(2), g(2));
	display4: display PORT MAP (entrada(15 DOWNTO 12), a(3), b(3), c(3), d(3), e(3), f(3), g(3));
	
END arq_decodificador;