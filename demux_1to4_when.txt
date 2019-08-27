LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY demux_1to4_when IS
	PORT( 
		S: IN STD_LOGIC_VECTOR(1 downto 0);
		CIN : IN STD_LOGIC_VECTOR(1 downto 0);
		S1, S2, S3, S4: OUT STD_LOGIC_VECTOR(1 downto 0));
END ENTITY;

ARCHITECTURE behavior OF demux_1to4_when IS
	BEGIN 
		S1 <= CIN WHEN S="00" ELSE "00";
		S2 <= CIN WHEN S="01" ELSE "00";
		S3 <= CIN WHEN S="10" ELSE "00";
		S4 <= CIN WHEN S="11" ELSE "00";
END behavior;