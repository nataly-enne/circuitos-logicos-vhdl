LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
	PORT(
        A, B: in STD_LOGIC;
		a_equals_b,a_bigger_b,a_smaller_b: in STD_LOGIC; 
		X, Y, Z: out STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF comparator IS
	BEGIN
		X <= (A xnor B) and a_equals_b;
		Y <= ((A and (not B))) and a_bigger_b;
		Z <= ((not A) and B) and a_smaller_b;
END behavior;