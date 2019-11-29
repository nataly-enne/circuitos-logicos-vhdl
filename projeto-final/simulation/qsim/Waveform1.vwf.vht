-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/29/2019 19:47:27"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          projeto_final
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY projeto_final_vhd_vec_tst IS
END projeto_final_vhd_vec_tst;
ARCHITECTURE projeto_final_arch OF projeto_final_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL b : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL botoes : STD_LOGIC_VECTOR(0 TO 2);
SIGNAL c : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL clk : STD_LOGIC;
SIGNAL d : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL e : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL f : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL g : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL leds : STD_LOGIC_VECTOR(0 TO 1);
SIGNAL switches : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL valor : STD_LOGIC_VECTOR(15 DOWNTO 0);
COMPONENT projeto_final
	PORT (
	a : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	b : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	botoes : IN STD_LOGIC_VECTOR(0 TO 2);
	c : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	clk : IN STD_LOGIC;
	d : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	e : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	f : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	g : BUFFER STD_LOGIC_VECTOR(0 TO 3);
	leds : BUFFER STD_LOGIC_VECTOR(0 TO 1);
	switches : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	valor : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : projeto_final
	PORT MAP (
-- list connections between master ports and signals
	a => a,
	b => b,
	botoes => botoes,
	c => c,
	clk => clk,
	d => d,
	e => e,
	f => f,
	g => g,
	leds => leds,
	switches => switches,
	valor => valor
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 20000 ps;
	clk <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;
-- botoes[2]
t_prcs_botoes_2: PROCESS
BEGIN
	botoes(2) <= '0';
	WAIT FOR 170000 ps;
	botoes(2) <= '1';
	WAIT FOR 20000 ps;
	botoes(2) <= '0';
	WAIT FOR 100000 ps;
	botoes(2) <= '1';
	WAIT FOR 20000 ps;
	botoes(2) <= '0';
	WAIT FOR 100000 ps;
	botoes(2) <= '1';
	WAIT FOR 20000 ps;
	botoes(2) <= '0';
	WAIT FOR 100000 ps;
	botoes(2) <= '1';
	WAIT FOR 20000 ps;
	botoes(2) <= '0';
WAIT;
END PROCESS t_prcs_botoes_2;
-- botoes[1]
t_prcs_botoes_1: PROCESS
BEGIN
	botoes(1) <= '1';
	WAIT FOR 40000 ps;
	botoes(1) <= '0';
	WAIT FOR 40000 ps;
	botoes(1) <= '1';
	WAIT FOR 40000 ps;
	botoes(1) <= '0';
WAIT;
END PROCESS t_prcs_botoes_1;
-- botoes[0]
t_prcs_botoes_0: PROCESS
BEGIN
	botoes(0) <= '0';
WAIT;
END PROCESS t_prcs_botoes_0;
-- switches[17]
t_prcs_switches_17: PROCESS
BEGIN
	switches(17) <= '0';
WAIT;
END PROCESS t_prcs_switches_17;
-- switches[16]
t_prcs_switches_16: PROCESS
BEGIN
	switches(16) <= '0';
	WAIT FOR 80000 ps;
	switches(16) <= '1';
	WAIT FOR 80000 ps;
	switches(16) <= '0';
WAIT;
END PROCESS t_prcs_switches_16;
-- switches[15]
t_prcs_switches_15: PROCESS
BEGIN
	switches(15) <= '0';
WAIT;
END PROCESS t_prcs_switches_15;
-- switches[14]
t_prcs_switches_14: PROCESS
BEGIN
	switches(14) <= '0';
	WAIT FOR 160000 ps;
	switches(14) <= '1';
	WAIT FOR 360000 ps;
	switches(14) <= '0';
WAIT;
END PROCESS t_prcs_switches_14;
-- switches[13]
t_prcs_switches_13: PROCESS
BEGIN
	switches(13) <= '0';
	WAIT FOR 160000 ps;
	switches(13) <= '1';
	WAIT FOR 120000 ps;
	switches(13) <= '0';
WAIT;
END PROCESS t_prcs_switches_13;
-- switches[12]
t_prcs_switches_12: PROCESS
BEGIN
	switches(12) <= '0';
	WAIT FOR 160000 ps;
	switches(12) <= '1';
	WAIT FOR 360000 ps;
	switches(12) <= '0';
WAIT;
END PROCESS t_prcs_switches_12;
-- switches[11]
t_prcs_switches_11: PROCESS
BEGIN
	switches(11) <= '0';
	WAIT FOR 520000 ps;
	switches(11) <= '1';
WAIT;
END PROCESS t_prcs_switches_11;
-- switches[10]
t_prcs_switches_10: PROCESS
BEGIN
	switches(10) <= '0';
	WAIT FOR 280000 ps;
	switches(10) <= '1';
	WAIT FOR 240000 ps;
	switches(10) <= '0';
WAIT;
END PROCESS t_prcs_switches_10;
-- switches[9]
t_prcs_switches_9: PROCESS
BEGIN
	switches(9) <= '0';
	WAIT FOR 400000 ps;
	switches(9) <= '1';
	WAIT FOR 120000 ps;
	switches(9) <= '0';
WAIT;
END PROCESS t_prcs_switches_9;
-- switches[8]
t_prcs_switches_8: PROCESS
BEGIN
	switches(8) <= '0';
WAIT;
END PROCESS t_prcs_switches_8;
-- switches[7]
t_prcs_switches_7: PROCESS
BEGIN
	switches(7) <= '0';
	WAIT FOR 520000 ps;
	switches(7) <= '1';
WAIT;
END PROCESS t_prcs_switches_7;
-- switches[6]
t_prcs_switches_6: PROCESS
BEGIN
	switches(6) <= '0';
	WAIT FOR 280000 ps;
	switches(6) <= '1';
	WAIT FOR 240000 ps;
	switches(6) <= '0';
WAIT;
END PROCESS t_prcs_switches_6;
-- switches[5]
t_prcs_switches_5: PROCESS
BEGIN
	switches(5) <= '0';
WAIT;
END PROCESS t_prcs_switches_5;
-- switches[4]
t_prcs_switches_4: PROCESS
BEGIN
	switches(4) <= '0';
	WAIT FOR 520000 ps;
	switches(4) <= '1';
WAIT;
END PROCESS t_prcs_switches_4;
-- switches[3]
t_prcs_switches_3: PROCESS
BEGIN
	switches(3) <= '1';
	WAIT FOR 80000 ps;
	switches(3) <= '0';
	WAIT FOR 440000 ps;
	switches(3) <= '1';
WAIT;
END PROCESS t_prcs_switches_3;
-- switches[2]
t_prcs_switches_2: PROCESS
BEGIN
	switches(2) <= '0';
WAIT;
END PROCESS t_prcs_switches_2;
-- switches[1]
t_prcs_switches_1: PROCESS
BEGIN
	switches(1) <= '0';
	WAIT FOR 80000 ps;
	switches(1) <= '1';
	WAIT FOR 320000 ps;
	switches(1) <= '0';
WAIT;
END PROCESS t_prcs_switches_1;
-- switches[0]
t_prcs_switches_0: PROCESS
BEGIN
	switches(0) <= '0';
	WAIT FOR 280000 ps;
	switches(0) <= '1';
	WAIT FOR 240000 ps;
	switches(0) <= '0';
WAIT;
END PROCESS t_prcs_switches_0;
END projeto_final_arch;
