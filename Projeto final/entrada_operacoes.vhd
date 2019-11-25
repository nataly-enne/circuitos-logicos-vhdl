LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY entrada_operacoes IS
PORT    (
            clk, bt1, bt2, bt3: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            resetar, ler_valor, executar_operacao: OUT STD_LOGIC;
            operacao: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            ra, rb, rc: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            constante: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
END entrada_operacoes;

ARCHITECTURE arq_entrada_operacoes OF entrada_operacoes IS

SIGNAL operacao_atual: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
    PROCESS(clk, bt1, bt2, bt3) 
    BEGIN
        IF (clk'event AND clk='1') THEN
            IF (bt1='1') THEN -- resetar valores
                resetar <= '1';
                ler_valor <= '0';
                executar_operacao <= '0';
            ELSE
                IF (bt2='1') THEN -- ler dado de entrada
                    resetar <= '0';
                    ler_valor <= '1';
                    executar_operacao <= '0';
                ELSIF (bt3='1') THEN -- ler e executar operacao
                    
                    operacao_atual <= entrada;

                    IF (operacao_atual(15 DOWNTO 12)="0000" 
                        OR operacao_atual(15 DOWNTO 12)="0010" 
                        OR operacao_atual(15 DOWNTO 12)="1000" 
                        OR operacao_atual(15 DOWNTO 12)="1010"
                        OR operacao_atual(15 DOWNTO 12)="1011") THEN -- formato 1: com ra, rb e rc
                        
                        operacao <= operacao_atual(15 DOWNTO 12);
                        ra <= operacao_atual(11 DOWNTO 9);
                        rb <= operacao_atual(8 DOWNTO 6);
                        rc <= operacao_atual(5 DOWNTO 3);
                        -- operacao(2 DOWNTO 0) está em "000"

                    ELSIF ( operacao_atual(15 DOWNTO 12)="0001" 
                            OR operacao_atual(15 DOWNTO 12)="0011"
                            OR operacao_atual(15 DOWNTO 12)="0100" 
                            OR operacao_atual(15 DOWNTO 12)="0101"
                            OR operacao_atual(15 DOWNTO 12)="0110"
                            OR operacao_atual(15 DOWNTO 12)="0111"
                            OR operacao_atual(15 DOWNTO 12)="1001"
                            OR operacao_atual(15 DOWNTO 12)="1100"
                            OR operacao_atual(15 DOWNTO 12)="1110") THEN -- formato 2: com ra, rb e constante
                        
                        operacao <= operacao_atual(15 DOWNTO 12);
                        regA <= operacao_atual(11 DOWNTO 9);
                        regB <= operacao_atual(8 DOWNTO 6);
                        constante <= "0000000000" & operacao_atual(5 DOWNTO 0);

                    END IF;

                    resetar <= '0';
                    ler_valor <= '0';
                    executar_operacao <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;
END arq_entrada_operacoes;