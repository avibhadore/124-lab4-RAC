LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY extender IS
PORT
	(
		extender_in		: IN std_logic;
		extender_en		: IN std_logic;
		state_input		: IN std_logic_vector(3 downto 0);
		
		extender_out	: OUT std_logic;
		clk_en 			: OUT std_logic;
		left_right		: OUT std_logic;
		grappler_en		: OUT std_logic;
	);

	
-- This component will be implemented using a state machine

ARCHITECTURE extender_SM OF extender IS

TYPE STATES IS (S0, S1, S2, S3);
SIGNAL current_state, next_state	: STATES;

BEGIN

PROCESS (extender_in, extender_en, current_state, next_state) IS
BEGIN
	


