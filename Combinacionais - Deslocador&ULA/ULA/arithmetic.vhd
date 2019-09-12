LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY arithmetic IS
	PORT (	
		S1, S0, U, b: IN STD_LOGIC;
		cout: OUT STD_LOGIC
	);
END arithmetic;

ARCHITECTURE behavior OF arithmetic IS
	BEGIN
		cout <= ((NOT U) AND 
				(NOT S1)) AND 
				(((NOT S0) AND b) OR 
				(S0 AND (NOT b)));
END behavior;