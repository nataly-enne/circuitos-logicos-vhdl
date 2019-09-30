LIBRARY ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;
 
ENTITY flip_flop is
	PORT( 
		J, K, CLOCK: in std_logic;
		Q: out std_logic);
END flip_flop;
 
ARCHITECTURE behavior OF flip_flop IS
	BEGIN
		PROCESS(CLOCK)
			variable AUXILIARY: std_logic;
			BEGIN
				if(CLOCK='1' and CLOCK'EVENT) then
				if(J='0' and K='0')then
				AUXILIARY:=AUXILIARY;
				elsif(J='1' and K='1')then
				AUXILIARY:= not AUXILIARY;
				elsif(J='0' and K='1')then
				AUXILIARY:='0';
				else
				AUXILIARY:='1';
				end if;
				end if;
				Q <= AUXILIARY;
				Q <= not AUXILIARY;
		END PROCESS;
END behavior;