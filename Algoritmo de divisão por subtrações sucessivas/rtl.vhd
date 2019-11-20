LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY divisor IS
PORT    (   clk, bt: IN STD_LOGIC;
            entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            quociente, resto: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
END divisor;

ARCHITECTURE arq OF divisor IS

COMPONENT pc IS
PORT	(	clk, bt, parar: IN STD_LOGIC;
			po_inicio, po_carrega_a, po_carrega_b, po_opera: OUT STD_LOGIC
		);
END COMPONENT;

COMPONENT po IS
PORT	(	clk, po_inicio, po_carrega_a, po_carrega_b, po_opera: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			quociente, resto: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			parar: OUT STD_LOGIC
		);
END COMPONENT;

SIGNAL po_inicio, po_carrega_a, po_carrega_b, po_opera, parar: STD_LOGIC;

BEGIN
    i1: po PORT MAP (clk, po_inicio, po_carrega_a, po_carrega_b, po_opera, entrada, quociente, resto, parar);
    i2: pc PORT MAP (clk, bt, parar, po_inicio, po_carrega_a, po_carrega_b, po_opera);
END arq;