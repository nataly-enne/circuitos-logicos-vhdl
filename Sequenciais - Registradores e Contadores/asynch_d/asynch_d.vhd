LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY asynch_d IS
	PORT(
		clock: in std_logic;
		q0, q1: out std_logic);
END ENTITY;

ARCHITECTURE behavior OF asynch_d IS
	SIGNAL sq0,sq1: std_logic;
	BEGIN
		PROCESS(clock, sq0, sq1)
			BEGIN
				IF(clock'event AND clock = '1') THEN
					sq0 <= not sq0;
				END IF;
				IF(sq0'event AND sq0 = '1') THEN
					sq1 <= not sq1;
				END IF;
				q0 <= sq0;
				q1 <= sq1;
		END PROCESS;
END behavior;