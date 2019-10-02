LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY latch_rs is
    PORT ( 
        S : in    STD_LOGIC;
        R : in    STD_LOGIC;
        Q : inout   STD_LOGIC
    );
END latch_rs;

ARCHITECTURE behavior OF latch_rs IS
    SIGNAL notQ : STD_LOGIC;
    BEGIN
        Q    <= R nor notQ;
        notQ <= S nor Q;
END behavior;