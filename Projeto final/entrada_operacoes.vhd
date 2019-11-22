LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY entrada_operacoes IS
PORT    (
            bt1, bt2, bt3: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            resetar, fim_algoritmo: OUT STD_LOGIC;
            operacao: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            ra, rb, rc: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            constante: OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
        );
END entrada_operacoes;

ARCHITECTURE arq_entrada_operacoes OF entrada_operacoes IS

SIGNAL operacao_atual: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
    PROCESS(bt1, bt2, bt3) 
    BEGIN
        IF (bt1='1') THEN -- resetar valores
            resetar <= '1';
        ELSE 
            resetar <= '0';

            IF (bt2='1') THEN -- ler operacao
                operacao_atual <= entrada;
            ELSIF (bt3='1') THEN -- executar operacao
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
                    constante <= operacao_atual(5 DOWNTO 0);

                END IF;

                fim_algoritmo<="0"; -- sera necessário se for preciso guardar várias operacoes de uma unica vez

            END IF;
        END IF;
    END PROCESS;
END arq_entrada_operacoes;