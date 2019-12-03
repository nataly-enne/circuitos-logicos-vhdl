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

-- controle de estados
CONSTANT espera: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
CONSTANT ula_ler_a: STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
CONSTANT ula_ler_b: STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
CONSTANT ula_operar: STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
CONSTANT operacao_especial: STD_LOGIC_VECTOR(2 DOWNTO 0) := "100"; -- RA = mem[RB+const]
SIGNAL estado_atual: STD_LOGIC_VECTOR(2 DOWNTO 0) := espera;

BEGIN
    
	map_ram: ram PORT MAP (clk, wren_ram, addr_ram, data_in_ram, data_out_ram);
	map_ula: ula PORT MAP (a_ula, b_ula, operacao, s_ula);
	map_banco_regs: banco_regs PORT MAP (clk, ler_escrever_brg, resetar, entrada_brg, seletor_brg, saida_brg);

	PROCESS(clk, resetar, ler_valor, executar_operacao, entrada, seletor_reg, operacao, ra, rb, rc, constante)
	BEGIN
		IF (clk'event AND clk='1') THEN
			IF (resetar='1') THEN
				
				estado_atual <= espera;
				
				valor_lido <= '1'; -- valor_lido em 1 quer dizer que nao foi lido
				operacao_finalizada <= '1'; -- operacao_finalizada em 1 quer dizer que nao terminou
				
				-- o sinal reseta está mapeado para o banco de registradores, que é responsável por zerar os valores
				-- falta fazer o controle para zerar a memória
				
			ELSIF (ler_valor='1') THEN
				
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
				ler_escrever_brg <= '0';
				
				valor_lido <= '0'; -- valor_lido em 0 quer dizer que foi lido
				operacao_finalizada <= '1'; -- operacao_finalizada em 1 quer dizer que nao terminou
				
			ELSIF (executar_operacao='1') THEN
			
				valor_lido <= '1'; -- valor_lido em 1 quer dizer que nao foi lido
			
				IF (estado_atual = espera) THEN
					
					operacao_finalizada <= '1'; -- operacao_finalizada em 1 quer dizer que terminou
					estado_atual <= ula_ler_a;
					
				ELSIF (estado_atual = ula_ler_a) THEN
					
					IF (operacao="1110") THEN -- unica operacao que o primeiro operando e ra
						seletor_brg <= ra;
						ler_escrever_brg <= '0';
					ELSE -- demais operacoes o primeiro operando e rb
						seletor_brg <= rb;
						ler_escrever_brg <= '0';
					END IF;
					
					estado_atual <= ula_ler_b;
					
				ELSIF (estado_atual = ula_ler_b) THEN
					
					a_ula <= saida_brg;
					valor_display <= saida_brg;
					
					-- unicas operacoes que o segundo operando e rc
					-- demais operacoes o segundo operando e a constante ou shift para a esquerda/direita
					IF (operacao="0000" OR operacao="0010" OR operacao="1000" OR operacao="1001" OR operacao="1010" OR operacao="1011") THEN
						seletor_brg <= rc;
						ler_escrever_brg <= '0';
					ELSIF (operacao="1110") THEN -- necessario para recuperar o valor de rb para a operacao mem[RA+const] = RB
						seletor_brg <= rb;
						ler_escrever_brg <= '0';
					END IF;
					
					estado_atual <= ula_operar;
					
				ELSIF (estado_atual = ula_operar) THEN
				
					IF (operacao="0000" OR operacao="0010" OR operacao="1000" OR operacao="1001" OR operacao="1010" OR operacao="1011") THEN -- operacoes que o segundo operando e rc
						b_ula <= saida_brg;
						valor_display <= saida_brg;
					ELSIF (NOT (operacao="0100" OR operacao="0110")) THEN -- nao for operacoes de shift
						b_ula <= constante;
						valor_display <= constante;
					END IF;
					
					IF (operacao="1100") THEN -- RA = mem[RB+const]
						addr_ram <= s_ula;
						wren_ram <= '0';
						estado_atual <= operacao_especial;
					ELSIF (operacao="1110") THEN -- mem[RA+const] = RB
						addr_ram <= s_ula;
						data_in_ram <= saida_brg;
						wren_ram <= '1';
						
						estado_atual <= espera;
						operacao_finalizada <= '0'; -- operacao_finalizada em 0 quer dizer que terminou
					ELSE -- salvar em ra
						entrada_brg <= s_ula;
						seletor_brg <= ra;
						ler_escrever_brg <= '1';
						valor_display <= s_ula;
						
						estado_atual <= espera;
						operacao_finalizada <= '0'; -- operacao_finalizada em 0 quer dizer que terminou
					END IF;
				ELSIF (estado_atual = operacao_especial) THEN -- RA = mem[RB+const]
					entrada_brg <= data_out_ram;
					seletor_brg <= ra;
					ler_escrever_brg <= '1';
					
					estado_atual <= espera;
					operacao_finalizada <= '0'; -- operacao_finalizada em 0 quer dizer que terminou
				END IF;
			ELSE
				valor_lido <= '1'; -- valor_lido em 1 quer dizer que nao foi lido
				operacao_finalizada <= '1'; -- operacao_finalizada em 1 quer dizer que nao terminou
			END IF;
		END IF;
	END PROCESS;

END arq_acesso_ram;