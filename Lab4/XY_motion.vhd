LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY XY_motion IS
PORT
	(
		X_GT, X_EQ, X_LT, motion, Y_GT, Y_EQ, Y_LT, extender_out	: IN std_logic;
		clk_en_X, clk_en_Y, up_down_X, up_down_Y, error, Capture_XY, extender_en	: OUT std_logic := '0';
	);
	
ARCHITECTURE XY_motion_architecture OF XY_motion IS
BEGIN

signal motion_1yes_0no : std_logic;


-- checking for movement
PROCESS (X_EQ, Y_EQ, extender_out) IS
BEGIN
	
	if (extender_out = '0') then
	
		if (X_EQ = '0' OR Y_EQ = '0') then
			motion_1yes_0no <= '0';
		else
			motion_1yes_0no <= '1';
		end if;
		
	end if;
	
extender_en <= motion_1yes_0no;

END PROCESS;


-- Incrementing and decrementing X values
PROCESS (X_GT, X_LT, extender_out) IS
BEGIN
	
	if (extender_out = '0') then
		
		if (X_GT = '1') then
			clk_en_X <= '1';
			up_down_X <= '0';
		elsif (X_LT = '1') then
			clk_en_X <= '1';
			up_down_X <= '1';
		elsif (X_EQ = '1') then
			clk_en_X <= '0';

		end if;
	end if;
	
END PROCESS;


-- Incrementing and decrementing Y values
PROCESS (Y_GT, Y_LT, extender_out) IS
BEGIN
	
	if (extender_out = '0') then
		
		if (Y_GT = '1') then
			clk_en_Y <= '1';
			up_down_Y <= '0';
		elsif (Y_LT = '1') then
			clk_en_Y <= '1';
			up_down_Y <= '1';
		elsif (Y_EQ = '1') then
			clk_en_Y <= '0';
		end if;
	end if;

END PROCESS;

clk_en_Y <= '0';


-- Capturing TargetXY values
PROCESS (motion) IS
	if (extender_out = '0') then
	
		if (motion = '1') then
			Capture_XY <= '1';
		else
			Capture_XY <= '0';
		end if;
	
	end if;
		
END PROCESS;


-- Error signal
PROCESS (motion, extender_out) IS

	if (extender_out = '1' AND motion = '1') then
		error <= '1';
	else
		error <= '0';
	end if;
	
END PROCESS;


END;
