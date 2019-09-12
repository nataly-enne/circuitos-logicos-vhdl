LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shifter IS 
    PORT (
        cin: IN std_logic_vector (7 downto 0);
        move: in std_logic_vector(1 downto 0);
        rightt, leftt: OUT std_logic_vector (7 downto 0)
    );
END ENTITY;

ARCHITECTURE behavior OF shifter IS 
    BEGIN 
        PROCESS (move, cin) IS 
            BEGIN 
                IF (move = "10") THEN
                    rightt <= '0'& cin(7 downto 1);
                    leftt <= "00000000";
                ELSIF (move "01") THEN
                    leftt <= cin(6 downto 1) & '0';
                ELSE 
                    rightt <= "00000000";
                    leftt <= "00000000";
                END IF;
        END PROCESS;
END behavior;