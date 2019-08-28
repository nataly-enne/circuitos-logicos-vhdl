LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
 
ENTITY demux_1to4_if_else IS
	PORT(
		CIN: in STD_LOGIC;
         	S : in STD_LOGIC_VECTOR(1 downto 0);
         	COUT : out STD_LOGIC_VECTOR (3 downto 0)
	);
END demux_1to4_if_else;
 
ARCHITECTURE behavior OF demux_1to4_if_else IS
	BEGIN
		DEMUX: PROCESS (CIN, S) IS
    		BEGIN
  	     		IF (S = "00") THEN
            			COUT <= CIN & "000";
        		ELSIF (S = "01") THEN
            			COUT <= '0' & CIN & "00";
        		ELSIF (S ="10") THEN
            			COUT <= "00" & CIN & '0';
        		ELSE
            			COUT <= "000" & CIN;
        		END IF;
    		END PROCESS DEMUX;
END behavior;
