LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY extender IS
PORT
	(
		extender_in		: IN std_logic;
		extender_en		: IN std_logic;
		state_input		: IN std_logic_vector(3 downto 0);
		
		extender_out	: OUT std_logic := '0';
		clk_en 			: OUT std_logic;
		left_right		: OUT std_logic;
		grappler_en		: OUT std_logic
	);

	
ARCHITECTURE extender_SM OF extender IS


SIGNAL backwards : std_logic;
SIGNAL forwards  : std_logic;

BEGIN

-- Assigning backwards
PROCESS (extender_en, extender, state_input) IS
	
	if (extender_en = '1') then
		
		-- If we are @ 1111 and button is pushed again, we move backwards
		if (falling_edge(extender) AND state_input = "1111") then
			backwards <= '1';
		
		-- If we are @ 0000 we cannot move backwards
		-- If we are @ 1111 but the extender button is not pushed, so we do not move backwards
		elsif (state_input = "0000" OR (NOT(falling_edge(extender)) AND state_input = "1111")) then
			backwards <= '0';
			
		end if;
	
	else
		
		-- If extender_en = '0' then nothing should work and all output signals should be '0'
		grappler_en <= '0';
		clk_en <= '0';
		left_right <= '0';
		extender_out <= '0';
	
	end if;

END PROCESS;


-- Assigning forwards
PROCESS (extender_en, extender, state_input) IS

	if (extender_en = '1') then
	
		-- If we are @ 0000 and button is pushed, forward goes high
		if (falling_edge(extender) AND state_input = "0000") then
			forwards <= '1';
		
		-- If we are @ 1111 then we cannot go forwards, so forwards goes low
		-- We can also use the grappler now
		elsif (state_input = "1111") then
			forwards <= '0';
			grappler_en <= '1';
		 
		end if;
	
	end if;
		
END PROCESS;


-- Movement process
PROCESS (extender_en, extender, state_input) IS

	if (extender_en = '1') then
		
		-- if backwards is high, we should left shift the register
		if (backwards = '1') then
			clk_en <= '1';
			left_right <= '0';
			extender_out <= '1';
		
		-- if forwards is high and we are @ 0000 we should right shift
		elsif (forwards = '1' AND state_input = "0000") then
			clk_en <= '1';
			left_right <= '1';
		
		-- forwards should still be high if we are moving, so extender_out should be high
		elsif (forwards = '1' AND state_input != "0000") then
			clk_en <= '1';
			left_right <= '1';
			extender_out <= '1';
		
		end if;
	
	end if;
	
END PROCESS;

			

END;
	


