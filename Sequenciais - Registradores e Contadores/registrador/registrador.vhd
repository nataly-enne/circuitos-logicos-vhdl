LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador IS
	PORT(
		t: in std_logic_vector(15 downto 0);
		clock: in std_logic;
		q: out std_logic_vector(15 downto 0)
	);
END ENTITY;

ARCHITECTURE behavior OF registrador IS
	BEGIN
		PROCESS(t, clock)
			BEGIN
				IF(clock'event AND clock = '1') THEN
					q <= t;
				END IF;
		END PROCESS;
END behavior;