LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY aula4_3 IS
	PORT(
    	a, b: IN STD_LOGIC; 
        c: OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavior OF aula4_3 IS
	BEGIN
		c <= a NAND b;
END ARCHITECTURE;

