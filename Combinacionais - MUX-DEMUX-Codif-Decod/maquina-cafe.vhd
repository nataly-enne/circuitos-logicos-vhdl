LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY maquina_cafe is -- demux 1 to 8
	PORT(
		CIN:in std_logic;
		S:in std_logic_vector(2 downto 0);
		COUT:out CHARACTER
	);
END maquina_cafe;

ARCHITECTURE behavior of maquina_cafe IS
	BEGIN
		PROCESS(S, CIN)
			BEGIN
				CASE S IS
					WHEN "000" => COUT <= 'H';
					WHEN "001" => COUT <= 'A';
					WHEN "010" => COUT <= 'B';
					WHEN "011" => COUT <= 'C';
					WHEN "100" => COUT <= 'D';
					WHEN "101" => COUT <= 'E';
					WHEN "110" => COUT <= 'F';
					WHEN OTHERS => COUT <= 'G';
				END CASE;
		END PROCESS;
END behavior;
