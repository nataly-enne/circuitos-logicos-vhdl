LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator_5_bits is
	PORT(
        A, B: in STD_LOGIC_VECTOR(4 DOWNTO 0);
		IA, IB, IC: in STD_LOGIC;
        X, Y, Z: out STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavior OF comparator_5_bits IS
	COMPONENT comparator IS
		PORT(
            A, B, a_equals_b, a_bigger_b, a_smaller_b: in STD_LOGIC;
			X, Y, Z: out STD_LOGIC);
	END COMPONENT;
	
	SIGNAL sig: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	BEGIN
		S0: comparator PORT MAP(A(0), B(0), IA,     IB,      IC,      sig(0),  sig(1),  sig(2));
		S1: comparator PORT MAP(A(1), B(1), sig(0), sig(1),  sig(2),  sig(3),  sig(4),  sig(5));
		S2: comparator PORT MAP(A(2), B(2), sig(3), sig(4),  sig(5),  sig(6),  sig(7),  sig(8));
		S3: comparator PORT MAP(A(3), B(3), sig(6), sig(7),  sig(8),  sig(9),  sig(10), sig(11));
		S4: comparator PORT MAP(A(4), B(4), sig(9), sig(10), sig(11), sig(12), sig(13), sig(14));
        
        X <= sig(0) and sig(3) and sig(6) and sig(9) and sig(12);
		Y <= sig(1) or  sig(4) or  sig(7) or  sig(10) or sig(13);
		Z <= sig(2) or  sig(5) or  sig(8) or  sig(11) or sig(14);
END behavior;