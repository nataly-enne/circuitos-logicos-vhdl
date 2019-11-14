LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY ula IS
PORT 	(  
			a: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			seletor: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			
			a1,b1,c1,d1,e1,f1,g1: OUT STD_LOGIC;
			a2,b2,c2,d2,e2,f2,g2: OUT STD_LOGIC;
			a3,b3,c3,d3,e3,f3,g3: OUT STD_LOGIC;
			a4,b4,c4,d4,e4,f4,g4: OUT STD_LOGIC
			
		);
END ula;

ARCHITECTURE arq_ula OF ula IS

COMPONENT display IS
PORT	(	entrada: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC
		);
END COMPONENT;

COMPONENT ula2 IS
PORT 	(  
			a: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			seletor: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

SIGNAL s: STD_LOGIC_VECTOR (15 DOWNTO 0) := "0000000000000000";

BEGIN

	u1: ula2 PORT MAP (a,seletor,s);
	display1: display PORT MAP (s(3 DOWNTO 0),a1,b1,c1,d1,e1,f1,g1);
	display2: display PORT MAP (s(7 DOWNTO 4),a2,b2,c2,d2,e2,f2,g2);
	display3: display PORT MAP (s(11 DOWNTO 8),a3,b3,c3,d3,e3,f3,g3);
	display4: display PORT MAP (s(15 DOWNTO 12),a4,b4,c4,d4,e4,f4,g4);
	
END arq_ula;