LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY demux_1to4_case IS
	PORT (
    		CIN: IN  STD_LOGIC;
    		SELETOR: IN  STD_LOGIC_VECTOR(1 downto 0);
			COUT: OUT STD_LOGIC_VECTOR(3 downto 0)
		);

END demux_1to4_case;

ARCHITECTURE behavior OF demux_1to4_case IS
  
BEGIN

DEMUX: PROCESS (CIN, SELETOR)
	VARIABLE AUX: STD_LOGIC_VECTOR(0 to 3); -- utilizando variavel auxiliar
  		BEGIN  
			CASE SELETOR IS
				WHEN "00" => AUX := "000" & CIN;
				WHEN "01" => AUX := "00"& CIN &'0';
				WHEN "10" => AUX := '0'& CIN &"00";
				WHEN "11" => AUX := CIN &"000";
				WHEN OTHERS => NULL;
			END CASE;
			COUT <= AUX;
		END PROCESS DEMUX;
END behavior;
