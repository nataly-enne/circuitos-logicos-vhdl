
library ieee;
use ieee.std_logic_1164.all;
entity FSM_1A is
   port (
       clock, W: in std_logic;
       cout: out std_logic;
       L1, L2, L3: out std_logic
   );
end entity;

architecture behavior of FSM_1A is
   constant fecha1: std_logic_vector(1 downto 0) := "00";
   constant fecha2: std_logic_vector(1 downto 0) := "01";
   constant fecha3: std_logic_vector(1 downto 0) := "10";
   constant abre: std_logic_vector(1 downto 0) := "11";
 
   signal X: std_logic_vector(1 downto 0) := fecha1;
       begin  
           process(clock, W, X)
               begin
                   if(clock'event and clock = '1') then
                       case X is
                           when fecha1 =>
                               if(W = '1') then
                                   X <= fecha2;
                               end if;
                           when fecha2 =>
                               if(W = '1') then
                                   X <= fecha3;
                               end if;
                           when fecha3 =>
                               if(W = '1') then
                                   X <= abre;
                               end if;
                           when abre =>
                               X <= fecha1;
                       end case;
                   end if;
           end process;
 
           process(W, X)
               begin
                   case X is
                       when fecha1 =>
                           if(W = '1') then
                               L1   <= '0';
                               L2   <= '0';
                               L3   <= '0';
                               cout <= '0';
                           end if;
                       when fecha2 =>
                           if(W = '1') then
                               L1   <= '1';
                               L2   <= '0';
                               L3   <= '0';
                               cout <= '0';
                           end if;
                       when fecha3 =>
                           if(W = '1') then
                               L1   <= '0';
                               L2   <= '1';
                               L3   <= '0';
                               cout <= '0';
                           end if;
                       when abre =>
                           if(W = '1') then
                               L1   <= '0';
                               L2   <= '0';
                               L3   <= '1';
                               cout <= '1';
                           end if;
                   end case;
           end process;
end behavior;