LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY entidadePrincipal IS
	
	port(
		mux, dmux: in std_logic_vector(2 downto 0);
		data: in std_logic_vector(15 downto 0);
		clock: in std_logic;
		q: out std_logic_vector(15 downto 0)
	);
END ENTITY;

ARCHITECTURE behavior OF entidadePrincipal IS
	component registrador
		port(
			t: in std_logic_vector(15 downto 0);
		  	clock: in std_logic;
		  	q: out std_logic_vector(15 downto 0)
		 );
	END component;
	
	SIGNAL r0: std_logic_vector(15 downto 0);
	SIGNAL r1: std_logic_vector(15 downto 0);
	SIGNAL r2: std_logic_vector(15 downto 0);
	SIGNAL r3: std_logic_vector(15 downto 0);
	SIGNAL r4: std_logic_vector(15 downto 0);
	SIGNAL r5: std_logic_vector(15 downto 0);
	SIGNAL r6: std_logic_vector(15 downto 0);
	SIGNAL r7: std_logic_vector(15 downto 0);
	
	BEGIN		
		PROCESS(data, dmux, mux, clock)
			BEGIN
				IF(clock'event and clock = '1') THEN
					IF(dmux = "000") 	THEN
						r0 <= data;
					ELSIF(dmux = "001") THEN
						r1 <= data;
					ELSIF(dmux = "010") THEN
						r2 <= data;
					ELSIF(dmux = "011") THEN
						r3 <= data;
					ELSIF(dmux = "100") THEN
						r4 <= data;
					ELSIF(dmux = "101") THEN
						r5 <= data;
					ELSIF(dmux = "110") THEN
						r6 <= data;
					ELSIF(dmux = "111") THEN
						r7 <= data;
					END IF;
					
					IF(mux = "000") 	THEN
						q <= r0;
					ELSIF(mux = "001") 	THEN
						q <= r1;
					ELSIF(mux = "010") 	THEN
						q <= r2;
					ELSIF(mux = "011") 	THEN
						q <= r3;
					ELSIF(mux = "100") 	THEN
						q <= r4;
					ELSIF(mux = "101") 	THEN
						q <= r5;
					ELSIF(mux = "110") 	THEN
						q <= r6;
					ELSIF(mux = "111") 	THEN
						q <= r7;
					END IF;
				END IF;
		END PROCESS;
END behavior;