
library ieee;
use ieee.std_logic_1164.all;

entity FSM_1B is
    port (
        clock, W: in std_logic;
        X, Y: out std_logic
    );
end entity;

architecture behavior of FSM_1B is
    constant E1: std_logic_vector(1 downto 0) := "00";
    constant E2: std_logic_vector(1 downto 0) := "01";
    constant E3: std_logic_vector(1 downto 0) := "10";
    constant E4: std_logic_vector(1 downto 0) := "11";
    
    signal N: std_logic_vector(1 downto 0) := E1;
        begin  
            process(W, X, N)
            begin
                if(clock'event and clock = '1') then
                    case N is
                        when E1 =>
                            X <= '0';
                            Y <= '0';
                            N <= E2;
                        when E2 =>
                            X <= '0';
                            Y <= '1';
                            N <= E3;
                        when E3 =>
                            if(W = '1') then
                                X <= '1';
                                Y <= '0';
                                N <= E2;
                            else
                                X <= '1';
                                Y <= '1';
                                N <= E4;
                            end if;
                        when E4 =>
                            if(W = '1') then
                                X <= '1';
                                Y <= '1';
                                N <= E4;
                            else
                                X <= '0';
                                Y <= '0';
                                N <= E1;
                            end if;
                    end case;
                end if;
            end process;
end behavior;


