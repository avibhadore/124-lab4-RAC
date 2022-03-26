LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY grappler IS
PORT
	(	clk			: IN std_logic;
		RESET			: IN std_logic;
		grappler_in	: IN std_logic;
		grappler_en		: IN std_logic;
		grappler_on  : OUT std_logic

	);
	
	ARCHITECTURE grappler_SM OF grappler IS
	
	TYPE STATE_NAMES IS (D,C,A);
	SIGNAL current_state, next_state : STATE_NAMES; --these signals will hold D,C, or A.
	
	--Register Logic
Register_Section: PROCESS (clk, RESET, next_state) 
	BEGIN
	IF (reset = '0') THEN --note that reset is active-low (input gets inverted)
		current_state <= D;
	ELSIF(rising_edge(clk)) THEN
		current_state <= next_state; --if not async reset, next state becomes current state
	END IF;
END PROCESS;

	--STATE TRANSITION LOGIC PROCESS
Transition_Section: PROCESS (grappler_en, grappler_in,current_state)
	BEGIN
	CASE current_state IS
		WHEN D =>
		IF(grappler_en = '1') THEN
			next_state <= C;
		ELSE
			next_state <= D;
		END IF;
		
		WHEN C =>
		IF (grappler_en = '0') THEN
			next_state <= D;
		ELSIF (grappler_in = '1') THEN
			next_state <= O;
		ELSE
			next_state <= C;
		END IF;
		
		WHEN O =>
		IF (grappler_en = '0') THEN
			next_state <= D;
		ELSIF (grappler_in = '0') THEN
			next_state <= C;
		ELSE
			next_state <= O;
		END IF;
		WHEN OTHERS =>
		next_state <= D; --this should never run. but just in case...
	END CASE;
END PROCESS;

--State Machine Actions 	
	Mealy_SM: PROCESS (current_state)
	BEGIN
	IF (current_state = D) THEN
		grappler_on <= '0';
	IF (current_state = c) THEN
		grappler_on <= '0';
	IF (current_state = O) THEN
		grappler_on <= '1';
	END IF;
	END PROCESS;
	
	END;