LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY acesso_ram IS
PORT    (
            clk: IN STD_LOGIC;
            bt1, bt2, bt3: IN STD_LOGIC;
            seletor_reg: IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- seletor do registrador para armazenar um valor lido
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0)
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

COMPONENT entrada_operacoes IS
PORT    (
            clk, bt1, bt2, bt3: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            resetar, ler_valor, executar_operacao: OUT STD_LOGIC;
            operacao: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            ra, rb, rc: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            constante: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
END COMPONENT;

COMPONENT banco_regs IS
PORT 	(  
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

-- sinais da entrada de operações (eop)
SIGNAL resetar_eop, ler_valor_eop, executar_operacao_eop: STD_LOGIC;
SIGNAL ra_eop, rb_eop, rc_eop: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL constante_eop: STD_LOGIC_VECTOR (15 DOWNTO 0);

-- sinais do banco de registradores (brg)
SIGNAL ler_escrever_brg: STD_LOGIC;
SIGNAL seletor_brg: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL entrada_brg, saida_brg: STD_LOGIC_VECTOR (15 DOWNTO 0);

-- sinais gerais
SIGNAL opcode: STD_LOGIC_VECTOR (3 DOWNTO 0); -- código da operação: sai do módulo de entrada de operações e entra na ula

BEGIN
    
    map_ram: ram PORT MAP (clk, wren_ram, addr_ram, data_in_ram, data_out_ram);
    map_ula: ula PORT MAP (a_ula, b_ula, opcode, s_ula);
    map_eop: entrada_operacoes PORT MAP (clk, bt1, bt2, bt3, entrada, resetar_eop, ler_valor_eop, executar_operacao_eop, opcode, ra_eop, rb_eop, rc_eop, constante_eop);
    map_banco_regs: banco_regs PORT MAP (clk, ler_escrever_brg, resetar_eop, entrada_brg, seletor_brg, saida_brg);

    PROCESS(clk, resetar_eop, ler_valor_eop, executar_operacao_eop)
    BEGIN
        IF (clk'event AND clk='1') THEN
            IF (resetar_eop='1') THEN
                
                -- zerar todos os valores dos registradores e da memória
                -- o sinal resetar_eop está mapeado para o banco de registradores, que é responsável por zerar os valores
                -- falta fazer o controle para zerar a memória

            ELSIF (ler_valor_eop='1') THEN -- ler valor e armazenar na entrada
                
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
                ler_escrever_brg <= '1';

            ELSIF (executar_operacao_eop='1') THEN
                IF (opcode="0000") THEN -- add RA, RB, RC / RA = RB + RC
                    entrada_brg <= s_ula;
                ELSIF (opcode="0001") THEN -- addi RA, RB, const / RA = RB + const
                ELSIF (opcode="0010") THEN -- sub RA, RB, RC / RA = RB - RC
                ELSIF (opcode="0011") THEN -- subi RA, RB, const / RA = RB - const
                ELSIF (opcode="0100") THEN -- sll RA, RB / RA = RB << 1
                ELSIF (opcode="0101") THEN -- slln RA, RB, const / RA = RB << const
                ELSIF (opcode="0110") THEN -- slr RA, RB / RA = RB >> 1
                ELSIF (opcode="0111") THEN -- slrn RA, RB, const / RA = RB >> const
                ELSIF (opcode="1000") THEN -- and RA, RB, RC / RA = RB and RC
                ELSIF (opcode="1001") THEN -- nand RA, RB, RC / RA = RB nand RC
                ELSIF (opcode="1010") THEN -- or RA, RB, RC / RA = RB or RC
                ELSIF (opcode="1011") THEN -- xor RA, RB, RC / RA = RB xor RC
                ELSIF (opcode="1100") THEN -- w RA, RB, const / RA = mem[RB+const]
                ELSIF (opcode="1110") THEN -- sw RA, RB, const / mem[RA+const] = RB
                END IF;
            END IF;
        END IF;
    END PROCESS;

END arq_acesso_ram;