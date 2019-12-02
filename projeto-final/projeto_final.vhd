LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY projeto_final IS
PORT	(
			clk: IN STD_LOGIC;
			switches: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
			botoes: IN STD_LOGIC_VECTOR (0 TO 2);
			leds: OUT STD_LOGIC_VECTOR (0 TO 1);
			valor: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3)
		);
END projeto_final;

ARCHITECTURE arq_projeto_final OF projeto_final IS

COMPONENT entrada_operacoes IS
PORT	(
			clk, bt1, bt2, bt3: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			resetar, ler_valor, executar_operacao: OUT STD_LOGIC;
			operacao: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			ra, rb, rc: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
			constante: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

COMPONENT acesso_ram IS
PORT	(
			clk, resetar, ler_valor, executar_operacao: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			seletor_reg: IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- seletor do registrador para armazenar um valor lido
			operacao: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			ra, rb, rc: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			constante: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			valor_display: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			operacao_finalizada, valor_lido: OUT STD_LOGIC
		);
END COMPONENT;

COMPONENT saida IS
PORT	(
			valor: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			operacao_finalizada, valor_lido: IN STD_LOGIC;
			a, b, c, d, e, f, g: OUT STD_LOGIC_VECTOR(0 TO 3);
			led17, led0: OUT STD_LOGIC
		);
END COMPONENT;

SIGNAL valor_display, constante: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL resetar, ler_valor, executar_operacao, operacao_finalizada, valor_lido: STD_LOGIC;
SIGNAL operacao: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL ra, rb, rc: STD_LOGIC_VECTOR (2 DOWNTO 0);
			
BEGIN
	
	entrada: entrada_operacoes PORT MAP (clk, botoes(0), botoes(1), botoes(2), switches(15 DOWNTO 0), resetar, ler_valor, executar_operacao, operacao, ra, rb, rc, constante);
	acesso: acesso_ram PORT MAP (clk, resetar, ler_valor, executar_operacao, switches(15 DOWNTO 0), switches(17 DOWNTO 16), operacao, ra, rb, rc, constante, valor_display, operacao_finalizada, valor_lido);
	s: saida PORT MAP (valor_display, operacao_finalizada, valor_lido, a, b, c, d, e, f, g, leds(0), leds(1));
	 
	valor <= valor_display;
    
END arq_projeto_final;