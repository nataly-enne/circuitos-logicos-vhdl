LIBRARY IEEE; 
USE ieee.std_logic_1164.ALL;

ENTITY aula4_2 IS 
	PORT(
        a: IN bit_vector(0 TO 3);
                    b: IN bit_vector(3 DOWNTO 0);
        c: OUT bit_vector(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavior OF aula4_2 IS
    BEGIN
        c(0) <= b(0);
        c(1) <= b(1);
        c(2) <= b(2);
        c(3) <= b(3);
        c(4) <= a(0);
        c(5) <= a(1);
        c(6) <= a(2);
        c(7) <= a(3);

END ARCHITECTURE;





