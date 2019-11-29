LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY projeto_final IS
PORT    (
            clk: IN STD_LOGIC;
            switches: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
            botoes: IN STD_LOGIC_VECTOR (0 TO 2);
            leds: OUT STD_LOGIC_VECTOR (0 TO 1);
				valor: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3)
        );
END projeto_final;

ARCHITECTURE arq_projeto_final OF projeto_final IS

COMPONENT acesso_ram IS
PORT    (
            clk: IN STD_LOGIC;
            bt1, bt2, bt3: IN STD_LOGIC;
            seletor_reg: IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- seletor do registrador para armazenar um valor lido
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            valor_display: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            operacao_finalizada, valor_lido: OUT STD_LOGIC
        );
END COMPONENT;

COMPONENT saida IS
PORT    (
            valor: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            operacao_finalizada, valor_lido: IN STD_LOGIC;
            a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3);
            led17, led0: OUT STD_LOGIC
        );
END COMPONENT;

SIGNAL valor_display: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL operacao_finalizada, valor_lido: STD_LOGIC;

BEGIN

    acesso: acesso_ram PORT MAP (clk, botoes(0), botoes(1), botoes(2), switches(17 DOWNTO 16), switches(15 DOWNTO 0), valor_display, operacao_finalizada, valor_lido);
    s: saida PORT MAP (valor_display, operacao_finalizada, valor_lido, a, b, c, d, e, f, g, leds(0), leds(1));
	 
	 PROCESS (valor_display)
	 BEGIN
		valor <= valor_display;
	 END PROCESS;
    
END arq_projeto_final;