LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sum IS
	PORT (	
		a, b, CIN: IN STD_LOGIC;
		S, COUT: OUT STD_LOGIC
	);
END sum;

ARCHITECTURE behavior OF sum IS
	BEGIN
		S <= a XOR b XOR CIN;
		COUT <= (a AND b) OR (CIN AND (a XOR b));
END behavior;