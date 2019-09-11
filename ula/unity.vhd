LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY unity IS
	PORT (	
		a, b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		U, S1, S0: IN STD_LOGIC;
		S: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		c: OUT STD_LOGIC
	);
END unity;

ARCHITECTURE behavior OF unity IS

	COMPONENT sum IS
		PORT (	
			a, b, CIN: IN STD_LOGIC;
			S, COUT: OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT arithmetic IS
		PORT (	
			S1, S0, U, b: IN STD_LOGIC;
			cout: OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT logic IS
		PORT (	
			S1, S0, a, b, U: IN STD_LOGIC;
			cout: OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL AUX: STD_LOGIC_VECTOR(0 TO 22);
	SIGNAL CARRY: STD_LOGIC;

	BEGIN
		a1: arithmetic PORT MAP (U, S1, S0, b(0), AUX(0));
		a2: arithmetic PORT MAP (U, S1, S0, b(1), AUX(1));
		a3: arithmetic PORT MAP (U, S1, S0, b(2), AUX(2));
		a4: arithmetic PORT MAP (U, S1, S0, b(3), AUX(3));
		a5: arithmetic PORT MAP (U, S1, S0, b(4), AUX(4));
		a6: arithmetic PORT MAP (U, S1, S0, b(5), AUX(5));
		a7: arithmetic PORT MAP (U, S1, S0, b(6), AUX(6));
		a8: arithmetic PORT MAP (U, S1, S0, b(7), AUX(7));
		
		l1: logic PORT MAP (U, S1, S0, a(0), b(0), AUX(8));
		l2: logic PORT MAP (U, S1, S0, a(1), b(1), AUX(9));
		l3: logic PORT MAP (U, S1, S0, a(2), b(2), AUX(10));
		l4: logic PORT MAP (U, S1, S0, a(3), b(3), AUX(11));
		l5: logic PORT MAP (U, S1, S0, a(4), b(4), AUX(12));
		l6: logic PORT MAP (U, S1, S0, a(5), b(5), AUX(13));
		l7: logic PORT MAP (U, S1, S0, a(6), b(6), AUX(14));
		l8: logic PORT MAP (U, S1, S0, a(7), b(7), AUX(15));
		
		CARRY <= (S1 XOR S0) AND (NOT U);
		
		OUT1: sum PORT MAP (AUX(8 ), AUX(0), CARRY  , S(0), AUX(16));
		OUT2: sum PORT MAP (AUX(9 ), AUX(1), AUX(16), S(1), AUX(17));
		OUT3: sum PORT MAP (AUX(10), AUX(2), AUX(17), S(2), AUX(18));
		OUT4: sum PORT MAP (AUX(11), AUX(3), AUX(18), S(3), AUX(19));
		OUT5: sum PORT MAP (AUX(12), AUX(4), AUX(19), S(4), AUX(20));
		OUT6: sum PORT MAP (AUX(13), AUX(5), AUX(20), S(5), AUX(21));
		OUT7: sum PORT MAP (AUX(14), AUX(6), AUX(21), S(6), AUX(22));
		OUT8: sum PORT MAP (AUX(15), AUX(7), AUX(22), S(7), c);
	
END behavior;