LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY logic IS
	PORT (	
		S1, S0, a, b, U: IN STD_LOGIC;
		cout: OUT STD_LOGIC
	);
END logic;

ARCHITECTURE behavior OF logic IS
	BEGIN
		cout <= (
				((a AND b AND (NOT S1)) OR 
				(a AND (NOT b) AND S0) OR 
				(a AND (NOT b) AND S1) OR 
				((NOT a) AND b AND S1 AND 
				(NOT S0)) OR ((NOT b) AND S1 AND S0) OR 
				(b AND (NOT S1) AND S0)) AND U) OR 
				(NOT U) AND a);
END behavior;