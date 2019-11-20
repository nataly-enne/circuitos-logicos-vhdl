LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY banco_regs IS
PORT 	(  
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            seletor: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            clk, ler_escrever: IN STD_LOGIC -- ler_escrever: 0->lê; 1->escreve.
            saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END banco_regs;

ARCHITECTURE arq_banco_regs OF banco_regs IS

COMPONENT registrador IS
PORT 	(
            i: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            clk: IN STD_LOGIC;
            q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
END COMPONENT;

SIGNAL reg1: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg2: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg3: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg4: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg5: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg6: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg7: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL reg8: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL registrador_escolhido: STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";

BEGIN

    r1: registrador PORT MAP (entrada, clk, registrador_escolhido(0), reg1);
    r2: registrador PORT MAP (entrada, clk, registrador_escolhido(1), reg2);
    r3: registrador PORT MAP (entrada, clk, registrador_escolhido(2), reg3);
    r4: registrador PORT MAP (entrada, clk, registrador_escolhido(3), reg4);
    r5: registrador PORT MAP (entrada, clk, registrador_escolhido(4), reg5);
    r6: registrador PORT MAP (entrada, clk, registrador_escolhido(5), reg6);
    r7: registrador PORT MAP (entrada, clk, registrador_escolhido(6), reg7);
    r8: registrador PORT MAP (entrada, clk, registrador_escolhido(7), reg8);

    PROCESS(clk, entrada, seletor, ler_escrever)
    BEGIN
        IF (clk'event AND clk='1') THEN
            IF (seletor="000") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00000001";
                ELSE
                    saida <= reg1;
                END IF;    
            ELSIF (seletor="001") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00000010";
                ELSE
                    saida <= reg2;
                END IF;
            ELSIF (seletor="010") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00000100";
                ELSE
                    saida <= reg3;
                END IF;
            ELSIF (seletor="011") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00001000";
                ELSE
                    saida <= reg4;
                END IF;
            ELSIF (seletor="100") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00010000";
                ELSE
                    saida <= reg5;
                END IF;
            ELSIF (seletor="101") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "00100000";
                ELSE
                    saida <= reg6;
                END IF;
            ELSIF (seletor="110") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "01000000";
                ELSE
                    saida <= reg7;
                END IF;
            ELSIF (seletor="111") THEN
                IF (ler_escrever='1') THEN
                    registrador_escolhido <= "10000000";
                ELSE
                    saida <= reg8;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END arq_banco_regs;