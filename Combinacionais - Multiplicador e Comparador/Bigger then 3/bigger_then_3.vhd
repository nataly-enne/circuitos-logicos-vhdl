LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bigger_then_3 is
	PORT(
        number1, number2, number3: in STD_LOGIC_VECTOR(7 downto 0);
		  S: out STD_LOGIC_VECTOR(7 downto 0));
END ENTITY;

ARCHITECTURE behavior OF bigger_then_3 IS 
	BEGIN 
		PROCESS(number1, number2, number3) 
			BEGIN 
				IF(number1 > number and number1 > number) THEN 
					S <= number1;
				ELSIF(number > number1 and number > number) THEN
					S <= number;
				ELSIF(number1 = number) THEN
					IF(number1 > number) THEN
						S <= number1;
					ELSE
						S <= number;
					END IF;
				ELSIF(number = number) THEN
					IF(number > number1) THEN
						S <= number;
					ELSE
						S <= number1;
					END IF;
				ELSIF(number = number1) THEN
					IF(number1 > number) THEN
						S <= number1;
					ELSE
						S <= number;
					END IF;
				ELSE
					S <= number;
				END IF;
		END PROCESS;
END behavior;
