library ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY synch_counter IS
	PORT(
		clear, clock, cnt, up_dwn: in std_logic;
		fc: out std_logic;
		S: out std_logic_vector(3 downto 0));
END ENTITY;

ARCHITECTURE behavior OF synch_counter IS 	
	SIGNAL value: std_logic_vector(3 downto 0);
	BEGIN
		PROCESS (clock, cnt, value, up_dwn, clear)
			BEGIN
				IF(clock'event AND clock = '1') THEN
					IF(up_dwn = '0') THEN
						IF(cnt = '1') THEN
							value <= value - "0001";
						ELSE
							value <= value;
						END IF;
					ELSE
						IF(cnt = '1') THEN
							value <= value + "0001";
						ELSE
							value <= value;
						END IF;
					END IF;
				END IF;
				S <= value;
				IF(up_dwn = '0') THEN 
					IF(((value(3) NOR value(2)) NOR (value(1) NOR value(0))) = '1') THEN
						fc <= '1';
					ELSE
						fc <= '0';
					END IF;
				ELSE
					IF((value(3) AND value(2) AND value(1) AND value(0)) = '1') THEN
						fc <= '1';
					ELSE
						fc <= '0';
					END IF;
				END IF;
		END PROCESS;
END behavior;