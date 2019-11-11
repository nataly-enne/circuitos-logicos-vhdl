LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

entity tb_bin_7seg is

end tb_bin_7seg;

architecture simulacao of tb_bin_7seg is

signal DADO: std_logic_vector(3 downto 0);

signal A, B, C, D, E, F, G : STD_LOGIC;

begin

    UUT: entity work.bin_7seg
    port map
    (
        DADO,A, B, C, D, E, F, G
    );

Teste:
process
begin
    -- DADO recebe 0

    DADO &lt;= "0000";
    wait for 100us;

    -- DADO recebe 1

    DADO &lt;= "0001";
    wait for 200us;

    -- DADO recebe 2

    DADO &lt;= "0010";
    wait for 100us;