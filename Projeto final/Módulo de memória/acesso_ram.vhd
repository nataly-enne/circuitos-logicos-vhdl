LIBRARY IEEE;
USE IEEE_STD_LOGIC_1164.ALL;

ENTITY acesso_ram IS
PORT    (
            clk: IN STD_LOGIC
            bt1, bt2, bt3: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
END acesso_ram;

ARCHITECTURE arq_acesso_ram IS

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

COMPONENT entrada_operacoes IS
PORT    (
            bt1, bt2, bt3: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            resetar, fim_algoritmo: OUT STD_LOGIC;
            operacao: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            ra, rb, rc: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            constante: OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
        );
END COMPONENT;

COMPONENT banco_regs IS
PORT 	(  
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            seletor: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            clk, ler_escrever: IN STD_LOGIC -- ler_escrever: 0->lê; 1->escreve.
            saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

COMPONENT ula IS
PORT 	(  
			a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			constante: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			operacao: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

SIGNAL resetar, fim_algoritmo, ler_escrever_reg, ler_escrever_mem: STD_LOGIC;
SIGNAL a, b, saida_ula, valor_reg, saida_mem, entrada_mem: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL opcode: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL regA, regB, regC, seletor_reg: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL constante: STD_LOGIC_VECTOR (5 DOWNTO 0);

BEGIN

    opin: entrada_operacoes PORT MAP (bt1, bt2, bt3, entrada, resetar, fim_algoritmo, opcode, regA, regB, regC, constante);
    
    m1: ram PORT MAP (clk, ler_escrever_mem, saida_ula, entrada_mem, saida_mem);

    b1: banco_regs (saida_ula, seletor_reg, clk, ler_escrever_reg, valor_reg);

    ula1: ula PORT MAP (a, b, constante, opcode, saida_ula);

    PROCESS(clk, fim_algoritmo, resetar, opcode, regA, regB, regC, constante)
    BEGIN
        IF(clk'event AND clk='1') THEN
            IF (fim_algoritmo='1') THEN
                -- mostrar no display
            ELSIF (resetar='1') THEN
                
                saida_ula <= "0000000000000000";
                
                ler_escrever_reg <= '1';
                
                seletor_reg <= "000";
                seletor_reg <= "001";
                seletor_reg <= "010";
                seletor_reg <= "011";
                seletor_reg <= "100";
                seletor_reg <= "101";
                seletor_reg <= "110";
                seletor_reg <= "111";

            ELSE
                IF (opcode="0000" OR ) THEN -- add RA, RB, RC / RA = RB + RC
                    
                    ler_escrever_reg <= '0';
                    
                    seletor_reg <= regB;
                    a <= valor_reg;

                    seletor_reg <= regC;
                    b <= valor_reg;

                    -- IMPORTANTE: para escrita no registrador é necessário alterar primeiro o seletor e depois o sinal ler_escrever_reg
                    seletor_reg <= regA;
                    ler_escrever_reg <= '1';

                ELSIF (opcode="0001") THEN -- addi RA, RB, const / RA = RB + const
                    
                    ler_escrever_reg <= '0';
                        
                    seletor_reg <= regB;
                    a <= valor_reg;

                    -- IMPORTANTE: para escrita no registrador é necessário alterar primeiro o seletor e depois o sinal ler_escrever_reg
                    seletor_reg <= regA;
                    ler_escrever_reg <= '1';

                ELSIF (opcode="0010") THEN -- sub RA, RB, RC / RA = RB - RC

                    ler_escrever_reg <= '0';
                    
                    seletor_reg <= regB;
                    a <= valor_reg;

                    seletor_reg <= regC;
                    b <= valor_reg;

                    -- IMPORTANTE: para escrita no registrador é necessário alterar primeiro o seletor e depois o sinal ler_escrever_reg
                    seletor_reg <= regA;
                    ler_escrever_reg <= '1';

                ELSIF (opcode="0011") THEN -- subi RA, RB, const / RA = RB - const

                    ler_escrever_reg <= '0';
                            
                    seletor_reg <= regB;
                    a <= valor_reg;

                    -- IMPORTANTE: para escrita no registrador é necessário alterar primeiro o seletor e depois o sinal ler_escrever_reg
                    seletor_reg <= regA;
                    ler_escrever_reg <= '1';

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