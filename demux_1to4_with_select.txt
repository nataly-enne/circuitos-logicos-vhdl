LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY demux_1to4_with_select IS
	PORT(
         	CIN : IN STD_LOGIC;
         	S : IN STD_LOGIC_VECTOR(1 downto 0);
         	COUT : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END demux_1to4_with_select;

ARCHITECTURE behavior OF demux_1to4_with_select IS
BEGIN
	WITH S SELECT
    	COUT <= (CIN & "000") WHEN "00",
		('0' & CIN & "00") WHEN "01",
		("00" & CIN & '0') WHEN "10",	
		("000" & CIN) WHEN OTHERS;
END behavior;