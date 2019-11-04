library ieee;
use ieee.std_logic_1164.all;

entity painel_carro is
    port ( 
            clock, bt: in std_logic;
            trip  , g_tanque , consumo: out std_logic := '0' ;
            total_km : out std_logic := '1'
    ) ;
end painel_carro;

architecture behavior of painel_carro is
    constant e0 : std_logic_vector(1 downto 0) := "01";
    constant e1 : std_logic_vector(1 downto 0) := "10";
    constant e2 : std_logic_vector(1 downto 0) := "11";
    constant e3 : std_logic_vector(1 downto 0) := "00";
    
    signal s : std_logic_vector(1 downto 0) := e0 ;
        begin
        process (clock, bt, s)
            variable aux_bt: std_logic;
            begin
            if (clock'event and clock = '1') then
                if (bt = '1' and bt /= aux_bt) then
                    case s is
                        when e0 =>
                            s <= e1;
                            trip <= '0';
                            total_km <= '0';
                            g_tanque <= '0';
                            consumo <= '1';
                        when e1 =>
                            s <= e2;
                            trip <= '0';
                            total_km <= '0';
                            g_tanque <= '1';
                            consumo <= '0';
                        when e2 =>
                            s <= e3;
                            trip <= '1';
                            total_km <= '0';
                            g_tanque <= '0';
                            consumo <= '0';
                        when OTHERS =>
                            s <= e0;
                            trip <= '0';
                            total_km <= '1';
                            g_tanque <= '0';
                            consumo <= '0';
                    end case;
                end if ;
            
                aux_bt:= bt ;
            
            end if ;
        end process;
end behavior;


