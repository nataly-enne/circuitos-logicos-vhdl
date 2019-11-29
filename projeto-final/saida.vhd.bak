LIBRARY IEEE;
USE IEEE.STD_LOGIC_VECTOR_1164.ALL;

ENTITY saida IS
PORT    (
            valor: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            operacao_finalizada, valor_lido: IN STD_LOGIC;
            a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3);
            led17, led0: OUT STD_LOGIC
        );
END saida;

ARCHITECTURE arq_saida OF saida IS

COMPONENT decodificador IS
PORT	(	
            entrada: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3)
		);
END COMPONENT;

BEGIN
    decod: decodificador PORT MAP (valor, a, b, c, d, e, f, g);

    PROCESS(operacao_finalizada, valor_lido)
    BEGIN
        led17 <= operacao_finalizada;
        led0 <= valor_lido;
    END PROCESS;
END arq_saida;