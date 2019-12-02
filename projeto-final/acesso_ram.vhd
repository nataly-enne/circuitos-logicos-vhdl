LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY acesso_ram IS
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
END acesso_ram;

ARCHITECTURE arq_acesso_ram OF acesso_ram IS

COMPONENT ram is
    GENERIC (
        DATA_WIDTH: INTEGER := 16;
        ADDR_WIDTH: INTEGER := 16
    );
    PORT (
        clock: IN STD_LOGIC;
        wren: IN STD_LOGIC;
        addr: IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
        data_i: IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
        data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
    );
END COMPONENT;

COMPONENT ula IS
PORT 	(  
			a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			operacao: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

COMPONENT banco_regs IS
PORT	(  
			clk, ler_escrever, resetar: IN STD_LOGIC; -- 0 -> lê do registrador; 1 -> escreve no registrador.
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			seletor: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;


-- sinais da ram
SIGNAL wren_ram: STD_LOGIC;
SIGNAL addr_ram, data_in_ram, data_out_ram: STD_LOGIC_VECTOR(15 DOWNTO 0);

-- sinais da ula
SIGNAL a_ula, b_ula, s_ula: STD_LOGIC_VECTOR(15 DOWNTO 0);

-- sinais do banco de registradores (brg)
SIGNAL ler_escrever_brg: STD_LOGIC;
SIGNAL seletor_brg: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL entrada_brg, saida_brg: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
    
	map_ram: ram PORT MAP (clk, wren_ram, addr_ram, data_in_ram, data_out_ram);
	map_ula: ula PORT MAP (a_ula, b_ula, operacao, s_ula);
	map_banco_regs: banco_regs PORT MAP (clk, ler_escrever_brg, resetar, entrada_brg, seletor_brg, saida_brg);

	PROCESS(clk, resetar, ler_valor, executar_operacao)
	BEGIN

		operacao_finalizada <= '0';
		valor_lido <= '0';

		IF (resetar='1') THEN

			-- zerar todos os valores dos registradores e da memória
			-- o sinal reseta está mapeado para o banco de registradores, que é responsável por zerar os valores
			-- falta fazer o controle para zerar a memória

		ELSIF (ler_valor='1') THEN -- ler valor e armazenar na entrada

			IF (seletor_reg="00") THEN -- salvar valor lido no primeiro registrador do banco de registradores
				seletor_brg <= "000";
			ELSIF (seletor_reg="01") THEN -- salvar valor lido no segundo registrador do banco de registradores
				seletor_brg <= "001";
			ELSIF (seletor_reg="01") THEN -- salvar valor lido no terceiro registrador do banco de registradores
				seletor_brg <= "010";
			ELSE -- salvar valor lido no quarto registrador do banco de registradores
				seletor_brg <= "011";
			END IF;

			entrada_brg <= entrada;
			valor_display <= entrada;
			ler_escrever_brg <= '1';
			valor_lido <= '1';

		ELSIF (executar_operacao='1') THEN

			IF (operacao="0000" OR operacao="0010" OR operacao="1000" OR operacao="1001"
				 OR operacao="1010" OR operacao="1011") THEN

				-- recuperando valor de rb
				ler_escrever_brg <= '0';
				seletor_brg <= rb;
				a_ula <= saida_brg;
				valor_display <= saida_brg;

				-- recuperando valor de rc
				seletor_brg <= rc;
				b_ula <= saida_brg;
				valor_display <= saida_brg;

				-- escrevendo o valor de saida da ula em ra
				seletor_brg <= ra;
				entrada_brg <= s_ula;
				ler_escrever_brg <= '1';
				valor_display <= s_ula;

			ELSIF (operacao="0001" OR operacao="0101" OR operacao="0111" OR operacao="0011") THEN

				-- recuperando valor de rb
				ler_escrever_brg <= '0';
				seletor_brg <= rb;
				a_ula <= saida_brg;
				valor_display <= saida_brg;

				b_ula <= constante;
				valor_display <= constante;

				-- escrevendo o valor de saida da ula em ra
				seletor_brg <= ra;
				entrada_brg <= s_ula;
				ler_escrever_brg <= '1';
				valor_display <= s_ula;

			ELSIF (operacao="0100" OR operacao="0110") THEN

				-- recuperando valor de rb
				ler_escrever_brg <= '0';
				seletor_brg <= rb;
				a_ula <= saida_brg;
				valor_display <= saida_brg;

				-- escrevendo o valor de saida da ula em ra
				seletor_brg <= ra;
				entrada_brg <= s_ula;
				ler_escrever_brg <= '1';
				valor_display <= s_ula;

			ELSIF (operacao="1100") THEN

				-- recuperando valor de rb
				ler_escrever_brg <= '0';
				seletor_brg <= rb;
				a_ula <= saida_brg;
				valor_display <= saida_brg;

				b_ula <= constante;
				valor_display <= constante;

				-- escrevendo o valor armazenado na memoria em ra
				addr_ram <= s_ula;
				wren_ram <= '0';
				seletor_brg <= ra;
				entrada_brg <= data_out_ram;
				ler_escrever_brg <= '1';
				valor_display <= data_out_ram;

			ELSIF (operacao="1110") THEN

				-- recuperando valor de ra
				ler_escrever_brg <= '0';
				seletor_brg <= ra;
				a_ula <= saida_brg;
				valor_display <= saida_brg;

				b_ula <= constante;
				valor_display <= constante;

				addr_ram <= s_ula;
				valor_display <= s_ula;

				-- recuperando valor de rb
				seletor_brg <= rb;
				data_in_ram <= saida_brg;
				wren_ram <= '1';
				valor_display <= saida_brg;

			END IF;

			operacao_finalizada <= '1';
	
		END IF;
	END PROCESS;

END arq_acesso_ram;