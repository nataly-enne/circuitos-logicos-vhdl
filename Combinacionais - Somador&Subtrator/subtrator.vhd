library ieee;
use ieee.std_logic_1164.all;

entity subtrator is 
    port (
        x, y:   in std_logic_vector(3 downto 0);
        z:      in std_logic;
        s:      out std_logic_vector(3 downto 0);
        zs:     out std_logic
    );
end subtrator;

architecture behavior of subtrator is
    component sum
        port(
            a, b, v:    in std_logic;
            s, vs:      out std_logic
        );
    end component;

    signal vx: std_logic_vector(3 downto 1);

    begin
        x0: sum port map(x(0), y(0), z,     s(0), vx(1));
        x1: sum port map(x(1), y(1), vx(1), s(1), vx(2));
        x2: sum port map(x(2), y(2), vx(2), s(2), vx(3));
        x3: sum port map(x(3), y(3), vx(3), s(3), zs);
end behavior;