LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY judges IS 
	port(
        J0, J1, J2, J3: IN std_logic;
        VD, VM: OUT std_logic
    );
END ENTITY;

ARCHITECTURE behavior OF julgadores IS
	SIGNAL aprovado: std_logic; 
	SIGNAL empate: std_logic;
	SIGNAL reprovado: std_logic; 
	
	BEGIN
        aprovado    <=  ((J0 and J2 and J3) or 
                        (J0 and J1 and J3) or 
                        (J1 and J2 and J3));

		empate      <=  (J0 and J1 and (not J2) and (not J3)) or
			            ((not J0) and J1 and (not J2) and J3) or
			            (J0 and (not J1) and (not J2) and J3) or
			            ((not J0) and (not J1) and J2 and J3) or
			            ((not J0) and J1 and J2 and (not J3)) or
                        (J0 and (not J1) and J2 and (not J3));
                        
		reprovado   <=  ((not J0) and (not J1) and (not J2) and J3) or
			            ((not J0) and (not J1) and J2 and (not J3)) or
			            ((not J0) and J1 and (not J2) and (not J3)) or
			            (J0 and (not J1) and (not J2) and (not J3));
        
        VD <= aprovado or empate;
		VM <= empate or reprovado;
END behavior;