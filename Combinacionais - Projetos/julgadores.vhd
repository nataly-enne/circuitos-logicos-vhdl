LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY julgadores IS 
	port(
        j0, j1, j2, j3: IN std_logic;
        VD, VM: OUT std_logic
    );
END ENTITY;

ARCHITECTURE behavior OF julgadores IS
	SIGNAL aprovado: std_logic; 
	SIGNAL empate: std_logic;
	SIGNAL reprovado: std_logic; 
	
	BEGIN
        aprovado    <=  ((j0 and j2 and j3) or 
                        (j0 and j1 and j3) or 
                        (j1 and j2 and j3));

		empate      <=  (j0 and j1 and (not j2) and (not j3)) or
			            ((not j0) and j1 and (not j2) and j3) or
			            (j0 and (not j1) and (not j2) and j3) or
			            ((not j0) and (not j1) and j2 and j3) or
			            ((not j0) and j1 and j2 and (not j3)) or
                        (j0 and (not j1) and j2 and (not j3));
                        
		reprovado   <=  ((not j0) and (not j1) and (not j2) and j3) or
			            ((not j0) and (not j1) and j2 and (not j3)) or
			            ((not j0) and j1 and (not j2) and (not j3)) or
			            (j0 and (not j1) and (not j2) and (not j3));
        
        VD <= aprovado or empate;
		VM <= empate or reprovado;
END behavior;